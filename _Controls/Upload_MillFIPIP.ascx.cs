using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class Upload_MillFIPIP : Common.ucAbstract
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
            clsFile.Show(Page, pnlPopup, cmd, isYN("t05"), "1st Piece & In-Process Inspection Report For Mill", string.Empty, myMode.GrpID, this.xID("TravelerID"), myMode.gData("mxLN"));
        }
        protected void viewMOT(object sender, EventArgs e)
        {
            clsFile.Show(Page, pnlPopup, "DL", false, "M.O.T. For Mill", string.Empty, Convert.ToInt32(myMode.gData("RefID")), this.xID("TravelerID"), string.Empty);
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Delete File");
            TaskSec.Add("t06", "Edit Prep Setup Status");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            gvPrepSetupStatus.Columns[0].Visible = isYN("t06");
            lnkBlank.OnClientClick = string.Format("javascript:lFrame('File/Download.aspx?TID={0}'); return false;", this.IDs[3]);
        }
    }
}