using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using myBiz.DAL;
using Common.DTO;

namespace webApp.AdminPanel
{
    public partial class PoCustMgmnt : webApp.Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Potential Customer Management"))
            {
            }
        }
        protected void gvContactCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Add") || e.CommandName.Equals("AddNew"))
            {
                var rw = e.CommandName.Equals("Add") ? gvContacts.FooterRow : gvContacts.Controls[0].Controls[0];

                odsContacts.UpdateParameters["HID"].DefaultValue = "-1";
                odsContacts.UpdateParameters["CustID"].DefaultValue = gvCustomer.SelectedValue.ToString();
                odsContacts.UpdateParameters["FirstName"].DefaultValue = (rw.FindControl("txtFirstName") as TextBox).Text.Trim();
                odsContacts.UpdateParameters["LastName"].DefaultValue = (rw.FindControl("txtLastName") as TextBox).Text.Trim();
                odsContacts.UpdateParameters["Dept"].DefaultValue = (rw.FindControl("txtDept") as TextBox).Text.Trim();
                odsContacts.UpdateParameters["Phone"].DefaultValue = (rw.FindControl("txtPhone") as TextBox).Text.Trim();
                odsContacts.UpdateParameters["Fax"].DefaultValue = (rw.FindControl("txtFax") as TextBox).Text.Trim();
                odsContacts.UpdateParameters["Cell"].DefaultValue = (rw.FindControl("txtCell") as TextBox).Text.Trim();
                odsContacts.UpdateParameters["Email"].DefaultValue = (rw.FindControl("txtEmail") as TextBox).Text.Trim();
                odsContacts.UpdateParameters["Address1"].DefaultValue = (rw.FindControl("txtAddress1") as TextBox).Text.Trim();
                odsContacts.UpdateParameters["Address2"].DefaultValue = (rw.FindControl("txtAddress2") as TextBox).Text.Trim();
                odsContacts.UpdateParameters["City"].DefaultValue = (rw.FindControl("txtCity") as TextBox).Text.Trim();
                odsContacts.UpdateParameters["State"].DefaultValue = (rw.FindControl("txtState") as TextBox).Text.Trim();
                odsContacts.UpdateParameters["Zip"].DefaultValue = (rw.FindControl("txtZip") as TextBox).Text.Trim();
                odsContacts.UpdateParameters["Website"].DefaultValue = (rw.FindControl("txtWebsite") as TextBox).Text.Trim();
                odsContacts.Update();
            }
        }
        protected void gvCustCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Add"))
            {
                odsCustomer.UpdateParameters["HID"].DefaultValue = "-1";
                odsCustomer.UpdateParameters["CompanyName"].DefaultValue = (gvCustomer.FooterRow.FindControl("txtCompanyName") as TextBox).Text.Trim();
                odsCustomer.UpdateParameters["CompanyID"].DefaultValue = (gvCustomer.FooterRow.FindControl("txtCompanyID") as TextBox).Text.Trim();
                odsCustomer.UpdateParameters["isActive"].DefaultValue = (gvCustomer.FooterRow.FindControl("chkActive") as CheckBox).Checked.ToString();
                odsCustomer.UpdateParameters["uID"].DefaultValue = Common.clsUser.uID;
                odsCustomer.Update();
            }
            else if (!e.CommandName.Equals("Select"))
            {
                ClearForm();
            }
        }
        protected void doRegister(object sender, EventArgs e)
        {
            if (gvCustomer.SelectedIndex > -1)
            {
                (new clsPoCustFU()).Register(Convert.ToInt32(gvCustomer.SelectedValue));
                iCustMsg.ShowMsg("Thank you! Customer has been registered.", true);
            }
            else iCustMsg.ShowErr("Sorry! Please customer to register", true);
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            ClearForm();
        }
        protected void ClearForm()
        {
            gvCustomer.SelectedIndex = -1;
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnRegister.Visible = gvContacts.Visible = gvCustomer.SelectedIndex > -1;
        }

        protected override void enforceSecurity()
        {

        }
    }
}