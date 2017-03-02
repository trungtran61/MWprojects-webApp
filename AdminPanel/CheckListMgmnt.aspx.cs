using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.AdminPanel
{
    public partial class CheckListMgmnt : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("AdminPanel/Check List Management");
        }

        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            var iGV = sender as GridView;
            if (e.CommandName.Equals("AddNew") || e.CommandName.Equals("InsertNew"))
            {
                Control Rw = e.CommandName.Equals("AddNew") ? iGV.FooterRow : iGV.Controls[0].Controls[0];
                switch (iGV.ID)
                {
                    case "gvCheckList":
                        odsCheckList.UpdateParameters["HID"].DefaultValue = "0";
                        odsCheckList.UpdateParameters["CheckListName"].DefaultValue = (Rw.FindControl("txtCheckListName") as TextBox).Text;
                        odsCheckList.UpdateParameters["Active"].DefaultValue = (Rw.FindControl("chkActive") as CheckBox).Checked.ToString();
                        odsCheckList.Update();
                        iCheckListMsg.ShowMsg("Thank you! New List Name has been added.", true);
                        break;
                    case "gvCheckListItems":
                        odsCheckListItems.UpdateParameters["HID"].DefaultValue = "0";
                        odsCheckListItems.UpdateParameters["Priority"].DefaultValue = (Rw.FindControl("txtPriority") as TextBox).Text;
                        odsCheckListItems.UpdateParameters["ItemTime"].DefaultValue = (Rw.FindControl("txtItemTime") as TextBox).Text;
                        odsCheckListItems.UpdateParameters["ItemName"].DefaultValue = (Rw.FindControl("txtItemName") as TextBox).Text;
                        odsCheckListItems.UpdateParameters["Description"].DefaultValue = (Rw.FindControl("txtDescription") as TextBox).Text;
                        odsCheckListItems.UpdateParameters["Active"].DefaultValue = (Rw.FindControl("chkActive") as CheckBox).Checked.ToString();
                        odsCheckListItems.Update();
                        iCheckListMsg.ShowMsg("Thank you! New Item has been added.", true);
                        break;
                }
            }

            if (!e.CommandName.Equals("Select")) iGV.SelectedIndex = -1;

            switch (iGV.ID)
            {
                case "gvCheckList": gvCheckListItems.SelectedIndex = -1; break;
            }
        }
        protected override void enforceSecurity()
        {
        }
        protected void doSave(object sender, EventArgs e)
        {
            odsUser.Update();
            iCheckListUserMsg.ShowMsg("Thank You! Data have been saved.", true);
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            uPnlCheckListItems.Visible = gvCheckList.SelectedIndex > -1;
        }
    }
}