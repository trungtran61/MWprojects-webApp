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

namespace webApp._Controls
{
    public partial class ucFileCnt : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) foreach (GridViewRow Rw in gvFileCnt.Rows) gLinks(Rw);
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("doUpload"))
            {
                string[] v = e.CommandArgument.ToString().Split(':');
                clsFile.Show(Page, pnlPopup, "DL", "View Documents", string.Empty, Convert.ToInt32(v[0]), Convert.ToInt32(v[1]), string.Empty);
            }
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow) gLinks(e.Row);
        }
        protected void shipBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int PackID = Convert.ToInt32(gvShip.DataKeys[e.Row.RowIndex].Value);
                LinkButton lnkMtlCert = e.Row.FindControl("lnkMtlCert") as LinkButton;
                LinkButton lnkOPSCert = e.Row.FindControl("lnkOPSCert") as LinkButton;
                LinkButton lnk1stArt = e.Row.FindControl("lnk1stArt") as LinkButton;
                LinkButton lnkFinal = e.Row.FindControl("lnkFinal") as LinkButton;
                DataRow Rw = shipRpt; System.Text.StringBuilder sb = new System.Text.StringBuilder();

                if (Rw == null || Convert.ToBoolean(Rw["CoC"])) sb.AppendFormat("<li><a onclick=\"javascript:loadC('CofC','CofC',{0})\" class=\"Pointer\">Certificate of Conformance</a></li>", PackID);
                if (Rw == null || Convert.ToBoolean(Rw["sLabel"])) sb.AppendFormat("<li><a onclick=\"javascript:loadPView({0})\" class=\"Pointer\">Shipping Label</a></li>", PackID);
                if (Rw == null || Convert.ToBoolean(Rw["MatCert"])) sb.AppendFormat("<li><a onclick=\"javascript:{0}\" class=\"Pointer\">Material Certificate</a></li>", Page.ClientScript.GetPostBackEventReference(lnkMtlCert, string.Empty));
                if (Rw == null || Convert.ToBoolean(Rw["OPSCert"])) sb.AppendFormat("<li><a onclick=\"javascript:{0}\" class=\"Pointer\">OPS Certificate(s)</a></li>", Page.ClientScript.GetPostBackEventReference(lnkOPSCert, string.Empty));
                if (Rw != null && Convert.ToBoolean(Rw["FAIR"])) sb.AppendFormat("<li><a onclick=\"javascript:{0}\" class=\"Pointer\">First Article Report</a></li>", Page.ClientScript.GetPostBackEventReference(lnk1stArt, string.Empty));
                if (Rw != null && Convert.ToBoolean(Rw["FIN"])) sb.AppendFormat("<li><a onclick=\"javascript:{0}\" class=\"Pointer\">Final Inspection Report</a></li>", Page.ClientScript.GetPostBackEventReference(lnkFinal, string.Empty));

                if (sb.Length > 0)
                {
                    (e.Row.FindControl("litShip") as Literal).Text = string.Format("<ol>{0}</ol>", sb);
                }
            }
        }
        protected void doPrint(object sender, EventArgs e)
        {
            int GrpID; string txt, GrpIDs = string.Empty, LnkIDs = string.Empty;
            int LnkID = Convert.ToInt32((sender as LinkButton).CommandArgument);

            switch ((sender as LinkButton).ID)
            {
                case "lnkMtlCert":
                    GrpID = Convert.ToInt32(ConfigurationManager.AppSettings["MaterialCert"]);
                    txt = "Material Certification"; break;
                case "lnkOPSCert":
                    GrpID = Convert.ToInt32(ConfigurationManager.AppSettings["OPSCert"]);
                    GrpIDs = "WOID"; LnkIDs = "TravelerID";
                    txt = "OPS Certification(s)"; break;
                case "lnk1stArt":
                    GrpID = Convert.ToInt32(ConfigurationManager.AppSettings["FirstArticle"]);
                    txt = "First Article Report"; break;
                case "lnkFinal":
                    GrpID = Convert.ToInt32(ConfigurationManager.AppSettings["FinalInspection"]);
                    txt = "Final Inspection Report"; break;
                default: LnkID = GrpID = 0; txt = string.Empty; break;
            }

            if (!string.IsNullOrEmpty(txt)) clsFile.Show(Page, pnlPopup, "DL", false, txt, string.Empty, GrpID, LnkID, GrpIDs, LnkIDs, string.Empty);
        }
        protected void odsFiltering(object sender, ObjectDataSourceFilteringEventArgs e)
        {
            System.Collections.Generic.List<string> sList = new System.Collections.Generic.List<string>(); sList.Add("''");
            if (!isYN("k10")) sList.Add("'WO-SALE01'"); //Customer PO

            e.ParameterValues["TaskID"] = string.Join(",", sList.ToArray());
        }
        private void gLinks(GridViewRow Rw)
        {
            LinkButton lnk = Rw.FindControl("lnkUpload") as LinkButton;
            string GrpID = (Rw.FindControl("hfGrpID") as HiddenField).Value;
            string LnkID = (Rw.FindControl("hfLnkID") as HiddenField).Value;
            string lIDs = (Rw.FindControl("hflIDs") as HiddenField).Value;

            if (LnkID.Equals("-1") && lIDs.Contains(":"))
            {
                string[] v = lIDs.Split(':'); LnkID = v[0];
                if (v.Length > 2)
                {
                    string[] u = { "A", "B", "C", "D", "E", "F", "G", "H" };
                    PlaceHolder phl = Rw.FindControl("phlLinks") as PlaceHolder;
                    for (int i = 1; i < v.Length - 1; i++)
                    {
                        LinkButton x = new LinkButton(); x.ID = string.Format("xLink{0}", u[i - 1]); x.Text = u[i - 1];
                        x.CommandName = "doUpload"; x.CommandArgument = string.Format("{0}:{1}", GrpID, v[i]); x.Style.Add("margin-left", "5px");
                        phl.Controls.Add(x);
                    }
                }
            }

            lnk.CommandArgument = string.Format("{0}:{1}", GrpID, LnkID);
        }
        public string WOID { set { this.Visible = Convert.ToInt32(value) > 0; hfWOID.Value = value; } }
        private DataRow shipRpt
        {
            get
            {
                if (ViewState["shipRpt"] == null) ViewState["shipRpt"] = (new clsCustTerm()).ShipRpt(hfWOID.Value);
                DataTable Tb = ViewState["shipRpt"] as DataTable;
                return Tb != null && Tb.Rows.Count > 0 ? Tb.Rows[0] : null;
            }
        }
        private bool isYN(string key) { return PageSec.ContainsKey(key) && Convert.ToBoolean(PageSec[key]); }
        public Hashtable PageSec
        {
            set { ViewState["PageSec"] = value; }
            get
            {
                if (ViewState["PageSec"] == null) ViewState["PageSec"] = new Hashtable();
                return ViewState["PageSec"] as Hashtable;
            }
        }
        protected void Page_PreRender(object sender, EventArgs e) { tblShip.Visible = isYN("k11"); }
    }
}