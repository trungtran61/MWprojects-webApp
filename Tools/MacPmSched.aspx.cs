using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class MacPmSched : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Machine PM Schedule"))
            {
            }
        }

        protected void clickSearch(object sender, EventArgs e)
        {
            odsPmSched.SelectParameters["isSearch"].DefaultValue = "True";
        }
        protected void gvBound(object sender, EventArgs e)
        {
            gvPmSched.EmptyDataText = string.Format("No Record Found! {0}", DateTime.Now);
        }
        protected string gDD(string f)
        {
            try
            {
                var DD = Convert.ToDateTime(Eval(f));
                return string.Format("<span>{0}</span>", DD);
            }
            catch
            {
                return "No Date";
            }
        }
        protected override void enforceSecurity()
        {
        }
    }
}