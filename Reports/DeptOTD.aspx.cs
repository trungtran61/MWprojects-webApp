using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Telerik.Charting;
using myBiz.Tools;
using myBiz.DAL;

namespace webApp.Reports
{
    public partial class DeptOTD : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Report/Dept. OTD");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnGo.Visible = isYN("k01");
        }
        protected void chartBound(object sender, EventArgs e)
        {
            rChart.Series[0].DataYColumn = "OTD";
            rChart.Series[0].Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.Nothing;
            rChart.Series[0].Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid;
            rChart.Series[0].Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml("#0000FF");
            rChart.Series[0].Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;

            if (rChart.Series.Count > 0 && rChart.Series[0].Items.Count > 0)
            {
                int iCnt = rChart.Series[0].Items.Count;
                SortedList Ab = new SortedList();

                if (iCnt > 3)
                {
                    for (int i = 0; i < iCnt; i++) Ab.Add(rChart.Series[0].Items[i].YValue, i);

                    rChart.Series[0].Items[Convert.ToInt32(Ab.GetByIndex(0))].Label.TextBlock.Appearance.TextProperties.Color = System.Drawing.Color.Red;
                    rChart.Series[0].Items[Convert.ToInt32(Ab.GetByIndex(1))].Label.TextBlock.Appearance.TextProperties.Color = System.Drawing.Color.Red;
                    rChart.Series[0].Items[Convert.ToInt32(Ab.GetByIndex(2))].Label.TextBlock.Appearance.TextProperties.Color = System.Drawing.Color.Red;
                }
            }
            btnEmail.Visible = isYN("k02") && rChart.Series[0].Items.Count > 0;
            if (btnEmail.Visible)
            {
                DataRow Rw = (new clsUser()).getUserEmail(Common.clsUser.uID, "OTDGraphEmail");
                txtFrom.Text = Rw["Email"].ToString();
                txtBody.Text = Rw["Body"].ToString();
                litEmail.Text = generateAddress;
            }
        }
        protected void cblBound(object sender, EventArgs e)
        {
            wcLibrary.ChkBoxList cbl = sender as wcLibrary.ChkBoxList;
            HiddenField hf = cbl.ID.Equals("cblDeptList") ? hfDept : cbl.ID.Equals("cblStepList") ? hfStep : hfQueue;
            for (int i = 0; i < cbl.Items.Count; i++)
            {
                string YN = i == 0 ? "true" : "false", iCID = string.Format("{0}_{1}", cbl.ClientID, i);
                ListItem item = cbl.Items[i];
                item.Attributes.Add("onclick", string.Format("javascript:chkAll({0},{1},{2});", iCID, YN, hf.ClientID));
                hf.Value += string.IsNullOrEmpty(hf.Value) ? iCID : string.Format(":{0}", iCID);
            }
        }
        protected void doSend(object sender, EventArgs e)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(clsValidator.Required(txtTo.Text, "To address", true));
            sb.Append(clsValidator.Required(txtFrom.Text, "From address", true));

            if (sb.Length > 0) iMsg.ShowErr("Cannot send email", sb.ToString(), true);
            else
            {
                Hashtable hEmail = new Hashtable(); hEmail.Add("From", txtFrom.Text.Trim()); hEmail.Add("To", txtTo.Text.Trim());
                hEmail.Add("Subject", txtSubject.Text.Trim()); hEmail.Add("Body", txtBody.Text.Trim().Replace("\r", "<br>").Replace("\n", "<br>"));

                System.IO.MemoryStream ms = new System.IO.MemoryStream();
                rChart.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg); ms.Position = 0;

                System.Collections.Generic.List<Hashtable> Att = new System.Collections.Generic.List<Hashtable>();
                Hashtable i = new Hashtable(); i.Add("Att", ms); i.Add("Nm", "DeptOTD.jpg"); Att.Add(i);
                hEmail.Add("Attachments", Att); string rMsg = Util.sendEmail(hEmail);

                if (!string.IsNullOrEmpty(rMsg)) iMsg.ShowErr(rMsg, true);
                else iMsg.ShowMsg("Thank you! Email has been sent.", true);
            }
            btnCancel.OnClientClick = string.Format("javascript:$('#dvEmail').hide(); javascript:$('#{0}').html(''); return false;", iMsg.ClientID);
        }
        private string generateAddress
        {
            get
            {
                DataTable Tb = (new clsUser()).getUserEmailList();
                if (Tb != null && Tb.Rows.Count > 0)
                {
                    System.Text.StringBuilder s = new System.Text.StringBuilder("<table>");
                    string tr = "<tr><td><input type=\"checkbox\" id=\"xAddress_{0}\" name=\"xAddress_{0}\" value=\"{1}\" /> {2}</td></tr>\n";
                    int Cnt = Tb.Rows.Count;
                    for (int i = 0; i < Cnt; i++)
                    {
                        DataRow r = Tb.Rows[i];
                        s.Append(string.Format(tr, i, r["Email"], r["xEmail"]));
                    }
                    s.Append("</table>"); hfCnt.Value = Cnt.ToString();
                    return s.ToString();
                }
                else return "Company does not have contact list.";
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Calculate OTD");
            PageSec.Add("k02", "Send Email");
        }
    }
}