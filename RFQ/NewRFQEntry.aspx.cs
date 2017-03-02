using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using myBiz.Tools;
using myBiz.DAL;
using webApp.Common;

namespace webApp.RFQ
{
    public partial class NewRFQEntry : pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("RFQ/RFQ Entry"))
            {
                if (!IsPostBack) gvSearch.EmptyDataText = "<b>Before entering new RFQ, please search for existing RFQs.</b>";
                else gvSearch.EmptyDataText = "<b>No Record Found!</b>";
            }
        }
        protected void btnNew_Click(object sender, EventArgs e)
        {
            txtQuote.Text = txtRFQ.Text;
            txtPartNumber.Text = txtPN.Text;
            txtRevision.Text = string.Empty;
            ddlCustomerID.SelectedValue = "0";
            txtCustomerRFQ.Text = string.Empty;
            txtLine.Text = string.Empty;
            txtCustJob.Text = string.Empty;
            txtDueDate.Text = string.Empty;
            //txtoQty.Text = string.Empty;
            txtRouterDesc.Text = string.Empty;
            txtUnitPrice.Text = string.Empty; txtDescription.Text = string.Empty;

            showAddNew(true);
        }
        protected override void OnInit(EventArgs e)
        {
            if (!Page.ClientScript.IsStartupScriptRegistered("setDate"))
            {
                DataTable Tb = clsDB.spAdmin_Variables_S("DueTime");
                string[] v = Tb.Rows[0]["sValue"].ToString().Split(':');
                int min = Convert.ToInt32(v[1]) + (Convert.ToInt32(v[0]) * 60);
                System.Text.StringBuilder x = new System.Text.StringBuilder("function setDate(sender,args) {\n");
                x.Append(" var Dt = new Date(sender._selectedDate);\n");
                x.Append(string.Format(" Dt.setMinutes({0});\n", min));
                x.Append(" sender._textbox.set_Value(Dt.format(sender._format));\n}\n");
                Page.ClientScript.RegisterStartupScript(typeof(Page), "setDate", x.ToString(), true);
            }
            base.OnInit(e);
        }
        protected void gv_Changed(object sender, EventArgs e)
        {
            clsRFQ mRFQ = new clsRFQ();
            DataRow Rw = mRFQ.Select(Convert.ToInt32(gvSearch.SelectedDataKey.Value.ToString()), IsPostBack).Rows[0];
            txtQuote.Text = Rw["RFQ"].ToString();
            txtPartNumber.Text = Rw["PartNumber"].ToString();
            txtRevision.Text = Rw["Revision"].ToString();
            ddlCustomerID.SelectedValue = Rw["CustomerID"].ToString();
            txtCustomerRFQ.Text = Rw["CustomerRFQ"].ToString(); txtDueDate.Text = string.Empty;
            //txtoQty.Text = Rw["mulQty"].ToString();
            txtUnitPrice.Text = Rw["UnitPrice"].ToString();
            txtDescription.Text = Rw["Description"].ToString(); txtLine.Text = Rw["Line"].ToString();
            txtCustJob.Text = Rw["CustJob"].ToString(); txtRouterDesc.Text = Rw["RouterDesc"].ToString(); showAddNew(true);
        }
        protected void newBox(object sender, EventArgs e)
        {
            var cnt = BoxCount + 1;
            txtOrderQty2.Visible = cnt >= 2;
            txtOrderQty3.Visible = cnt >= 3;
            txtOrderQty4.Visible = cnt >= 4;
            txtOrderQty5.Visible = cnt >= 5;
            txtOrderQty6.Visible = cnt >= 6;
            txtOrderQty7.Visible = cnt >= 7;
            txtOrderQty8.Visible = cnt >= 8;
            txtOrderQty9.Visible = cnt >= 9;
            txtOrderQty10.Visible = cnt >= 10;
            txtOrderQty11.Visible = cnt >= 11;
            txtOrderQty12.Visible = cnt >= 12;
            BoxCount = cnt;
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (doValidate)
            {
                string Qte = txtQuote.Text, PN = txtPartNumber.Text, RV = txtRevision.Text, LN = txtLine.Text, CJ = txtCustJob.Text;
                string CRfq = txtCustomerRFQ.Text, UP = txtUnitPrice.Text, DES = txtDescription.Text, rDES = txtRouterDesc.Text;
                int oQty = Convert.ToInt32(txtOrderQty1.Text), CID = Convert.ToInt32(ddlCustomerID.SelectedValue);

                if (clsValidator.isDate(txtDueDate.Text))
                {
                    DateTime DD = Convert.ToDateTime(txtDueDate.Text);
                    if (DD.CompareTo(DateTime.Today) >= 0)
                    {
                        try
                        {
                            clsRFQ mRFQ = new clsRFQ();
                            mRFQ.Insert(Qte, PN, RV, CID, CRfq, LN, CJ, oQty, OrderQty, UP, DES, rDES, DD);
                            iMsg.ShowMsg("RFQ has been added successfully", true);
                        }
                        catch (Exception ex)
                        {
                            getError(string.Format("<li>{0}</li>", ex.Message));
                        }
                    }
                    else getError("<li>Due date must be on or after today's date.</li>");
                }
                else getError("<li>You have entered invalid due date</li>");
            }
        }
        private bool doValidate
        {
            get
            {
                System.Text.StringBuilder x = new System.Text.StringBuilder();
                x.Append(clsValidator.gErrMsg("Integer", txtQuote.Text, "Quote", true));
                if (ddlCustomerID.SelectedValue.Equals("0")) x.Append("<li>Customer is required.</li>");
                x.Append(clsValidator.gErrMsg("String", txtCustomerRFQ.Text, "Customer RFQ", true));
                x.Append(clsValidator.gErrMsg("String", txtPartNumber.Text, "Part Number", true));
                x.Append(clsValidator.gErrMsg("String", txtRevision.Text, "Revision", true));
                x.Append(clsValidator.gErrMsg("Integer", txtOrderQty1.Text, "Order Qty (box 1)", true));
                x.Append(clsValidator.gErrMsg("Integer", txtOrderQty2.Text, "Order Qty (box 2)", false));
                x.Append(clsValidator.gErrMsg("Integer", txtOrderQty3.Text, "Order Qty (box 3)", false));
                x.Append(clsValidator.gErrMsg("Integer", txtOrderQty4.Text, "Order Qty (box 4)", false));
                x.Append(clsValidator.gErrMsg("Integer", txtOrderQty5.Text, "Order Qty (box 5)", false));
                x.Append(clsValidator.gErrMsg("Integer", txtOrderQty6.Text, "Order Qty (box 6)", false));
                x.Append(clsValidator.gErrMsg("Integer", txtOrderQty7.Text, "Order Qty (box 7)", false));
                x.Append(clsValidator.gErrMsg("Integer", txtOrderQty8.Text, "Order Qty (box 8)", false));
                x.Append(clsValidator.gErrMsg("Integer", txtOrderQty9.Text, "Order Qty (box 9)", false));
                x.Append(clsValidator.gErrMsg("Integer", txtOrderQty10.Text, "Order Qty (box 10)", false));
                x.Append(clsValidator.gErrMsg("Integer", txtOrderQty11.Text, "Order Qty (box 11)", false));
                x.Append(clsValidator.gErrMsg("Integer", txtOrderQty12.Text, "Order Qty (box 12)", false));
                x.Append(clsValidator.gErrMsg("Numeric", txtUnitPrice.Text, "Unit Price", false));
                x.Append(clsValidator.gErrMsg("Date", txtDueDate.Text, "Due Date", true));
                if (x.Length > 0) getError(x.ToString());

                return x.Length < 1;
            }
        }
        private void getError(string x)
        {
            iMsg.ShowErr("New RFQ can NOT be added", x, false);
        }
        private string OrderQty
        {
            get
            {
                var txt = plhOrderQty.Controls.Cast<Control>().Where(x => x.Visible).Select(x => (x as TextBox).Text).ToList();
                var filteredData = txt.Where(x => !string.IsNullOrWhiteSpace(x));
                return string.Join("/", filteredData);
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtRFQ.Text.Trim()) && string.IsNullOrEmpty(txtPN.Text.Trim()))
            {
                jMsg.ShowErr("Please enter something to search.", true);
            }
            btnNew.Enabled = isYN("k01");
            gvSearch.SelectedIndex = -1;
        }
        protected void btnBack_Click(object sender, EventArgs e) { showAddNew(false); gvSearch.DataBind(); }
        protected void showAddNew(bool YN) { pnlAddNew.Visible = YN; pnlSearch.Visible = !YN; }
        protected void gv_PreRender(object sender, EventArgs e)
        {
            odsSearch.SelectParameters["isPB"].DefaultValue = IsPostBack ? "true" : "false";
        }
        protected void Rw_Bound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1)
            {
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
                {
                    ((LinkButton)e.Row.FindControl("lnkSelect")).Enabled = isYN("k01");
                }
            }
        }
        protected int BoxCount
        {
            get { return Convert.ToInt32(hfBoxCount.Value); }
            set { hfBoxCount.Value = value.ToString(); }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Add New RFQ");
        }
    }
}