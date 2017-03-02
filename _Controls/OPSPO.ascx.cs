using System;
using System.Linq;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class OPSPO : Common.ucAbstract
    {
        protected void Page_Init(object sender, EventArgs e) { hfUID.Value = Common.clsUser.uID; }
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) { pnlTask.Visible = !myMode.reqTask; gCmd("View"); }
        }
        protected void pbKeepOpen(object sender, EventArgs e)
        {
            mpePO.Show();
        }
        protected void poSelected(object sender, EventArgs e)
        {
            btnPreview.Enabled = true;
            btnPreview.OnClientClick = string.Format("javascript:loadPreview({0}); return false;", ddlPO.SelectedValue);
        }
        protected void poBound(object sender, EventArgs e)
        {
            if (ddlPO.Items.Count > 0) ddlPO.SelectedIndex = 0;
            poSelected(sender, e);
        }
        protected void deletePO(object sender, EventArgs e)
        {
            (new clsOPS()).Delete_PO(Convert.ToInt32(ddlPO.SelectedValue), this.AppCode);
            ddlPO.DataBind();
            iMsg.ShowMsg("Thank You! Your PO has been deleted!", true);
        }
        protected void sData(object sender, EventArgs e)
        {
            odsRFQPO.UpdateParameters["HID"].DefaultValue = hfHID.Value;
            odsRFQPO.UpdateParameters["UnitPrice"].DefaultValue = txtUPrice.Text.Trim();
            odsRFQPO.UpdateParameters["Amount"].DefaultValue = txtAmount.Text.Trim();
            odsRFQPO.UpdateParameters["Frieght"].DefaultValue = txtFrieght.Text.Trim();
            odsRFQPO.UpdateParameters["Misc"].DefaultValue = txtMisc.Text.Trim();
            odsRFQPO.UpdateParameters["Tax"].DefaultValue = txtTax.Text.Trim();
            odsRFQPO.UpdateParameters["LeadTime"].DefaultValue = txtLTime.Text.Trim();
            odsRFQPO.UpdateParameters["OPSDescID"].DefaultValue = ddlDesc.SelectedValue;
            odsRFQPO.UpdateParameters["Comment"].DefaultValue = txtComment.Text.Trim();
            odsRFQPO.UpdateParameters["Description"].DefaultValue = txtDescription.Text.Trim();
            odsRFQPO.UpdateParameters["Qty"].DefaultValue = txtQty.Text.Trim();
            odsRFQPO.UpdateParameters["Unit"].DefaultValue = ddlUnit.SelectedValue;
            odsRFQPO.UpdateParameters["VendorID"].DefaultValue = ddlVendor.SelectedValue;
            odsRFQPO.Update();
            iMsg.ShowMsg("Thank You! Your PO has been saved!", true);
        }
        protected void pEdit(object sender, EventArgs e)
        {
            DataTable Tb = (new clsOPS()).Select_PO(Convert.ToInt32(ddlPO.SelectedValue), this.AppCode);
            if (Tb != null && Tb.Rows.Count > 0)
            {
                DataRow Rw = Tb.Rows[0];
                hfHID.Value = Rw["HID"].ToString();
                hfPID.Value = Rw["ProcessID"].ToString();

                try { ddlType.SelectedValue = Rw["OPSTypeID"].ToString(); }
                catch { ddlType.SelectedIndex = -1; }
                try { ddlSpec.SelectedValue = Rw["OPSSpecID"].ToString(); }
                catch { ddlSpec.SelectedIndex = -1; }
                try { ddlDesc.SelectedValue = Rw["OPSDescID"].ToString(); }
                catch { ddlDesc.SelectedIndex = -1; }

                txtDescription.Text = Rw["ItemDesc"].ToString();
                txtQty.Text = Rw["Qty"].ToString();
                ddlUnit.SelectedValue = Rw["Unit"].ToString();
                txtUPrice.Text = Rw["UnitPrice"].ToString();
                txtAmount.Text = Rw["Amount"].ToString();
                txtFrieght.Text = Rw["Frieght"].ToString();
                txtMisc.Text = Rw["Misc"].ToString();
                txtTax.Text = Rw["Tax"].ToString();
                txtTotal.Text = Rw["Total"].ToString();
                lblAmount.Text = string.Format("[{0}]", txtAmount.Text);
                lblTotal.Text = string.Format("[{0}]", txtTotal.Text);
                txtLTime.Text = Rw["LeadTime"].ToString();
                try { ddlVendor.DataBind(); ddlVendor.SelectedValue = Rw["VendorID"].ToString(); }
                catch { ddlVendor.SelectedIndex = -1; }
                txtComment.Text = Rw["Comment"].ToString();
                litPartNumber.Text = Rw["PartNumber"].ToString();
                litRFQPO.Text = string.Format("{0}/{1}", Rw["RFQNumber"], Rw["PONumber"]);
                dControl(Rw["Status"].ToString());
                mpePO.Show();
            }
        }
        private void dControl(string Status)
        {
            txtLTime.ReadOnly = Status.Equals("Received") || Status.Equals("Verified") || Status.Equals("Billed") || Status.Equals("Paid");
            btnDelete.Enabled = ddlVendor.Enabled = !txtLTime.ReadOnly;
            txtDescription.ReadOnly = Status.Equals("Verified") || Status.Equals("Billed") || Status.Equals("Paid");
            txtQty.ReadOnly = txtUPrice.ReadOnly = txtAmount.ReadOnly = Status.Equals("Billed") || Status.Equals("Paid");
            ddlUnit.Enabled = !txtQty.ReadOnly; lnkNumbers.Visible = !txtAmount.ReadOnly;
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var q = (from i in gvQuote.Rows.Cast<GridViewRow>()
                     where (i.FindControl("chkQuote") as CheckBox).Checked
                     select new
                     {
                         ID = gvQuote.DataKeys[i.DataItemIndex].Values["HID"].ToString(),
                         Amt = string.IsNullOrWhiteSpace(i.Cells[7].Text) ? 0 : Convert.ToDouble(i.Cells[7].Text)
                     }).ToList();

            if (q.Count > 0)
            {
                if (Convert.ToBoolean(hfEnforcedBalance.Value) && q.Sum(x => x.Amt) > Convert.ToDouble(litBalance.Text))
                {
                    iMsg.ShowErr("Over Limit!", true);
                }
                else
                {
                    odsQuote.InsertParameters["QuoteID"].DefaultValue = string.Join(":", q.Select(x => x.ID).ToArray());
                    odsQuote.Insert(); ddlPO.DataBind();
                    iMsg.ShowMsg("Thank You! Your PO for OPS has been created.", true);
                }
            }
            else iMsg.ShowErr("Please select the item to create a PO for!", true);
        }
        protected override void dTask()
        {
            pnlTask.Enabled = true;
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            pnlTask.Enabled = false;
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "Generate PO");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = ddlPO.Items.Count > 0 && isYN("t05");
            btnSubmit.Visible = isYN("t06");

            var bd = new myBiz.DAL.clsBudget(); var Rw = bd.BudgetForcast_Balance_S(IDs[3]);
            btnSubmit.Enabled = !bd.BudgetForcast_Enforced_S(IDs[3]);
            litBalance.Text = Rw["Balance"].ToString();
            hfEnforcedBalance.Value = Rw["Enforced"].ToString();
            if (!btnSubmit.Enabled) iMsg.ShowErr("This expense account is over limit.", false);
        }
    }
}