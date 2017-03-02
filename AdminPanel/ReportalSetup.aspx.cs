using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.AdminPanel
{
    public partial class ReportalSetup : webApp.Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("AdminPanel/Reportal Setup");
        }
        protected override void enforceSecurity()
        {
        }
    }
}