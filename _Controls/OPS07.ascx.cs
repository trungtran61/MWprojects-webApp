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
    public partial class OPS07 : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) gCmd("loadSec");
        }
        protected void fvSave(object sender, EventArgs e)
        {
            if (fvOPS_SendRecdBy.DataItemCount > 0) fvOPS_SendRecdBy.UpdateItem(true);
            else fvOPS_SendRecdBy.InsertItem(true);
            iMsg.ShowMsg("Thank You! Your data has been saved!", true);
        }
        protected void fvBound(object sender, EventArgs e)
        {
            if (fvOPS_SendRecdBy.CurrentMode != FormViewMode.ReadOnly)
            {
                DropDownList ddl = fvOPS_SendRecdBy.FindControl("ddlName") as DropDownList;
                Telerik.Web.UI.RadDateTimePicker DD = fvOPS_SendRecdBy.FindControl("txtDate") as Telerik.Web.UI.RadDateTimePicker;
                if (DD.DbSelectedDate == null) DD.DbSelectedDate = DateTime.Now;

                if (ddl.SelectedIndex < 1)
                {
                    try { ddl.SelectedValue = Common.clsUser.uID; } //old one uses usrID
                    catch { }
                }
            }
            myMode.Completable = isYN("t05") && fvOPS_SendRecdBy.CurrentMode == FormViewMode.ReadOnly
                && !string.IsNullOrEmpty((fvOPS_SendRecdBy.FindControl("litSendRecdBy") as Literal).Text)
                && !string.IsNullOrEmpty((fvOPS_SendRecdBy.FindControl("litSendRecdDate") as Literal).Text);
        }
        protected bool xReset()
        {
            return !myMode.pTask && isYN("t07") && !string.IsNullOrEmpty(Eval("SendRecdBy").ToString()) && !string.IsNullOrEmpty(Eval("SendRecdDate").ToString());
        }
        protected override void dTask()
        {
            if (fvOPS_SendRecdBy.DataItemCount > 0) fvOPS_SendRecdBy.ChangeMode(FormViewMode.Edit);
            else fvOPS_SendRecdBy.ChangeMode(FormViewMode.Insert);
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            fvOPS_SendRecdBy.ChangeMode(FormViewMode.ReadOnly);
        }
        protected void doView(object sender, EventArgs e)
        {
            clsFile.Show(Page, pnlPopup, "DL", "View M.O.T.", string.Empty, Convert.ToInt32(myMode.gData("MOTGrp")), this.xID("TravelerID"), string.Empty);
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "View M.O.T.");
            TaskSec.Add("t07", "Reset");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = isYN("t05") && fvOPS_SendRecdBy.CurrentMode == FormViewMode.ReadOnly;
            lnkMOT.Visible = isYN("t06");
            lnkBlank.OnClientClick = string.Format("javascript:lFrame('File/Download.aspx?TID={0}'); return false;", this.IDs[3]);
        }
    }
}