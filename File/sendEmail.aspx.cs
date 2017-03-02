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
    public partial class sendEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ucEmail.GT = Request.QueryString["GT"];
            ucEmail.FormID = Request.QueryString["FID"];
            ucEmail.HID = Request.QueryString["HID"];
            ucEmail.DF = Request.QueryString["DF"];
            ucEmail.Code = Request.QueryString["Code"];
            ucEmail.loadData();
        }
    }
}