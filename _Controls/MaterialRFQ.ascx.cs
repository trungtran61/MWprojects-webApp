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
using webApp.Common;
using myBiz.DAL;
using System.Linq;

namespace webApp._Controls
{
    public partial class MaterialRFQ : ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new myDelegate(mEvent);
            if (!IsPostBack) { gCmd("View"); }
        }
        protected void rfqSelected(object sender, EventArgs e)
        {
            btnPreview.Enabled = true;
            btnPreview.OnClientClick = string.Format("javascript:lPopup('File/Preview.aspx?AppCode={1}&FID=RFQ&Code=Material&HID={0}&TaskID={2}'); return false;", ddlRFQ.SelectedValue, this.AppCode, IDs[3]);
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
                odsItems.InsertParameters["TaskID"].DefaultValue = IDs[3];
                odsItems.InsertParameters["ItemID"].DefaultValue = string.Join(":", itemIDs.ToArray());
                odsItems.Insert(); ddlRFQ.DataBind();
                iMsg.ShowMsg("Thank You! Your RFQ for material has been created.", true);
            }
            else iMsg.ShowMsg("Please select item(s) before you can create RFQ here.", true);
        }
        protected void deleteRFQ(object sender, EventArgs e)
        {
            if ((new clsMaterial()).RFQ_Delete(ddlRFQ.SelectedValue, this.AppCode))
            {
                ddlRFQ.DataBind();
                iMsg.ShowMsg("Thank You! Your RFQ has been deleted!", true);
            }
            else
            {
                iMsg.ShowErr("Sorry! Please delete all related PO before deleting this RFQ.", true);
            }
        }
        protected void lInstruction(object sender, EventArgs e)
        {
            litInstruction.Text = string.Format("{0}<br><br>", (new clsMaterial()).GetInstruction(IDs[3], AppCode));
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
            TaskSec.Add("t06", "Submit Button");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = ddlRFQ.Items.Count > 0 && isYN("t05");
            btnSubmit.Visible = isYN("t06");
        }
    }
}