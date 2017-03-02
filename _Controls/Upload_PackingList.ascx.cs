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
    public partial class Upload_PackingList : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) gCmd("View");
        }
        protected override void dTask()
        {
            foreach (GridViewRow i in gvPackingList.Rows) (i.FindControl("btnUpload") as Button).Text = "Upload";
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            foreach (GridViewRow i in gvPackingList.Rows) (i.FindControl("btnUpload") as Button).Text = "View";
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Upload"))
            {
                string cmd = (e.CommandSource as Button).Text.Equals("View") ? "DL" : "UL";
                clsFile.Show(Page, pnlPopup, cmd, isYN("t05"), "Signed Packing List", string.Empty, myMode.GrpID, Convert.ToInt32(e.CommandArgument), myMode.gData("mxLN"));
            }
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Delete File");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
        }
    }
}