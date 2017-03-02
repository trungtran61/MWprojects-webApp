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
    public partial class OpenPO : Common.pgAbstract
    {
        protected void Page_Init(object sender, EventArgs e) { hfValx.Value = Request.Form["hfVal"]; hfUID.Value = Common.clsUser.uID; }
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Purchasing/Open Order");
        }

        protected void doSubmit(object sender, EventArgs e)
        {
            if (ddlLocation.SelectedValue.Equals("-1")) iMsg.ShowErr("Sorry! Location is Required.", true);
            else
            {
                System.Text.StringBuilder x = new System.Text.StringBuilder();
                for (int i = 0; i < gvOpenPO.Rows.Count; i++)
                    if ((gvOpenPO.Rows[i].FindControl("chkItem") as CheckBox).Checked) x.AppendFormat("{0}:", gvOpenPO.DataKeys[i].Value);

                if (x.Length > 0)
                {
                    odsOpenPO.UpdateParameters["IDs"].DefaultValue = x.ToString();
                    odsOpenPO.Update(); gvOpenPO.DataBind(); gvRecdPO.DataBind();
                }
                else iMsg.ShowErr("Sorry! Please select Purchase Order.", true);
            }
        }

        protected void doUndo(object sender, EventArgs e)
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
                odsRecdPO.Update(); gvRecdPO.DataBind(); gvOpenPO.DataBind();
            }
            else iMsg.ShowErr("Sorry! Please select Purchase Order.", true);
        }
        protected void recdBound(object sender, EventArgs e)
        {
            DateTime DDf = string.IsNullOrEmpty(txtRecdDDf.Text.Trim()) ? DateTime.MinValue : Convert.ToDateTime(txtRecdDDf.Text);
            DateTime DDt = string.IsNullOrEmpty(txtRecdDDt.Text.Trim()) ? DateTime.MinValue : Convert.ToDateTime(txtRecdDDt.Text);
            DataTable Tb = (new clsPO()).Select(hfValx.Value, "RecdTotal", txtRecdPN.Text, txtRecdPO.Text, txtRecdSupplier.Text, null, DDf, DDt, string.Empty, null);
            if (Tb != null & Tb.Rows.Count > 0)
            {
                int Cnt = Convert.ToInt32(Tb.Rows[0]["Cnt"]); litRecdCnt.Visible = Cnt > 0;
                if (litRecdCnt.Visible) litRecdCnt.Text = string.Format("[{0} {1}]", Cnt, Cnt > 1 ? "records" : "record");
            }
            else litRecdCnt.Visible = false;
        }
        protected void openBound(object sender, EventArgs e)
        {
            DateTime DDf = string.IsNullOrEmpty(txtOpenDDf.Text.Trim()) ? DateTime.MinValue : Convert.ToDateTime(txtOpenDDf.Text);
            DateTime DDt = string.IsNullOrEmpty(txtOpenDDt.Text.Trim()) ? DateTime.MinValue : Convert.ToDateTime(txtOpenDDt.Text);
            DataTable Tb = (new clsPO()).Select(hfValx.Value, "OpenTotal", txtOpenPN.Text, txtOpenPO.Text, txtOpenSupplier.Text, null, DDf, DDt, string.Empty, Request.QueryString["lMode"]);
            if (Tb != null & Tb.Rows.Count > 0)
            {
                int Cnt = Convert.ToInt32(Tb.Rows[0]["Cnt"]);
                litOpenCnt.Visible = Cnt > 0; showOpenTotal.Visible = isYN("k03") && Cnt > 0;
                if (litOpenCnt.Visible) litOpenCnt.Text = string.Format("[{0} {1}]", Cnt, Cnt > 1 ? "records" : "record");
                if (showOpenTotal.Visible) litOpenTotal.Text = string.Format("[{0:C}]", Tb.Rows[0]["Total"]);
            }
            else showOpenTotal.Visible = litOpenCnt.Visible = false;
        }

        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            bool isRecd = (sender as GridView).ID.Equals("gvRecdPO");
            if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList ddl = e.Row.FindControl(isRecd ? "ddlRecdDisplay" : "ddlOpenDisplay") as DropDownList;
                ddl.SelectedIndex = isRecd ? RecdIndex : OpenIndex;
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chk = e.Row.FindControl("chkItem") as CheckBox;
                if (chk != null)
                    chk.Attributes.Add("onclick", string.Format("javascript:dCnt({0},{1},'{2}');", chk.ClientID, (e.Row.FindControl("hfDollar") as HiddenField).Value, isRecd ? "lblRecdCnt" : "lblOpenCnt"));
            }
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl.ID.Equals("ddlRecdDisplay"))
            {
                gvRecdPO.PageSize = Convert.ToInt32(ddl.SelectedValue);
                RecdIndex = ddl.SelectedIndex;
            }
            else
            {
                gvOpenPO.PageSize = Convert.ToInt32(ddl.SelectedValue);
                OpenIndex = ddl.SelectedIndex;
            }
        }
        private int RecdIndex
        {
            get { return ViewState["RecdIndex"] != null ? Convert.ToInt32(ViewState["RecdIndex"]) : 0; }
            set { ViewState["RecdIndex"] = value; }
        }
        private int OpenIndex
        {
            get { return ViewState["OpenIndex"] != null ? Convert.ToInt32(ViewState["OpenIndex"]) : 0; }
            set { ViewState["OpenIndex"] = value; }
        }

        protected string gVdrName()
        {
            var vdrTerm = Eval("VdrTerm").ToString();
            var name = "<span title=\"{0}\">{1}{2}</span>";
            return string.Format(name, vdrTerm, Convert.ToBoolean(Eval("hasCCR")) ? "<span style=\"color:blue;\">&copy;</span> " : string.Empty, Eval("VendorName"));
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
            PageSec.Add("k02", "Submit");
            PageSec.Add("k03", "View Total");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnUndo.Visible = isYN("k01");
            btnSubmit.Visible = isYN("k02");
        }
    }
}