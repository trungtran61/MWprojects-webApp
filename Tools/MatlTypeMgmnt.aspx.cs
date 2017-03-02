using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class MatlTypeMgmnt : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Material Type Management"))
            {
                ucNewBlk.myEvent += new Common.myDelegate(ucNewBlk_myEvent);
            }
        }

        protected void ucNewBlk_myEvent(System.Collections.Hashtable h)
        {
            if (h.Contains("Cmd"))
            {
                cpeNew.ClientState = "true";
                dlBlkVendor.DataBind();
            }
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            var iGV = sender as GridView;
            if (e.CommandName.Equals("AddNew") || e.CommandName.Equals("InsertNew"))
            {
                Control Rw = e.CommandName.Equals("AddNew") ? iGV.FooterRow : iGV.Controls[0].Controls[0];
                switch (iGV.ID)
                {
                    case "gvTypeList":
                        odsTypeList.UpdateParameters["HID"].DefaultValue = "-1";
                        odsTypeList.UpdateParameters["MatlType"].DefaultValue = (Rw.FindControl("txtMatlType") as TextBox).Text;
                        odsTypeList.UpdateParameters["isActive"].DefaultValue = (Rw.FindControl("chkActive") as CheckBox).Checked.ToString();
                        odsTypeList.Update();
                        iTypeMsg.ShowMsg("Thank you! New Type has been added.", true);
                        break;
                    case "gvAmsList":
                        odsAmsList.UpdateParameters["HID"].DefaultValue = "-1";
                        odsAmsList.UpdateParameters["MatlAms"].DefaultValue = (Rw.FindControl("txtMatlAms") as TextBox).Text;
                        odsAmsList.UpdateParameters["isActive"].DefaultValue = (Rw.FindControl("chkActive") as CheckBox).Checked.ToString();
                        odsAmsList.Update();
                        iTypeMsg.ShowMsg("Thank you! New Ams has been added.", true);
                        break;
                    case "gvFormList":
                        odsFormList.UpdateParameters["HID"].DefaultValue = "-1";
                        odsFormList.UpdateParameters["MatlForm"].DefaultValue = (Rw.FindControl("txtMatlForm") as TextBox).Text;
                        odsFormList.UpdateParameters["isActive"].DefaultValue = (Rw.FindControl("chkActive") as CheckBox).Checked.ToString();
                        odsFormList.Update();
                        iFormMsg.ShowMsg("Thank you! New Form has been added.", true);
                        break;
                    case "gvDmsList":
                        odsDmsList.UpdateParameters["HID"].DefaultValue = "-1";
                        odsDmsList.UpdateParameters["MatlDms"].DefaultValue = (Rw.FindControl("txtMatlDms") as TextBox).Text;
                        odsDmsList.UpdateParameters["isActive"].DefaultValue = (Rw.FindControl("chkActive") as CheckBox).Checked.ToString();
                        odsDmsList.Update();
                        iFormMsg.ShowMsg("Thank you! New Dimension has been added.", true);
                        break;
                    case "gvUnitList":
                        odsUnitList.UpdateParameters["HID"].DefaultValue = "-1";
                        odsUnitList.UpdateParameters["MatlUnitTxt"].DefaultValue = (Rw.FindControl("txtMatlUnitTxt") as TextBox).Text;
                        odsUnitList.UpdateParameters["MatlUnitVal"].DefaultValue = (Rw.FindControl("txtMatlUnitVal") as TextBox).Text;
                        odsUnitList.UpdateParameters["isActive"].DefaultValue = (Rw.FindControl("chkActive") as CheckBox).Checked.ToString();
                        odsUnitList.Update();
                        iFormMsg.ShowMsg("Thank you! New Unit has been added.", true);
                        break;
                }
            }
            
            if (!e.CommandName.Equals("Select")) iGV.SelectedIndex = -1;

            switch (iGV.ID)
            {
                case "gvTypeList": gvAmsList.SelectedIndex = -1; break;
                case "gvFormList": gvDmsList.SelectedIndex = gvUnitList.SelectedIndex = -1; break;
                case "gvDmsList": gvUnitList.SelectedIndex = -1; break;
            }
        }
        protected void ddlSelected(object sender, EventArgs e)
        {
            lblNew.Visible = pnlNew.Visible = cpeNew.Enabled = ddlVendorList.SelectedIndex > 0;
            if (lblNew.Visible)
            {
                lblNew.Text = string.Format("Click to add new material to block for {0}", ddlVendorList.SelectedItem.Text);
                ucNewBlk.VendorID = ddlVendorList.SelectedValue;
            }
        }
        protected override void enforceSecurity()
        {
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            uPnlAms.Visible = gvTypeList.SelectedIndex > -1;
            uPnlDms.Visible = uPnlForm.Visible && gvFormList.SelectedIndex > -1;
            uPnlUnit.Visible = uPnlDms.Visible && gvDmsList.SelectedIndex > -1;
        }
    }
}