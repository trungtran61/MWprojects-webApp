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
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class CurrentMode : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;
        protected void Page_Init(object sender, EventArgs e)
        {
            DataRow Rw = (new clsTaskName()).TaskInfo(Request.QueryString["IDs"], Common.clsUser.isWIP);
            btnTask.Text = Convert.ToString(Rw["ActionName"]);
            btnEdit.Visible = Convert.ToBoolean(Rw["isEdit"]);
            btnView.Visible = Convert.ToBoolean(Rw["isView"]);
            btnPrint.Visible = Convert.ToBoolean(Rw["isPrint"]);
            btnComp.Visible = !btnTask.Text.Equals("Upload");
            btnComp.Enabled = !"Completed".Equals(Rw["Status"]);
            myData = Rw; Msg = "Look_Back_N_Forth";
        }
        protected void Cmd_Click(object sender, CommandEventArgs e)
        {
            if (e.CommandName.Equals("Complete"))
            {
                string[] v = Request.QueryString["IDs"].Split(':');
                (new clsTaskList()).completeTask(Convert.ToInt32(v[3]), Common.clsUser.AppCode);
                btnComp.Enabled = false; myData["Status"] = "Completed";
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "xClose", "javascript:self.close();", true);
            }
            else
            {
                if (!btnComp.Enabled && (e.CommandName.Equals("Task") || e.CommandName.Equals("Edit")))
                {
                    (new clsTaskList()).undoTask(Request.QueryString["IDs"], Common.clsUser.AppCode);
                    btnComp.Enabled = true; myData["Status"] = "Open";
                }
                Hashtable h = new Hashtable(); h.Add("cMode", e.CommandName); this.myEvent(h);
            }
        }
        public bool reqTask { get { return litMsg.Visible && !pTask; } }
        public bool Taskable { set { btnTask.Visible = value; } }
        public bool Editable { set { btnEdit.Visible = value; } }
        public bool Viewable { set { btnView.Visible = value; } }
        public bool Printable { set { btnPrint.Visible = value; } }
        public bool Completable { set { btnComp.Visible = value; } }
        public string Msg
        {
            set
            {
                DataRow Rw = myData; pTask = false;
                if (value.Equals("Look_Back_N_Forth"))
                {
                    string reqTask = Convert.ToString(Rw["reqTask"]), preTask = Convert.ToString(Rw["preTask"]);
                    if (!string.IsNullOrEmpty(reqTask))
                    {
                        string xMsg = string.Format("{0} ({1})", reqTask, Convert.ToDateTime(Rw["DD"]).ToString(Common.clsUser.Util.AppSetting("DueDateFormat")));
                        litMsg.Text = string.Format("<br><font color=red>Please complete the task <b>{0}</b> prior to working on this task.</font>", xMsg);
                    }
                    else if (!string.IsNullOrEmpty(preTask))
                    {
                        pTask = true;
                        litMsg.Text = string.Format("<br><font color=red>Sorry! Can't modify this task due to tasks: <b>{0}</b> already completed.</font>", preTask);
                    }
                }
                else if (value.StartsWith(":")) litMsg.Text = string.Format("<br><font color=red>{0}</font>", value.Substring(1));

                litMsg.Visible = !string.IsNullOrEmpty(litMsg.Text); btnTask.Enabled = !litMsg.Visible;

                btnEdit.Enabled = Convert.ToBoolean(Rw["isEdit"]) && !litMsg.Visible;
                btnView.Enabled = Convert.ToBoolean(Rw["isView"]) && (!litMsg.Visible || pTask);
                btnPrint.Enabled = Convert.ToBoolean(Rw["isPrint"]) && (!litMsg.Visible || pTask);
                btnComp.Enabled = !"Completed".Equals(Rw["Status"]) && !litMsg.Visible;
            }
        }
        public string ActionName { get { return btnTask.Text; } }
        public string FormID { get { return gData("FormID"); } }
        public int GrpID { get { return Convert.ToInt32(myData["GrpID"]); } }
        public bool isOR { get { return Convert.ToBoolean(myData["isOR"]); } }
        public bool isDone { get { return Convert.ToBoolean(myData["isDone"]); } }
        public string woStatus { get { return Convert.ToString(myData["woStatus"]); } }
        public string Status { get { return Convert.ToString(myData["Status"]); } }
        public string TaskID { get { return Convert.ToString(myData["TaskID"]); } }
        private DataRow myData
        {
            get { return ViewState["myData"] as DataRow; }
            set
            {
                ViewState["myData"] = value; string Att = Convert.ToString(value["Attribute"]);
                if (!string.IsNullOrEmpty(Att))
                {
                    Hashtable h = new Hashtable(); string[] u = { "**" };
                    foreach (string i in Att.Split(u, StringSplitOptions.None))
                    {
                        string[] v = { "::" }; string[] w = i.Split(v, StringSplitOptions.None);
                        h.Add(w[0], w[1]);
                    }
                    ViewState["iAttribute"] = h;
                }
            }
        }
        public bool pTask
        {
            get { return hfpTask.Value.Equals("1"); }
            set { hfpTask.Value = value ? "1" : "0"; }
        }
        public string gData(string key)
        {
            if (ViewState["iAttribute"] != null)
            {
                Hashtable h = ViewState["iAttribute"] as Hashtable;
                return h.ContainsKey(key) ? h[key].ToString() : string.Empty;
            }
            else return string.Empty;
        }
        public ListItemCollection PrintItems { get { return btnPrint.Items; } }
        public string ViewTarget { set { btnView.OnClientClick = string.Format("javascript:{0}.style.display='block'; return false;", value); } }
        public void newWindow(string btn, string xURL)
        {
            switch (btn)
            {
                case "btnTask": btnTask.OnClientClick = string.Format("javascript:{0}; return false;", xURL); break;
                case "btnEdit": btnEdit.OnClientClick = string.Format("javascript:{0}; return false;", xURL); break;
                case "btnView": btnView.OnClientClick = string.Format("javascript:{0}; return false;", xURL); break;
            }
        }
        public void MarkDone(string text)
        {
            myData["isDone"] = text.Equals("Done");

        }
    }
}