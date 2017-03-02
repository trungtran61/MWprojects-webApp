using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class ToolTrackPeriods : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Tool Activity Period Report"))
            {
                hfToken.Value = Util.AppSetting("Token");
                hfChannel.Value = Util.AppSetting("Channel");
                hfApiUrl.Value = string.Format(Util.AppSetting("ApiUrl"), "ToolTracking/GetReportTotals");
            }
        }

        protected void clickSearch(object sender, EventArgs e)
        {
            odsPeriods.SelectParameters["isSearch"].DefaultValue = "True";
        }
        protected void gvBound(object sender, EventArgs e)
        {
            gvPeriods.EmptyDataText = string.Format("No Record Found! {0}", DateTime.Now);
        }
        protected override void enforceSecurity()
        {
        }
    }
}