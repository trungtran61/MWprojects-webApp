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
using System.Text;
using myBiz.Tools;
using myBiz.DAL;

namespace webApp.Reports
{
    public partial class OTDTrend : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Report/Dept. OTD Trend");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnGo.Visible = isYN("k01");
        }

        protected void doCalculate(object sender, EventArgs e)
        {
            DataTable Tb = (new clsReport()).Dept_OTD_S("spReport_OTDTrend_S", Convert.ToDateTime(txtDf.Text),
                Convert.ToDateTime(txtDt.Text), cblDeptList.SelectedValues, cblStepList.SelectedValues, cblQueue.SelectedValues);
            rChart.Series.Clear();
            foreach (DataColumn Cl in Tb.Columns)
            {
                if (Cl.ColumnName.Equals("dName") || Cl.ColumnName.Equals("xCnt")) continue;
                ChartSeries x = new ChartSeries(); x.Type = ChartSeriesType.Line;
                x.DataXColumn = "xCnt"; x.Name = x.DataYColumn = Cl.ColumnName;
                x.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
                x.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;

                string clr = string.Empty;

                switch (Cl.ColumnName.ToUpper())
                {
                    case "SALES": clr = "#008000"; break;
                    case "ENG": clr = "#0000FF"; break;
                    case "QTY": clr = "#DC143C"; break;
                    case "INVENT": clr = "#9400D3"; break;
                    case "SHIP": clr = "#FFFF00"; break;
                    case "DELIVER": clr = "#FFA500"; break;
                    case "BILL": clr = "#2E8B57"; break;
                    case "C_OTD": clr = "#FF0000"; break;
                    case "RC_OTD": clr = "#FF0CC0"; break;
                    case "LATHE": clr = "#00BFFF"; break;
                    case "MILL": clr = "#FF1493"; break;
                    case "RIM": clr = "#FF6347"; break;
                    case "SAW": clr = "#4B0082"; break;
                    case "OPS": clr = "#800080"; break;
                    case "HF": clr = "#006400"; break;
                    case "FIN": clr = "#FF00FF"; break;
                    case "ASE": clr = "#DAA520"; break;
                    case "RO": clr = "#FA8072"; break;
                    case "VO": clr = "#B22222"; break;
                    case "EB": clr = "#000080"; break;
                    case "PB": clr = "#7CFC00"; break;
                    case "UI": clr = "#4169E1"; break;
                    case "AP": clr = "#00FF7F"; break;
                }

                if (!string.IsNullOrEmpty(clr)) x.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml(clr);
                rChart.Series.Add(x);
            }

            rChart.DataSource = Tb; rChart.DataBind();
            btnEmail.Visible = isYN("k02") && rChart.Series.Count > 0;
            if (btnEmail.Visible)
            {
                DataRow Rw = (new clsUser()).getUserEmail(Common.clsUser.uID, "OTDGraphTrendEmail");
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
                Hashtable i = new Hashtable(); i.Add("Att", ms); i.Add("Nm", "DeptOTDTrend.jpg"); Att.Add(i);
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
            PageSec.Add("k01", "Calculate OTD Trend");
            PageSec.Add("k02", "Send Email");
        }
    }
}