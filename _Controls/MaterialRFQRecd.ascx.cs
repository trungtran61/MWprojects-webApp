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

namespace webApp._Controls
{
    public partial class MaterialRFQRecd : ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new myDelegate(mEvent);
            if (!IsPostBack) gCmd("View");
        }
        protected string gLnk()
        {
            return string.Format("<a onclick=\"javascript:xPopup('File/VdrBlk.aspx?vID={0}&mID={1}&aE=0&MOGT=Matl'); return false;\" class=\"mLink\">No Bid</a>", Eval("VendorID"), Eval("BDID"));
        }

        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("viewFile"))
            {
                btn_Click("DL", Convert.ToInt32(e.CommandArgument));
            }
            else if (e.CommandName.Equals("uploadFile"))
            {
                btn_Click("UL", Convert.ToInt32(e.CommandArgument));
            }
        }

        protected void lInstruction(object sender, EventArgs e)
        {
            litInstruction.Text = string.Format("{0}<br><br>", (new clsMaterial()).GetInstruction(IDs[3], AppCode));
        }

        protected void btn_Click(string cmd, int HID)
        {
            var GrpID = Convert.ToInt32(Util.AppSetting(string.Format("MaterialRFQFile{0}", AppCode)));
            clsFile.Show(Page, pnlPopup, cmd, isYN("t06"), "Attachments", string.Empty, GrpID, HID, "500");
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
            TaskSec.Add("t06", "Delete File");
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