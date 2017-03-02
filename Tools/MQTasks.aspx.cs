using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class MQTasks : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Material OPS Task List"))
            {
            }
        }

        protected void clickSearch(object sender, EventArgs e)
        {
            odsTask.SelectParameters["isSearch"].DefaultValue = "True";
        }
        protected void gvBound(object sender, EventArgs e)
        {
            gvTask.EmptyDataText = string.Format("No Record Found! {0}", DateTime.Now);
        }
        protected string gLink()
        {
            string IDs = string.Format("{0}:{1}:{2}:{3}", Eval("xHID"), Eval("mID"), Eval("isD"), Eval("HID"));
            string url = string.Format("../myTask.aspx?AppCode={1}&IDs={0}", IDs, ddlAppCode.SelectedValue);
            string glight = Convert.ToInt32(Eval("RFQCnt")) > 0 ? "<img src=\"../App_Themes/GreenLight.jpg\">" : string.Empty;
            return string.Format("<a href=\"javascript:void(0)\" onclick=\"{0}\">{1}</a>{2}", Util.popupURL(url, IDs.Replace(":", "_")), Eval("TaskName"), glight);
        }
        protected string gDD(string f)
        {
            try
            {
                var status = Eval("Status").ToString();
                var DD = Convert.ToDateTime(Eval(f));
                var result = string.Empty;

                if (status.Equals("Completed"))
                {
                    result = string.Format("<span style=\"color:Green;\">{0}</span>", DD);
                }
                else
                {
                    result = string.Format("<span{0}>{1}</span>", DD.CompareTo(DateTime.Now) < 0 ? " style=\"color:#FE2E2E;\"" : string.Empty, DD);
                }

                return result;
            }
            catch
            {
                return "No Date";
            }
        }
        protected override void enforceSecurity()
        {
        }
    }
}