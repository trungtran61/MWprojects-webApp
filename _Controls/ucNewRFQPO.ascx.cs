using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Linq;
using myBiz.Tools;

namespace webApp._Controls
{
    public partial class ucNewRFQPO : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void nData(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            x.Append(clsValidator.gErrMsg("String", txtPartNumberN.Text, "Part Number", true));
            x.Append(clsValidator.gErrMsg("Integer", txtQtyN.Text, "Qty", false));
            x.Append(clsValidator.gErrMsg("Numeric", txtUnitPriceN.Text, "Unit Price", false));
            x.Append(clsValidator.gErrMsg("Numeric", txtAmountN.Text, "Amount", false));
            x.Append(clsValidator.gErrMsg("Integer", txtLeadTimeN.Text, "Lead Time", false));

            //var Amount = !string.IsNullOrEmpty(txtAmountN.Text.Trim()) ? Convert.ToDecimal(txtAmountN.Text) : 0;

            if (x.Length > 0)
            {
                jMsg.ShowErr("<br>Cannot add new PO", x.ToString(), true);
                mpeRFQPON.Show();
            }
            else
            {
                int Qty = !string.IsNullOrEmpty(txtQtyN.Text.Trim()) ? Convert.ToInt32(txtQtyN.Text) : 0;
                decimal UnitPrice = !string.IsNullOrEmpty(txtQtyN.Text.Trim()) ? Convert.ToDecimal(txtUnitPriceN.Text) : 0;
                decimal Amount = !string.IsNullOrEmpty(txtAmountN.Text.Trim()) ? Convert.ToDecimal(txtAmountN.Text) : Qty * UnitPrice;
                int LeadTime = !string.IsNullOrEmpty(txtLeadTimeN.Text.Trim()) ? Convert.ToInt32(txtLeadTimeN.Text) : 0;

                if (Qty < 0) x.Append("<li>Qty must be non-negative.</li>");
                if (UnitPrice < 0) x.Append("<li>Unit Price must be non-negative.</li>");
                if (Amount < 0) x.Append("<li>Amount must be non-negative.</li>");
                if (LeadTime < 0) x.Append("<li>Lead Time must be non-negative.</li>");

                var v = ddlProcessIDN.SelectedValue.Split(':');

                if (x.Length < 1)
                {
                    if (v[3].Equals("1") && Amount > Convert.ToDecimal(v[2]))
                    {
                        x.Append("<li>Over Limit!</li>");
                    }
                }

                if (x.Length > 0)
                {
                    jMsg.ShowErr("<br>Cannot add new PO", x.ToString(), true);
                    mpeRFQPON.Show();
                }
                else
                {
                    string UN = Common.clsUser.uID;
                    int wID = Convert.ToInt32(ddlWorkOrderN.SelectedValue);
                    int pID = Convert.ToInt32(v[0]);
                    int VendorID = Convert.ToInt32(ddlVendorN.SelectedValue);
                    string Desc = txtDescriptionN.Text.Trim();
                    string Comment = txtCommentN.Text.Trim();
                    string Unit = ddlUnitN.SelectedValue;
                    string PN = txtPartNumberN.Text.Trim();

                    DataTable Tb = (new myBiz.DAL.clsTool()).RFQPO_Insert(UN, PN, wID, pID, Desc, Qty, Unit, UnitPrice, Amount, LeadTime, VendorID, Comment);
                    clearForm(); Hashtable h = new Hashtable();
                    h.Add("Msg", string.Format("Thank You! RFQ/PO {0} has been created.", Tb.Rows[0]["RFQPO"]));
                    h.Add("Refresh", true); myEvent(h);
                    odsRFQPO.SelectParameters["POID"].DefaultValue = Tb.Rows[0]["HID"].ToString();
                    gvSearch.DataBind();
                }
            }
        }
        protected void ddlSelected(object sender, EventArgs e)
        {
            mpeRFQPON.Show();
        }
        protected void ddlPreRender(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            foreach (ListItem i in ddl.Items)
            {
                var v = i.Value.Split(':');

                if (v[1].Equals("N"))
                {
                    i.Attributes.Add("style", "color:gray;");
                    i.Attributes.Add("title", v[2]);
                }
                else if (v[1].Equals("Y"))
                {
                    i.Attributes.Add("title", v[2]);
                }
            }
        }
        protected void ddlVendorPreRender(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            foreach (ListItem i in ddl.Items)
            {
                if (i.Text.Contains("(Expired)"))
                {
                    i.Attributes.Add("style", "background:gray;color:red;");
                }
            }
        }
        private void clearForm()
        {
            ddlWorkOrderN.SelectedIndex = ddlProcessIDN.SelectedIndex = ddlVendorN.SelectedIndex = ddlUnitN.SelectedIndex = -1;
            txtDescriptionN.Text = txtQtyN.Text = txtUnitPriceN.Text = string.Empty;
            txtPartNumberN.Text = txtAmountN.Text = txtLeadTimeN.Text = txtCommentN.Text = string.Empty;
        }
        protected void btnNew_Click(object sender, EventArgs e)
        {
            mpeRFQPON.Show();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            odsRFQPO.SelectParameters["POID"].DefaultValue = "0";
            if (string.IsNullOrEmpty(txtPartNumber.Text.Trim()) && string.IsNullOrEmpty(txtDesc.Text.Trim()) && string.IsNullOrEmpty(txtPONumber.Text.Trim())
                && string.IsNullOrEmpty(txtRFQNumber.Text.Trim()) && string.IsNullOrEmpty(txtVendorName.Text.Trim()))
            {
                btnNew.Enabled = false; Hashtable h = new Hashtable();
                h.Add("errMsg", "Please enter something to search.");
                myEvent(h);
            }
            else
            {
                btnNew.Enabled = true; gvSearch.DataBind();
                if (gvSearch.Rows.Count < 1)
                {
                    Hashtable h = new Hashtable();
                    h.Add("Msg", "No Record Found!");
                    myEvent(h);
                }
            }
        }
        protected void doReset(object sender, EventArgs e)
        {
            txtPartNumber.Text = txtDesc.Text = txtPONumber.Text = txtRFQNumber.Text = txtVendorName.Text = string.Empty;
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("cNew"))
            {
                GridViewRow Rw = gvSearch.Rows[Convert.ToInt32(e.CommandArgument)];
                string wID = (Rw.FindControl("hfWorkOrderIDN") as HiddenField).Value;
                string pID = (Rw.FindControl("hfProcessIDN") as HiddenField).Value;
                string vID = (Rw.FindControl("hfVendorIDN") as HiddenField).Value;

                try { ddlWorkOrderN.DataBind(); ddlWorkOrderN.SelectedValue = wID; }
                catch { ddlWorkOrderN.SelectedIndex = -1; }
                try
                {
                    ddlProcessIDN.DataBind();
                    ddlProcessIDN.Items.Cast<ListItem>().FirstOrDefault(x => x.Value.StartsWith(string.Format("{0}:Y", pID))).Selected = true;
                }
                catch
                {
                    ddlProcessIDN.SelectedIndex = -1;
                }

                txtPartNumberN.Text = clsSpace(Rw.Cells[1].Text);
                txtDescriptionN.Text = clsSpace(Rw.Cells[2].Text);
                litRFQPON.Text = string.Format("{0}/{1}", clsSpace(Rw.Cells[3].Text), clsSpace(Rw.Cells[4].Text));
                txtQtyN.Text = clsSpace(Rw.Cells[5].Text);

                try { ddlUnitN.DataBind(); ddlUnitN.SelectedValue = clsSpace(Rw.Cells[6].Text); }
                catch { ddlUnitN.SelectedIndex = -1; }

                txtUnitPriceN.Text = clsSpace(Rw.Cells[7].Text);
                txtAmountN.Text = clsSpace(Rw.Cells[8].Text);
                txtLeadTimeN.Text = clsSpace(Rw.Cells[9].Text);

                try { ddlVendorN.DataBind(); ddlVendorN.SelectedValue = vID; }
                catch { ddlVendorN.SelectedIndex = -1; }

                txtCommentN.Text = string.Empty;
                mpeRFQPON.Show();
            }
        }
        protected void gvBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
                (e.Row.FindControl("lnkSelect") as LinkButton).CommandArgument = e.Row.RowIndex.ToString();
        }
        private string clsSpace(string x)
        {
            return x.Equals("&nbsp;") ? string.Empty : x;
        }
    }
}