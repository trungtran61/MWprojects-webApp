using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class UpdateCount : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack)
            {
                //fvUpdateCount.Visible = !myMode.reqTask;
                gCmd("View");
            }
        }
        protected void fvSave(object sender, EventArgs e)
        {
            if (fvUpdateCount.DataItemCount > 0) fvUpdateCount.UpdateItem(true);
            else fvUpdateCount.InsertItem(true);
        }
        protected void fvBound(object sender, EventArgs e)
        {
            bool xCmp = isYN("t05") && fvUpdateCount.CurrentMode == FormViewMode.ReadOnly && fvUpdateCount.DataItemCount > 0;
            if (xCmp)
            {
                string tCnt = (fvUpdateCount.FindControl("litTotalCnt") as Literal).Text;
                if (string.IsNullOrEmpty(tCnt)) tCnt = "0";
                xCmp = Convert.ToInt32(tCnt) > 0;
            }
            myMode.Completable = xCmp;
            if (fvUpdateCount.CurrentMode != FormViewMode.ReadOnly)
            {
                Telerik.Web.UI.RadDateTimePicker DD = fvUpdateCount.FindControl("txtEndDate") as Telerik.Web.UI.RadDateTimePicker;
                if (DD.DbSelectedDate == null) DD.DbSelectedDate = DateTime.Now;
            }
        }
        protected void chkOverride(object sender, EventArgs e)
        {
            if (isYN("t07") && chkSec) dTask();
            else iMsg.ShowErr("Sorry! Override failed.", true);
        }
        protected override void dTask()
        {
            if (fvUpdateCount.DataItemCount > 0) fvUpdateCount.ChangeMode(FormViewMode.Edit);
            else fvUpdateCount.ChangeMode(FormViewMode.Insert);
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            fvUpdateCount.ChangeMode(FormViewMode.ReadOnly);
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "Reset");
            TaskSec.Add("t07", "Override Edit");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01") && !myMode.isOR;
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
        }
        private Hashtable hSec
        {
            get
            {
                Hashtable xH = new Hashtable();
                xH.Add("t01", myMode.ActionName);
                xH.Add("t02", "Edit");
                xH.Add("t03", "View");
                xH.Add("t04", "Print");
                xH.Add("t05", "Mark Complete");
                xH.Add("t06", "Reset");
                xH.Add("t07", "Override Edit");
                return xH;
            }
        }
        private bool chkSec
        {
            get
            {
                string tUN = (fvUpdateCount.FindControl("txtUN") as TextBox).Text;
                string tPW = (fvUpdateCount.FindControl("txtPW") as TextBox).Text;
                Hashtable xSec = (new clsUser()).getTaskSec(tUN, Convert.ToInt32(IDs[3]), hSec, AppCode);
                return Common.clsUser.chkLogin(tUN, tPW) && xSec.ContainsKey("t07") && Convert.ToBoolean(xSec["t07"]);
            }
        }
    }
}