using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webApp.Common;

namespace webApp._Controls
{
    public partial class ToolRFQ : ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new myDelegate(mEvent);
            if (!IsPostBack) { gCmd("View"); }
        }
        protected void rfqSelected(object sender, EventArgs e)
        {
            btnPreview.Enabled = true;
            btnPreview.OnClientClick = string.Format("javascript:lPopup('File/Preview.aspx?AppCode={1}&FID=RFQ&GT=GT&Code=Tools&HID={0}'); return false;", ddlRFQ.SelectedValue, this.AppCode);
        }
        protected void rfqBound(object sender, EventArgs e)
        {
            if (ddlRFQ.Items.Count > 0) ddlRFQ.SelectedIndex = 0;
            rfqSelected(sender, e);
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var chk = e.Row.FindControl("chkItem") as CheckBox;
                chk.Attributes.Add("onclick", "javascript:chkAll(this,false);");
                hfChkBox.Value += string.IsNullOrEmpty(hfChkBox.Value) ? chk.ClientID : string.Format(":{0}", chk.ClientID);
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var itemIDs = from Rw in gvItems.Rows.Cast<GridViewRow>()
                          where (Rw.FindControl("chkItem") as CheckBox).Checked
                          select gvItems.DataKeys[Rw.DataItemIndex].Value;

            if (itemIDs.Count() > 0)
            {
                odsItems.InsertParameters["ItemID"].DefaultValue = string.Join(":", itemIDs.ToArray());
                odsItems.Insert(); ddlRFQ.DataBind();
                iMsg.ShowMsg("Thank You! Your RFQ for tool has been created.", true);
            }
            else iMsg.ShowMsg("Please select item(s) before you can create RFQ here.", true);
        }
        protected void deleteRFQ(object sender, EventArgs e)
        {
            if ((new myBiz.DAL.clsTools()).RFQ_Delete(ddlRFQ.SelectedValue, this.AppCode))
            {
                ddlRFQ.DataBind();
                iMsg.ShowMsg("Thank You! Your RFQ has been deleted!", true);
            }
            else
            {
                iMsg.ShowErr("Sorry! Please delete all related PO before deleting this RFQ.", true);
            }
        }
        protected override void dTask()
        {
            pnlTask.Enabled = true;
        }
        protected override void dEdit()
        {
            dTask();
        }
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