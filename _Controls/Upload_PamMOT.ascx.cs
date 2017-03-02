using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class Upload_PamMOT : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) gCmd("loadSec");
        }
        protected override void dTask()
        {
            btn_Click("UL");
        }
        protected override void dEdit()
        {
            btn_Click("DL");
        }
        protected override void dView()
        {
            btn_Click("DL");
        }
        protected void btn_Click(string cmd)
        {
            clsFile.Show(Page, pnlPopup, cmd, isYN("t05"), "M.O.T. For Part Marking", string.Empty, myMode.GrpID, this.xID("TravelerID"), myMode.gData("mxLN"));
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