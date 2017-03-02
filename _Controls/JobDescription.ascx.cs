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
    public partial class JobDescription : System.Web.UI.UserControl
    {
        public string AppCode { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (AppCode.Equals("RFQ"))
            {
                var x = new myBiz.DAL.clsRFQ();
                DataTable Tb = x.Select(Request.QueryString["IDs"]);
                if (Tb != null && Tb.Rows.Count > 0)
                {
                    litDesc.Text = myBiz.Tools.clsUtils.myUtil.NewLine(Tb.Rows[0]["Description"]) + "<br><br>" +
                        myBiz.Tools.clsUtils.myUtil.NewLine(Tb.Rows[0]["RouterDesc"]);
                }
            }
            else //WIP
            {
                var x = new myBiz.DAL.clsWorkOrder();
                DataTable Tb = x.Select(Request.QueryString["IDs"]);
                if (Tb != null && Tb.Rows.Count > 0)
                {
                    litDesc.Text = myBiz.Tools.clsUtils.myUtil.NewLine(Tb.Rows[0]["Description"]) + "<br><br>" +
                        myBiz.Tools.clsUtils.myUtil.NewLine(Tb.Rows[0]["TravelDesc"]);
                }
            }
        }
    }
}