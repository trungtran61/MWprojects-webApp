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

namespace webApp._Controls
{
    public partial class MaterialRFQSend : ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new myDelegate(mEvent);
            if (!IsPostBack) gCmd("View");
        }

        protected void rfqSelected(object sender, EventArgs e)
        {
            btnPreview.Enabled = true;
            btnPreview.OnClientClick = string.Format("javascript:lPopup('File/Preview.aspx?AppCode={1}&FID=RFQ&Code=Material&HID={0}&TaskID={2}'); return false;", ddlRFQ.SelectedValue, this.AppCode, IDs[3]);
        }
        protected void rfqBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlRFQ.SelectedIndex = 0;
                rfqSelected(sender, e);
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
        protected void lInstruction(object sender, EventArgs e)
        {
            litInstruction.Text = string.Format("{0}<br><br>", (new myBiz.DAL.clsMaterial()).GetInstruction(IDs[3], AppCode));
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