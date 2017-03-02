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

namespace webApp._Controls
{
    public partial class notAvailable : Common.ucAbstract
    {
        public event Common.myDelegate myEvent;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { gCmd("View"); }
        }
        protected override void dTask()
        {
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
        }
        protected override void enforceSecurity()
        {
            //TaskSec.Add("t01", myMode.ActionName);
            //TaskSec.Add("t02", "Edit");
            //TaskSec.Add("t03", "View");
            //TaskSec.Add("t04", "Print");
            //TaskSec.Add("t05", "Mark Complete");
            //TaskSec.Add("t06", "Reset");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = false;
            myMode.Editable = false;
            myMode.Viewable = false;
            myMode.Printable = false;
        }
    }
}