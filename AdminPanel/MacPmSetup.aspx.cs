using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.AdminPanel
{
    public partial class MacPmSetup : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("AdminPanel/Machine PM Setup");
        }

        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {
                var isFooter = e.CommandArgument.ToString().Equals("Footer");
                var gv = isFooter ? gvPMTask.FooterRow : gvPMTask.Controls[0].Controls[0];

                odsPMTask.UpdateParameters["HID"].DefaultValue = "0";
                odsPMTask.UpdateParameters["TaskID"].DefaultValue = (gv.FindControl("txtTaskID") as TextBox).Text.Trim();
                odsPMTask.UpdateParameters["TaskName"].DefaultValue = (gv.FindControl("txtTaskName") as TextBox).Text.Trim();
                odsPMTask.UpdateParameters["Description"].DefaultValue = (gv.FindControl("txtDescription") as TextBox).Text.Trim();
                odsPMTask.UpdateParameters["PMInterval"].DefaultValue = (gv.FindControl("txtPMInterval") as TextBox).Text.Trim();
                odsPMTask.Update();
            }
        }
        protected override void enforceSecurity()
        {
            //PageSec.Add("k01", "Controled Vendors");
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            gvPMTask.Visible = ddlMachineList.SelectedIndex > 0;
        }
    }
}