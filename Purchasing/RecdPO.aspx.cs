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
    public partial class RecdPO : Common.pgAbstract
    {
        protected void Page_Init(object sender, EventArgs e) { hfValx.Value = Request.Form["hfVal"]; hfUID.Value = Common.clsUser.uID; }
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Purchasing/Verify Order");
        }
        protected string clsCnt()
        {
            string GoodCnt = Convert.ToDecimal(Eval("GoodCnt")) > 0 ? string.Format("<span style=\"color:Blue\">[{0}]</span>", Eval("GoodCnt")) : string.Empty;
            string TotalCnt = Convert.ToDecimal(Eval("TotalCnt")) > 0 ? string.Format("<span style=\"color:Black\">[{0}]</span>", Eval("TotalCnt")) : string.Empty;
            string RewrkCnt = Convert.ToDecimal(Eval("RewrkCnt")) > 0 ? string.Format("<span style=\"color:Orange\">[{0}]</span>", Eval("RewrkCnt")) : string.Empty;
            string ScrapCnt = Convert.ToDecimal(Eval("ScrapCnt")) > 0 ? string.Format("<span style=\"color:Red\">[{0}]</span>", Eval("ScrapCnt")) : string.Empty;
            return string.Format("{0}{1}{2}{3}", GoodCnt, TotalCnt, RewrkCnt, ScrapCnt);
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("pEdit"))
            {
                int i = Convert.ToInt32(e.CommandArgument); GridViewRow Rw = gvRecdPO.Rows[i];
                hfHID.Value = gvRecdPO.DataKeys[i].Value.ToString();
                litPONumber.Text = (Rw.FindControl("lnkPONumber") as LinkButton).Text;
                txtGoodCnt.Text = clsSpace((Rw.FindControl("hfGoodCnt") as HiddenField).Value);
                txtRewrkCnt.Text = clsSpace((Rw.FindControl("hfRewrkCnt") as HiddenField).Value);
                txtScrapCnt.Text = clsSpace((Rw.FindControl("hfScrapCnt") as HiddenField).Value);
                txtTotalCnt.Text = clsSpace((Rw.FindControl("hfTotalCnt") as HiddenField).Value);
                mpeRecdCnt.Show();
            }
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList ddl = e.Row.FindControl("ddlVerifiedDisplay") as DropDownList;
                ddl.SelectedIndex = VerifiedIndex;
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
                gvRecdPO.PageSize = Convert.ToInt32(ddl.SelectedValue);
                RecdIndex = ddl.SelectedIndex;
            }
        }
        private int VerifiedIndex
        {
            get { return ViewState["VerifiedIndex"] != null ? Convert.ToInt32(ViewState["VerifiedIndex"]) : 0; }
            set { ViewState["VerifiedIndex"] = value; }
        }
        private int RecdIndex
        {
            get { return ViewState["RecdIndex"] != null ? Convert.ToInt32(ViewState["RecdIndex"]) : 0; }
            set { ViewState["RecdIndex"] = value; }
        }
        protected void sData(object sender, EventArgs e)
        {
            string GoodCnt = !string.IsNullOrEmpty(txtGoodCnt.Text.Trim()) ? txtGoodCnt.Text.Trim() : "0";
            string RewrkCnt = !string.IsNullOrEmpty(txtRewrkCnt.Text.Trim()) ? txtRewrkCnt.Text.Trim() : "0";
            string ScrapCnt = !string.IsNullOrEmpty(txtScrapCnt.Text.Trim()) ? txtScrapCnt.Text.Trim() : "0";
            System.Text.StringBuilder x = new System.Text.StringBuilder();

            x.Append(myBiz.Tools.clsValidator.gErrMsg("Numeric", GoodCnt, "Good Count", false));
            if (x.Length < 1 && Convert.ToDecimal(GoodCnt) < 0) x.Append("<li>Good Count must be non-negative.</li>");

            x.Append(myBiz.Tools.clsValidator.gErrMsg("Numeric", RewrkCnt, "Reworkable Count", false));
            if (x.Length < 1 && Convert.ToDecimal(RewrkCnt) < 0) x.Append("<li>Reworkable Count must be non-negative.</li>");

            x.Append(myBiz.Tools.clsValidator.gErrMsg("Numeric", ScrapCnt, "Scrap Count", false));
            if (x.Length < 1 && Convert.ToDecimal(ScrapCnt) < 0) x.Append("<li>Scrap Count must be non-negative.</li>");

            if (x.Length > 0)
            {
                jMsg.ShowErr("<br>Data can NOT be saved", x.ToString(), true);
                mpeRecdCnt.Show();
            }
            else
            {
                odsRecdPO.InsertParameters["HID"].DefaultValue = hfHID.Value;
                odsRecdPO.InsertParameters["GoodCnt"].DefaultValue = GoodCnt;
                odsRecdPO.InsertParameters["RewrkCnt"].DefaultValue = RewrkCnt;
                odsRecdPO.InsertParameters["ScrapCnt"].DefaultValue = ScrapCnt;
                odsRecdPO.Insert();
            }
        }
        protected void gvBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList ddl = e.Row.FindControl("ddlRecdDisplay") as DropDownList;
                ddl.SelectedIndex = RecdIndex;
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lnk = e.Row.FindControl("lnkEdit") as LinkButton; lnk.Visible = isYN("k03");
                if (lnk.Visible) lnk.CommandArgument = e.Row.RowIndex.ToString();
            }
        }

        private string clsSpace(string x)
        {
            return x.Equals("&nbsp;") ? string.Empty : x;
        }

        protected void doApprove(object sender, EventArgs e)
        {
            if (ddlLocation.SelectedValue.Equals("-1")) iMsg.ShowErr("Sorry! Location is Required.", true);
            else
            {
                System.Text.StringBuilder x = new System.Text.StringBuilder();
                for (int i = 0; i < gvRecdPO.Rows.Count; i++)
                {
                    GridViewRow Rw = gvRecdPO.Rows[i];
                    if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                        x.Append(string.Format("{0}:", gvRecdPO.DataKeys[i].Value));
                }
                if (x.Length > 0)
                {
                    odsRecdPO.UpdateParameters["IDs"].DefaultValue = x.ToString();
                    odsRecdPO.Update(); gvRecdPO.DataBind(); gvVerifiedPO.DataBind();
                }
                else iMsg.ShowErr("Sorry! Please select Purchase Order.", true);
            }
        }

        protected void doUndo(object sender, EventArgs e)
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
                odsVerifiedPO.Update(); gvVerifiedPO.DataBind(); gvRecdPO.DataBind();
            }
            else iMsg.ShowErr("Sorry! Please select Purchase Order.", true);
        }
        protected void dataBound(object sender, EventArgs e)
        {
            bool isRecd = (sender as GridView).ID.Equals("gvRecdPO");
            string PN = isRecd ? txtRecdPN.Text : txtVerifiedPN.Text;
            string PO = isRecd ? txtRecdPO.Text : txtVerifiedPO.Text;
            string St = isRecd ? "RecdTotal" : "VerifiedTotal";
            string lMode = isRecd ? Request.QueryString["lMode"] : string.Empty;
            DataTable Tb = (new clsPO()).Select(hfValx.Value, St, PN, PO, null, null, string.Empty, lMode);
            int Cnt = Tb != null & Tb.Rows.Count > 0 ? Convert.ToInt32(Tb.Rows[0]["Cnt"]) : 0;

            if (isRecd)
            {
                litRecdCnt.Visible = Cnt > 0;
                if (Cnt > 0) litRecdCnt.Text = string.Format("[{0} {1}]", Cnt, Cnt > 1 ? "records" : "record");
            }
            else
            {
                litVerifiedCnt.Visible = Cnt > 0;
                if (Cnt > 0) litVerifiedCnt.Text = string.Format("[{0} {1}]", Cnt, Cnt > 1 ? "records" : "record");
            }
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
            PageSec.Add("k01", "Undo");
            PageSec.Add("k02", "Approve");
            PageSec.Add("k03", "Update Count");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnUndo.Visible = isYN("k01");
            btnSubmit.Visible = isYN("k02");
        }
    }
}