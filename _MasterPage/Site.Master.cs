using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace webApp._MasterPage
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            dvSize.Style[HtmlTextWriterStyle.FontSize] = "small";
            //dvSize.Style[HtmlTextWriterStyle.FontSize] = string.IsNullOrEmpty(Profile.fontSize) ? "small" : Profile.fontSize;
            //if (Profile.lDate.AddHours(Convert.ToDouble(ConfigurationManager.AppSettings["inSession"])) < DateTime.Now) Util.Logout(Profile);
            //loadMenu();
        }
        //protected void loadMenu()
        //{
        //    mySB.Visible = Profile.isAuth; litRight.Text = "<a onclick=\"javascript:xy();\">Welcome ";
        //    litRight.Text += Profile.isAuth ? Profile.dName + "!</a>" : "Guest!</a>";
        //    Profile.lDate = Profile.LastActivityDate;
        //    if (!IsPostBack) ddlFontSize.SelectedValue = Profile.fontSize;
        //}
        protected void Changed(object sender, EventArgs e)
        {
            //Profile.fontSize = ddlFontSize.SelectedValue;
            //dvSize.Style[HtmlTextWriterStyle.FontSize] = Profile.fontSize;
        }
    }
}