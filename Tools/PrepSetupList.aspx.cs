using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class PrepSetupList : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Setup Prep List"))
            {
                hfToken.Value = Util.AppSetting("Token");
                hfChannel.Value = Util.AppSetting("Channel");
                hfApiListUrl.Value = string.Format(Util.AppSetting("ApiUrl"), "List/GetAutoList");
            }
        }
        protected string gDD(string k)
        {
            try
            {
                var DD = Convert.ToDateTime(Eval(k));
                var fColor = DateTime.Compare(DD, DateTime.Today) > 0 ? string.Empty : " style=\"color:Red;\"";
                return string.Format("<span{0}>{1}</span>", fColor, DD.ToString("MM/dd/yyyy"));
            }
            catch
            {
                return "No Date";
            }
        }
        protected override void enforceSecurity()
        {
        }

        protected void clickSearch(object sender, EventArgs e)
        {
            odsPrepSetupList.SelectParameters["isSearch"].DefaultValue = "True";
        }

        protected void gvBound(object sender, EventArgs e)
        {
            gvPrepSetupList.EmptyDataText = string.Format("No Record Found! {0}", DateTime.Now);
        }
    }
}