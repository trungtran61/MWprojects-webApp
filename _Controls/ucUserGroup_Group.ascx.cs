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
    public partial class ucUserGroup_Group : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected string getRptLnk()
        {
            return string.Format("<a onclick=\"javascript:lPopup('../Reports/GroupReport.aspx?gID={0}&gName={1}');\" class=\"Pointer\">Report</a>", Eval("HID"), Eval("gName"));
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {
                odsGroup.UpdateParameters["HID"].DefaultValue = "-1";
                odsGroup.UpdateParameters["gName"].DefaultValue = (gvGroup.FooterRow.FindControl("txtgName") as TextBox).Text.Trim();
                odsGroup.UpdateParameters["isActive"].DefaultValue = (gvGroup.FooterRow.FindControl("chkActive") as CheckBox).Checked.ToString();
                odsGroup.Update(); gvGroup.DataBind();
            }
            else if (e.CommandName.Equals("Edit"))
            {
                gvGroup.SelectedIndex = -1;
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
            foreach (ListItem i in cblUser.Items) if (i.Selected) x.Append(string.Format("{0}:", i.Value));
            (new myBiz.DAL.clsUserGroup()).GroupUser_SaveByGroup(Convert.ToInt32(gvGroup.SelectedValue), x.ToString());
            cblUser.DataBind(); iMsg.ShowMsg("Thank You! Data have been saved.", true);
        }
        public override void DataBind()
        {
            cblUser.DataBind();
        }
    }
}