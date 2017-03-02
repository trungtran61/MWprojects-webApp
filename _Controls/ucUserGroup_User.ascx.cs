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
    public partial class ucUserGroup_User : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void doSave(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlUser.SelectedValue)) iMsg.ShowErr("Please select User!", true);
            else
            {
                (new myBiz.DAL.clsUserGroup()).GroupUser_SaveByUser(ddlUser.SelectedValue, cblGroup.SelectedValues, !ddlSelected.SelectedValue.Equals("0")); cblGroup.DataBind();
                iMsg.ShowMsg("Thank You! Data have been saved.", true);
            }
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            pnlSave.Visible = ddlUser.SelectedIndex > 0;
        }
        public override void DataBind()
        {
            cblGroup.DataBind();
        }
    }
}