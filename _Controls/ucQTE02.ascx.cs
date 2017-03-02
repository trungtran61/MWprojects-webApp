using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class ucQTE02 : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) gCmd("View");
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
        protected void ddlChanged(object sender, EventArgs e)
        {
            btnPreview.OnClientClick = string.Format("javascript:lPopup1('File/Preview.aspx?AppCode={1}&FID=QTE&Code=FinQte&HID={0}&uID={2}'); return false;", ddlQTE.SelectedValue, this.AppCode, Common.clsUser.uID);
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
            myMode.Completable = false;// isYN("t05");
            //litSent.Visible = myMode.Status.Equals("Completed");
            //lnkSend.OnClientClick = string.Format("javascript:lPopup('RFQ/FollowUp_Log.aspx?AppCode=RFQ&HID={0}&TID={1}&uID={2}'); return false;", this.IDs[0], litSent.Visible ? "-1" : this.IDs[3], Common.clsUser.uID);
        }
    }
}
