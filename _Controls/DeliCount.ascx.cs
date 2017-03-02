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

namespace webApp._Controls
{
    public partial class DeliCount : Common.ucAbstract
    {
        protected void Page_Init(object sender, EventArgs e) { hfUID.Value = Common.clsUser.uID; }
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) gCmd("View");
        }
        protected void pStatusSelected(object sender, EventArgs e)
        {
            odsPartialShip.UpdateParameters["pStatus"].DefaultValue = (sender as DropDownList).SelectedValue;
            odsPartialShip.Update();
        }
        protected void PartialShipRwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                (e.Row.FindControl("ddlPartialStatus") as DropDownList).Enabled = isYN("t08");
            }
        }
        protected void doSubmit(object sender, EventArgs e)
        {
            if (ddlLocation.SelectedValue.Equals("-1")) iMsg.ShowErr("Sorry! Location is required.", true);
            else
            {
                System.Text.StringBuilder x = new System.Text.StringBuilder();
                for (int i = 0; i < gvDeli.Rows.Count; i++)
                {
                    GridViewRow Rw = gvDeli.Rows[i];
                    if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                        x.Append(string.Format("{0}:", gvDeli.DataKeys[i].Value));
                }
                if (x.Length > 0)
                {
                    odsDeli.UpdateParameters["WOID"].DefaultValue = IDs[0];
                    odsDeli.UpdateParameters["IDs"].DefaultValue = x.ToString();
                    odsDeli.Update(); gvDeli.DataBind(); gvDeliA.DataBind();
                }
            }
        }
        protected void bUndo(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < gvDeliA.Rows.Count; i++)
            {
                GridViewRow Rw = gvDeliA.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.Append(string.Format("{0}:", gvDeliA.DataKeys[i].Value));
            }
            if (x.Length > 0)
            {
                odsDeliA.UpdateParameters["WOID"].DefaultValue = IDs[0];
                odsDeliA.UpdateParameters["IDs"].DefaultValue = x.ToString();
                odsDeliA.Update(); gvDeli.DataBind(); gvDeliA.DataBind();
            }
        }
        protected void PartialStatusBound(object sender, EventArgs e)
        {
            gvPartialShip.Visible = gvPartialShip.Rows.Count > 0;
        }
        protected void DeliBound(object sender, EventArgs e)
        {
            ddlLocation.Visible = btnSubmit.Visible = gvDeli.Rows.Count > 0;
        }
        protected void DeliABound(object sender, EventArgs e)
        {
            btnUndo.Visible = gvDeliA.Rows.Count > 0;
        }
        protected override void dTask()
        {
            btnUndo.Enabled = ddlLocation.Enabled = btnSubmit.Enabled = gvPartialShip.Enabled = gvDeli.Enabled = gvDeliA.Enabled = true;
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            btnUndo.Enabled = ddlLocation.Enabled = btnSubmit.Enabled = gvPartialShip.Enabled = gvDeli.Enabled = gvDeliA.Enabled = false;
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "Submit");
            TaskSec.Add("t07", "Undo");
            TaskSec.Add("t08", "Partial Ship Action");
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