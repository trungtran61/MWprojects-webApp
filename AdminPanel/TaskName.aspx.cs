using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.AdminPanel
{
    public partial class TaskName : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Task Name Management"))
            {
                if (!IsPostBack) gvTaskName.ShowFooter = isYN("k01");
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            odsTaskName.InsertParameters["TaskID"].DefaultValue = ((TextBox)gvTaskName.FooterRow.FindControl("txtTaskID")).Text.Trim();
            odsTaskName.InsertParameters["ActionName"].DefaultValue = ((DropDownList)gvTaskName.FooterRow.FindControl("ddlActionName")).SelectedValue;
            odsTaskName.InsertParameters["isEdit"].DefaultValue = ((CheckBox)gvTaskName.FooterRow.FindControl("chkEdit")).Checked.ToString();
            odsTaskName.InsertParameters["isView"].DefaultValue = ((CheckBox)gvTaskName.FooterRow.FindControl("chkView")).Checked.ToString();
            odsTaskName.InsertParameters["isPrint"].DefaultValue = ((CheckBox)gvTaskName.FooterRow.FindControl("chkPrint")).Checked.ToString();
            odsTaskName.InsertParameters["reqTask"].DefaultValue = ((DropDownList)gvTaskName.FooterRow.FindControl("ddlreqTask")).SelectedValue;
            odsTaskName.InsertParameters["Name"].DefaultValue = ((TextBox)gvTaskName.FooterRow.FindControl("txtName")).Text.Trim();
            odsTaskName.InsertParameters["Category"].DefaultValue = ((TextBox)gvTaskName.FooterRow.FindControl("txtCategory")).Text.Trim();
            odsTaskName.InsertParameters["Hrs"].DefaultValue = ((TextBox)gvTaskName.FooterRow.FindControl("txtHrs")).Text.Trim();
            odsTaskName.InsertParameters["isActive"].DefaultValue = ((CheckBox)gvTaskName.FooterRow.FindControl("chkActive")).Checked ? "True" : "False";
            odsTaskName.InsertParameters["AppCode"].DefaultValue = ((DropDownList)gvTaskName.FooterRow.FindControl("ddlAppCode")).SelectedValue;
            odsTaskName.Insert();
        }
        protected void odsInserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                iMsg.ShowErr(e.Exception.InnerException.Message, true);
                e.ExceptionHandled = true;
            }
        }
        protected void gv_Bound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1)
            {
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
                {
                    ((LinkButton)e.Row.FindControl("lnkEdit")).Enabled = isYN("k02");
                    ((LinkButton)e.Row.FindControl("lnkDelete")).Enabled = isYN("k03");
                }
            }
            string v = ddlCategory.SelectedValue;
            ddlCategory.DataBind();
            try { ddlCategory.SelectedValue = v; }
            catch { ddlCategory.SelectedIndex = 0; }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Add Task Name");
            PageSec.Add("k02", "Edit Task Name");
            PageSec.Add("k03", "Delete Task Name");
        }
    }
}