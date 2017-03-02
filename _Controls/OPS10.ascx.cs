using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class OPS10 : Common.ucAbstract
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
                    try { ddl.SelectedValue = Common.clsUser.uID; }
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
        protected void odsInit(object sender, EventArgs e)
        {
            ObjectDataSource obj = sender as ObjectDataSource;
            obj.SelectParameters["SoR"].DefaultValue = obj.UpdateParameters["SoR"].DefaultValue =
                obj.DeleteParameters["SoR"].DefaultValue = isMatl ? "Material Received On " : "OPS Received On ";
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
            lnkMOT.Visible = !isMatl && isYN("t06");
            litHeader.Text = isMatl ? "RECEIVE MATERIAL FROM VENDOR" : "RECEIVE PART FROM VENDOR (OPS)";
        }
        private bool isMatl { get { return myMode.TaskID.Equals("RIM09"); } }
    }
}