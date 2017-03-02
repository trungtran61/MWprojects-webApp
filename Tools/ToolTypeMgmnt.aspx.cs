using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class ToolTypeMgmnt : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Tools Type Management"))
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
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {
                odsDDL.UpdateParameters["mText"].DefaultValue = ((TextBox)gvDDL.FooterRow.FindControl("txtmText")).Text.Trim();
                odsDDL.UpdateParameters["mValue"].DefaultValue = ((TextBox)gvDDL.FooterRow.FindControl("txtmValue")).Text.Trim();
                odsDDL.UpdateParameters["isActive"].DefaultValue = ((CheckBox)gvDDL.FooterRow.FindControl("chkActive")).Checked.ToString();
                odsDDL.UpdateParameters["SortOrder"].DefaultValue = ((TextBox)gvDDL.FooterRow.FindControl("txtSortOrder")).Text.Trim();
                odsDDL.Update();
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
                        odsTypeList.UpdateParameters["ToolType"].DefaultValue = (Rw.FindControl("txtToolType") as TextBox).Text;
                        odsTypeList.UpdateParameters["isActive"].DefaultValue = (Rw.FindControl("chkActive") as CheckBox).Checked.ToString();
                        odsTypeList.Update();
                        iTypeMsg.ShowMsg("Thank you! New Type has been added.", true);
                        break;
                    case "gvNameList":
                        odsNameList.UpdateParameters["HID"].DefaultValue = "-1";
                        odsNameList.UpdateParameters["ToolName"].DefaultValue = (Rw.FindControl("txtToolName") as TextBox).Text;
                        odsNameList.UpdateParameters["isActive"].DefaultValue = (Rw.FindControl("chkActive") as CheckBox).Checked.ToString();
                        odsNameList.Update();
                        iTypeMsg.ShowMsg("Thank you! New Name has been added.", true);
                        break;
                    case "gvDmsList":
                        clbDmsLib.Items.Cast<ListItem>().ToList().ForEach(r => r.Selected = false);
                        mpeDms.Show();
                        break;
                    case "gvUnitList":
                        odsUnitList.UpdateParameters["HID"].DefaultValue = "-1";
                        odsUnitList.UpdateParameters["ToolUnitTxt"].DefaultValue = (Rw.FindControl("txtToolUnitTxt") as TextBox).Text;
                        odsUnitList.UpdateParameters["ToolUnitVal"].DefaultValue = (Rw.FindControl("txtToolUnitVal") as TextBox).Text;
                        odsUnitList.UpdateParameters["isActive"].DefaultValue = (Rw.FindControl("chkActive") as CheckBox).Checked.ToString();
                        odsUnitList.Update();
                        iTypeMsg.ShowMsg("Thank you! New Unit has been added.", true);
                        break;
                }
            }

            if (!e.CommandName.Equals("Select")) iGV.SelectedIndex = -1;

            switch (iGV.ID)
            {
                case "gvTypeList": gvNameList.SelectedIndex = gvDmsList.SelectedIndex = gvUnitList.SelectedIndex = -1; break;
                case "gvNameList": gvDmsList.SelectedIndex = gvUnitList.SelectedIndex = -1; break;
                case "gvDmsList": gvUnitList.SelectedIndex = -1; break;
            }
        }
        protected void addDms(object sender, EventArgs e)
        {
            odsDmsList.InsertParameters["ToolDmsIDs"].DefaultValue = clbDmsLib.SelectedValues;
            odsDmsList.Insert();
            iTypeMsg.ShowMsg("Thank you! New selected dimension(s) have been added.", true);
        }
        protected void ddlSelected(object sender, EventArgs e)
        {
            lblNew.Visible = pnlNew.Visible = cpeNew.Enabled = ddlVendorList.SelectedIndex > 0;
            if (lblNew.Visible)
            {
                lblNew.Text = string.Format("Click to add new tool to block for {0}", ddlVendorList.SelectedItem.Text);
                ucNewBlk.VendorID = ddlVendorList.SelectedValue;
            }
        }
        protected override void enforceSecurity()
        {
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            uPnlName.Visible = gvTypeList.SelectedIndex > -1;
            uPnlDms.Visible = uPnlName.Visible && gvNameList.SelectedIndex > -1;
            uPnlUnit.Visible = uPnlDms.Visible && gvDmsList.SelectedIndex > -1;
        }
    }
}