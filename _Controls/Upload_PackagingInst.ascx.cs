using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class Upload_PackagingInst : Common.ucAbstract
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
            clsFile.Show(Page, pnlPopup, cmd, isYN("t05"), "Packaging Instructions", string.Empty, myMode.GrpID, this.xID("PartID"), myMode.gData("mxLN"));
        }
        protected void LoadCustPackSpec(object sender, EventArgs e)
        {
            var data = (new clsTraveler()).GetCustPackSpec(IDs[0]);
            litPackage.Visible = data.Tables[0].Rows.Count < 1;
            if (!litPackage.Visible)
            {
                var rw = data.Tables[0].Rows[0];
                lnkPackage.Text = rw["PackageName"].ToString();
                lnkPackage.CommandArgument = rw["PackageSpecID"].ToString();
            }
        }

        protected void doFile(object sender, EventArgs e)
        {
            var pHID = Convert.ToInt32(lnkPackage.CommandArgument);
            clsFile.Show(Page, pnlPopup, "DL", false, "Packaging Specification", string.Empty, Convert.ToInt32(Util.AppSetting("PackageSpecFile")), pHID, "300");
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
            lnkBlank.OnClientClick = string.Format("javascript:lFrame('File/Download.aspx?TID={0}'); return false;", this.IDs[3]);
        }
    }
}