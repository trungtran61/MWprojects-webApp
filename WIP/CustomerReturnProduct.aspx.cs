using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webApp.Common;

namespace webApp.WIP
{
    public partial class CustomerReturnProduct : pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("WIP/Customer Return Product"))
            {
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Edit Non-conformance");
            PageSec.Add("k02", "Edit Cause of Non-conformance");
            PageSec.Add("k03", "Edit Contributin Factors");
            PageSec.Add("k04", "Edit Root Cause");
            PageSec.Add("k05", "Edit Disposition");
            PageSec.Add("k06", "Edit Corrective Action");
            PageSec.Add("k07", "Edit Approved By QA");
            PageSec.Add("k08", "Edit Approved By Engineer");
            PageSec.Add("k09", "Edit Product Page");
        }

        protected void fvBound(object sender, EventArgs e)
        {
            if (fvProduct.CurrentMode == FormViewMode.Edit)
            {
                var ddlDisposition = fvProduct.FindControl("ddlDisposition") as DropDownList;
                var ddlCorrectiveAction = fvProduct.FindControl("ddlCorrectiveAction") as DropDownList;
                var blankDisposition = string.IsNullOrWhiteSpace(ddlDisposition.SelectedValue);
                var blankCorrectiveAction = string.IsNullOrWhiteSpace(ddlCorrectiveAction.SelectedValue);
                var carNoGenerated = (fvProduct.FindControl("litCarNum") as Literal).Text.Equals("TBD");

                ddlDisposition.Enabled = isYN("k05") && blankCorrectiveAction;
                ddlCorrectiveAction.Enabled = isYN("k06") && !blankDisposition && carNoGenerated;

                (fvProduct.FindControl("txtNonConform") as TextBox).Enabled = isYN("k01") && blankDisposition;
                (fvProduct.FindControl("txtCauseNonConform") as TextBox).Enabled = isYN("k02") && blankDisposition;
                (fvProduct.FindControl("txtConFactor") as TextBox).Enabled = isYN("k03") && blankDisposition;
                (fvProduct.FindControl("txtRootCause") as TextBox).Enabled = isYN("k04") && blankDisposition;
                (fvProduct.FindControl("txtAppByQa") as TextBox).Enabled = isYN("k07");
                (fvProduct.FindControl("txtAppByEng") as TextBox).Enabled = isYN("k08");
                fvProduct.FindControl("btnCreateCar").Visible = ddlCorrectiveAction.SelectedValue.Equals("Yes") && carNoGenerated;
            }
            else if (fvProduct.CurrentMode == FormViewMode.ReadOnly)
            {
                (fvProduct.FindControl("btnEdit") as Button).Enabled = isYN("k09");
            }
        }

        protected void fvCmd(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Update"))
            {
                iMsg.ShowMsg("Thank you! Data has been saved.", true);
            }
            else if (e.CommandName.Equals("CreateMWCar"))
            {
                var logID = Convert.ToInt32(fvProduct.DataKey.Value);
                var userName = clsUser.uID;
                var responseDate = Convert.ToDateTime((fvProduct.FindControl("txtResponseDate") as TextBox).Text);
                var dto = (new myBiz.DAL.clsCustomerReturnLog()).CreateMWCar(logID, userName, responseDate);
                (fvProduct.FindControl("litCarNum") as Literal).Text = dto.CarNum;
                fvProduct.FindControl("btnCreateCar").Visible = false;
            }
        }

        protected void fvUpdating(object sender, FormViewUpdateEventArgs e)
        {
            var disValue = e.NewValues["Disposition"] != null ? e.NewValues["Disposition"].ToString() : e.OldValues["Disposition"].ToString();
            var corValue = e.NewValues["CorrectiveAction"] != null ? e.NewValues["CorrectiveAction"].ToString() : e.OldValues["CorrectiveAction"].ToString();
            var carNum = (fvProduct.FindControl("litCarNum") as Literal).Text;
            if (carNum.Equals("TBD")) carNum = string.Empty; //TBD is actually empty, no value

            if (string.IsNullOrWhiteSpace(disValue) && !string.IsNullOrWhiteSpace(corValue))
            {
                e.Cancel = true;
                iMsg.ShowErr("Corrective Action is not allowed when Disposition is blank.", true);
            }
            else if (!corValue.Equals("Yes") && !string.IsNullOrWhiteSpace(carNum))
            {
                e.Cancel = true;
                iMsg.ShowErr("Changing Corrective Action is not allowed when MWCar# has already been generated.", true);
            }
        }
    }
}