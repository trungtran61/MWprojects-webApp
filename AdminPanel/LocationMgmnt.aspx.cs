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

namespace webApp.AdminPanel
{
    public partial class LocationMgmnt : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Location Management"))
            {
                if (!IsPostBack) gvLocation.ShowFooter = isYN("k01");
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string Dept = ((TextBox)gvLocation.FooterRow.FindControl("txtDept")).Text.Trim();
            odsLocation.InsertParameters["HID"].DefaultValue = "0";
            odsLocation.InsertParameters["DescID"].DefaultValue = ((TextBox)gvLocation.FooterRow.FindControl("txtDescID")).Text.Trim();
            odsLocation.InsertParameters["Description"].DefaultValue = ((TextBox)gvLocation.FooterRow.FindControl("txtDescription")).Text.Trim();
            odsLocation.InsertParameters["Dept"].DefaultValue = string.IsNullOrEmpty(Dept) ? ddlDept.SelectedValue : Dept;
            odsLocation.InsertParameters["isActive"].DefaultValue = ((CheckBox)gvLocation.FooterRow.FindControl("chkActive")).Checked ? "True" : "False";
            odsLocation.Insert();
        }
        protected void gv_Bound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1)
            {
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
                {
                    ((LinkButton)e.Row.FindControl("lnkEdit")).Enabled = isYN("k02");
                }
            }
            string v = ddlDept.SelectedValue;
            ddlDept.DataBind();
            try { ddlDept.SelectedValue = v; }
            catch { ddlDept.SelectedIndex = 0; }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Add Location");
            PageSec.Add("k02", "Edit Location");
        }
    }
}