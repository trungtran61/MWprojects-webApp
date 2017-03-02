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
    public partial class ucLAT12 : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack)
            {
                fvInspector.Visible = !myMode.reqTask;
                gCmd("View");
            }
        }
        protected void fvSave(object sender, EventArgs e)
        {
            if (fvInspector.DataItemCount > 0) fvInspector.UpdateItem(true);
            else fvInspector.InsertItem(true);
            iMsg.ShowMsg("Thank You! Your data has been saved!", true);
        }
        protected override void dTask()
        {
            if (fvInspector.DataItemCount > 0) fvInspector.ChangeMode(FormViewMode.Edit);
            else fvInspector.ChangeMode(FormViewMode.Insert);
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            fvInspector.ChangeMode(FormViewMode.ReadOnly);
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