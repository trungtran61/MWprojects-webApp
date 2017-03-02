using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class IncPartList : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Tools/Incompleted Part List");
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && !e.Row.RowState.ToString().EndsWith("Edit"))
            {
                e.Row.FindControl("lnkEdit").Visible = isYN("k01");
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Edit");
        }
    }
}