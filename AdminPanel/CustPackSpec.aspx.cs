using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.AdminPanel
{
    public partial class CustPackSpec : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("AdminPanel/Customer Packaging Specification");
        }
        protected void doSave(object sender, EventArgs e)
        {
            if (ddlCust.SelectedIndex > 0)
            {
                odsPackage.Update();
                iMsg.ShowMsg("Thank You! Your customer-packaging list have been saved.", true);
            }
            else iMsg.ShowErr("Please select Customer before you can save.", true);
        }
        protected void doChange(object sender, EventArgs e)
        {
            btnSaveCustPackSpec.Visible = cblPackage.Visible = isYN("k01") && ddlCust.SelectedIndex > 0;
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Save Packaging Specification");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            doChange(sender, e);
        }
    }
}