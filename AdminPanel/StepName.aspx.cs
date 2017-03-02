using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.AdminPanel
{
    public partial class StepName : Common.pgAbstract
    {
        private myBiz.DAL.clsStepName myDB = new myBiz.DAL.clsStepName();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Step Name Management"))
            {
                if (!IsPostBack)
                {
                    gvStepName.ShowFooter = isYN("k01");
                    this.Title = string.Format("Step Name Management for {0}", AppCode);
                }
            }
        }
        protected void lnk_Reset(object sender, EventArgs e) { gvStepName.SelectedIndex = -1; TabContainer1.Visible = false; }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string a = ((TextBox)gvStepName.FooterRow.FindControl("txtName")).Text.Trim();
            string b = ((TextBox)gvStepName.FooterRow.FindControl("txtDescription")).Text.Trim();
            string c = ((TextBox)gvStepName.FooterRow.FindControl("txtTopNote")).Text.Trim();
            string d = ((TextBox)gvStepName.FooterRow.FindControl("txtBottomNote")).Text.Trim();
            odsStepName.InsertParameters["Name"].DefaultValue = a;
            odsStepName.InsertParameters["Description"].DefaultValue = b;
            odsStepName.InsertParameters["TopNote"].DefaultValue = c;
            odsStepName.InsertParameters["BottomNote"].DefaultValue = d;
            odsStepName.InsertParameters["isActive"].DefaultValue = ((CheckBox)gvStepName.FooterRow.FindControl("chkActive")).Checked ? "True" : "False";
            odsStepName.Insert(); lnk_Reset(sender, e);
        }
        protected void btnAddProcessList_Click(object sender, EventArgs e)
        {
            if (lbxRemM.SelectedIndex > -1)
            {
                myDB.spStepName_ProcessList_I(gvStepName.SelectedDataKey.Value.ToString(), lbxRemM.SelectedValue); reloadMlbx();
            }
        }
        protected void btnDelProcessList_Click(object sender, EventArgs e)
        {
            if (lbxAddM.SelectedIndex > -1)
            {
                myDB.spStepName_ProcessList_D(lbxAddM.SelectedValue); reloadMlbx();
            }
        }
        protected void btnAddTask_Click(object sender, EventArgs e)
        {
            if (lbxRemT.SelectedIndex > -1)
            {
                myDB.spStepTask_I(gvStepName.SelectedDataKey.Value.ToString(), lbxRemT.SelectedValue); reloadTlbx();
            }
        }
        protected void btnDelTask_Click(object sender, EventArgs e)
        {
            if (lbxAddT.SelectedIndex > -1)
            {
                myDB.spStepTask_D(lbxAddT.SelectedValue); reloadTlbx();
            }
        }
        protected void odsUpdated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null && e.Exception.InnerException != null)
            {
                iMsg.ShowErr(e.Exception.InnerException.Message, true);
                e.ExceptionHandled = true;
            }
        }
        protected void gv_Select(object sender, EventArgs e) { gvStepName.EditIndex = -1; reloadMlbx(); reloadTlbx(); }
        protected void reloadMlbx()
        {
            lbxAddM.Items.Clear(); lbxRemM.Items.Clear();
            if (gvStepName.SelectedIndex > -1)
            {
                System.Data.DataSet Ds = myDB.spStepName_ProcessList_S(gvStepName.SelectedDataKey.Value.ToString());
                lbxAddM.DataSource = Ds.Tables[0]; lbxAddM.DataBind();
                lbxRemM.DataSource = Ds.Tables[1]; lbxRemM.DataBind();
            }
            TabContainer1.Visible = gvStepName.SelectedIndex > -1;
        }
        protected void reloadTlbx()
        {
            lbxAddT.Items.Clear(); lbxRemT.Items.Clear();
            if (gvStepName.SelectedIndex > -1)
            {
                System.Data.DataSet Ds = myDB.spStepTask_S(gvStepName.SelectedDataKey.Value.ToString(), AppCode);
                lbxAddT.DataSource = Ds.Tables[0]; ; lbxAddT.DataBind();
                lbxRemT.DataSource = Ds.Tables[1]; ; lbxRemT.DataBind();
            }
            TabContainer1.Visible = gvStepName.SelectedIndex > -1;
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
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Add Step Name");
            PageSec.Add("k02", "Edit Step Name");
            PageSec.Add("k03", "Delete Step Name");
        }
    }
}