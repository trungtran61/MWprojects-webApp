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
    public partial class ucLAT06 : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack)
            {
                fvSetupMan.Visible = !myMode.reqTask;
                gCmd("View");
            }
        }
        protected void fvSave(object sender, EventArgs e)
        {
            if (fvSetupMan.DataItemCount > 0) fvSetupMan.UpdateItem(true);
            else fvSetupMan.InsertItem(true);
            iMsg.ShowMsg("Thank You! Your data has been saved!", true);
        }
        protected void fvBound(object sender, EventArgs e)
        {
            if (fvSetupMan.CurrentMode != FormViewMode.ReadOnly)
            {
                Telerik.Web.UI.RadDateTimePicker DD = fvSetupMan.FindControl("txtDate") as Telerik.Web.UI.RadDateTimePicker;
                if (DD.DbSelectedDate == null) DD.DbSelectedDate = DateTime.Now;
            }
            myMode.Completable = isYN("t05") && fvSetupMan.CurrentMode == FormViewMode.ReadOnly && (fvSetupMan.FindControl("chkBuyOff") as CheckBox).Checked;
        }
        protected bool xReset()
        {
            return !myMode.pTask && isYN("t06") && !string.IsNullOrEmpty(Eval("SetDate").ToString()) && !string.IsNullOrEmpty(Eval("SetFullName").ToString());
        }
        protected override void dTask()
        {
            if (fvSetupMan.DataItemCount > 0) fvSetupMan.ChangeMode(FormViewMode.Edit);
            else fvSetupMan.ChangeMode(FormViewMode.Insert);
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            fvSetupMan.ChangeMode(FormViewMode.ReadOnly);
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "Reset");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
        }
    }
}