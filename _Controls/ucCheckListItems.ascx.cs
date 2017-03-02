using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class ucCheckListItems : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string UserName
        {
            set
            {
                hfUserName.Value = value;
            }
        }

        public string CheckListID { set { hfCheckListID.Value = value; } }

        protected void chkChanged(object sender, EventArgs e)
        {
            var chk = sender as CheckBox;
            var row = chk.NamingContainer as GridViewRow;

            odsCheckListItems.UpdateParameters["HID"].DefaultValue = gvCheckListItems.DataKeys[row.RowIndex].Value.ToString();
            odsCheckListItems.UpdateParameters["Done"].DefaultValue = chk.Checked.ToString();
            odsCheckListItems.Update();
        }
    }
}