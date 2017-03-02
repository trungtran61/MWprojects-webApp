using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.AdminPanel
{
    public partial class UserMgmnt : Common.pgAbstract
    {
        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    if (loadSec("AdminPanel/Manage User List"))
        //    {
        //        if (!Page.IsPostBack) { cblGroup.DataBind(); gvUser.ShowFooter = isYN("k01"); }
        //    }
        //}
        //protected void btnAdd_Click(object sender, EventArgs e)
        //{
        //    sdsUser.InsertParameters["mwUserName"].DefaultValue = ((TextBox)gvUser.FooterRow.FindControl("txtmwUserName")).Text.Trim();
        //    sdsUser.InsertParameters["mwPassword"].DefaultValue = ((TextBox)gvUser.FooterRow.FindControl("txtmwPassword")).Text.Trim();
        //    sdsUser.InsertParameters["mwName"].DefaultValue = ((TextBox)gvUser.FooterRow.FindControl("txtmwName")).Text.Trim();
        //    sdsUser.InsertParameters["mwEmail"].DefaultValue = ((TextBox)gvUser.FooterRow.FindControl("txtmwEmail")).Text.Trim();
        //    sdsUser.InsertParameters["mwActive"].DefaultValue = ((CheckBox)gvUser.FooterRow.FindControl("chkmwActive")).Checked ? "1" : "0";
        //    sdsUser.Insert(); lnk_Reset(sender, e);
        //}
        //protected void gv_Bound(object sender, GridViewRowEventArgs e)
        //{
        //    if (e.Row.RowIndex > -1)
        //    {
        //        if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
        //        {
        //            ((LinkButton)e.Row.FindControl("lnkEdit")).Enabled = isYN("k02");
        //            ((LinkButton)e.Row.FindControl("lnkDelete")).Enabled = isYN("k03");
        //        }
        //        myBiz.SQLAccess.SQL mSQL = new myBiz.SQLAccess.SQL();
        //        mSQL.ConnectDB(ConfigurationManager.ConnectionStrings["DefCS"].ConnectionString);
        //        string i = mSQL.getStr("SELECT mwTitle FROM MWEmployees WHERE mwEmployeeID=(SELECT mwEmployeeID FROM MWUser WHERE mwUserName='" +
        //            gvUser.DataKeys[e.Row.RowIndex].Value.ToString() + "')");
        //        ((Literal)e.Row.FindControl("litTitle")).Text = string.IsNullOrEmpty(i) ? "N/A" : i;
        //        mSQL.DisconnectDB();
        //    }
        //}
        //protected void gv_Update(object sender, GridViewUpdateEventArgs e)
        //{
        //    if (e.NewValues["mwPassword"] == null || string.IsNullOrEmpty(e.NewValues["mwPassword"].ToString().Trim()))
        //        e.NewValues["mwPassword"] = e.OldValues["mwPassword"];
        //}
        //protected void gv_Delete(object sender, GridViewDeleteEventArgs e)
        //{
        //    Util.dAccountGrp(e.Keys["mwUserName"].ToString());
        //}
        //protected void gv_Changed(object sender, EventArgs e)
        //{
        //    if (gvUser.SelectedIndex > -1)
        //    {
        //        Hashtable h = Util.userGroup(gvUser.SelectedValue.ToString()); pnlCB.Visible = true;
        //        foreach (ListItem i in cblGroup.Items) i.Selected = Convert.ToBoolean(h[i.Value]);
        //    }
        //    else pnlCB.Visible = false;
        //}
        //protected void lnk_Save(object sender, EventArgs e)
        //{
        //    string rMsg = string.Empty;
        //    if (gvUser.SelectedIndex > -1)
        //        rMsg = Util.updateUsrGroup(gvUser.SelectedValue.ToString(), cblGroup.Items);
        //    else rMsg = "Please select a user.";
        //    Util.MessageBox(Page, rMsg);
        //}
        //protected void lnk_Reset(object sender, EventArgs e) { gvUser.SelectedIndex = -1; pnlCB.Visible = false; }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Add New User");
            PageSec.Add("k02", "Edit User");
            PageSec.Add("k03", "Delete User");
        }
    }
}