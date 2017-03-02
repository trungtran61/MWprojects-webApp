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
    public partial class ucFIN03 : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack)
            {
                gCmd("loadSec");
                myMode.PrintItems[0].Value = "dvForm";
                myMode.ViewTarget = "dvForm";
                frmInspection.FormPath = ConfigurationManager.AppSettings["FormPath"];
                frmInspection.FormID = myMode.FormID;
                generateForm();
            }
        }
        private void generateForm()
        {
            frmInspection.Update((new cls1stArticle()).FirstArticle_getData(IDs[0]));
        }
        protected override void dTask()
        {
            generateForm();
            iMsg.ShowMsg("Thank you! final inspection report has been created.", true);
        }
        protected override void dEdit()
        {
            iMsg.ShowErr("What exactly do you want to edit?", true);
        }
        protected override void dView() { }
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