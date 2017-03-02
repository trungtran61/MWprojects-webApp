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
using myBiz.Tools;
using myBiz.DAL;

namespace webApp.WIP
{
    public partial class DataEntry : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("WIP/Work Order Entry"))
            {
                if (!IsPostBack) gvSearch.EmptyDataText = "<b>Before entering new order, let's search for the existing orders/parts.</b>";
                else gvSearch.EmptyDataText = "<b>No Record Found!</b>";
            }
        }
        protected void btnNew_Click(object sender, EventArgs e)
        {
            txtWorkOrder.Text = txtWO.Text;
            txtPartNumber.Text = txtPN.Text;
            txtRevision.Text = string.Empty;
            ddlCustomerID.SelectedValue = "-1";
            ddlCustomerPO.SelectedIndex = -1;
            txtLine.Text = string.Empty;
            txtCustJob.Text = string.Empty;
            txtDueDate.Text = string.Empty;
            txtoQty.Text = string.Empty; txtTravelDesc.Text = string.Empty;
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
            clsWorkOrder mWO = new clsWorkOrder();
            DataRow Rw = mWO.Select(Convert.ToInt32(gvSearch.SelectedDataKey.Value.ToString()), IsPostBack).Rows[0];
            txtWorkOrder.Text = Rw["WorkOrder"].ToString();
            txtPartNumber.Text = Rw["PartNumber"].ToString();
            txtRevision.Text = Rw["Revision"].ToString();
            ddlCustomerID.SelectedValue = Rw["CustomerID"].ToString();
            ddlCustomerPO.SelectedIndex = -1; txtDueDate.Text = string.Empty;
            txtoQty.Text = Rw["oQty"].ToString(); txtUnitPrice.Text = Rw["UnitPrice"].ToString();
            txtDescription.Text = Rw["Description"].ToString(); txtLine.Text = Rw["Line"].ToString();
            txtCustJob.Text = Rw["CustJob"].ToString(); txtTravelDesc.Text = Rw["TravelDesc"].ToString(); showAddNew(true);
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Validate())
            {
                string WO = txtWorkOrder.Text, PN = txtPartNumber.Text, RV = txtRevision.Text, LN = txtLine.Text, CJ = txtCustJob.Text;
                string CPO = ddlCustomerPO.SelectedValue, UP = txtUnitPrice.Text, DES = txtDescription.Text, tDES = txtTravelDesc.Text;
                int oQty = Convert.ToInt32(txtoQty.Text), CID = Convert.ToInt32(ddlCustomerID.SelectedValue);

                if (clsValidator.isDate(txtDueDate.Text))
                {
                    DateTime DD = Convert.ToDateTime(txtDueDate.Text);
                    if (DD.CompareTo(DateTime.Today) >= 0)
                    {
                        try
                        {
                            clsWorkOrder mWO = new clsWorkOrder();
                            mWO.Insert(WO, PN, RV, CID, CPO, LN, CJ, DD, oQty, UP, DES, tDES);
                            iMsg.ShowMsg("Work order has been added successfully", true);
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
        private bool Validate()
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            x.Append(clsValidator.gErrMsg("Integer", txtWorkOrder.Text, "Work Order", true));
            if (ddlCustomerID.SelectedValue.Equals("-1")) x.Append("<li>Customer is required.</li>");
            x.Append(clsValidator.gErrMsg("String", ddlCustomerPO.SelectedValue, "Customer PO", true));
            x.Append(clsValidator.gErrMsg("String", txtPartNumber.Text, "Part Number", true));
            x.Append(clsValidator.gErrMsg("String", txtRevision.Text, "Revision", true));
            x.Append(clsValidator.gErrMsg("Integer", txtoQty.Text, "Order Qty", true));
            x.Append(clsValidator.gErrMsg("Numeric", txtUnitPrice.Text, "Unit Price", true));
            x.Append(clsValidator.gErrMsg("Date", txtDueDate.Text, "Due Date", true));
            if (x.Length > 0) getError(x.ToString());

            return x.Length < 1;
        }
        private void getError(string x)
        {
            iMsg.ShowErr("New Work Order can NOT be added", x, false);
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtWO.Text.Trim()) && string.IsNullOrEmpty(txtPN.Text.Trim()) && Convert.ToInt32(ddlCustomerName.SelectedValue) < 0 && string.IsNullOrEmpty(txtCustomerPO.Text.Trim()))
            {
                iMsg.ShowErr("Please enter something to search.", true);
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
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Add New Work Order");
        }
    }
}