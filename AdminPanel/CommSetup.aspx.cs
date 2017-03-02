using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace webApp.AdminPanel
{
    public partial class CommSetup : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("AdminPanel/Communication Setup");
        }
        protected void doReset(object sender, EventArgs e)
        {
            txtItem.Text = txtCompany.Text = txtClass.Text = txtType.Text = txtContact.Text = txtMisc.Text = string.Empty;
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (gvComm.SelectedIndex > -1)
            {
                System.Text.StringBuilder x = new System.Text.StringBuilder();
                foreach (GridViewRow Rw in gvSendBy.Rows)
                    if ((Rw.FindControl("chkSendBy") as CheckBox).Checked)
                        x.Append(string.Format("{0}:", gvSendBy.DataKeys[Rw.DataItemIndex].Value));

                odsSendBy.UpdateParameters["SendBy"].DefaultValue = x.ToString();
                odsSendBy.Update();
                iMsg.ShowMsg("Thank You! Your settings have been saved.", true);
            }
            else iMsg.ShowErr("Sorry! Please select contact information before saving settings.", true);
        }
        public string gInfo()
        {
            return string.Format("{0}: {1} {2} {3}", Eval("CompanyName"), Eval("FirstName"), Eval("MiddleName"), Eval("LastName"));
        }
        protected void odsFiltering(object sender, ObjectDataSourceFilteringEventArgs e)
        {
            List<string> sList = new List<string>(); sList.Add("''");
            if (isYN("k01")) sList.Add("'Customer'");
            if (isYN("k02")) sList.Add("'Supplier'");
            if (isYN("k04")) sList.Add("'Owner'");

            e.ParameterValues["ClassName"] = string.Join(",", sList.ToArray());
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Customer");
            PageSec.Add("k02", "Supplier");
            PageSec.Add("k03", "Save Button");
            PageSec.Add("k04", "Owner");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnSave.Visible = isYN("k03");
        }
    }
}