using System;
using System.Collections;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using myBiz.DAL;
using Common.DTO;

namespace webApp.AdminPanel
{
    public partial class PoCustFUMgmnt : webApp.Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Potential Customer Follow Up Management"))
            {
                if (!IsPostBack)
                {
                    DataTable Tb = clsDB.spAdmin_Variables_S("PoCustFU_COCIN:PoCustFU_BROC:PoCustFU_FoURFQP:PoCustFU_RFQU:PoCustFU_RFQE:PoCustFU_EarlyMark:PoCustFU_BeLate");
                    foreach (DataRow Rw in Tb.Rows)
                    {
                        switch (Rw["nKey"].ToString())
                        {
                            case "PoCustFU_COCIN": txtCOCIN.Text = Rw["iValue"].ToString(); break;
                            case "PoCustFU_BROC": txtBROC.Text = Rw["iValue"].ToString(); break;
                            case "PoCustFU_FoURFQP": txtFoURFQP.Text = Rw["iValue"].ToString(); break;
                            case "PoCustFU_RFQU": txtRFQU.Text = Rw["iValue"].ToString(); break;
                            case "PoCustFU_RFQE": txtRFQE.Text = Rw["iValue"].ToString(); break;
                            case "PoCustFU_EarlyMark": txtEarlyMark.Text = Rw["iValue"].ToString(); break;
                            case "PoCustFU_BeLate": txtBeLate.Text = Rw["iValue"].ToString(); break;
                        }
                    }
                }
            }
        }
        protected void doSave(object sender, EventArgs e)
        {
            string errMsg = string.Empty;

            if (string.IsNullOrEmpty(txtCOCIN.Text.Trim())) txtCOCIN.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtCOCIN.Text)) errMsg = "You have entered invalid COCIN value.";
            else if (Convert.ToInt32(txtCOCIN.Text.Trim()) < 0) errMsg = "The COCIN value cannot be negative.";

            if (string.IsNullOrEmpty(txtBROC.Text.Trim())) txtBROC.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtBROC.Text)) errMsg = "You have entered invalid BROC value.";
            else if (Convert.ToInt32(txtBROC.Text.Trim()) < 0) errMsg = "The BROC value cannot be negative.";

            if (string.IsNullOrEmpty(txtFoURFQP.Text.Trim())) txtFoURFQP.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtFoURFQP.Text)) errMsg = "You have entered invalid FoURFQP.";
            else if (Convert.ToInt32(txtFoURFQP.Text.Trim()) < 0) errMsg = "The FoURFQP cannot be negative.";

            if (string.IsNullOrEmpty(txtRFQU.Text.Trim())) txtRFQU.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtRFQU.Text)) errMsg = "You have entered invalid RFQU value.";
            else if (Convert.ToInt32(txtRFQU.Text.Trim()) < 0) errMsg = "The RFQU value cannot be negative.";

            if (string.IsNullOrEmpty(txtRFQE.Text.Trim())) txtRFQE.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtRFQE.Text)) errMsg = "You have entered invalid RFQE value.";
            else if (Convert.ToInt32(txtRFQE.Text.Trim()) < 0) errMsg = "The RFQE cannot be negative.";

            if (string.IsNullOrEmpty(txtEarlyMark.Text.Trim())) txtEarlyMark.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtEarlyMark.Text)) errMsg = "You have entered invalid Early Mark value.";
            else if (Convert.ToInt32(txtEarlyMark.Text.Trim()) < 0) errMsg = "The Early Mark cannot be negative.";

            if (string.IsNullOrEmpty(txtBeLate.Text.Trim())) txtBeLate.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtBeLate.Text)) errMsg = "You have entered invalid Be Late value.";
            else if (Convert.ToInt32(txtBeLate.Text.Trim()) < 0) errMsg = "The Be Late cannot be negative.";
            else if (Convert.ToInt32(txtBeLate.Text.Trim()) > Convert.ToInt32(txtEarlyMark.Text.Trim())) errMsg = "The Be Late cannot be greater than Early Mark.";

            if (string.IsNullOrEmpty(errMsg))
            {
                Hashtable h = new Hashtable();
                h.Add("PoCustFU_COCIN", Convert.ToInt32(txtCOCIN.Text));
                h.Add("PoCustFU_BROC", Convert.ToInt32(txtBROC.Text));
                h.Add("PoCustFU_FoURFQP", Convert.ToInt32(txtFoURFQP.Text));
                h.Add("PoCustFU_RFQU", Convert.ToInt32(txtRFQU.Text));
                h.Add("PoCustFU_RFQE", Convert.ToInt32(txtRFQE.Text));
                h.Add("PoCustFU_EarlyMark", Convert.ToInt32(txtEarlyMark.Text));
                h.Add("PoCustFU_BeLate", Convert.ToInt32(txtBeLate.Text));
                clsDB.spAdmin_Variables_Save(h);
                iMsg.ShowMsg("Thank You! Your data has been saved.", true);
            }
            else iMsg.ShowErr(errMsg, true);
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {
                odsResult.UpdateParameters["HID"].DefaultValue = "-1";
                odsResult.UpdateParameters["curStatus"].DefaultValue = ddlStatus.SelectedValue;
                odsResult.UpdateParameters["nextStatus"].DefaultValue = ((TextBox)gvResult.FooterRow.FindControl("txtNextStatus")).Text.Trim();
                odsResult.UpdateParameters["mText"].DefaultValue = ((TextBox)gvResult.FooterRow.FindControl("txtmText")).Text.Trim();
                odsResult.Update();
            }
        }
        protected void doCustSave(object sender, EventArgs e)
        {
            odsCustomer.Update();
            iCustMsg.ShowMsg("Thank you! Your Potential Customer list has been saved.", true);
        }

        protected override void enforceSecurity()
        {

        }
    }
}