using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class PackageSpec : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Packaging Specification"))
            {
            }
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {
                odsPackageSpec.UpdateParameters["HID"].DefaultValue = "-1";
                odsPackageSpec.UpdateParameters["PackageName"].DefaultValue = (gvPackageSpec.FooterRow.FindControl("txtName") as TextBox).Text.Trim();
                odsPackageSpec.Update();
            }
            else if (e.CommandName.Equals("viewFile"))
            {
                doFile("DL", Convert.ToInt32(e.CommandArgument));
            }
            else if (e.CommandName.Equals("uploadFile"))
            {
                doFile("UL", Convert.ToInt32(e.CommandArgument));
            }
        }
        protected void doFile(string cmd, int HID)
        {
            myBiz.DAL.clsFile.Show(Page, pnlPopup, cmd, isYN("k02"), "Packaging Specification", string.Empty, Convert.ToInt32(Util.AppSetting("PackageSpecFile")), HID, "300");
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Edit Specification");
            PageSec.Add("k02", "Delete Specification");
            PageSec.Add("k03", "Add New Specification");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            gvPackageSpec.ShowFooter = isYN("k03");
        }
    }
}