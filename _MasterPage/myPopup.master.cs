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
    public partial class myPopup : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            dvSize.Style[HtmlTextWriterStyle.FontSize] = clsUser.fontSize;
            //if (Common.clsUser.lDate.AddHours(Convert.ToDouble(ConfigurationManager.AppSettings["inSession"])) < DateTime.Now) Common.clsUser.Logout();
            //Common.clsUser.lDate = DateTime.Now;
        }
    }
}