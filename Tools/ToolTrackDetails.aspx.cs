using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class ToolTrackDetails : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Tool Activity Detail Report"))
            {
            }
        }

        protected void clickSearch(object sender, EventArgs e)
        {
            odsDetails.SelectParameters["isSearch"].DefaultValue = "True";
        }
        protected void gvBound(object sender, EventArgs e)
        {
            gvDetails.EmptyDataText = string.Format("No Record Found! {0}", DateTime.Now);
        }
        protected override void enforceSecurity()
        {
        }
    }
}