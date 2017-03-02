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
    public partial class AppliedPayment : Common.pgAbstract
    {
        protected void Page_Init(object sender, EventArgs e) { hfValx.Value = Request.Form["hfVal"]; hfUID.Value = Common.clsUser.uID; }
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Purchasing/Apply Payment");
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("pView"))
            {
                doCmd("DL", Convert.ToInt32(e.CommandArgument));
            }
        }
        private void doCmd(string cmd, int LnkID)
        {
            int GrpID = Convert.ToInt32(ConfigurationManager.AppSettings["CheckImage"]);
            clsFile.Show(Page, pnlPopup, cmd, "Viewing Checks", string.Empty, GrpID, LnkID, string.Empty);
        }
        protected void doExport(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < gvPaid.Rows.Count; i++)
            {
                GridViewRow Rw = gvPaid.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.Append(string.Format("{0}:", gvPaid.DataKeys[i].Value));
            }

            DataTable Tb = (new clsPackingList()).getExcel(x.ToString(), txtPaidCustomer.Text, txtPaidCustomerPO.Text, txtPaidInvoice.Text, DateTime.MinValue, DateTime.MinValue);
            int invCnt = Tb != null && Tb.Rows.Count > 0 ? Tb.Rows.Count + 1 : 1;
            string xPort = System.IO.File.ReadAllText(string.Format("{0}\\xPort.xml", Util.AppSetting("FormPath"))).Replace("**InvCnt**", invCnt.ToString()).Replace("**BillCnt**", "1");
            System.Text.StringBuilder invRow = new System.Text.StringBuilder();
            foreach (DataRow Rw in Tb.Rows) invRow.Append(xRow(Rw));

            Response.Clear();
            Response.ContentType = "application/vnd.ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment; filename=xPort.xls");
            Response.Write(xPort.Replace("**BillRow**", string.Empty).Replace("**InvRow**", invRow.ToString()));
            Response.End();
        }
        private string xRow(DataRow Rw)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder("<Row ss:StyleID=\"s64\">\n");
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["Customer"]);
            sb.AppendFormat(" <Cell ss:StyleID=\"s65\"><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["TransactionDate"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["RefNumber"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["PONumber"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["Terms"]);
            sb.AppendFormat(" <Cell ss:Index=\"10\"><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["BillAddress1"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["BillAddress2"]);
            sb.AppendFormat(" <Cell ss:Index=\"14\"><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["BillCity"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["BillState"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["BillZip"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["BillCountry"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["ShipAddress1"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["ShipAddress2"]);
            sb.AppendFormat(" <Cell ss:Index=\"22\"><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["ShipCity"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["ShipState"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["ShipZip"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["ShipCountry"]);
            sb.AppendFormat(" <Cell ss:Index=\"33\" ss:StyleID=\"s65\"><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["DueDate"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["ShipMethod"]);
            sb.AppendFormat(" <Cell ss:Index=\"37\"><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["Item"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["Quantity"]);
            sb.AppendFormat(" <Cell ss:StyleID=\"s66\"><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["Description"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["Price"]);
            sb.Append("</Row>\n");

            return sb.ToString();
        }
        protected void doApply(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            if (gvChecks.SelectedIndex < 0) x.Append("<li>Please select which check to apply.</li>");
            if (string.IsNullOrEmpty(txtCheckNo.Text.Trim())) x.Append("<li>Please enter check number.</li>");

            if (x.Length > 0) iMsg.ShowErr("<br>Cannot apply payment", x.ToString(), true);
            else
            {
                for (int i = 0; i < gvUnpaid.Rows.Count; i++)
                {
                    GridViewRow Rw = gvUnpaid.Rows[i];
                    if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                        x.Append(string.Format("{0}:", gvUnpaid.DataKeys[i].Value));
                }
                if (x.Length > 0)
                {
                    string CheckID = (gvChecks.Rows[gvChecks.SelectedIndex].FindControl("lnkSelect") as LinkButton).Text;
                    odsUnpaid.UpdateParameters["IDs"].DefaultValue = x.ToString();
                    odsUnpaid.UpdateParameters["CheckID"].DefaultValue = CheckID;
                    odsUnpaid.Update(); gvUnpaid.DataBind(); gvPaid.DataBind(); gvChecks.DataBind();
                }
                else iMsg.ShowErr("Sorry! Please select Invoice.", true);
            }
        }
        protected void unPaidBound(object sender, EventArgs e)
        {
            DateTime DDf = string.IsNullOrEmpty(txtDDf.Text.Trim()) ? DateTime.MinValue : Convert.ToDateTime(txtDDf.Text);
            DateTime DDt = string.IsNullOrEmpty(txtDDt.Text.Trim()) ? DateTime.MinValue : Convert.ToDateTime(txtDDt.Text);
            DataTable Tb = (new clsPackingList()).Select3(hfValx.Value, txtUnpaidCustomer.Text.Trim(), txtUnpaidCustomerPO.Text.Trim(),
                txtUnpaidInvoice.Text.Trim(), null, DDf, DDt, "UnpaidTotals", string.Empty, Request.QueryString["lMode"]);

            if (Tb != null & Tb.Rows.Count > 0)
            {
                int Cnt = 0; float uTotal = 0, apTotal = 0, uInvoice = 0, oTt = 0, aTt = 0;
                foreach (DataRow Rw in Tb.Rows)
                {
                    switch (Rw["xTitle"].ToString().Trim())
                    {
                        case "UnpaidTotal": Cnt = Convert.ToInt32(Rw["Cnt"]); uTotal = float.Parse(Rw["Total"].ToString()); break;
                        case "UnpaidInvoice": uInvoice = float.Parse(Rw["Total"].ToString()); break;
                        //case "APTotal": apTotal = float.Parse(Rw["Total"].ToString()); break;
                        case "OnHandTotal": oTt = float.Parse(Rw["Total"].ToString()); break;
                        case "AvailTotal": aTt = float.Parse(Rw["Total"].ToString()); break;
                    }
                }
                apTotal = this.apTotal();
                dNET = uTotal - apTotal;
                litCount.Visible = Cnt > 0; showTotal.Visible = isYN("k04") && Cnt > 0; showAPTotal.Visible = isYN("k05"); showOATotal.Visible = isYN("k10");
                if (litCount.Visible) litCount.Text = string.Format("[{0} {1}]", Cnt, Cnt > 1 ? "records" : "record");
                if (showTotal.Visible) litTotal.Text = string.Format("[{0:N}]", uTotal);
                if (showAPTotal.Visible) litAPTotal.Text = string.Format("[AP-Total: {0:N}; NET: {1:N}]", apTotal, dNET);
                if (showOATotal.Visible) litOATotal.Text = string.Format("[On-Hand: {0:N}; Avail: {1:N}]", oTt, aTt);
            }
            else showTotal.Visible = litCount.Visible = showAPTotal.Visible = showOATotal.Visible = false;
        }
        private float apTotal()
        {
            DataTable Tb = (new clsPO()).Select1(hfValx.Value, "getTotals", null, string.Empty, string.Empty, string.Empty, DateTime.MinValue, DateTime.MinValue, string.Empty, Request.QueryString["lMode"]);
            int Cnt = 0; float UB = 0, RO = 0, VO = 0, RB = 0;

            foreach (DataRow Rw in Tb.Rows)
            {
                switch (Rw["Status"].ToString().Trim())
                {
                    case "Cnt": Cnt = Convert.ToInt32(Rw["Total"]); break;
                    case "Billed": UB = float.Parse(Rw["Total"].ToString()); break;
                    case "Open": RO = float.Parse(Rw["Total"].ToString()); break;
                    case "Received": VO = float.Parse(Rw["Total"].ToString()); break;
                    case "Verified": RB = float.Parse(Rw["Total"].ToString()); break;
                }
            }

            DataTable tSU = (new clsPO()).Select1(hfValx.Value, "getTotals_Sched", null, string.Empty, string.Empty, string.Empty, DateTime.MinValue, DateTime.MinValue, string.Empty, Request.QueryString["lMode"]);
            float SU = 0;

            foreach (DataRow Rw in tSU.Rows)
            {
                switch (Rw["Status"].ToString().Trim())
                {
                    case "Cnt": Cnt = Convert.ToInt32(Rw["Total"]); break;
                    case "BillAmt": SU = float.Parse(Rw["Total"].ToString()); break;
                }
            }

            return UB + RO + VO + RB + SU;
        }

        protected void paidBound(object sender, EventArgs e)
        {
            DataTable Tb = (new clsPackingList()).Select3(hfValx.Value, txtPaidCustomer.Text.Trim(), txtPaidCustomerPO.Text.Trim(),
                txtPaidInvoice.Text.Trim(), txtPaidCheckNo.Text.Trim(), DateTime.MinValue, DateTime.MinValue, "PaidTotal", string.Empty, string.Empty);

            if (Tb != null & Tb.Rows.Count > 0)
            {
                int Cnt = Convert.ToInt32(Tb.Rows[0]["Cnt"]);
                litPaidCnt.Visible = Cnt > 0; showPaidTotal.Visible = isYN("k06") && Cnt > 0;
                if (litPaidCnt.Visible) litPaidCnt.Text = string.Format("[{0} {1}]", Cnt, Cnt > 1 ? "records" : "record");
                if (showPaidTotal.Visible) litPaidTotal.Text = string.Format("[{0:N}; GNET: {1:N}]", Tb.Rows[0]["Total"], Convert.ToDouble(Tb.Rows[0]["Total"]) + dNET);
                litChkCnt.Text = Tb.Rows[0]["ChkCnt"].ToString();
            }
            else showPaidTotal.Visible = litPaidCnt.Visible = false;
        }
        protected void RpaidBound(object sender, EventArgs e)
        {
            DataTable Tb = (new clsPackingList()).Select3(hfValx.Value, txtRPaidCustomer.Text.Trim(), txtRPaidCustomerPO.Text.Trim(),
                txtRPaidInvoice.Text.Trim(), txtRPaidCheckNo.Text.Trim(), DateTime.MinValue, DateTime.MinValue, "RPaidTotal", string.Empty, string.Empty);

            if (Tb != null & Tb.Rows.Count > 0)
            {
                int Cnt = Convert.ToInt32(Tb.Rows[0]["Cnt"]);
                litRPaidCnt.Visible = Cnt > 0; showRPaidTotal.Visible = isYN("k09") && Cnt > 0;
                if (litRPaidCnt.Visible) litRPaidCnt.Text = string.Format("[{0} {1}]", Cnt, Cnt > 1 ? "records" : "record");
                if (showRPaidTotal.Visible) litRPaidTotal.Text = string.Format("[{0:N}]", Tb.Rows[0]["Total"]);
            }
            else showRPaidTotal.Visible = litRPaidCnt.Visible = false;
        }
        protected void doUndo(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < gvPaid.Rows.Count; i++)
            {
                GridViewRow Rw = gvPaid.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.Append(string.Format("{0}:", gvPaid.DataKeys[i].Value));
            }
            if (x.Length > 0)
            {
                odsPaid.UpdateParameters["IDs"].DefaultValue = x.ToString();
                odsPaid.Update(); gvPaid.DataBind(); gvUnpaid.DataBind(); gvChecks.DataBind();
            }
            else iMsg.ShowErr("Sorry! Please select Invoice.", true);
        }
        protected void doRecon(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < gvPaid.Rows.Count; i++)
            {
                GridViewRow Rw = gvPaid.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.Append(string.Format("{0}:", gvPaid.DataKeys[i].Value));
            }
            if (x.Length > 0)
            {
                (new clsPackingList()).Reconcile(x.ToString(), true);
                gvPaid.DataBind(); gvRPaid.DataBind();
            }
            else iMsg.ShowErr("Sorry! Please select Invoice.", true);
        }
        protected void doUnRecon(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < gvRPaid.Rows.Count; i++)
            {
                GridViewRow Rw = gvRPaid.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.Append(string.Format("{0}:", gvRPaid.DataKeys[i].Value));
            }
            if (x.Length > 0)
            {
                (new clsPackingList()).Reconcile(x.ToString(), false);
                gvPaid.DataBind(); gvRPaid.DataBind();
            }
            else iMsg.ShowErr("Sorry! Please select Invoice.", true);
        }

        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            bool isUnpaid = (sender as GridView).ID.Equals("gvUnpaid");
            if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList ddl = e.Row.FindControl(isUnpaid ? "ddlUnpaidDisplay" : "ddlPaidDisplay") as DropDownList;
                ddl.SelectedIndex = isUnpaid ? UnpaidIndex : PaidIndex;
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var lbl = isUnpaid ? "lblUnpaidCnt" : "lblPaidCnt";
                CheckBox chk = e.Row.FindControl("chkItem") as CheckBox;
                if (chk != null)
                    chk.Attributes.Add("onclick", string.Format("javascript:dCnt({0},{1},'{2}');", chk.ClientID, (e.Row.FindControl("hfDollar") as HiddenField).Value, lbl));
            }
        }
        protected void rwRBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                (e.Row.FindControl("ddlRPaidDisplay") as DropDownList).SelectedIndex = RPaidIndex;
            }
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl.ID.Equals("ddlUnpaidDisplay"))
            {
                gvUnpaid.PageSize = Convert.ToInt32(ddl.SelectedValue);
                UnpaidIndex = ddl.SelectedIndex;
            }
            else if (ddl.ID.Equals("ddlPaidDisplay"))
            {
                gvPaid.PageSize = Convert.ToInt32(ddl.SelectedValue);
                PaidIndex = ddl.SelectedIndex;
            }
            else
            {
                gvRPaid.PageSize = Convert.ToInt32(ddl.SelectedValue);
                RPaidIndex = ddl.SelectedIndex;
            }
        }
        private double dNET
        {
            get { return ViewState["dNET"] == null ? 0 : Convert.ToDouble(ViewState["dNET"]); }
            set { ViewState["dNET"] = value; }
        }
        private int UnpaidIndex
        {
            get { return ViewState["UnpaidIndex"] != null ? Convert.ToInt32(ViewState["UnpaidIndex"]) : 0; }
            set { ViewState["UnpaidIndex"] = value; }
        }
        private int PaidIndex
        {
            get { return ViewState["PaidIndex"] != null ? Convert.ToInt32(ViewState["PaidIndex"]) : 0; }
            set { ViewState["PaidIndex"] = value; }
        }
        private int RPaidIndex
        {
            get { return ViewState["RPaidIndex"] != null ? Convert.ToInt32(ViewState["RPaidIndex"]) : 0; }
            set { ViewState["RPaidIndex"] = value; }
        }

        protected string gAmt()
        {
            var rQty = Convert.ToInt32(Eval("ReturnedQty"));
            var reQty = rQty > 0 ? string.Format("[{0}]", rQty) : string.Empty;

            return string.Format("{0:0.00}{1}", Eval("Amount"), reQty);
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
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Apply Payment");
            PageSec.Add("k02", "Undo Payment");
            PageSec.Add("k03", "Allow Export");
            PageSec.Add("k04", "View Total");
            PageSec.Add("k05", "View AP-Total");
            PageSec.Add("k06", "View Unreconciled Paid Total");
            PageSec.Add("k07", "Reconcile");
            PageSec.Add("k08", "Unreconcile");
            PageSec.Add("k09", "View Reconciled Paid Total");
            PageSec.Add("k10", "View On-Hand/Available Total");
            PageSec.Add("k11", "Income/Expense Link");
            PageSec.Add("k12", "Expense Account Link");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnApplyPay.Visible = isYN("k01");
            btnUndo.Visible = isYN("k02");
            btnExportS.Visible = isYN("k03");
            btnRecon.Visible = isYN("k07");
            btnUnRecon.Visible = isYN("k08");
            lnkIncExp.Visible = isYN("k11");
            lnkExpAcct.Visible = isYN("k12");
        }
    }
}