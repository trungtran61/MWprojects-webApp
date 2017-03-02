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

namespace webApp._Controls
{
    public partial class ucUserGroup_ChatGroup : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {
                odsChatGroup.UpdateParameters["HID"].DefaultValue = "-1";
                odsChatGroup.UpdateParameters["gName"].DefaultValue = (gvChatGroup.FooterRow.FindControl("txtgName") as TextBox).Text.Trim();
                odsChatGroup.UpdateParameters["isActive"].DefaultValue = (gvChatGroup.FooterRow.FindControl("chkActive") as CheckBox).Checked.ToString();
                odsChatGroup.Update(); gvChatGroup.DataBind();
            }
            else if (e.CommandName.Equals("Edit"))
            {
                gvChatGroup.SelectedIndex = -1;
                if (pnlSave.Visible) pnlSave.Visible = false;
            }
        }
        protected void gvChanged(object sender, EventArgs e)
        {
            if (!pnlSave.Visible) pnlSave.Visible = true;
        }
        protected void doSave(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            foreach (ListItem i in cblGroup.Items) if (i.Selected) x.Append(string.Format("{0}:", i.Value));
            (new myBiz.DAL.clsChatLog()).ChatGroup_SaveGrpIDs(Convert.ToInt32(gvChatGroup.SelectedValue), x.ToString());
            cblGroup.DataBind(); iMsg.ShowMsg("Thank You! Data have been saved.", true);
        }
    }
}