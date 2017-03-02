using System;
using System.Collections;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using myBiz.DAL;

namespace webApp.AdminPanel
{
    public partial class CustFUMgmnt : webApp.Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Customer Follow Up Management"))
            {
                if (!IsPostBack)
                {
                    DataTable Tb = clsDB.spAdmin_Variables_S("CustFU_CIRFQ:CustFU_FIRFQ:CustFU_FoURFQP:CustFU_RFQU:CustFU_RFQE:CustFU_EarlyMark:CustFU_BeLate");
                    foreach (DataRow Rw in Tb.Rows)
                    {
                        switch (Rw["nKey"].ToString())
                        {
                            case "CustFU_CIRFQ": txtCIRFQ.Text = Rw["iValue"].ToString(); break;
                            case "CustFU_FIRFQ": txtFIRFQ.Text = Rw["iValue"].ToString(); break;
                            case "CustFU_FoURFQP": txtFoURFQP.Text = Rw["iValue"].ToString(); break;
                            case "CustFU_RFQU": txtRFQU.Text = Rw["iValue"].ToString(); break;
                            case "CustFU_RFQE": txtRFQE.Text = Rw["iValue"].ToString(); break;
                            case "CustFU_EarlyMark": txtEarlyMark.Text = Rw["iValue"].ToString(); break;
                            case "CustFU_BeLate": txtBeLate.Text = Rw["iValue"].ToString(); break;
                        }
                    }
                }
            }
        }
        protected void doSave(object sender, EventArgs e)
        {
            string errMsg = string.Empty;

            if (string.IsNullOrEmpty(txtCIRFQ.Text.Trim())) txtCIRFQ.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtCIRFQ.Text)) errMsg = "You have entered invalid CIRFQ value.";
            else if (Convert.ToInt32(txtCIRFQ.Text.Trim()) < 0) errMsg = "The CIRFQ value cannot be negative.";

            if (string.IsNullOrEmpty(txtFIRFQ.Text.Trim())) txtFIRFQ.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtFIRFQ.Text)) errMsg = "You have entered invalid FIRFQ value.";
            else if (Convert.ToInt32(txtFIRFQ.Text.Trim()) < 0) errMsg = "The FIRFQ value cannot be negative.";

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
                h.Add("CustFU_CIRFQ", Convert.ToInt32(txtCIRFQ.Text));
                h.Add("CustFU_FIRFQ", Convert.ToInt32(txtFIRFQ.Text));
                h.Add("CustFU_FoURFQP", Convert.ToInt32(txtFoURFQP.Text));
                h.Add("CustFU_RFQU", Convert.ToInt32(txtRFQU.Text));
                h.Add("CustFU_RFQE", Convert.ToInt32(txtRFQE.Text));
                h.Add("CustFU_EarlyMark", Convert.ToInt32(txtEarlyMark.Text));
                h.Add("CustFU_BeLate", Convert.ToInt32(txtBeLate.Text));
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
            iCustMsg.ShowMsg("Thank you! Your Customer list has been saved.", true);
        }
        protected override void enforceSecurity()
        {

        }
    }
}