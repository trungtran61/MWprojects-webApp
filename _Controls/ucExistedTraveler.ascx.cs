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
using System.Linq;

namespace webApp._Controls
{
    public partial class ucExistedTraveler : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) gCmd("View");
        }

        protected void doGenerate(object sender, EventArgs e)
        {
            if (gvExisted.SelectedIndex < 0 && gvExistedRouter.SelectedIndex < 0) iMsg.ShowErr("Please select existed job traveler/router.", true);
            else
            {
                var isTraveler = gvExisted.SelectedIndex >= 0;
                var fID = isTraveler ? Convert.ToInt32(gvExisted.SelectedValue) : Convert.ToInt32(gvExistedRouter.SelectedValue);
                var tWOID = Convert.ToInt32(IDs[0]);
                var cls = new clsTraveler();
                var success = isTraveler ? cls.Copy(fID, tWOID) : cls.CopyFromRouter(fID, tWOID);

                if (success) iMsg.ShowMsg("Thank you! Data has been saved.", true);
                else iMsg.ShowErr("Sorry! Work order already has job traveler.", true);
            }
        }

        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            UnSelected();
            if (e.CommandName.Equals("Select") && !btnSave.OnClientClick.StartsWith("return"))
            {
                btnSave.OnClientClick = "return confirm('Are you sure you want to use this job traveler/router?');";
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

            DataTable Tb = (new clsTraveler()).SavedTrvlr_Select(Request.QueryString["IDs"], txtWO.Text, txtPN.Text, out MaxStepNo);

            for (int i = 1; i <= MaxStepNo; i++)
            {
                string y = string.Format("Step# {0}", i);
                BoundField x = new BoundField();
                x.DataField = x.HeaderText = y;
                x.InsertVisible = false;
                gvExisted.Columns.Add(x);
            }

            gvExisted.DataSource = Tb; gvExisted.DataBind();

            if (!string.IsNullOrWhiteSpace(txtWO.Text) || !string.IsNullOrWhiteSpace(txtPN.Text)) doLoadRouter();
            if (Util.isEmpty(gvExisted) && Util.isEmpty(gvExistedRouter)) iMsg.ShowErr("Sorry, You have no existing traveler/router at this time!", true);
        }

        protected void doLoadRouter()
        {
            int MaxStepNo, Cnt = gvExistedRouter.Columns.Count;
            for (int i = Cnt - 1; i > 3; i--) gvExistedRouter.Columns.RemoveAt(i);

            DataTable Tb = (new clsRouter()).SavedRter_Select("0:1:1:1", txtWO.Text, txtPN.Text, out MaxStepNo);

            for (int i = 1; i <= MaxStepNo; i++)
            {
                string y = string.Format("Step# {0}", i);
                BoundField x = new BoundField();
                x.DataField = x.HeaderText = y;
                x.InsertVisible = false;
                gvExistedRouter.Columns.Add(x);
            }

            gvExistedRouter.DataSource = Tb; gvExistedRouter.DataBind();
        }

        protected void UnSelected()
        {
            gvExisted.SelectedIndex = gvExistedRouter.SelectedIndex = -1;
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
            TaskSec.Add("t06", "Generate Job Traveler");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = isYN("t05");
        }
    }
}