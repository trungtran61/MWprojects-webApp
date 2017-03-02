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
    public partial class BillCount : Common.ucAbstract
    {
        protected void Page_Init(object sender, EventArgs e) { hfUID.Value = Common.clsUser.uID; }
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack)
            {
                gCmd("View");
            }
        }
        protected void doSubmit(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < gvBill.Rows.Count; i++)
            {
                GridViewRow Rw = gvBill.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.AppendFormat("{0}:", gvBill.DataKeys[i].Value);
            }
            if (x.Length > 0)
            {
                odsBill.UpdateParameters["WOID"].DefaultValue = IDs[0];
                odsBill.UpdateParameters["IDs"].DefaultValue = x.ToString();
                odsBill.Update(); gvBill.DataBind(); gvBillA.DataBind();
            }
        }
        protected void bUndo(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < gvBillA.Rows.Count; i++)
            {
                GridViewRow Rw = gvBillA.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.Append(string.Format("{0}:", gvBillA.DataKeys[i].Value));
            }
            if (x.Length > 0)
            {
                odsBillA.UpdateParameters["WOID"].DefaultValue = IDs[0];
                odsBillA.UpdateParameters["IDs"].DefaultValue = x.ToString();
                odsBillA.Update(); gvBill.DataBind(); gvBillA.DataBind();
            }
        }
        protected void BillBound(object sender, EventArgs e)
        {
            btnSubmit.Visible = gvBill.Rows.Count > 0;
        }
        protected void BillABound(object sender, EventArgs e)
        {
            btnUndo.Visible = gvBillA.Rows.Count > 0;
        }
        protected void PartialStatusBound(object sender, EventArgs e)
        {
            gvPartialShip.Visible = gvPartialShip.Rows.Count > 0;
        }
        protected override void dTask()
        {
            btnUndo.Enabled = btnSubmit.Enabled = gvBill.Enabled = gvBillA.Enabled = true;
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            btnUndo.Enabled = btnSubmit.Enabled = gvBill.Enabled = gvBillA.Enabled = false;
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("ViewSPL"))
            {
                int GrpID = Convert.ToInt32(ConfigurationManager.AppSettings["PackingList"]);
                clsFile.Show(Page, pnlPopup, "DL", false, "Signed Packing List", string.Empty, GrpID, Convert.ToInt32(e.CommandArgument), string.Empty);
            }
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "Submit");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = isYN("t05");
            btnSubmit.Visible = isYN("t06");
        }
    }
}