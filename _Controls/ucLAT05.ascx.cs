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
    public partial class ucLAT05 : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) gCmd("loadSec");
        }
        protected override void dTask()
        {
        }
        protected override void dEdit()
        {
        }
        protected override void dView()
        {
        }
        protected void doView(object sender, EventArgs e)
        {
            string GrpIDs, LnkIDs, txt = (sender as LinkButton).Text;
            string Grp = txt.Equals("View Program") ? "ProGrp" : "MOTGrp";
            int GrpID, LnkID, TrvlID = this.xID("TravelerID");

            if (Grp.Equals("ProGrp"))
            {
                GrpID = LnkID = 0;
                GrpIDs = myMode.gData(Grp);
                LnkIDs = string.Format("{0}:{0}:", TrvlID, TrvlID);
            }
            else
            {
                GrpID = Convert.ToInt32(myMode.gData(Grp)); LnkID = TrvlID;
                GrpIDs = LnkIDs = string.Empty;
            }

            clsFile.Show(Page, pnlPopup, "DL", txt, string.Empty, GrpID, LnkID, GrpIDs, LnkIDs, myMode.gData("mxLN"));
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "View M.O.T.");
            TaskSec.Add("t07", "View Program");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = isYN("t05");
            lnkMOT.Visible = isYN("t06");
            lnkPro.Visible = isYN("t07");
        }
    }
}