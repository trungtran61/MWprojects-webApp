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
    public partial class ucLAT07 : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) { fvCycle.Visible = !myMode.reqTask; gCmd("View"); }
        }
        protected void fvSave(object sender, EventArgs e)
        {
            if (fvCycle.DataItemCount > 0) fvCycle.UpdateItem(true);
            else fvCycle.InsertItem(true);
            iMsg.ShowMsg("Thank You! Your data has been saved!", true);
        }
        protected void fvBound(object sender, EventArgs e)
        {
            bool xCmp = isYN("t05") && fvCycle.CurrentMode == FormViewMode.ReadOnly;
            if (xCmp)
            {
                string opCycle = (fvCycle.FindControl("litOpCycle") as Literal).Text;
                if (string.IsNullOrEmpty(opCycle)) opCycle = "0";

                xCmp = Convert.ToDouble(opCycle) > 0;
            }
            myMode.Completable = xCmp;
            if (fvCycle.CurrentMode != FormViewMode.ReadOnly)
            {
                Telerik.Web.UI.RadDateTimePicker DD = fvCycle.FindControl("txtDate") as Telerik.Web.UI.RadDateTimePicker;
                if (DD.DbSelectedDate == null) DD.DbSelectedDate = DateTime.Now;
            }
        }
        protected bool xReset()
        {
            return !myMode.pTask && isYN("t06") && !string.IsNullOrEmpty(Eval("OpCycle").ToString()) && !string.IsNullOrEmpty(Eval("OpDate").ToString()) && !string.IsNullOrEmpty(Eval("OpFullName").ToString());
        }
        protected override void dTask()
        {
            if (fvCycle.DataItemCount > 0) fvCycle.ChangeMode(FormViewMode.Edit);
            else fvCycle.ChangeMode(FormViewMode.Insert);
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            fvCycle.ChangeMode(FormViewMode.ReadOnly);
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