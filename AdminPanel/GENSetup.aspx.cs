using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using myBiz.DAL;

namespace webApp.AdminPanel
{
    public partial class GENSetup : webApp.Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Work Order Settings"))
            {
                if (!IsPostBack)
                {
                    reloadTlbx(); DataTable Tb = clsDB.spAdmin_Variables_S("AutoRefresh:WKPTimer:ARTRemain:AutoLogout:AutoLogoutAlert:AvgWage:LocCap:VdrLnkExp:OrderReview:OrderEntry:MinLeadTime:VdrExpGraPeriod:Margin:JobNote:PONote:CustFUNote:PCustFUNote:RFQNote:CoCNote:VdrLnk:VdrSrvLnk:InvoiceEmail:POEmail:RFQEmail:CustFUEmail:PoCustFUEmail:ToolGroupEmail:SurveyEmail:QTEEmail:InvAvailEmail:DueTime:PN4CustEmail:OpenPOEmail:OpenAREmail:OTDGraphEmail:OTDGraphTrendEmail:ExpLimRtoEmail:AutoRecd:EnfExpCert:EnfMatPN:MinMedMax:EnfQty:TGR:OHE:EnfTola");
                    foreach (DataRow Rw in Tb.Rows)
                    {
                        switch (Rw["nKey"].ToString())
                        {
                            case "JobNote": txtJobNote.Text = Rw["sValue"].ToString(); break;
                            case "PONote": txtPONote.Text = Rw["sValue"].ToString(); break;
                            case "CustFUNote": txtCustFUNote.Text = Rw["sValue"].ToString(); break;
                            case "PCustFUNote": txtPCustFUNote.Text = Rw["sValue"].ToString(); break;
                            case "RFQNote": txtRFQNote.Text = Rw["sValue"].ToString(); break;
                            case "CoCNote": txtCoCNote.Text = Rw["sValue"].ToString(); break;
                            case "VdrLnk": txtVdrLnk.Text = Rw["sValue"].ToString(); break;
                            case "VdrSrvLnk": txtVdrSrvLnk.Text = Rw["sValue"].ToString(); break;
                            case "InvoiceEmail": txtInvoiceEmail.Text = Rw["sValue"].ToString(); break;
                            case "POEmail": txtPOEmail.Text = Rw["sValue"].ToString(); break;
                            case "RFQEmail": txtRFQEmail.Text = Rw["sValue"].ToString(); break;
                            case "CustFUEmail": txtCustFUEmail.Text = Rw["sValue"].ToString(); break;
                            case "PoCustFUEmail": txtPoCustFUEmail.Text = Rw["sValue"].ToString(); break;
                            case "ToolGroupEmail": txtToolGroupEmail.Text = Rw["sValue"].ToString(); break;
                            case "SurveyEmail": txtSurveyEmail.Text = Rw["sValue"].ToString(); break;
                            case "QTEEmail": txtQTEEmail.Text = Rw["sValue"].ToString(); break;
                            case "InvAvailEmail": txtInvAvailEmail.Text = Rw["sValue"].ToString(); break;
                            case "PN4CustEmail": txtPN4CustEmail.Text = Rw["sValue"].ToString(); break;
                            case "OpenPOEmail": txtOpenPOEmail.Text = Rw["sValue"].ToString(); break;
                            case "OpenAREmail": txtOpenAREmail.Text = Rw["sValue"].ToString(); break;
                            case "OTDGraphEmail": txtOTDGraphEmail.Text = Rw["sValue"].ToString(); break;
                            case "OTDGraphTrendEmail": txtOTDGraphTrendEmail.Text = Rw["sValue"].ToString(); break;
                            case "ExpLimRtoEmail": txtExpLimRtoEmail.Text = Rw["sValue"].ToString(); break;
                            case "VdrLnkExp": txtVdrLnkExp.Text = Rw["iValue"].ToString(); break;
                            case "OrderReview": txtOrderReview.Text = Rw["iValue"].ToString(); break;
                            case "OrderEntry": txtOrderEntry.Text = Rw["iValue"].ToString(); break;
                            case "MinLeadTime": txtMinLeadTime.Text = Rw["iValue"].ToString(); break;
                            case "VdrExpGraPeriod": txtVdrExpGraPeriod.Text = Rw["iValue"].ToString(); break;
                            case "Margin": txtMargin.Text = Rw["iValue"].ToString(); break;
                            case "DueTime": txtDueTime.Text = Rw["sValue"].ToString(); break;
                            case "LocCap": txtLocCap.Text = Rw["iValue"].ToString(); break;
                            case "AutoRefresh": txtAutoRefresh.Text = Rw["iValue"].ToString(); break;
                            case "WKPTimer": txtWKPTimer.Text = Rw["iValue"].ToString(); break;
                            case "ARTRemain": txtARTRemain.Text = Rw["iValue"].ToString(); break;
                            case "AutoLogout": txtAutoLogout.Text = Rw["iValue"].ToString(); break;
                            case "AutoLogoutAlert": txtAutoLogoutAlert.Text = Rw["iValue"].ToString(); break;
                            case "AvgWage": txtAvgWage.Text = Rw["sValue"].ToString(); break;
                            case "AutoRecd": ddlAutoRecd.SelectedValue = Rw["sValue"].ToString(); break;
                            case "EnfExpCert": ddlEnfExpCert.SelectedValue = Rw["sValue"].ToString(); break;
                            case "EnfMatPN": ddlEnfMatPN.SelectedValue = Rw["sValue"].ToString(); break;
                            case "MinMedMax": ddlMinMedMax.SelectedValue = Rw["sValue"].ToString(); break;
                            case "EnfQty": ddlEnfQty.SelectedValue = Rw["sValue"].ToString(); break;
                            case "TGR": txtTGR.Text = Rw["iValue"].ToString(); break;
                            case "OHE": txtOHE.Text = Rw["sValue"].ToString(); break;
                            case "EnfTola": ddlEnfTola.SelectedValue = Rw["sValue"].ToString(); break;
                        }
                    }
                    this.Title = AppCode.Equals("WIP") ? "Work Order Setup" : "RFQ Setup";
                }
            }
        }
        protected void btnAddTask_Click(object sender, EventArgs e)
        {
            var x = new clsStepName();
            if (lbxRemT.SelectedIndex > -1)
            {
                foreach (int idx in lbxRemT.GetSelectedIndices())
                {
                    x.spStepTask_I("0", lbxRemT.Items[idx].Value);
                }
                reloadTlbx();
            }
            //if (lbxRemT.SelectedIndex > -1) { clsDB.spStepTask_I("0", lbxRemT.SelectedValue); reloadTlbx(); }
        }
        protected void btnDelTask_Click(object sender, EventArgs e)
        {
            var x = new clsStepName();
            if (lbxAddT.SelectedIndex > -1)
            {
                foreach (int idx in lbxAddT.GetSelectedIndices())
                {
                    x.spStepTask_D(lbxAddT.Items[idx].Value);
                }
                reloadTlbx();
            }
        }
        protected void reloadTlbx()
        {
            var x = new clsStepName();
            lbxAddT.Items.Clear(); lbxRemT.Items.Clear();
            DataSet Ds = x.spStepTask_S("0", AppCode);
            lbxAddT.DataSource = Ds.Tables[0]; lbxAddT.DataBind();
            lbxRemT.DataSource = Ds.Tables[1]; lbxRemT.DataBind();
        }
        protected void btnSaveNote_Click(object sender, EventArgs e)
        {
            string errMsg = string.Empty;

            if (string.IsNullOrEmpty(txtVdrLnkExp.Text.Trim())) txtVdrLnkExp.Text = "30";
            if (!myBiz.Tools.clsValidator.isInteger(txtVdrLnkExp.Text)) errMsg = "You have entered invalid Vendor Link Expired value.";
            else if (Convert.ToInt32(txtVdrLnkExp.Text.Trim()) < 1) errMsg = "The Vendor Link Expired value must be 1 or greater.";

            if (string.IsNullOrEmpty(txtOrderReview.Text.Trim())) txtOrderReview.Text = "30";
            if (!myBiz.Tools.clsValidator.isInteger(txtOrderReview.Text)) errMsg = "You have entered invalid Days of Order Review value.";
            else if (Convert.ToInt32(txtOrderReview.Text.Trim()) < 1) errMsg = "The Days of Order Review value must be 1 or greater.";

            if (string.IsNullOrEmpty(txtOrderEntry.Text.Trim())) txtOrderEntry.Text = "30";
            if (!myBiz.Tools.clsValidator.isInteger(txtOrderEntry.Text)) errMsg = "You have entered invalid Days of Order Entry value.";
            else if (Convert.ToInt32(txtOrderEntry.Text.Trim()) < 1) errMsg = "The Days of Order Entry value must be 1 or greater.";

            if (string.IsNullOrEmpty(txtMinLeadTime.Text.Trim())) txtMinLeadTime.Text = "30";
            if (!myBiz.Tools.clsValidator.isInteger(txtMinLeadTime.Text)) errMsg = "You have entered invalid Minimum Lead Time value.";
            else if (Convert.ToInt32(txtMinLeadTime.Text.Trim()) < 1) errMsg = "The Minimum Lead Time value must be 1 or greater.";

            if (string.IsNullOrEmpty(txtVdrExpGraPeriod.Text.Trim())) txtVdrExpGraPeriod.Text = "10";
            if (!myBiz.Tools.clsValidator.isInteger(txtVdrExpGraPeriod.Text)) errMsg = "You have entered invalid Days of Vendor Expired Grace Period value.";
            else if (Convert.ToInt32(txtVdrExpGraPeriod.Text.Trim()) < 1) errMsg = "The Days of Vendor Expired Grace Period value must be 1 or greater.";

            if (string.IsNullOrEmpty(txtTGR.Text.Trim())) txtTGR.Text = "3";
            if (!myBiz.Tools.clsValidator.isInteger(txtTGR.Text)) errMsg = "You have entered invalid point for Find-Vendor.";
            else if (Convert.ToInt32(txtTGR.Text.Trim()) < 1) errMsg = "The points for Find-Vendor value must be 1 or greater.";

            if (string.IsNullOrEmpty(txtMargin.Text.Trim())) txtMargin.Text = "4";
            if (!myBiz.Tools.clsValidator.isInteger(txtMargin.Text)) errMsg = "You have entered invalid margin value.";
            else if (Convert.ToInt32(txtMargin.Text.Trim()) < 1) errMsg = "The margin value must be 1 or greater.";

            if (string.IsNullOrEmpty(txtLocCap.Text.Trim())) txtLocCap.Text = "0";
            if (!myBiz.Tools.clsValidator.isInteger(txtLocCap.Text)) errMsg = "You have entered invalid location capacity.";
            else if (Convert.ToInt32(txtLocCap.Text.Trim()) < 0) errMsg = "The location capacity cannot be negative.";

            if (string.IsNullOrEmpty(txtAutoRefresh.Text.Trim())) txtAutoRefresh.Text = "30";
            if (!myBiz.Tools.clsValidator.isInteger(txtAutoRefresh.Text)) errMsg = "You have entered invalid machine auto refresh.";
            else if (Convert.ToInt32(txtAutoRefresh.Text.Trim()) < 0) errMsg = "The machine auto refresh cannot be negative.";

            if (string.IsNullOrEmpty(txtWKPTimer.Text.Trim())) txtWKPTimer.Text = "30";
            if (!myBiz.Tools.clsValidator.isInteger(txtWKPTimer.Text)) errMsg = "You have entered invalid wakeup timer.";
            else if (Convert.ToInt32(txtWKPTimer.Text.Trim()) < 0) errMsg = "The wakeup timer cannot be negative.";

            if (string.IsNullOrEmpty(txtARTRemain.Text.Trim())) txtARTRemain.Text = "30";
            if (!myBiz.Tools.clsValidator.isInteger(txtARTRemain.Text)) errMsg = "You have entered invalid ART remaining.";
            else if (Convert.ToInt32(txtARTRemain.Text.Trim()) < 0) errMsg = "The ART remaining cannot be negative.";

            if (string.IsNullOrEmpty(txtAutoLogout.Text.Trim())) txtAutoLogout.Text = "20";
            if (!myBiz.Tools.clsValidator.isInteger(txtAutoLogout.Text)) errMsg = "You have entered invalid Auto logout.";
            else if (Convert.ToInt32(txtAutoLogout.Text.Trim()) < 0) errMsg = "The Auto logout cannot be negative.";

            if (string.IsNullOrEmpty(txtAutoLogoutAlert.Text.Trim())) txtAutoLogoutAlert.Text = "5";
            if (!myBiz.Tools.clsValidator.isInteger(txtAutoLogoutAlert.Text)) errMsg = "You have entered invalid Auto logout alert.";
            else if (Convert.ToInt32(txtAutoLogoutAlert.Text.Trim()) < 0) errMsg = "The Auto logout alert cannot be negative.";

            if (string.IsNullOrEmpty(txtAvgWage.Text.Trim())) txtAvgWage.Text = "10";
            if (!myBiz.Tools.clsValidator.isNumeric(txtAvgWage.Text)) errMsg = "You have entered invalid Average Wage.";
            else if (Convert.ToDecimal(txtAvgWage.Text.Trim()) < 0) errMsg = "The Average Wage cannot be negative.";

            if (string.IsNullOrEmpty(txtOHE.Text.Trim())) txtOHE.Text = "10";
            if (!myBiz.Tools.clsValidator.isNumeric(txtOHE.Text)) errMsg = "You have entered invalid Operating Hour Efficiency.";
            else if (Convert.ToDecimal(txtOHE.Text.Trim()) < 1 || Convert.ToDecimal(txtOHE.Text.Trim()) > 99) errMsg = "The Operating Hour Efficiency value must be between 1 and 99.";

            if (string.IsNullOrEmpty(errMsg))
            {
                clsDB.spAdmin_Variables_U(txtAutoRefresh.Text, txtWKPTimer.Text, txtARTRemain.Text, txtAutoLogout.Text, txtAutoLogoutAlert.Text, txtAvgWage.Text, txtLocCap.Text, txtVdrLnkExp.Text, txtOrderReview.Text, txtOrderEntry.Text, txtMinLeadTime.Text, txtVdrExpGraPeriod.Text, txtMargin.Text, txtJobNote.Text, txtPONote.Text, txtCustFUNote.Text, txtPCustFUNote.Text, txtRFQNote.Text, txtCoCNote.Text, txtVdrLnk.Text, txtVdrSrvLnk.Text, txtDueTime.Text, txtInvoiceEmail.Text, txtPOEmail.Text, txtRFQEmail.Text, txtCustFUEmail.Text, txtPoCustFUEmail.Text, txtToolGroupEmail.Text, txtSurveyEmail.Text, txtQTEEmail.Text, txtInvAvailEmail.Text, txtPN4CustEmail.Text, txtOpenPOEmail.Text, txtOpenAREmail.Text, txtOTDGraphEmail.Text, txtOTDGraphTrendEmail.Text, txtExpLimRtoEmail.Text, ddlAutoRecd.SelectedValue, ddlEnfExpCert.SelectedValue, ddlEnfMatPN.SelectedValue, ddlMinMedMax.SelectedValue, ddlEnfQty.SelectedValue, txtTGR.Text, txtOHE.Text, ddlEnfTola.SelectedValue);
                iMsg.ShowMsg("Your job notes, PO note, Emails, margin, and/or Due Time have been saved.", true);
            }
            else iMsg.ShowErr(errMsg, true);
        }
        protected void odsUpdated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null && e.Exception.InnerException != null)
            {
                iMsg.ShowErr(e.Exception.InnerException.Message, true);
                e.ExceptionHandled = true;
            }
        }
        protected override void enforceSecurity()
        {
        }

        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {
                odsDDL.UpdateParameters["mText"].DefaultValue = ((TextBox)gvDDL.FooterRow.FindControl("txtmText")).Text.Trim();
                odsDDL.UpdateParameters["mValue"].DefaultValue = ((TextBox)gvDDL.FooterRow.FindControl("txtmValue")).Text.Trim();
                odsDDL.UpdateParameters["isActive"].DefaultValue = ((CheckBox)gvDDL.FooterRow.FindControl("chkActive")).Checked.ToString();
                odsDDL.UpdateParameters["SortOrder"].DefaultValue = ((TextBox)gvDDL.FooterRow.FindControl("txtSortOrder")).Text.Trim();
                odsDDL.Update();
            }
        }
    }
}