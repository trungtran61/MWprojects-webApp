using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class OPSTypeMgmnt : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/OPS Type Management"))
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
                    case "gvSpecList":
                        odsSpecList.UpdateParameters["HID"].DefaultValue = "-1";
                        odsSpecList.UpdateParameters["OPSSpec"].DefaultValue = (Rw.FindControl("txtOPSSpec") as TextBox).Text;
                        odsSpecList.UpdateParameters["isActive"].DefaultValue = (Rw.FindControl("chkActive") as CheckBox).Checked.ToString();
                        odsSpecList.Update();
                        iTypeMsg.ShowMsg("Thank you! New Spec with description has been added.", true);
                        break;
                    case "gvDescList":
                        odsDescList.UpdateParameters["HID"].DefaultValue = "-1";
                        odsDescList.UpdateParameters["OPSDesc"].DefaultValue = (Rw.FindControl("txtOPSDesc") as TextBox).Text;
                        odsDescList.UpdateParameters["isActive"].DefaultValue = (Rw.FindControl("chkActive") as CheckBox).Checked.ToString();
                        odsDescList.Update();
                        iTypeMsg.ShowMsg("Thank you! New Desc has been added.", true);
                        break;
                }
            }

            if (!e.CommandName.Equals("Select")) iGV.SelectedIndex = -1;

            switch (iGV.ID)
            {
                case "gvTypeList": gvSpecList.SelectedIndex = -1; break;
                case "gvSpecList": gvDescList.SelectedIndex = -1; break;
            }
        }
        protected void ddlSelected(object sender, EventArgs e)
        {
            lblNew.Visible = pnlNew.Visible = cpeNew.Enabled = ddlVendorList.SelectedIndex > 0;
            if (lblNew.Visible)
            {
                lblNew.Text = string.Format("Click to add new OPS to block for {0}", ddlVendorList.SelectedItem.Text);
                ucNewBlk.VendorID = ddlVendorList.SelectedValue;
            }
        }
        protected override void enforceSecurity()
        {
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            uPnlSpec.Visible = gvTypeList.SelectedIndex > -1;
            uPnlDesc.Visible = gvSpecList.SelectedIndex > -1;
        }
    }
}