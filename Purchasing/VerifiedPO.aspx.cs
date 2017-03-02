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
using myBiz.DAL;

namespace webApp.Purchasing
{
    public partial class VerifiedPO : Common.pgAbstract
    {
        protected void Page_Init(object sender, EventArgs e) { hfValx.Value = Request.Form["hfVal"]; hfUID.Value = Common.clsUser.uID; }
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Purchasing/Enter Bill");
        }
        protected void dataBound(object sender, EventArgs e)
        {
            bool isBilled = (sender as GridView).ID.Equals("gvBilledPO");
            string PO = isBilled ? txtBilledPO.Text : txtVerifiedPO.Text;
            string Splier = isBilled ? txtBilledSupplier.Text : txtVerifiedSupplier.Text;
            string Invice = isBilled ? txtBilledInvoice.Text : txtVerifiedInvoice.Text;
            string St = isBilled ? "BilledTotal" : "VerifiedTotal";
            string lMode = isBilled ? string.Empty : Request.QueryString["lMode"];
            DataTable Tb = (new clsPO()).Select(hfValx.Value, St, null, PO, Splier, Invice, string.Empty, lMode);
            int Cnt = Tb != null & Tb.Rows.Count > 0 ? Convert.ToInt32(Tb.Rows[0]["Cnt"]) : 0;

            if (isBilled)
            {
                litBilledCnt.Visible = Cnt > 0;
                if (Cnt > 0) litBilledCnt.Text = string.Format("[{0} {1}]", Cnt, Cnt > 1 ? "records" : "record");
            }
            else
            {
                litVerifiedCnt.Visible = Cnt > 0;
                if (Cnt > 0) litVerifiedCnt.Text = string.Format("[{0} {1}]", Cnt, Cnt > 1 ? "records" : "record");
            }
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList ddl = e.Row.FindControl("ddlBilledDisplay") as DropDownList;
                ddl.SelectedIndex = BilledIndex;
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lnkDLI = e.Row.FindControl("lnkDLInvoice") as LinkButton; lnkDLI.Visible = isYN("k05");
                if (lnkDLI.Visible) lnkDLI.CommandArgument = e.Row.RowIndex.ToString();
            }
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl.ID.Equals("ddlVerifiedDisplay"))
            {
                gvVerifiedPO.PageSize = Convert.ToInt32(ddl.SelectedValue);
                VerifiedIndex = ddl.SelectedIndex;
            }
            else
            {
                gvBilledPO.PageSize = Convert.ToInt32(ddl.SelectedValue);
                BilledIndex = ddl.SelectedIndex;
            }
        }
        private int VerifiedIndex
        {
            get { return ViewState["VerifiedIndex"] != null ? Convert.ToInt32(ViewState["VerifiedIndex"]) : 0; }
            set { ViewState["VerifiedIndex"] = value; }
        }
        private int BilledIndex
        {
            get { return ViewState["BilledIndex"] != null ? Convert.ToInt32(ViewState["BilledIndex"]) : 0; }
            set { ViewState["BilledIndex"] = value; }
        }
        protected void gvBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList ddl = e.Row.FindControl("ddlVerifiedDisplay") as DropDownList;
                ddl.SelectedIndex = VerifiedIndex;
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lnk = e.Row.FindControl("lnkEdit") as LinkButton; lnk.Visible = isYN("k03");
                if (lnk.Visible) lnk.CommandArgument = e.Row.RowIndex.ToString();

                LinkButton lnkULI = e.Row.FindControl("lnkULInvoice") as LinkButton; lnkULI.Visible = isYN("k04");
                if (lnkULI.Visible) lnkULI.CommandArgument = e.Row.RowIndex.ToString();

                LinkButton lnkDLI = e.Row.FindControl("lnkDLInvoice") as LinkButton; lnkDLI.Visible = isYN("k05");
                if (lnkDLI.Visible) lnkDLI.CommandArgument = e.Row.RowIndex.ToString();
            }
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("pEdit"))
            {
                int i = Convert.ToInt32(e.CommandArgument); GridViewRow Rw = gvVerifiedPO.Rows[i];
                hfHID.Value = gvVerifiedPO.DataKeys[i].Value.ToString();
                litPONumber.Text = clsSpace((Rw.FindControl("lnkPONumber") as LinkButton).Text);
                txtBillAmt.Text = clsSpace((Rw.FindControl("litBillAmt") as Literal).Text);
                txtInvoiceNo.Text = clsSpace(Rw.Cells[9].Text);
                ddlExpAcct.DataSource = (new clsPO()).ExpAcct_DDL(Convert.ToInt32(hfHID.Value));
                ddlExpAcct.DataBind();
                string D1 = clsSpace((Rw.FindControl("hfExpAcct") as HiddenField).Value);
                string D2 = clsSpace((Rw.FindControl("hfDefAcct") as HiddenField).Value);
                try { ddlExpAcct.SelectedValue = D1; }
                catch
                {
                    try { ddlExpAcct.SelectedValue = D2; }
                    catch { }
                }
                mpeVerifiedPO.Show();
            }
            else if (e.CommandName.Equals("uInvoice") || e.CommandName.Equals("dInvoice"))
            {
                int GrpID = Convert.ToInt32(ConfigurationManager.AppSettings["Invoice"]);
                int LnkID = Convert.ToInt32(gvVerifiedPO.DataKeys[Convert.ToInt32(e.CommandArgument)].Value);
                DataTable Tb = clsDB.spAdmin_Variables_S("UploadLimitInvoice");
                string maxLen = Tb != null && Tb.Rows.Count > 0 ? Tb.Rows[0]["iValue"].ToString() : string.Empty;
                clsFile.Show(Page, Master.FindControl("pnlPopup") as Panel, e.CommandName.Equals("uInvoice") ? "UL" : "DL", "Invoice", string.Empty, GrpID, LnkID, maxLen);
            }
            else if (e.CommandName.Equals("bInvoice"))
            {
                int GrpID = Convert.ToInt32(ConfigurationManager.AppSettings["Invoice"]);
                int LnkID = Convert.ToInt32(gvBilledPO.DataKeys[Convert.ToInt32(e.CommandArgument)].Value);
                clsFile.Show(Page, Master.FindControl("pnlPopup") as Panel, "DL", "Invoice", string.Empty, GrpID, LnkID, string.Empty);
            }
        }
        protected void sData(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            x.Append(myBiz.Tools.clsValidator.gErrMsg("Numeric", txtBillAmt.Text, "Bill Amount", true));
            x.Append(myBiz.Tools.clsValidator.gErrMsg("String", txtInvoiceNo.Text, "Invoice No", false));
            x.Append(myBiz.Tools.clsValidator.gErrMsg("String", ddlExpAcct.SelectedValue, "Expense Account", true));

            if (x.Length < 1)
            {
                if (Convert.ToDecimal(txtBillAmt.Text.Trim()) < 0) x.Append("<li>Invalid Bill Amount [non-negative number only]</li>");
            }

            if (x.Length > 0) { jMsg.ShowErr("<br>Cannot save data", x.ToString(), true); mpeVerifiedPO.Show(); }
            else
            {
                odsVerifiedPO.InsertParameters["HID"].DefaultValue = hfHID.Value;
                odsVerifiedPO.InsertParameters["BillAmt"].DefaultValue = txtBillAmt.Text.Trim();
                odsVerifiedPO.InsertParameters["InvoiceNo"].DefaultValue = txtInvoiceNo.Text.Trim();
                odsVerifiedPO.InsertParameters["ExpAcct"].DefaultValue = ddlExpAcct.SelectedValue;
                odsVerifiedPO.Insert(); gvVerifiedPO.DataBind();
            }
        }
        private string clsSpace(string x)
        {
            return x.Equals("&nbsp;") ? string.Empty : x;
        }
        protected string clsCnt()
        {
            string GoodCnt = Convert.ToDecimal(Eval("GoodCnt")) > 0 ? string.Format("<span style=\"color:Blue\">[{0}]</span>", Eval("GoodCnt")) : string.Empty;
            string TotalCnt = Convert.ToDecimal(Eval("TotalCnt")) > 0 ? string.Format("<span style=\"color:Black\">[{0}]</span>", Eval("TotalCnt")) : string.Empty;
            string RewrkCnt = Convert.ToDecimal(Eval("RewrkCnt")) > 0 ? string.Format("<span style=\"color:Orange\">[{0}]</span>", Eval("RewrkCnt")) : string.Empty;
            string ScrapCnt = Convert.ToDecimal(Eval("ScrapCnt")) > 0 ? string.Format("<span style=\"color:Red\">[{0}]</span>", Eval("ScrapCnt")) : string.Empty;
            return string.Format("{0}{1}{2}{3}", GoodCnt, TotalCnt, RewrkCnt, ScrapCnt);
        }
        protected void doApprove(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < gvVerifiedPO.Rows.Count; i++)
            {
                GridViewRow Rw = gvVerifiedPO.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.Append(string.Format("{0}:", gvVerifiedPO.DataKeys[i].Value));
            }
            if (x.Length > 0)
            {
                odsVerifiedPO.UpdateParameters["IDs"].DefaultValue = x.ToString();
                odsVerifiedPO.Update(); gvVerifiedPO.DataBind(); gvBilledPO.DataBind();
            }
            else iMsg.ShowErr("Sorry! Please select Purchase Order.", true);
        }
        protected void doUndo(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < gvBilledPO.Rows.Count; i++)
            {
                GridViewRow Rw = gvBilledPO.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.Append(string.Format("{0}:", gvBilledPO.DataKeys[i].Value));
            }
            if (x.Length > 0)
            {
                odsBilledPO.UpdateParameters["IDs"].DefaultValue = x.ToString();
                odsBilledPO.Update(); gvVerifiedPO.DataBind(); gvBilledPO.DataBind();
            }
            else iMsg.ShowErr("Sorry! Please select Purchase Order.", true);
        }
        protected string gDD(string k)
        {
            try
            {
                string fColor = string.Empty;
                switch (Eval("lMode").ToString())
                {
                    case "beLate": fColor = " style=\"color:Brown;\""; break;
                    case "Late": fColor = " style=\"color:Red;\""; break;
                }

                DateTime DD = Convert.ToDateTime(Eval(k));
                return string.Format("<span{0}>{1}</span>", fColor, DD.ToString(Util.DD_Format));
            }
            catch
            {
                return "No Date";
            }
        }
        protected string gVdrName()
        {
            var vdrTerm = Eval("VdrTerm").ToString();
            var name = "<span title=\"{0}\">{1}{2}</span>";
            return string.Format(name, vdrTerm, Convert.ToBoolean(Eval("hasCCR")) ? "<span style=\"color:blue;\">&copy;</span> " : string.Empty, Eval("VendorName"));
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Undo");
            PageSec.Add("k02", "Approve");
            PageSec.Add("k03", "Update Amount");
            PageSec.Add("k04", "Upload Invoice");
            PageSec.Add("k05", "View Invoice");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnUndo.Visible = isYN("k01");
            btnApprove.Visible = isYN("k02");
        }
    }
}