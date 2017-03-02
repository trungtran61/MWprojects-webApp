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

namespace webApp._MasterPage
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            dvSize.Style[HtmlTextWriterStyle.FontSize] = clsUser.fontSize;
            //if (Common.clsUser.lDate.AddHours(Convert.ToDouble(ConfigurationManager.AppSettings["inSession"])) < DateTime.Now) Common.clsUser.Logout();
            loadMenu();
        }
        //protected override void OnPreRender(EventArgs e)
        //{
        //    base.OnPreRender(e);
        //    if (!Page.ClientScript.IsClientScriptBlockRegistered("TimeOutScript"))
        //    {
        //        string jvScript = Common.clsUser.TimeOutScript("Your page will expire in 5 minutes", 89);
        //        Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "TimeOutScript", jvScript);
        //    }
        //}
        protected void loadMenu()
        {
            mySB.Visible = clsUser.isValidated; litRight.Text = "<a onclick=\"javascript:xy();\">Welcome ";
            litRight.Text += mySB.Visible ? clsUser.dName + "!</a>" : "Guest!</a>";
            //clsUser.lDate = DateTime.Now;
            if (!IsPostBack) ddlFontSize.SelectedValue = clsUser.fontSize;
        }
        protected void Changed(object sender, EventArgs e)
        {
            dvSize.Style[HtmlTextWriterStyle.FontSize] = clsUser.fontSize = ddlFontSize.SelectedValue;
        }
        protected string gVersion()
        {
            return clsUser.Util.AppSetting("AppVersion");
        }
        protected string gLink(string item)
        {
            string url = Request.ServerVariables["HTTP_HOST"];
            string[] v = Request.ServerVariables["PATH_INFO"].Split('/');

            return string.Format("<a href=\"javascript:xPopup('http://{0}/{1}/Tools/{2}.aspx');\" class=\"lnkQueue\">{2}</a> |", url, v[1], item);
        }
    }
}