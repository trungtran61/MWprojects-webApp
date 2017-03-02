using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using myBiz.DAL;
using System.Data;

namespace webApp._Controls
{
    public partial class ucExistedRouter : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack)
            {
                CheckRouterCreator();
                gCmd("View");
            }
        }

        protected void CheckRouterCreator()
        {
            var rw = (new clsRouter()).CheckRouterCreator(IDs[0]);

            if (rw != null)
            {
                txtPN.Text = rw["PN"] != null ? rw["PN"].ToString() : string.Empty;
                hfHasRouter.Value = rw["hasRouter"] != null ? rw["hasRouter"].ToString() : string.Empty;
                try
                {
                    hfRouterCreator.Value = ddlName.SelectedValue = rw["AssignedTo"].ToString();
                }
                catch
                {
                    hfRouterCreator.Value = string.Empty;
                    ddlName.SelectedIndex = 0;
                }
            }
            else
            {
                hfRouterCreator.Value = string.Empty;
                ddlName.SelectedIndex = 0;
                hfHasRouter.Value = "No";
            }
        }

        protected void doAssign(object sender, EventArgs e)
        {
            hfRouterCreator.Value = ddlName.SelectedValue;
            (new clsTaskList()).AssignTo(IDs[0], ddlName.SelectedValue);
            iMsg.ShowMsg(string.Format("Thank you! Router has been assigned to: {0}", ddlName.SelectedItem.Text), true);
        }

        protected void doGenerate(object sender, EventArgs e)
        {
            if (gvExisted.SelectedIndex < 0 && gvExistedTraveler.SelectedIndex < 0) iMsg.ShowErr("Please select existed router/traveler.", true);
            else
            {
                var isRouter = gvExisted.SelectedIndex >= 0;
                var fID = isRouter ? Convert.ToInt32(gvExisted.SelectedValue) : Convert.ToInt32(gvExistedTraveler.SelectedValue);
                var tRFQID = Convert.ToInt32(IDs[0]);
                var cls = new clsRouter();
                var success = isRouter ? cls.Copy(fID, tRFQID) : cls.CopyFromTraveler(fID, tRFQID);

                if (success) iMsg.ShowMsg("Thank you! Data has been saved.", true);
                else iMsg.ShowErr("Sorry! RFQ already has router.", true);
                
                hfHasRouter.Value = "Yes";
            }
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Select") && !btnSave.OnClientClick.StartsWith("return"))
            {
                btnSave.OnClientClick = "return confirm('Are you sure you want to use this router?');";
                btnSave.Visible = isYN("t06");
            }
            else if (!e.CommandName.Equals("Select"))
            {
                btnSave.OnClientClick = string.Empty;
                btnSave.Visible = false;
            }
        }
        protected void doLoad(object sender, EventArgs e)
        {
            UnSelected();
            int MaxStepNo, Cnt = gvExisted.Columns.Count;
            for (int i = Cnt - 1; i > 3; i--) gvExisted.Columns.RemoveAt(i);

            DataTable Tb = (new clsRouter()).SavedRter_Select(Request.QueryString["IDs"], txtRFQ.Text, txtPN.Text, out MaxStepNo);

            for (int i = 1; i <= MaxStepNo; i++)
            {
                string y = string.Format("Step# {0}", i);
                BoundField x = new BoundField();
                x.DataField = x.HeaderText = y;
                x.InsertVisible = false;
                gvExisted.Columns.Add(x);
            }

            gvExisted.DataSource = Tb; gvExisted.DataBind();

            if (!string.IsNullOrWhiteSpace(txtRFQ.Text) || !string.IsNullOrWhiteSpace(txtPN.Text)) doLoadTraveler();
            if (Util.isEmpty(gvExisted) && Util.isEmpty(gvExistedTraveler)) iMsg.ShowErr("Sorry, You have no existing router at this time!", true);
        }

        protected void doLoadTraveler()
        {
            int MaxStepNo, Cnt = gvExistedTraveler.Columns.Count;
            for (int i = Cnt - 1; i > 3; i--) gvExistedTraveler.Columns.RemoveAt(i);

            DataTable Tb = (new clsTraveler()).SavedTrvlr_Select("0:1:1:1", txtRFQ.Text, txtPN.Text, out MaxStepNo);

            for (int i = 1; i <= MaxStepNo; i++)
            {
                string y = string.Format("Step# {0}", i);
                BoundField x = new BoundField();
                x.DataField = x.HeaderText = y;
                x.InsertVisible = false;
                gvExistedTraveler.Columns.Add(x);
            }

            gvExistedTraveler.DataSource = Tb; gvExistedTraveler.DataBind();
        }

        protected void UnSelected()
        {
            gvExisted.SelectedIndex = gvExistedTraveler.SelectedIndex = -1;
        }
        protected override void dTask()
        {
            pnlTask.Enabled = true; doLoad(null, null);
        }
        protected override void dEdit() { dTask(); }
        protected override void dView()
        {
            pnlTask.Enabled = false;
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "Generate Router");
            TaskSec.Add("t07", "Assign Router Creator");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = isYN("t05") && (hfHasRouter.Value.Equals("Yes") || !string.IsNullOrWhiteSpace(hfRouterCreator.Value));
            btnRouterCreator.Visible = isYN("t07");
        }
    }
}