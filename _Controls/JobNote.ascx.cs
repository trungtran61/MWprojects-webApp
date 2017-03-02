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
    public partial class JobNote : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable Tb = myBiz.DAL.clsDB.spAdmin_Variables_S("JobNote");
            if (Tb != null && Tb.Rows.Count > 0) litNote.Text = Common.clsUser.Util.NewLine(Tb.Rows[0]["sValue"]);
        }
    }
}