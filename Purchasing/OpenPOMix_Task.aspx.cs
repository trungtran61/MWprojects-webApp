using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Purchasing
{
    public partial class OpenPOMix_Task : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Purchasing/ReceivePOMix_Task");
        }
        protected void fvSave(object sender, EventArgs e)
        {
            if (fvPO_Task.DataItemCount > 0) fvPO_Task.UpdateItem(true);
            else fvPO_Task.InsertItem(true);
            iMsg.ShowMsg("Thank You! Your data has been saved!", true);
        }
        protected void fvBound(object sender, EventArgs e)
        {
            if (fvPO_Task.CurrentMode != FormViewMode.ReadOnly)
            {
                DropDownList ddl = fvPO_Task.FindControl("ddlName") as DropDownList;
                Telerik.Web.UI.RadDateTimePicker DD = fvPO_Task.FindControl("txtDate") as Telerik.Web.UI.RadDateTimePicker;
                if (DD.DbSelectedDate == null) DD.DbSelectedDate = DateTime.Now;
                if (ddl.SelectedIndex < 1)
                {
                    try { ddl.SelectedValue = Common.clsUser.uID; }
                    catch { }
                }
            }
            btnComplete.Visible = isYN("k02") && fvPO_Task.CurrentMode == FormViewMode.ReadOnly
                && !string.IsNullOrEmpty((fvPO_Task.FindControl("litSendRecdBy") as Literal).Text)
                && !string.IsNullOrEmpty((fvPO_Task.FindControl("litSendRecdDate") as Literal).Text);
        }
        protected bool xReset()
        {
            return isYN("k01") && !string.IsNullOrEmpty(Eval("SendRecdBy").ToString()) && !string.IsNullOrEmpty(Eval("SendRecdDate").ToString());
        }
        protected void doRecdComp(object sender, EventArgs e)
        {
            bool isRecd = (sender as Button).ID.Equals("btnReceive");

            if (isRecd)
            {
                if (fvPO_Task.DataItemCount > 0) fvPO_Task.ChangeMode(FormViewMode.Edit);
                else fvPO_Task.ChangeMode(FormViewMode.Insert);
            }
            else iMsg.ShowMsg("Thank You! Mixed Order Task has been completed!", true);

            (new myBiz.DAL.clsPO()).Tool_PO_Task_C(Request.QueryString["IDs"], !isRecd);
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Reset");
            PageSec.Add("k02", "Mark Completed");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
        }
    }
}