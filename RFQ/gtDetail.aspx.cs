using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.RFQ
{
    public partial class gtDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                uPnlGage.Visible = isGage;
                uPnlTool.Visible = !uPnlGage.Visible;
            }
        }
        protected void lblLoad(object sender, EventArgs e)
        {
            string pQty = isGage ? string.Empty : string.Format("; PART-QTY: {0}", Request.QueryString["pQty"]);
            (sender as Label).Text = string.Format("{0}s: STEP#{1}: {2}{3}", Request.QueryString["GageTool"], Request.QueryString["sNo"], Request.QueryString["sNm"], pQty).ToUpper();
        }
        protected void gvBound(object sender, EventArgs e)
        {
            var xGV = sender as GridView;
            GridViewRow Rw = xGV.FooterRow;
            if (Rw != null)
            {
                var tt = xGV.Rows.Cast<GridViewRow>()
                    .Sum(r => Convert.ToDecimal((r.FindControl("hfTotal") as HiddenField).Value));
                (Rw.FindControl("litTotal") as Literal).Text = string.Format("{0:C}", tt);
            }
        }

        private bool isGage { get { return Request.QueryString["GageTool"].Equals("Gage"); } }
    }
}