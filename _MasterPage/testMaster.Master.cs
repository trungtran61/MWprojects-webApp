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
    public partial class testMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            dvSize.Style[HtmlTextWriterStyle.FontSize] = clsUser.fontSize;
            //if (Common.clsUser.lDate.AddHours(Convert.ToDouble(ConfigurationManager.AppSettings["inSession"])) < DateTime.Now) Common.clsUser.Logout();
            //Common.clsUser.lDate = DateTime.Now;
        }
        protected void loadMenu()
        {
            lblLeft.Text = "Welcome ";
            lblLeft.Text += clsUser.isValidated ? clsUser.dName + "!" : "Guest!";

        }
        public void setInfo(Hashtable h)
        {
            if (h.Contains("ForeColor") && !string.Empty.Equals(h["ForeColor"])) lblLeft.ForeColor = System.Drawing.ColorTranslator.FromHtml(h["ForeColor"].ToString());
            trTitle.BgColor = h.Contains("BackColor") && !string.Empty.Equals(h["BackColor"]) ? h["BackColor"].ToString() : "#CCFFCC";
            lblLeft.Text = h.Contains("Title") ? h["Title"].ToString() : string.Format("Welcome {0}!", clsUser.isValidated ? clsUser.dName : "Guest");
        }
    }
}