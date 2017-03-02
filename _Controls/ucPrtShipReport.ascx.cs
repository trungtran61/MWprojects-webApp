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
    public partial class ucPrtShipReport : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) { gCmd("Task"); }
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
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
        private DataRow shipRpt
        {
            get
            {
                if (ViewState["shipRpt"] == null) ViewState["shipRpt"] = (new clsCustTerm()).ShipRpt(IDs[0]);
                DataTable Tb = ViewState["shipRpt"] as DataTable;
                return Tb != null && Tb.Rows.Count > 0 ? Tb.Rows[0] : null;
            }
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
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = isYN("t05");
            lnkPartTag.OnClientClick = string.Format("javascript:lFrame('File/Download.aspx?TID={0}'); return false;", this.IDs[3]);
        }
        //private void showModal()
        //{
        //    ScriptManager.RegisterStartupScript(Page, typeof(Page), "doScr", "prtShowModal();", true);
        //}
        //protected void pnlPreRender(object sender, EventArgs e)
        //{
        //    if (!IsPostBack)
        //    {
        //        int PackID = 103;
        //        frmCofC.FormPath = ConfigurationManager.AppSettings["FormPath"];
        //        frmCofC.Update((new clsPackingList()).getCofCData(PackID.ToString()));
        //        shipLabel.PackingID = PackID;

        //        prtForm.Items.Add(new ListItem("Certificate of Conformance::javascript:loadC('CofC','CofC',103)", "dvCofC"));
        //        prtForm.Items.Add(new ListItem("Shipping Label::javascript:loadPView(103)", "dvShippingLabel"));
        //        prtForm.Items.Add(new ListItem("Three", "dvThree"));
        //        prtForm.Items.Add(new ListItem("Four", "dvFour"));
        //    }
        //}

        //wcLibrary.Form frmCofC = e.Row.FindControl("frmCofC") as wcLibrary.Form;
        //UserControl_ShippingLabel shipLabel = e.Row.FindControl("shipLabel") as UserControl_ShippingLabel;
        //shipLabel.PackingID = PackID;

        //string dvCofC = (e.Row.FindControl("pnlCofC") as Panel).ClientID;
        //string dvShipLbl = (e.Row.FindControl("pnlShippingLabel") as Panel).ClientID;
        //string dvMtlCert = (e.Row.FindControl("pnlMtlCert") as Panel).ClientID;
        //string dvOPSCert = (e.Row.FindControl("pnlOPSCert") as Panel).ClientID;
        //string dvFirstArticle = (e.Row.FindControl("pnlFirstArticle") as Panel).ClientID;
        //string dvFinalInsRpt = (e.Row.FindControl("pnlFinalInsRpt") as Panel).ClientID;

        //frmCofC.FormPath = ConfigurationManager.AppSettings["FormPath"];
        //frmCofC.Update((new clsPackingList()).getCofCData(PackID.ToString()));
    }
}