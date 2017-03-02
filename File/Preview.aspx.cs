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

namespace webApp.File
{
    public partial class Preview : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["FID"]) && !string.IsNullOrEmpty(Request.QueryString["HID"]) && !string.IsNullOrEmpty(Request.QueryString["Code"]))
                {
                    this.Title = !string.IsNullOrEmpty(Request.QueryString["Tt"]) ? Request.QueryString["Tt"] : "Preview";
                    string DF = Util.AppSetting("FormDefDate"), HID = Request.QueryString["HID"];
                    frmView.FormID = string.Format("{0}{1}", Request.QueryString["FID"], Request.QueryString["GT"]);
                    frmView.DF = string.IsNullOrEmpty(Request.QueryString["DF"]) ? DF : Request.QueryString["DF"];
                    frmView.FormPath = Util.AppSetting("FormPath");

                    switch (Request.QueryString["Code"])
                    {
                        case "Invoice": frmView.Update((new clsPackingList()).getInvoiceData(HID)); break;
                        case "PackingList": frmView.Update((new clsPackingList()).getPackingData(HID)); break;
                        case "CofC": frmView.Update((new clsPackingList()).getCofCData(HID)); break;
                        case "Tool": frmView.Update((new clsTool()).getFormData(frmView.FormID, HID)); break;
                        case "Traveler": frmView.Update(getTravelerWithTitle(HID, true)); btnLive.Visible = true; break;
                        case "Router": frmView.Update(getRouterWithTitle(HID, true)); break;
                        case "GeneralPO": frmView.Update((new clsPO()).getFormData(frmView.FormID, HID)); break;
                        case "OPSPO": frmView.Update((new clsOPS()).PO_Data(HID)); break;
                        case "OPS": frmView.Update((new clsOPS()).RFQ_Data(HID, this.AppCode)); break;
                        case "MaterialPO": frmView.Update((new clsMaterial()).PO_Data(HID, this.AppCode)); break;
                        case "Material": frmView.Update((new clsMaterial()).RFQ_Data(HID, this.AppCode)); break;
                        case "Gage": frmView.Update((new clsGage()).RFQ_Data(HID, this.AppCode)); break;
                        case "Tools": frmView.Update((new clsTools()).RFQ_Data(HID, this.AppCode)); break;
                        case "FinQte": frmView.Update((new clsFinQte()).QTE_Data(HID, this.AppCode));
                         btnEmail.Visible = btnFollowUp.Visible = string.IsNullOrEmpty(Request.QueryString["Q01"]);
                         break;
                        case "CustFU": frmView.Update((new clsCustFU()).LoadData(HID, this.AppCode));
                         btnFollowUp.Visible = true;
                         break;
                        case "PoCustFU": frmView.Update((new clsPoCustFU()).LoadData(HID, this.AppCode));
                         btnFollowUp.Visible = true;
                         break;
                        case "FirstArtDetail": frmView.Update((new cls1stArticle()).FirstArticle_getDetail(HID)); break;
                        case "FirstArtData": frmView.Update((new cls1stArticle()).FirstArticle_getData(HID)); break;
                        case "ComingSoon":
                        default: frmView.Text = "This feature is Coming Soon"; prtForm.Visible = btnEmail.Visible = false; break;
                    }
                }
                else
                {
                    frmView.Text = "I don't know what data to display here.";
                    prtForm.Visible = btnEmail.Visible = btnLive.Visible = btnFollowUp.Visible = false;
                }
            }
        }

        private Hashtable getRouterWithTitle(string RFQID, bool wData)
        {
            Hashtable h = (new clsRouter()).getFormData(RFQID, wData);
            this.Title = string.Format("RFQ#: {0}", (h["rwForm"] as DataRow)["RFQ"]);
            return h;
        }
        private Hashtable getTravelerWithTitle(string WOID, bool wData)
        {
            lSec("PreviewTraveler");
            if (btnLive.Visible && !isYN("k01")) btnLive.Visible = false;

            Hashtable h = (new clsTraveler()).getFormData(WOID, wData);
            this.Title = string.Format("WO#: {0}", (h["rwForm"] as DataRow)["WorkOrder"]);
            if (!isYN("k02")) (h["rwForm"] as DataRow)["DueDate"] = DateTime.MinValue;
            return h;
        }
        protected void ulData(object sender, EventArgs e) { frmView.Update(getTravelerWithTitle(Request.QueryString["HID"], false)); }
        protected void btnLoad(object sender, EventArgs e)
        {
            string url = string.Format("../File/sendEmail.aspx?AppCode={3}&FID={0}&GT={5}&HID={1}&Code={2}{4}",
                Request.QueryString["FID"], Request.QueryString["HID"], Request.QueryString["Code"], this.AppCode, glID, Request.QueryString["GT"]);

            if (!string.IsNullOrEmpty(Request.QueryString["DF"]))
                url += string.Format("&DF={0}", Request.QueryString["DF"]);

            btnEmail.OnClientClick = string.Format("javascript:loadEmail('{0}'); return false;", url);
        }
        protected void fuLoad(object sender, EventArgs e)
        {
            (sender as Button).OnClientClick = string.Format("javascript:loadEmail('../RFQ/{3}_Log.aspx?AppCode={1}&HID={0}&uID={2}'); return false;",
                Request.QueryString["HID"], this.AppCode, Request.QueryString["uID"], Request.QueryString["Code"].Equals("FinQte") ? "FollowUp" : Request.QueryString["Code"]);
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Live Traveler Data");
            PageSec.Add("k02", "View Customer Due Date");
        }
        protected void lSec(string PageName)
        {
            if (PageSec.Count < 1)
            {
                PageSec.Add("k00", "Page Access");
                PageSec = Common.clsUser.prepareSecurity(PageName, PageSec);
            }
        }
        private string glID
        {
            get
            {
                if (!string.IsNullOrEmpty(Request.QueryString["TaskID"]))
                {
                    int xID = Common.clsUser.xID(Request.QueryString["TaskID"], Common.clsUser.isWIP ? "TravelerID" : "PartID");
                    return string.Format("&gID={0}&lID={1}", Common.clsUser.isWIP ? 27 : 3, xID);
                }
                else
                {
                    return string.Empty;
                }
            }
        }
    }
}