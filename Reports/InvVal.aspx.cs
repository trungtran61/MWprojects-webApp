using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using myBiz.Tools;
using myBiz.DAL;

namespace webApp.Reports
{
    public partial class InvVal : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Report/Inventory Valuation");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            rptInvVal.DataBind(); btnGo.Visible = isYN("k01");
            litGrandTotal.Visible = trHeader.Visible = rptInvVal.Items.Count > 0;
            btnEmail.Visible = trHeader.Visible && isYN("k02");
            if (btnEmail.Visible) txtFrom.Text = (new clsUser()).getUserEmail(Common.clsUser.uID, string.Empty)["Email"].ToString();
        }
        protected void doSend(object sender, EventArgs e)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(clsValidator.Required(txtTo.Text, "To address", true));
            sb.Append(clsValidator.Required(txtFrom.Text, "From address", true));

            if (sb.Length > 0) iMsg.ShowErr("Cannot send email", sb.ToString(), true);
            else
            {
                DataTable Tb = (new clsReport()).InvVal_S2(ddlCustomerName.SelectedValue, txtPartNumber.Text, txtWO.Text, ddlLocation.SelectedValue);
                Hashtable h = new Hashtable(); h.Add("RowList", Tb);
                clsPDF objPdf = new clsPDF(Util.AppSetting("FormPath"), "InvVal");

                Hashtable hEmail = new Hashtable(); hEmail.Add("From", txtFrom.Text.Trim()); hEmail.Add("To", txtTo.Text.Trim());
                hEmail.Add("Subject", txtSubject.Text.Trim()); hEmail.Add("Body", txtBody.Text.Trim().Replace("\r", "<br>").Replace("\n", "<br>"));

                System.Collections.Generic.List<Hashtable> Att = new System.Collections.Generic.List<Hashtable>();
                Hashtable i = new Hashtable(); i.Add("Att", objPdf.getPdf(h)); i.Add("Nm", "InvVal.pdf"); Att.Add(i);
                hEmail.Add("Attachments", Att); string rMsg = Util.sendEmail(hEmail);
                if (!string.IsNullOrEmpty(rMsg)) iMsg.ShowErr(rMsg, true);
                else iMsg.ShowMsg("Thank you! Email has been sent.", true);
            }
            btnCancel.OnClientClick = string.Format("javascript:$('#dvEmail').hide(); javascript:$('#{0}').html(''); return false;", iMsg.ClientID);
        }
        protected void lGrandTotal(object sender, EventArgs e)
        {
            DataTable Tb = (new clsReport()).InvVal_S3(ddlCustomerName.SelectedValue, txtPartNumber.Text, txtWO.Text, ddlLocation.SelectedValue);
            (sender as Literal).Text = string.Format("<b><u>Grand On-Hand Total:</u></b> {0:c}<br><b><u>Grand Available Total:</u></b> {1:c}", Tb.Rows[0]["OnHandTotal"], Tb.Rows[0]["AvailTotal"]);
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Run Report");
            PageSec.Add("k02", "Send Email");
        }
    }
}