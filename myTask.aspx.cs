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

namespace webApp
{
    public partial class myTask : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("myTask"))
            {
                if (!goodEntry()) Response.Redirect("Errors/InvalidPopup.aspx");
                else if (!string.IsNullOrEmpty(Request.QueryString["IDs"]))
                {
                    if (!IsPostBack)
                    {
                        Hashtable h = new Hashtable(); clsTaskList TL = new clsTaskList();
                        DataTable Tb = Common.clsUser.isWIP ? TL.Select(Request.QueryString["IDs"]) : TL.Select_RFQ(Request.QueryString["IDs"]);
                        if (Tb != null && Tb.Rows.Count > 0)
                        {
                            DataRow Rw = Tb.Rows[0]; curUC = Rw["UserControl"].ToString(); pgTitle = Rw["pgTitle"].ToString();
                            h.Add("Title", Rw["dTitle"]); h.Add("ForeColor", Rw["FC"]); h.Add("BackColor", Rw["BC"]);
                        }
                        else curUC = string.Empty;
                        ((_MasterPage.MiniMaster)Master).setInfo(h);
                    }
                    loadTask(); this.Title = pgTitle;
                }
            }
        }
        protected void loadTask()
        {
            Control x = gControl(curUC); pnlTask.Controls.Clear(); pnlTask.Controls.Add(x);
            Control btn = x.FindControl("myMode").FindControl("btnComp");
            hfCompBtn.Value = btn == null ? "NotFound" : btn.ClientID;
        }
        private UserControl gControl(string ucFile)
        {
            if (string.IsNullOrEmpty(ucFile)) ucFile = "notAvailable";
            UserControl x = (UserControl)LoadControl(string.Format("~/_Controls/{0}.ascx", ucFile));
            x.ID = string.Format("uc{0}", ucFile); return x;
        }
        private string curUC
        {
            set { ViewState.Add("curUC", value); }
            get { return !string.IsNullOrEmpty(Request.QueryString["test"]) ? Request.QueryString["test"] : ViewState["curUC"].ToString(); }
        }
        private string pgTitle
        {
            get { return Convert.ToString(ViewState["pgTitle"]); }
            set { ViewState["pgTitle"] = value; }
        }
        private bool goodEntry()
        {
            Response.AddHeader("pragma", "no-cache");
            Response.AddHeader("cache-control", "private");
            Response.CacheControl = "no-cache";
            Response.Cache.SetExpires(DateTime.Now.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            return !string.IsNullOrEmpty(Request.QueryString["IDs"]);
        }
        protected override void enforceSecurity()
        {
        }
    }
}