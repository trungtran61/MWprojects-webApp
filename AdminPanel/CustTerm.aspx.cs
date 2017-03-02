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
    public partial class CustTerm : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("AdminPanel/Customer Term Setup");
        }
        protected void gv_Bound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1)
            {
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
                {
                    ((LinkButton)e.Row.FindControl("lnkEdit")).Enabled = isYN("k01");
                }
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Edit Customer Term");
        }
    }
}