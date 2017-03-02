using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class CheckList : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            odsCheckLists.SelectParameters["UserName"].DefaultValue = Common.clsUser.uID;
        }
    }
}