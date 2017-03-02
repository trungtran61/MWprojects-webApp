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

namespace webApp.Tools
{
    public partial class OldWO : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Tools/CreateOldWO");
        }
        protected void fvInserted(object sender, FormViewInsertedEventArgs e)
        {
            Exception ex = e.Exception;
            if (ex != null)
            {
                iMsg.ShowErr(ex.InnerException.Message, true);
                e.ExceptionHandled = true;
            }
            else iMsg.ShowMsg("Thank you, your work order has been created!", true);
        }
        protected override void enforceSecurity() { }
    }
}