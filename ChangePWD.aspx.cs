using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using webApp.Common;

namespace webApp
{
    public partial class ChangePWD : pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            litEpwd.Visible = !string.IsNullOrEmpty(clsUser.EnforcePWD);
        }
        protected void doChange(object sender, EventArgs e)
        {
            if (clsUser.ChangePWD(txtoPWD.Text, txtnPWD.Text))
            {
                Session["EnforcePWD"] = null;
                iMsg.ShowMsg("Thank you, you have successfully changed password!", true);
            }
            else iMsg.ShowErr("Sorry, Old password was invalid!", true);
        }
        protected override void enforceSecurity()
        {
        }
    }
}