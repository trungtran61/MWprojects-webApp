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

namespace webApp._Controls
{
    public partial class ShippingLabel : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public int PackingID
        {
            set
            {
                this.Visible = value > 0;
                odsShippingLabel.SelectParameters["PackingID"].DefaultValue = value.ToString();
            }
        }
    }
}