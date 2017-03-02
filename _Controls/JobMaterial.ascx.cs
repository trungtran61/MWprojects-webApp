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
    public partial class JobMaterial : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void prtInit(object sender, EventArgs e)
        {
            litTags.Text = string.Empty;
            DataTable Tb = (new myBiz.DAL.clsMaterial()).Tag_Select(Request.QueryString["IDs"], "N", Common.clsUser.AppCode);
            btnPrint.Visible = Tb != null && Tb.Rows.Count > 0;
            if (btnPrint.Visible)
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                for (int i = 0; i < Tb.Rows.Count; i++) sb.Append(gTag(Tb.Rows[i]));
                litTags.Text = sb.ToString();
            }
        }

        private string gTag(DataRow Rw)
        {
            string txt = string.Format("Print tag for step {0}", Rw["StepNo"]);
            string val = string.Format("dvTag{0}", Rw["StepNo"]);
            string oDiv = string.Format("<div id=\"{0}\" style=\"display:none\">\n", val);

            btnPrint.Items.Add(new ListItem(txt, val));

            System.Text.StringBuilder x = new System.Text.StringBuilder("<table>");
            x.Append(string.Format("<tr><td style=\"white-space:nowrap\" align=\"left\" colspan=\"2\"><b>WO#:</b> {0}</td></tr>\n", Rw["WorkOrder"]));
            x.Append(string.Format("<tr>\n<td style=\"white-space:nowrap\" align=\"left\"><b>PN:</b> {0}</td>\n", Rw["PartNumber"]));
            x.Append(string.Format("<td style=\"white-space:nowrap\" align=\"left\"><b>REV#:</b> {0}</td>\n</tr>\n", Rw["Revision"]));
            x.Append(string.Format("<tr>\n<td style=\"white-space:nowrap\" align=\"left\"><b>PO#:</b> {0}</td>\n", Rw["PONum"]));
            x.Append(string.Format("<td style=\"white-space:nowrap\" align=\"left\"><b>CERT#:</b> {0}</td>\n</tr>\n", Rw["CertNo"]));
            x.Append(string.Format("<tr>\n<td style=\"white-space:nowrap\" align=\"left\"><b>TYPE:</b> {0}</td>\n", Rw["Type"]));
            x.Append(string.Format("<td style=\"white-space:nowrap\" align=\"left\"><b>AMS#:</b> {0}</td>\n</tr>\n", Rw["Ams"]));
            x.Append(string.Format("<tr>\n<td style=\"white-space:nowrap\" align=\"left\"><b>HEAT LOT #:</b> {0}</td>\n", Rw["HeatLot"]));
            x.Append(string.Format("<td style=\"white-space:nowrap\" align=\"left\"><b>SIZE:</b> {0} {1}</td>\n</tr>\n", Rw["Size"], Rw["Unit"]));
            x.Append(string.Format("<tr><td style=\"white-space:nowrap\" align=\"left\" colspan=\"2\"><b>TOTAL:</b> {0}</td></tr>\n", Rw["GoodCnt"]));
            x.Append(string.Format("<tr><td style=\"white-space:nowrap\" align=\"left\" colspan=\"2\"><b>VENDOR:</b> {0}</td></tr>\n", Rw["CompanyName"]));
            x.Append(string.Format("<tr><td style=\"white-space:nowrap\" align=\"left\" colspan=\"2\"><b>BY:</b> {0}</td></tr>\n", Rw["FullName"]));
            x.Append("</table>\n");

            return string.Format("{0}<table>\n<tr>\n<td>\n{1}</td>\n<td width=\"200px\">&nbsp;</td>\n<td>\n{1}</td>\n</tr>\n</table>\n</div>", oDiv, x);
        }
    }
}