using System;
using System.Web.UI.WebControls;
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class ucLAT04 : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) gCmd("View");
        }
        protected void ddlDataBinding(object sender, EventArgs e)
        {
            odsLocByType.SelectParameters["itemId"].DefaultValue = gvPrepSetupStatus.DataKeys[gvPrepSetupStatus.EditIndex].Value.ToString();
        }

        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1)
            {
                if (e.Row.RowState.ToString().Contains("Edit"))
                {
                    var req = e.Row.FindControl("chkRequested") as CheckBox;
                    var del = e.Row.FindControl("chkDelivered") as CheckBox;
                    var rec = e.Row.FindControl("chkReceived") as CheckBox;
                    var ver = e.Row.FindControl("chkVerified") as CheckBox;

                    if (Convert.ToBoolean((e.Row.FindControl("hfPending") as HiddenField).Value))
                    {
                        req.Enabled = del.Enabled = rec.Enabled = ver.Enabled = false;
                    }
                    else
                    {
                        req.Enabled = isYN("t08") && !del.Checked && !rec.Checked && !ver.Checked;
                        rec.Enabled = isYN("t09") && req.Checked && del.Checked && !ver.Checked;
                        ver.Enabled = isYN("t10") && req.Checked && del.Checked && rec.Checked;
                    }
                }
                else
                {
                    e.Row.FindControl("lnkEdit").Visible = isYN("t08") || isYN("t09") || isYN("t10");
                }
            }
        }
        protected void fvSave(object sender, EventArgs e)
        {
            if (fvTools.DataItemCount > 0) fvTools.UpdateItem(true);
            else fvTools.InsertItem(true);
        }
        protected void fvBound(object sender, EventArgs e)
        {
            myMode.Completable = isYN("t05") && fvTools.DataItemCount > 0 && fvTools.CurrentMode == FormViewMode.ReadOnly && (fvTools.FindControl("btnReset") as Button).Visible;
        }
        protected bool xReset()
        {
            return !myMode.pTask && isYN("t07") && !string.IsNullOrEmpty(Eval("FullName").ToString());
        }
        protected override void dTask()
        {
            if (fvTools.DataItemCount > 0) fvTools.ChangeMode(FormViewMode.Edit);
            else fvTools.ChangeMode(FormViewMode.Insert);

            gvPrepSetupStatus.Columns[0].Visible = fvTools.CurrentMode != FormViewMode.ReadOnly && isYN("t02");
            
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            fvTools.ChangeMode(FormViewMode.ReadOnly);
            gvPrepSetupStatus.Columns[0].Visible = fvTools.CurrentMode != FormViewMode.ReadOnly && isYN("t01");
        }
        protected void doView(object sender, EventArgs e)
        {
            clsFile.Show(Page, pnlPopup, "DL", "Setup Sheet", string.Empty, Convert.ToInt32(myMode.gData("RefID")), this.xID("TravelerID"), string.Empty);
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "View Setup Sheet");
            TaskSec.Add("t07", "Reset");
            TaskSec.Add("t08", "Requested");
            TaskSec.Add("t09", "Received");
            TaskSec.Add("t10", "Verified");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = isYN("t05");
            lnkView.Visible = isYN("t06");
            btnScan.Visible = isYN("t08") || isYN("t09") || isYN("t10");
            lnkBlank.OnClientClick = string.Format("javascript:lFrame('File/Download.aspx?TID={0}'); return false;", this.IDs[3]);
        }

        protected void rwUpdating(object sender, GridViewUpdateEventArgs e)
        {
            var req = Convert.ToBoolean(e.NewValues["Requested"]);
            var del = Convert.ToBoolean(e.NewValues["Delivered"]);
            var rec = Convert.ToBoolean(e.NewValues["Received"]);
            var ver = Convert.ToBoolean(e.NewValues["Verified"]);

            var reqEdit = !req && del;
            var delEdit = !del && rec;
            var recEdit = !rec && ver;

            if (reqEdit || delEdit || recEdit)
            {
                iMsg.ShowErr("Invalid data!", true);
                e.Cancel = true;
            }
        }
    }
}