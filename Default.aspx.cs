using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webApp.Common;

namespace webApp
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (clsUser.isValidated)
            {
                myQueue.Visible = true;
                string xPwd = clsUser.EnforcePWD;
                if (xPwd.Equals("ePwd")) Response.Redirect("~/ChangePWD.aspx", true);
                else dvChgPwd.Visible = !string.IsNullOrEmpty(xPwd);
            }
            else
            {
                myQueue.Visible = false;
                string ssKey = string.Format("i{0}", DateTime.Now.Ticks);
                Session.Add("ssKey", ssKey);
                Server.Transfer(string.Format("Login.aspx?P=WIP/Status.aspx&ssKey={0}", ssKey));
            }
        }
    }
}