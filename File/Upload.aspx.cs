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

namespace webApp.File
{
    public partial class Upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["cmd"]))
            {
                if (Request.QueryString["cmd"].Equals("UL")) DL.Visible = false;
                else if (Request.QueryString["cmd"].Equals("DL")) UL.Visible = false;
            }
            UL.myEvent += new Common.myDelegate(UL_myEvent);
        }

        protected void UL_myEvent(Hashtable h) { if (DL.Visible) DL.DataBind(); }
    }
}