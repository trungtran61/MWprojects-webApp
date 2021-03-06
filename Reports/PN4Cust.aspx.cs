﻿using System;
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
    public partial class PN4Cust : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Report/PN4Customer");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnGo.Visible = isYN("k01");
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            gvPN4Cust.AllowPaging = !ddl.SelectedValue.Equals("*");
            if (gvPN4Cust.AllowPaging) gvPN4Cust.PageSize = Convert.ToInt32(ddl.SelectedValue);
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
                litPN4Cust.Text = string.Format("P/N Make for: {0}", ddlCustomerName.SelectedItem.Text);
                DataRow Rw = (new clsUser()).getUserEmail(Common.clsUser.uID, "PN4CustEmail");
                txtFrom.Text = Rw["Email"].ToString();
                txtSubject.Text = string.Format("P/N Make for {0}", ddlCustomerName.SelectedItem.Text);
                txtBody.Text = Rw["Body"].ToString();
                litEmail.Text = generateAddress;
            }
            else if (IsPostBack && !iFind) litPN4Cust.Text = string.Format("No Records Found for {0}!", ddlCustomerName.SelectedItem.Text);
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
                ListItem CN = ddlCustomerName.SelectedItem;
                DataTable Tb = (new clsReport()).PN4Cust(Convert.ToInt32(CN.Value), txtPartNumber.Text);

                Hashtable hashForm = new Hashtable(); hashForm.Add("CustomerName", CN.Text);
                Hashtable h = new Hashtable(); h.Add("hashForm", hashForm); h.Add("RowList", Tb);
                clsPDF objPdf = new clsPDF(Util.AppSetting("FormPath"), "PN4Cust");

                Hashtable hEmail = new Hashtable(); hEmail.Add("From", txtFrom.Text.Trim()); hEmail.Add("To", txtTo.Text.Trim());
                hEmail.Add("Subject", txtSubject.Text.Trim()); hEmail.Add("Body", txtBody.Text.Trim().Replace("\r", "<br>").Replace("\n", "<br>"));

                System.Collections.Generic.List<Hashtable> Att = new System.Collections.Generic.List<Hashtable>();
                Hashtable i = new Hashtable(); i.Add("Att", objPdf.getPdf(h)); i.Add("Nm", "PN4Cust.pdf"); Att.Add(i);
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
        }
    }
}