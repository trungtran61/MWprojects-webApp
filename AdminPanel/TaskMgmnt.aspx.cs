using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using myBiz.DAL;

namespace webApp.AdminPanel
{
    public partial class TaskMgmnt : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Task Management"))
            {
                if (!IsPostBack) this.Title = string.Format("Task Management for {0}", AppCode);
                if (ddlStepName.SelectedIndex > -1) loadTbl(clsDB.loadTaskMgmnt(tblTaskMgmnt, ddlStepName.SelectedValue, AppCode, ddlOrderBy.SelectedValue));
            }
        }
        protected void btn_Save(object sender, EventArgs e)
        {
            litMsg.Text = clsDB.saveTaskMgmnt(tblTaskMgmnt);
        }
        protected void ddl_Bound(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) loadTbl(clsDB.loadTaskMgmnt(tblTaskMgmnt, ddlStepName.Items[0].Value, AppCode, ddlOrderBy.SelectedValue));
        }
        protected void loadTbl(bool YN)
        {
            tblTaskMgmnt.Visible = YN; litNotFound.Visible = !YN; btnSave.Visible = YN; litMsg.Visible = YN;
            btnSave.Enabled = isYN("k01");
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Save Task Management");
        }
    }
}