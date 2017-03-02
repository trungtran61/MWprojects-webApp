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
    public partial class ucFIN09 : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) gCmd("loadSec");
        }
        protected override void dTask()
        {
            pnlTask.Enabled = true;
        }
        protected override void dEdit()
        {
            iMsg.ShowErr("What exactly do you want to edit?", true);
        }
        protected override void dView() { }
        protected void doUpload(object sender, EventArgs e)
        {
            string xType = (sender as Button).ID.Equals("btnExcel") ? "Excel" : "SolidWork";
            string[] pi = Request.ServerVariables["PATH_INFO"].Split('/');
            Hashtable h = new Hashtable(); h.Add("Width", 450); h.Add("Height", 100);
            h.Add("Title", "Upload XML File");
            h.Add("URL", string.Format("http://{0}/{2}/WIP/Misc.aspx?mID={1}&xmlType={3}&xmlFor=Article", Request.ServerVariables["HTTP_HOST"], IDs[0], pi[1], xType));
            h.Add("Refresh", Page.ClientScript.GetPostBackClientHyperlink(lnkRefresh, string.Empty));
            Util.newWindow(Page, pnlPopup, h);
        }
        protected void doRefresh(object sender, EventArgs e)
        {
            gvXML.DataBind();
        }
        protected void gvBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                (e.Row.FindControl("lnkDelete") as LinkButton).Visible = isYN("t07");
            }
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "Upload XML");
            TaskSec.Add("t07", "Remove XML");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = isYN("t05");
            btnUpload.Visible = isYN("t06");
        }
    }
}