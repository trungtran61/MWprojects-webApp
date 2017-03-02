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
using webApp.Common;

namespace webApp
{
    public partial class Login : pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getReferrer();
                if (!string.IsNullOrEmpty(Request.QueryString["cmd"]))
                {
                    if (Request.QueryString["cmd"].Equals("logout"))
                    {
                        litMessage.Text = "<b>You are now logged out.</b>";
                        clsUser.Logout();
                    }
                }
            }
            txtUserName.Focus();
        }
        protected void getReferrer()
        {
            Response.AddHeader("pragma", "no-cache");
            Response.AddHeader("cache-control", "private");
            Response.CacheControl = "no-cache";
            Response.Cache.SetExpires(DateTime.Now.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            if (isAllowed)
            {
                if (string.IsNullOrEmpty(Request.QueryString["P"]))
                {
                    string r = Request.UrlReferrer.ToString();
                    if (r.Contains("ChangePWD")) myHID.Value = "WIP/Status.aspx";
                    else if (r.IndexOf("Login") < 0) myHID.Value = r;
                }
                litMessage.Text = "<font color=blue>Please provide your credentials to login.</font>";
            }
            else
            {
                clsUser.Logout(); goBack();
            }
        }
        private bool isAllowed
        {
            get
            {
                bool YN = Request.UrlReferrer != null;
                if (!YN && !string.IsNullOrEmpty(Request.QueryString["ssKey"]) && Session["ssKey"] != null)
                {
                    string ssKey = Session["ssKey"].ToString();
                    YN = ssKey.Equals(Request.QueryString["ssKey"]);
                    Session["ssKey"] = null;
                }
                return YN;
            }
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (clsUser.Login(txtUserName.Text.Trim(), txtPassword.Text.Trim()))
            {
                if (Request.ServerVariables["REMOTE_ADDR"].StartsWith(ConfigurationManager.AppSettings["internalIP"]) || lSec("Login")) pageReturn();
                else
                {
                    clsUser.Logout();
                    litMessage.Text = string.Format("<b><font color=red>Login Denied! Your IP {0} is blocked.</font></b>", Request.ServerVariables["REMOTE_ADDR"]);
                }
            }
            else litMessage.Text = "<b><font color=red>Login Failed! Invalid username or bad password.</font></b>";
        }
        protected void btnCancel_Click(object sender, EventArgs e) { Response.Redirect("~/Default.aspx"); }
        protected void pageReturn()
        {
            Session["EnforcePWD"] = null;
            if (!string.IsNullOrEmpty(Request.QueryString["P"])) Response.Redirect(Request.QueryString["P"]);
            else if (!string.IsNullOrEmpty(myHID.Value)) Response.Redirect(myHID.Value);
            else goBack();
        }
        protected void goBack()
        {
            Response.Write("<script>window.history.go(-1);</script>");
            Response.End();
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "External Login");
            PageSec.Add("k02", "Enforce Password Change");
        }
        protected bool lSec(string PageName)
        {
            if (PageSec.Count < 1)
            {
                PageSec = new Hashtable(); PageSec.Add("k00", "Page Access"); enforceSecurity();
                PageSec = clsUser.prepareSecurity(PageName, PageSec);
            }

            return isYN("k00") && isYN("k01");
        }
    }
}