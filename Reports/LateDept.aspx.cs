using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using myBiz.DAL;

namespace webApp.Reports
{
    public partial class LateDept : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Report/Late Departmnet");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnGo.Visible = isYN("k01");
        }

        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Show Late Deliveries");
        }
    }
}