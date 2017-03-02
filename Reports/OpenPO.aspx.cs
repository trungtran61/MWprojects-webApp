using System;
using System.Collections;
using System.Data;
using System.Web.UI.WebControls;
using myBiz.Tools;
using myBiz.DAL;
using System.Linq;

namespace webApp.Reports
{
    public partial class OpenPO : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Report/OpenPO");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnGo.Visible = isYN("k01");
        }
        protected void ddlLoad(object sender, EventArgs e)
        {
            if (!IsPostBack && isYN("k03"))
            {
                var items = ddlCustomerName.Items;
                var rem = items.Cast<ListItem>().Where(x => Convert.ToInt32(x.Value) > 0).ToList();
                rem.ForEach(x => ddlCustomerName.Items.Remove(x));
            }
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            gvOpenPO.AllowPaging = !ddl.SelectedValue.Equals("*");
            if (gvOpenPO.AllowPaging) gvOpenPO.PageSize = Convert.ToInt32(ddl.SelectedValue);
            ddlIndex = ddl.SelectedIndex;
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header) (e.Row.FindControl("ddlDisplay") as DropDownList).SelectedIndex = ddlIndex;
        }
        protected void gvBound(object sender, EventArgs e)
        {
            bool iFind = (sender as GridView).Rows.Count > 0;
            btnEmail.Visible = isYN("k02") && iFind;

            if (btnEmail.Visible)
            {
                litOpenPO.Text = string.Format("Open PO Report for: {0}", ddlCustomerName.SelectedItem.Text);
                DataRow Rw = (new clsUser()).getUserEmail(Common.clsUser.uID, "OpenPOEmail");
                txtFrom.Text = Rw["Email"].ToString();
                txtSubject.Text = string.Format("Open PO Report for {0}", ddlCustomerName.SelectedItem.Text);
                txtBody.Text = Rw["Body"].ToString();
                litEmail.Text = generateAddress;
            }
            else if (IsPostBack && !iFind) litOpenPO.Text = string.Format("No Records Found for {0}!", ddlCustomerName.SelectedItem.Text);
        }

        protected string gPN()
        {
            var xSt = Eval("xSt").ToString();
            var style = !string.IsNullOrWhiteSpace(xSt) ? string.Format("<span style=\"{1}\">{0}</span>", xSt, Util.AppSetting("StatusStyle")) : string.Empty;

            return string.Format("{0}{1}", Eval("PN"), style);
        }
        protected string gStatus()
        {
            var status = Eval("Status").ToString();
            var bcolor = status.Equals("Late") ? "#FE2E2E" : status.Equals("Behind") ? "Yellow" : "#58FA58";
            var fcolor = status.Equals("Late") ? "#FFFFFF   " : status.Equals("Behind") ? "Black" : "#000000   ";
            return string.Format("<span style=\"background-color:{1};color:{2}\">{0}</span>", status, bcolor, fcolor);
        }
        private int ddlIndex
        {
            get { return ViewState["ddlIndex"] != null ? Convert.ToInt32(ViewState["ddlIndex"]) : 1; }
            set { ViewState["ddlIndex"] = value; }
        }
        protected void doSend(object sender, EventArgs e)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(clsValidator.Required(txtTo.Text, "To address", true));
            sb.Append(clsValidator.Required(txtFrom.Text, "From address", true));

            if (sb.Length > 0) iMsg.ShowErr("Cannot send email", sb.ToString(), true);
            else
            {
                var CN = ddlCustomerName.SelectedItem;
                DataTable Tb = (new clsReport()).OpenPO(Convert.ToInt32(CN.Value), txtPO.Text, txtLN.Text, txtPN.Text, txtWO.Text, ddlSN.SelectedValue, ddlST.SelectedValue);

                Hashtable hashForm = new Hashtable(); hashForm.Add("CustomerName", CN.Text);
                Hashtable h = new Hashtable(); h.Add("hashForm", hashForm); h.Add("RowList", Tb);
                clsPDF objPdf = new clsPDF(Util.AppSetting("FormPath"), "OpenPO"); objPdf.DF = "MM/dd/yy";

                Hashtable hEmail = new Hashtable(); hEmail.Add("From", txtFrom.Text.Trim()); hEmail.Add("To", txtTo.Text.Trim());
                hEmail.Add("Subject", txtSubject.Text.Trim()); hEmail.Add("Body", txtBody.Text.Trim().Replace("\r", "<br>").Replace("\n", "<br>"));

                System.Collections.Generic.List<Hashtable> Att = new System.Collections.Generic.List<Hashtable>();
                Hashtable i = new Hashtable(); i.Add("Att", objPdf.getPdf(h)); i.Add("Nm", "OpenPO.pdf"); Att.Add(i);
                hEmail.Add("Attachments", Att); string rMsg = Util.sendEmail(hEmail);
                if (!string.IsNullOrEmpty(rMsg)) iMsg.ShowErr(rMsg, true);
                else iMsg.ShowMsg("Thank you! Email has been sent.", true);
            }
            btnCancel.OnClientClick = string.Format("javascript:$('#dvEmail').hide(); javascript:$('#{0}').html(''); return false;", iMsg.ClientID);
        }
        private string generateAddress
        {
            get
            {
                DataTable Tb = (new clsCommunication()).CompanyEmailList_S(Convert.ToInt32(ddlCustomerName.SelectedValue));
                if (Tb != null && Tb.Rows.Count > 0)
                {
                    System.Text.StringBuilder s = new System.Text.StringBuilder("<table>");
                    string tr = "<tr><td><input type=\"checkbox\" id=\"xAddress_{0}\" name=\"xAddress_{0}\" value=\"{1}\" /> {2}</td></tr>\n";
                    int Cnt = Tb.Rows.Count;
                    for (int i = 0; i < Cnt; i++)
                    {
                        DataRow r = Tb.Rows[i];
                        s.Append(string.Format(tr, i, r["Email"], r["xEmail"]));
                    }
                    s.Append("</table>"); hfCnt.Value = Cnt.ToString();
                    return s.ToString();
                }
                else return "Company does not have contact list.";
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Run Report");
            PageSec.Add("k02", "Send Email");
            PageSec.Add("k03", "Show ALL option only");
        }
    }
}