using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;

namespace webApp.AdminPanel
{
    public partial class TaskSecSetup : webApp.Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("AdminPanel/Task Securities Setup");
        }
        protected void doLoad(object sender, EventArgs e)
        {
            if (ddlGroup.SelectedIndex < 1 || ddlDeptStep.SelectedIndex < 1)
                iMsg.ShowErr("Please select both the Group and Dept/Step to continue.", true);
        }
        protected void gvBound(object sender, EventArgs e) { btnSave.Enabled = gvTaskSec.Rows.Count > 0; }
        protected void doSave(object sender, EventArgs e)
        {
            if (ddlGroup.SelectedIndex > 0 && ddlDeptStep.SelectedIndex > 0)
            {
                List<StringBuilder> Val = new List<StringBuilder>();
                for (int j = 0; j < 11; j++) Val.Add(new StringBuilder());

                for (int i = 0; i < gvTaskSec.Rows.Count; i++)
                {
                    Val[0].Append(string.Format("{0}:", gvTaskSec.DataKeys[i].Value));
                    Val[1].Append(getItem(i, "chk01"));
                    Val[2].Append(getItem(i, "chk02"));
                    Val[3].Append(getItem(i, "chk03"));
                    Val[4].Append(getItem(i, "chk04"));
                    Val[5].Append(getItem(i, "chk05"));
                    Val[6].Append(getItem(i, "chk06"));
                    Val[7].Append(getItem(i, "chk07"));
                    Val[8].Append(getItem(i, "chk08"));
                    Val[9].Append(getItem(i, "chk09"));
                    Val[10].Append(getItem(i, "chk10"));
                }

                (new myBiz.DAL.clsUserGroup()).Task_Security_U(Val);
                iMsg.ShowMsg("Thank You! Data have been saved successfully.", true);
            }
            else
            {
                btnSave.Enabled = false;
                iMsg.ShowErr("Please select both the Group and Dept/Step to continue.", true);
            }
        }
        private string getItem(int i, string chkItem)
        {
            CheckBox chk = gvTaskSec.Rows[i].FindControl(chkItem) as CheckBox;
            return string.Format("{0}:", chk.Visible && chk.Checked ? 1 : 0);
        }
        protected override void enforceSecurity()
        {
        }
    }
}