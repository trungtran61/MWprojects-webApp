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
    public partial class BilledPO : Common.pgAbstract
    {
        protected void Page_Init(object sender, EventArgs e) { hfValx.Value = Request.Form["hfVal"]; hfUID.Value = Common.clsUser.uID; }
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Purchasing/Pay Bill");
        }
        protected void doExport(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < gvBilledPO.Rows.Count; i++)
            {
                GridViewRow Rw = gvBilledPO.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.AppendFormat("{0}:", gvBilledPO.DataKeys[i].Value);
            }

            DataTable Tb = (new clsPO()).getExcel(x.ToString(), hfValx.Value, txtBilledPO.Text, txtBilledSupplier.Text, txtBilledInvoice.Text, DateTime.MinValue, DateTime.MinValue, string.Empty);
            int billCnt = Tb != null && Tb.Rows.Count > 0 ? Tb.Rows.Count + 1 : 1;
            string xPort = System.IO.File.ReadAllText(string.Format("{0}\\xPort.xml", Util.AppSetting("FormPath"))).Replace("**BillCnt**", billCnt.ToString()).Replace("**InvCnt**", "1");
            System.Text.StringBuilder billRow = new System.Text.StringBuilder();
            foreach (DataRow Rw in Tb.Rows) billRow.Append(xRow(Rw));

            Response.Clear();
            Response.ContentType = "application/vnd.ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment; filename=xPort.xls");
            Response.Write(xPort.Replace("**InvRow**", string.Empty).Replace("**BillRow**", billRow.ToString()));
            Response.End();
        }
        private string xRow(DataRow Rw)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder("<Row>\n");
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["VendorName"]);
            sb.AppendFormat(" <Cell ss:StyleID=\"s62\"><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["TransactionDate"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["RefNumber"]);
            sb.AppendFormat(" <Cell ss:StyleID=\"s62\"><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["BillDue"]);
            sb.AppendFormat(" <Cell ss:Index=\"7\"><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["Address1"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["Address2"]);
            sb.AppendFormat(" <Cell ss:Index=\"11\"><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["City"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["State"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["Zip"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["Country"]);
            sb.AppendFormat(" <Cell ss:Index=\"16\"><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["ExpAcct"]);
            sb.AppendFormat(" <Cell><Data ss:Type=\"Number\">{0}</Data></Cell>\n", Rw["ExpAmt"]);
            sb.AppendFormat(" <Cell ss:Index=\"24\"><Data ss:Type=\"String\">{0}</Data></Cell>\n", Rw["ItemDesc"]);
            sb.Append("</Row>\n");

            return sb.ToString();
        }

        protected void doScheduling(object sender, EventArgs e)
        {
            string st = (sender as Button).ID.Equals("btnSched") ? "Billed_Sched" : "Billed";
            GridView iGV = st.Equals("Billed_Sched") ? gvBilledPO : gvSchedPO; int Cnt = iGV.Rows.Count;

            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < Cnt; i++)
            {
                GridViewRow Rw = iGV.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.Append(string.Format("{0}:", iGV.DataKeys[i].Value));
            }
            if (x.Length > 0)
            {
                (new clsPO()).Sched_U(x.ToString(), st);
                gvBilledPO.DataBind(); gvSchedPO.DataBind();
            }
            else iMsg.ShowErr("Sorry! Please select Purchase Order.", true);
        }

        protected void doPay(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < gvSchedPO.Rows.Count; i++)
            {
                GridViewRow Rw = gvSchedPO.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.Append(string.Format("{0}:", gvSchedPO.DataKeys[i].Value));
            }
            if (x.Length > 0)
            {
                odsSchedPO.UpdateParameters["IDs"].DefaultValue = x.ToString();
                odsSchedPO.Update(); gvSchedPO.DataBind(); gvPaidPO.DataBind();
            }
            else iMsg.ShowErr("Sorry! Please select Purchase Order.", true);
        }

        protected void doUndo(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < gvPaidPO.Rows.Count; i++)
            {
                GridViewRow Rw = gvPaidPO.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.Append(string.Format("{0}:", gvPaidPO.DataKeys[i].Value));
            }
            if (x.Length > 0)
            {
                odsPaidPO.UpdateParameters["IDs"].DefaultValue = x.ToString();
                odsPaidPO.Update(); gvPaidPO.DataBind(); gvSchedPO.DataBind();
            }
            else iMsg.ShowErr("Sorry! Please select Purchase Order.", true);
        }
        protected void schedBound(object sender, EventArgs e)
        {
            DateTime DDf = string.IsNullOrEmpty(txtSchedDDf.Text.Trim()) ? DateTime.MinValue : Convert.ToDateTime(txtSchedDDf.Text);
            DateTime DDt = string.IsNullOrEmpty(txtSchedDDt.Text.Trim()) ? DateTime.MinValue : Convert.ToDateTime(txtSchedDDt.Text);
            DataTable Tb = (new clsPO()).Select1(hfValx.Value, "getTotals_Sched", null, txtSchedPO.Text.Trim(),
                txtSchedSupplier.Text.Trim(), txtSchedInvoice.Text.Trim(), DDf, DDt, string.Empty, Request.QueryString["lMode"]);
            int Cnt = 0; float SU = 0;

            foreach (DataRow Rw in Tb.Rows)
            {
                var isGood = Rw["Total"] != null && myBiz.Tools.clsValidator.isNumeric(Rw["Total"].ToString());

                if (isGood)
                {
                    switch (Rw["Status"].ToString().Trim())
                    {
                        case "Cnt": Cnt = Convert.ToInt32(Rw["Total"]); break;
                        case "BillAmt": SU = float.Parse(Rw["Total"].ToString()); break;
                    }
                }
            }
            litSchedTotal.Text = string.Format("[SU: {0:C}]", SU);
            hfSUTotal.Value = SU.ToString();
            billBound1();

            litSchedCnt.Visible = Cnt > 0; showSchedTotal.Visible = Cnt > 0;
            if (litSchedCnt.Visible) litSchedCnt.Text = string.Format("[{0} {1}]", Cnt, Cnt > 1 ? "records" : "record");
        }
        protected void billBound(object sender, EventArgs e) { if (!string.IsNullOrEmpty(hfSUTotal.Value)) billBound1(); }
        protected void billBound1()
        {
            DateTime DDf = string.IsNullOrEmpty(txtBilledDDf.Text.Trim()) ? DateTime.MinValue : Convert.ToDateTime(txtBilledDDf.Text);
            DateTime DDt = string.IsNullOrEmpty(txtBilledDDt.Text.Trim()) ? DateTime.MinValue : Convert.ToDateTime(txtBilledDDt.Text);
            DataTable Tb = (new clsPO()).Select1(hfValx.Value, "getTotals", null, txtBilledPO.Text.Trim(),
                txtBilledSupplier.Text.Trim(), txtBilledInvoice.Text.Trim(), DDf, DDt, string.Empty, Request.QueryString["lMode"]);
            int Cnt = 0; float UB = 0, RO = 0, VO = 0, RB = 0, Total = 0, SU = float.Parse(hfSUTotal.Value);

            foreach (DataRow Rw in Tb.Rows)
            {
                var isGood = Rw["Total"] != null && myBiz.Tools.clsValidator.isNumeric(Rw["Total"].ToString());
                if (isGood)
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
            }
            
            Total = UB + RO + VO + RB + SU;
            litBilledTotal.Text = string.Format("[UB: {0:C}, RO: {1:C}, VO: {2:C}, RB: {3:C},  SU: {4:C}, AP-Total: {5:C}]", UB, RO, VO, RB, SU, Total);

            litBilledCnt.Visible = Cnt > 0; showBilledTotal.Visible = isYN("k04") && Cnt > 0;
            if (litBilledCnt.Visible) litBilledCnt.Text = string.Format("[{0} {1}]", Cnt, Cnt > 1 ? "records" : "record");
        }
        protected void paidBound(object sender, EventArgs e)
        {
            DateTime DDf = string.IsNullOrEmpty(txtPaidDDf.Text.Trim()) ? DateTime.MinValue : Convert.ToDateTime(txtPaidDDf.Text);
            DateTime DDt = string.IsNullOrEmpty(txtPaidDDt.Text.Trim()) ? DateTime.MinValue : Convert.ToDateTime(txtPaidDDt.Text);
            DataTable Tb = (new clsPO()).Select1(hfValx.Value, "PaidTotal", null, txtPaidPO.Text, txtPaidSupplier.Text, txtPaidInvoice.Text, DDf, DDt, string.Empty, string.Empty);

            if (Tb != null & Tb.Rows.Count > 0)
            {
                int Cnt = Convert.ToInt32(Tb.Rows[0]["Cnt"]);
                litPaidCnt.Visible = Cnt > 0; showPaidTotal.Visible = isYN("k03") && Cnt > 0;
                if (litPaidCnt.Visible) litPaidCnt.Text = string.Format("[{0} {1}]", Cnt, Cnt > 1 ? "records" : "record");
                if (showPaidTotal.Visible) litPaidTotal.Text = string.Format("[{0:C}]", Tb.Rows[0]["Total"]);
            }
            else showPaidTotal.Visible = litPaidCnt.Visible = false;
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            bool isBill = (sender as GridView).ID.Equals("gvBilledPO");
            if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList ddl = e.Row.FindControl(isBill ? "ddlBilledDisplay" : "ddlPaidDisplay") as DropDownList;
                ddl.SelectedIndex = isBill ? BilledIndex : PaidIndex;
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                (e.Row.FindControl("lnkDLInvoice") as LinkButton).CommandArgument = e.Row.RowIndex.ToString();
                if (isBill)
                {
                    CheckBox chk = e.Row.FindControl("chkItem") as CheckBox;
                    if (chk != null)
                        chk.Attributes.Add("onclick", string.Format("javascript:dCnt({0},{1},'{2}');", chk.ClientID, (e.Row.FindControl("hfDollar") as HiddenField).Value, "lblBilledCnt"));
                }
            }
        }
        protected void rwSchedBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList ddl = e.Row.FindControl("ddlSchedDisplay") as DropDownList;
                ddl.SelectedIndex = SchedIndex;
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                (e.Row.FindControl("lnkDLInvoice") as LinkButton).CommandArgument = e.Row.RowIndex.ToString();
                CheckBox chk = e.Row.FindControl("chkItem") as CheckBox;
                if (chk != null)
                    chk.Attributes.Add("onclick", string.Format("javascript:dCnt({0},{1},'{2}');", chk.ClientID, (e.Row.FindControl("hfDollar") as HiddenField).Value, "lblSchedCnt"));
            }
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("bInvoice") || e.CommandName.Equals("pInvoice"))
            {
                int GrpID = Convert.ToInt32(ConfigurationManager.AppSettings["Invoice"]);
                int LnkID = Convert.ToInt32((sender as GridView).DataKeys[Convert.ToInt32(e.CommandArgument)].Value);
                clsFile.Show(Page, Master.FindControl("pnlPopup") as Panel, "DL", "Invoice", string.Empty, GrpID, LnkID, string.Empty);
            }
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl.ID.Equals("ddlBilledDisplay"))
            {
                gvBilledPO.PageSize = Convert.ToInt32(ddl.SelectedValue);
                BilledIndex = ddl.SelectedIndex;
            }
            else if (ddl.ID.Equals("ddlSchedDisplay"))
            {
                gvSchedPO.PageSize = Convert.ToInt32(ddl.SelectedValue);
                SchedIndex = ddl.SelectedIndex;
            }
            else
            {
                gvPaidPO.PageSize = Convert.ToInt32(ddl.SelectedValue);
                PaidIndex = ddl.SelectedIndex;
            }
        }
        private int BilledIndex
        {
            get { return ViewState["BilledIndex"] != null ? Convert.ToInt32(ViewState["BilledIndex"]) : 0; }
            set { ViewState["BilledIndex"] = value; }
        }
        private int SchedIndex
        {
            get { return ViewState["SchedIndex"] != null ? Convert.ToInt32(ViewState["SchedIndex"]) : 0; }
            set { ViewState["SchedIndex"] = value; }
        }
        private int PaidIndex
        {
            get { return ViewState["PaidIndex"] != null ? Convert.ToInt32(ViewState["PaidIndex"]) : 0; }
            set { ViewState["PaidIndex"] = value; }
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
            PageSec.Add("k01", "Pay Bill");
            PageSec.Add("k02", "Undo Payment");
            PageSec.Add("k03", "View Paid Total");
            PageSec.Add("k04", "View UnPaid Total");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnPay.Visible = isYN("k01");
            btnUndo.Visible = isYN("k02");
        }
    }
}