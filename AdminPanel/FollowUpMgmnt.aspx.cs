using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using myBiz.DAL;

namespace webApp.AdminPanel
{
    public partial class FollowUpMgmnt : webApp.Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Follow Up Management"))
            {
                if (!IsPostBack)
                {
                    DataTable Tb = clsDB.spAdmin_Variables_S("RFQ_SNP:RFQ_CCP:RFQ_FoUP:RFQ_FoUPPO:RFQ_EarlyMark:RFQ_BeLate");
                    foreach (DataRow Rw in Tb.Rows)
                    {
                        switch (Rw["nKey"].ToString())
                        {
                            case "RFQ_SNP": txtSNP.Text = Rw["iValue"].ToString(); break;
                            case "RFQ_CCP": txtCCP.Text = Rw["iValue"].ToString(); break;
                            case "RFQ_FoUP": txtFoUP.Text = Rw["iValue"].ToString(); break;
                            case "RFQ_FoUPPO": txtFoUPPO.Text = Rw["iValue"].ToString(); break;
                            case "RFQ_EarlyMark": txtEarlyMark.Text = Rw["iValue"].ToString(); break;
                            case "RFQ_BeLate": txtBeLate.Text = Rw["iValue"].ToString(); break;
                        }
                    }
                }
            }
        }
        protected void doSave(object sender, EventArgs e)
        {
            string errMsg = string.Empty;

            if (string.IsNullOrEmpty(txtSNP.Text.Trim())) txtSNP.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtSNP.Text)) errMsg = "You have entered invalid SNP value.";
            else if (Convert.ToInt32(txtSNP.Text.Trim()) < 0) errMsg = "The SNP value cannot be negative.";

            if (string.IsNullOrEmpty(txtCCP.Text.Trim())) txtCCP.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtCCP.Text)) errMsg = "You have entered invalid CCP value.";
            else if (Convert.ToInt32(txtCCP.Text.Trim()) < 0) errMsg = "The CCP value cannot be negative.";

            if (string.IsNullOrEmpty(txtFoUP.Text.Trim())) txtFoUP.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtFoUP.Text)) errMsg = "You have entered invalid FoUP value.";
            else if (Convert.ToInt32(txtFoUP.Text.Trim()) < 0) errMsg = "The FoUP cannot be negative.";

            if (string.IsNullOrEmpty(txtFoUPPO.Text.Trim())) txtFoUPPO.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtFoUPPO.Text)) errMsg = "You have entered invalid FoUPPO.";
            else if (Convert.ToInt32(txtFoUPPO.Text.Trim()) < 0) errMsg = "The FoUPPO cannot be negative.";

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
                h.Add("RFQ_SNP", Convert.ToInt32(txtSNP.Text));
                h.Add("RFQ_CCP", Convert.ToInt32(txtCCP.Text));
                h.Add("RFQ_FoUP", Convert.ToInt32(txtFoUP.Text));
                h.Add("RFQ_FoUPPO", Convert.ToInt32(txtFoUPPO.Text));
                h.Add("RFQ_EarlyMark", Convert.ToInt32(txtEarlyMark.Text));
                h.Add("RFQ_BeLate", Convert.ToInt32(txtBeLate.Text));
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
        protected override void enforceSecurity()
        {
            
        }
    }
}