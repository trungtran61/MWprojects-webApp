using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class MOTLog : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Tools/MOT Log");
        }

        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow) //e.Row.RowState.ToString().Contains("Edit")
            {
                e.Row.FindControl("btnDelete").Visible = isYN("k01");
            }
        }

        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Delete Log");
        }
    }
}