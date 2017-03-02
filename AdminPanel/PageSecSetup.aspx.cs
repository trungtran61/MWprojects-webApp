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
    public partial class PageSecSetup : webApp.Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("AdminPanel/Page Securities Setup");
        }
        protected void doLoad(object sender, EventArgs e)
        {
            if (ddlGroup.SelectedIndex < 1 || ddlPage.SelectedIndex < 1)
                iMsg.ShowErr("Please select both the Group and Page to continue.", true);
        }
        protected void cblBound(object sender, EventArgs e) { btnSave.Enabled = cblPageSec.Items.Count > 0; }
        protected void doSave(object sender, EventArgs e)
        {
            if (ddlGroup.SelectedIndex > 0 && ddlPage.SelectedIndex > 0)
            {
                System.Text.StringBuilder IDs = new System.Text.StringBuilder();
                System.Text.StringBuilder Val = new System.Text.StringBuilder();

                foreach (ListItem i in cblPageSec.Items)
                {
                    IDs.Append(string.Format("{0}:", i.Value));
                    Val.Append(string.Format("{0}:", i.Selected ? 1 : 0));
                }
                odsPageSec.UpdateParameters["IDs"].DefaultValue = IDs.ToString();
                odsPageSec.UpdateParameters["Val"].DefaultValue = Val.ToString();
                odsPageSec.Update();

                iMsg.ShowMsg("Thank You! Data have been saved successfully.", true);
            }
            else
            {
                btnSave.Enabled = false;
                iMsg.ShowErr("Please select both the Group and Page to continue.", true);
            }
        }
        protected override void enforceSecurity()
        {
        }
    }
}