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

namespace webApp.Errors
{
    public partial class Invalid : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Common.clsUser.isValidated)
                litMessage.Text = "<b><font color=red>Sorry! You have performed invalid function.<br>Please contact administrator for assistance.</b></font>";
            else Response.Redirect("../Default.aspx");
        }
    }
}