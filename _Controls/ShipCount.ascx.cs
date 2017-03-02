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
    public partial class ShipCount : Common.ucAbstract
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
            if (ddlLocation.SelectedValue.Equals("-1")) iMsg.ShowErr("Sorry! Location is Required.", true);
            else
            {
                System.Text.StringBuilder x = new System.Text.StringBuilder();
                for (int i = 0; i < gvShip.Rows.Count; i++)
                {
                    GridViewRow Rw = gvShip.Rows[i];
                    if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                        x.Append(string.Format("{0}:", gvShip.DataKeys[i].Value));
                }
                if (x.Length > 0)
                {
                    odsShip.UpdateParameters["WOID"].DefaultValue = IDs[0];
                    odsShip.UpdateParameters["IDs"].DefaultValue = x.ToString();
                    odsShip.Update(); gvShip.DataBind(); gvShipA.DataBind();
                }
            }
        }
        protected void bUndo(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < gvShipA.Rows.Count; i++)
            {
                GridViewRow Rw = gvShipA.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.Append(string.Format("{0}:", gvShipA.DataKeys[i].Value));
            }
            if (x.Length > 0)
            {
                odsShipA.UpdateParameters["WOID"].DefaultValue = IDs[0];
                odsShipA.UpdateParameters["IDs"].DefaultValue = x.ToString();
                odsShipA.Update(); gvShip.DataBind(); gvShipA.DataBind();
            }
        }
        protected void ShipBound(object sender, EventArgs e)
        {
            litLoc.Visible = ddlLocation.Visible = btnSubmit.Visible = gvShip.Rows.Count > 0;
        }
        protected void ShipABound(object sender, EventArgs e)
        {
            btnUndo.Visible = gvShipA.Rows.Count > 0;
        }
        protected void gLnk(object sender, EventArgs e)
        {
            string[] v = Request.QueryString["IDs"].Split(':');
            litLnk.Text = gvShip.Rows.Count > 0 || gvShipA.Rows.Count > 0 ? string.Empty : string.Format("<a onclick=\"javascript:loadPreview(-{0});\" class=\"mLink\">Blank Packing List</a>", v[0]);
        }
        protected override void dTask()
        {
            btnUndo.Enabled = ddlLocation.Enabled = btnSubmit.Enabled = gvShip.Enabled = gvShipA.Enabled = true;
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            btnUndo.Enabled = ddlLocation.Enabled = btnSubmit.Enabled = gvShip.Enabled = gvShipA.Enabled = false;
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "Submit");
            TaskSec.Add("t07", "Undo Shipping");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = isYN("t05");
            btnSubmit.Visible = isYN("t06");
            btnUndo.Visible = isYN("t07");
        }
    }
}