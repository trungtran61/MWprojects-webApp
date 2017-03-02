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
    public partial class CheckInventory : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            chkInv.myEvent += new Common.myDelegate(chkInv_myEvent);
            if (!IsPostBack) gCmd("View");
        }

        protected void chkInv_myEvent(Hashtable h)
        {

        }
        protected void btnRender(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable Tb = (new clsWorkOrder()).Select(Request.QueryString["IDs"]);
                if (Tb != null && Tb.Rows.Count > 0)
                {
                    toggle(Convert.ToBoolean(Tb.Rows[0]["useInv"]));
                    btnCheckInventory.Enabled = !Convert.ToBoolean(Tb.Rows[0]["hasShipped"]);
                }
            }
        }
        private void toggle(bool useInv)
        {
            tblUndoCheck.Visible = useInv;
            tblCheck.Visible = !tblUndoCheck.Visible;
            if (tblUndoCheck.Visible)
            {
                btnCheckInventory.OnClientClick = "return confirm('Are you sure you want to undo check inventory?');";
                btnCheckInventory.Text = "Undo Check Inventory";
            }
            else
            {
                btnCheckInventory.OnClientClick = string.Empty;
                btnCheckInventory.Text = "Check Inventory";
            }
        }
        protected void doCheck(object sender, EventArgs e)
        {
            clsPartInv x = new clsPartInv();
            if (btnCheckInventory.Text.Equals("Check Inventory"))
            {
                chkInv.WOID = Convert.ToInt32(IDs[0]); chkInv.doCheck();
            }
            else
            {
                x.UndoCheck(IDs[0]); toggle(false);
            }
            btnCheckInventory.Visible = false;
        }
        protected override void dTask()
        {
            pnlTask.Enabled = true;
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
            TaskSec.Add("t06", "Check Inventory");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = isYN("t05");
            btnCheckInventory.Visible = isYN("t06");
        }
    }
}