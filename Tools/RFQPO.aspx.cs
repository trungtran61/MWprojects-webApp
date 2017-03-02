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

namespace webApp.Tools
{
    public partial class RFQPO : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Create RFQ/PO"))
            {
                if (!IsPostBack) hfUID.Value = Common.clsUser.uID;
                ucRFQPO.myEvent += new Common.myDelegate(ucRFQPO_myEvent);
            }
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            gvRFQPO.PageSize = Convert.ToInt32(ddl.SelectedValue);
            getSelectedIndex = ddl.SelectedIndex;
        }
        protected void doReset(object sender, EventArgs e)
        {
            txt1PartNumber.Text = txt1Desc.Text = txt1PONumber.Text = txt1RFQNumber.Text = txt1VendorName.Text = string.Empty;
        }
        protected void ucRFQPO_myEvent(Hashtable h)
        {
            if (h.Contains("errMsg")) iMsg.ShowErr(h["errMsg"].ToString(), true);
            else if (h.Contains("Msg")) iMsg.ShowMsg(h["Msg"].ToString(), true);

            if (h.Contains("Refresh")) gvRFQPO.DataBind();
        }
        protected void sData(object sender, EventArgs e)
        {
            odsRFQPO.UpdateParameters["HID"].DefaultValue = hfHID.Value;
            odsRFQPO.UpdateParameters["Description"].DefaultValue = txtDescription.Text.Trim();
            odsRFQPO.UpdateParameters["Qty"].DefaultValue = txtQty.Text.Trim();
            odsRFQPO.UpdateParameters["Unit"].DefaultValue = ddlUnit.SelectedValue;
            odsRFQPO.UpdateParameters["UnitPrice"].DefaultValue = txtUnitPrice.Text.Trim();
            odsRFQPO.UpdateParameters["Amount"].DefaultValue = txtAmount.Text.Trim();
            odsRFQPO.UpdateParameters["Frieght"].DefaultValue = txtFrieght.Text.Trim();
            odsRFQPO.UpdateParameters["Misc"].DefaultValue = txtMisc.Text.Trim();
            odsRFQPO.UpdateParameters["Tax"].DefaultValue = txtTax.Text.Trim();
            odsRFQPO.UpdateParameters["LeadTime"].DefaultValue = txtLeadTime.Text.Trim();
            odsRFQPO.UpdateParameters["VendorID"].DefaultValue = ddlVendor.SelectedValue;
            odsRFQPO.Update();
            if (!string.IsNullOrEmpty(txtComment.Text.Trim()))
            {
                odsChatLog.InsertParameters["LnkID"].DefaultValue = hfxHID.Value;
                odsChatLog.InsertParameters["Note"].DefaultValue = txtComment.Text.Trim();
                odsChatLog.Insert();
            }
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("pEdit"))
            {
                int i = Convert.ToInt32(e.CommandArgument); GridViewRow Rw = gvRFQPO.Rows[i];
                string RFQ = (Rw.FindControl("lnkRFQ") as LinkButton).Text;
                string PO = (Rw.FindControl("lnkPO") as LinkButton).Text;

                hfHID.Value = gvRFQPO.DataKeys[i].Value.ToString();
                hfPID.Value = (Rw.FindControl("hfProcessID") as HiddenField).Value;
                hfxHID.Value = (Rw.FindControl("hfxHID") as HiddenField).Value;
                txtDescription.Text = clsSpace((Rw.FindControl("hfDescription") as HiddenField).Value);
                txtQty.Text = clsSpace(Rw.Cells[7].Text);
                ddlUnit.SelectedValue = clsSpace(Rw.Cells[8].Text);
                txtUnitPrice.Text = clsSpace(Rw.Cells[9].Text);
                txtAmount.Text = clsSpace(Rw.Cells[10].Text);
                txtFrieght.Text = (Rw.FindControl("hfFrieght") as HiddenField).Value;
                txtMisc.Text = (Rw.FindControl("hfMisc") as HiddenField).Value;
                txtTax.Text = (Rw.FindControl("hfTax") as HiddenField).Value;
                txtTotal.Text = (Rw.FindControl("hfTotal") as HiddenField).Value;
                lblAmount.Text = string.Format("[{0}]", txtAmount.Text);
                lblTotal.Text = string.Format("[{0}]", txtTotal.Text);
                txtLeadTime.Text = clsSpace(Rw.Cells[11].Text);
                try { ddlVendor.DataBind(); ddlVendor.SelectedValue = (Rw.FindControl("hfVendorID") as HiddenField).Value; }
                catch { ddlVendor.SelectedIndex = -1; }
                txtComment.Text = string.Empty;
                litPartNumber.Text = clsSpace(Rw.Cells[5].Text);
                litRFQPO.Text = string.Format("{0}/{1}", RFQ, PO);
                dControl((Rw.FindControl("hfStatus") as HiddenField).Value);
                mpeRFQPO.Show();
            }
            else if (e.CommandName.Equals("Copy"))
            {
                string x = (new myBiz.DAL.clsTool()).RFQPO_Copy(Convert.ToInt32(e.CommandArgument.ToString()), Common.clsUser.uID);
                gvRFQPO.DataBind();
                iMsg.ShowMsg(string.Format("RFQ/PO [{0}] has been copied", x), true);
            }
        }
        private void dControl(string Status)
        {
            txtLeadTime.ReadOnly = Status.Equals("Received") || Status.Equals("Verified") || Status.Equals("Billed") || Status.Equals("Paid");
            btnDelete.Enabled = ddlVendor.Enabled = !txtLeadTime.ReadOnly;
            txtDescription.ReadOnly = Status.Equals("Verified") || Status.Equals("Billed") || Status.Equals("Paid");
            txtQty.ReadOnly = txtUnitPrice.ReadOnly = txtAmount.ReadOnly = Status.Equals("Billed") || Status.Equals("Paid");
            ddlUnit.Enabled = !txtQty.ReadOnly; lnkNumbers.Visible = !txtAmount.ReadOnly;
            mpeNumbers.TargetControlID = lnkNumbers.Visible ? "lnkNumbers" : "hfNoClick";
        }
        protected void delRFQPO(object sender, EventArgs e)
        {
            string x = (new myBiz.DAL.clsTool()).RFQPO_Delete(Convert.ToInt32(hfHID.Value));
            if (!string.IsNullOrEmpty(x))
            {
                iMsg.ShowMsg(string.Format("PO number {0} has been deleted.", x), true);
                gvRFQPO.DataBind();
            }
            else iMsg.ShowErr("No PO number has been deleted.", true);
        }
        private string clsSpace(string x)
        {
            return x.Equals("&nbsp;") ? string.Empty : x;
        }
        protected void gvBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lnk = e.Row.FindControl("lnkEdit") as LinkButton; lnk.Visible = isYN("k02");
                if (lnk.Visible) lnk.CommandArgument = e.Row.RowIndex.ToString();
                (e.Row.FindControl("lnkCopy") as LinkButton).Visible = isYN("k03");
            }
            else if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList ddl = e.Row.FindControl("ddlDisplay") as DropDownList;
                ddl.SelectedIndex = getSelectedIndex;
            }
        }
        protected string strTrim(string key)
        {
            string vl = Eval(key).ToString();
            return vl.Length > 30 ? vl.Substring(0, 29) + " ..." : vl;
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "New RFQ/PO");
            PageSec.Add("k02", "Edit");
            PageSec.Add("k03", "Copy");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            cpeRFQPON.Enabled = pnlRFQPON.Visible = btnRFQPON.Visible = isYN("k01");
        }
        private int getSelectedIndex
        {
            get { return ViewState["iSelectedIndex"] != null ? Convert.ToInt32(ViewState["iSelectedIndex"]) : 0; }
            set { ViewState["iSelectedIndex"] = value; }
        }
    }
}