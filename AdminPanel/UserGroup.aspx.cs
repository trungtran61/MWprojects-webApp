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

namespace webApp.AdminPanel
{
    public partial class UserGroup : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("AdminPanel/Group User Management");
        }
        protected void tabChanged(object sender, EventArgs e)
        {
            if (TabContainer1.ActiveTabIndex == 0) xUser.DataBind();
            else xGroup.DataBind();
        }
        protected override void enforceSecurity()
        {
        }
    }
}