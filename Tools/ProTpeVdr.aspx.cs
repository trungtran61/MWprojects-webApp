using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class ProTpeVdr : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Tools/Vendors for Process Type");
        }
 
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            var v = e.CommandArgument.ToString().Split(':');
            var state = v[1];
            odsDetails.SelectParameters["TypeID"].DefaultValue = v[0];
            odsDetails.SelectParameters["State"].DefaultValue = state;
            odsDetails.DataBind(); gvDetails.DataBind();
            litTitle.Text = state.Equals("All") ? "Total" : state.Equals("In") ? "In State" : "Out State";
        }

        protected void ddlChanged(object sender, EventArgs e)
        {
            odsDetails.SelectParameters["TypeID"].DefaultValue = "-1";
            gvProTpeVdr.SelectedIndex = -1;
            odsDetails.DataBind(); gvDetails.DataBind();
            litTitle.Text = string.Empty;
        }

        protected override void enforceSecurity()
        {
        }
    }
}