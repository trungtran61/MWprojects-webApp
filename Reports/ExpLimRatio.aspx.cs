using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Charting;
using myBiz.DAL;
using myBiz.Tools;

namespace webApp.Reports
{
    public partial class ExpLimRatio : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Report/Expense Limit Ratio");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnGo.Visible = isYN("k01");
        }
        protected void doCalculate(object sender, EventArgs e)
        {
            (new clsBudget()).BudgetForcast_RefreshRange(Convert.ToDateTime(txtDf.Text), Convert.ToDateTime(txtDt.Text));
            DrawExpLimRatioGraph();
            DrawBudgetDifferentGraph();
            btnEmail.Visible = isYN("k02") && rChart.Series.Count > 0;
            if (btnEmail.Visible)
            {
                DataRow Rw = (new clsUser()).getUserEmail(Common.clsUser.uID, "ExpLimRtoEmail");
                txtFrom.Text = Rw["Email"].ToString();
                txtBody.Text = Rw["Body"].ToString();
                litEmail.Text = generateAddress;
            }
        }
        protected void DrawBudgetDifferentGraph()
        {
            DataTable Tb = (new clsReport()).BudgetDifferent_S(Convert.ToDateTime(txtDf.Text), Convert.ToDateTime(txtDt.Text), cblExpAcct.SelectedValues.Replace("-1:", string.Empty));
            chtBD.Series.Clear();
            foreach (DataColumn Cl in Tb.Columns)
            {
                if (Cl.ColumnName.Equals("dName") || Cl.ColumnName.Equals("xCnt") || Cl.ColumnName.StartsWith("acu")) continue;
                ChartSeries x = new ChartSeries(); x.Type = ChartSeriesType.Bar;
                x.DataXColumn = "xCnt"; x.Name = x.DataYColumn = Cl.ColumnName;
                x.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
                x.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;

                ChartSeries y = new ChartSeries(); y.Type = ChartSeriesType.Line;
                y.DataXColumn = "xCnt"; y.Name = y.DataYColumn = "acu" + Cl.ColumnName;
                y.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.Nothing;
                y.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;

                string clr = string.Empty;

                switch (Cl.ColumnName.ToUpper())
                {
                    case "MATERIAL": clr = "#008000"; break;
                    case "OPS": clr = "#0000FF"; break;
                    case "SS": clr = "#DC143C"; break;
                    case "OS": clr = "#9400D3"; break;
                    case "MTN": clr = "#FFFF00"; break;
                    case "TLN": clr = "#FFA500"; break;
                    case "TLG": clr = "#2E8B57"; break;
                    case "MACP": clr = "#FF0000"; break;
                    case "UTL": clr = "#00BFFF"; break;
                    case "LAB": clr = "#FF1493"; break;
                    case "COMM": clr = "#FF6347"; break;
                    case "GAGN": clr = "#4B0082"; break;
                    case "GAGC": clr = "#800080"; break;
                    case "GAGR": clr = "#006400"; break;
                    case "CONT": clr = "#FF00FF"; break;
                    case "GME": clr = "#DAA520"; break;
                    case "INS": clr = "#FA8072"; break;
                    case "RENT": clr = "#B22222"; break;
                    case "DEBUT": clr = "#000080"; break;
                    case "FRE": clr = "#7CFC00"; break;
                    case "TOTAL": clr = "#4169E1"; break;
                    //case "UI": clr = "#4169E1"; break;
                    //case "AP": clr = "#00FF7F"; break;
                }

                if (!string.IsNullOrEmpty(clr)) x.Appearance.FillStyle.MainColor = y.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml(clr);
                chtBD.Series.Add(x); chtBD.Series.Add(y);
            }

            chtBD.DataSource = Tb; chtBD.DataBind();
        }

        protected void DrawExpLimRatioGraph()
        {
            DataTable Tb = (new clsReport()).ExpLimRatio_S(Convert.ToDateTime(txtDf.Text), Convert.ToDateTime(txtDt.Text), cblExpAcct.SelectedValues.Replace("-1:", string.Empty));
            rChart.Series.Clear();
            foreach (DataColumn Cl in Tb.Columns)
            {
                if (Cl.ColumnName.Equals("dName") || Cl.ColumnName.Equals("xCnt")) continue;
                ChartSeries x = new ChartSeries(); x.Type = ChartSeriesType.Line;
                x.DataXColumn = "xCnt"; x.Name = x.DataYColumn = Cl.ColumnName;
                x.Appearance.LegendDisplayMode = x.Name.Equals("Line") ? ChartSeriesLegendDisplayMode.Nothing : ChartSeriesLegendDisplayMode.SeriesName;

                if (x.Name.Equals("Line")) x.Appearance.TextAppearance.Visible = false;
                else x.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;

                string clr = string.Empty;

                switch (Cl.ColumnName.ToUpper())
                {
                    case "MATERIAL": clr = "#008000"; break;
                    case "OPS": clr = "#0000FF"; break;
                    case "SS": clr = "#DC143C"; break;
                    case "OS": clr = "#9400D3"; break;
                    case "MTN": clr = "#FFFF00"; break;
                    case "TLN": clr = "#FFA500"; break;
                    case "TLG": clr = "#2E8B57"; break;
                    case "MACP": clr = "#FFDD00"; break;
                    case "UTL": clr = "#00BFFF"; break;
                    case "LAB": clr = "#FF1493"; break;
                    case "COMM": clr = "#FF6347"; break;
                    case "GAGN": clr = "#4B0082"; break;
                    case "GAGC": clr = "#800080"; break;
                    case "GAGR": clr = "#006400"; break;
                    case "CONT": clr = "#FF00FF"; break;
                    case "GME": clr = "#DAA520"; break;
                    case "INS": clr = "#FA8072"; break;
                    case "RENT": clr = "#B22222"; break;
                    case "DEBUT": clr = "#000080"; break;
                    case "FRE": clr = "#7CFC00"; break;
                    case "LINE": clr = "#FF0000"; break;
                    case "TOTAL": clr = "#4169E1"; break;
                    //case "UI": clr = "#4169E1"; break;
                    //case "AP": clr = "#00FF7F"; break;
                }

                if (!string.IsNullOrEmpty(clr)) x.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml(clr);
                rChart.Series.Add(x);
            }

            rChart.DataSource = Tb; rChart.DataBind();
        }

        protected void cblBound(object sender, EventArgs e)
        {
            wcLibrary.ChkBoxList cbl = sender as wcLibrary.ChkBoxList;
            HiddenField hf = hfExpAcct;
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

                System.IO.MemoryStream da = new System.IO.MemoryStream();
                chtBD.Save(da, System.Drawing.Imaging.ImageFormat.Jpeg); da.Position = 0;

                System.Collections.Generic.List<Hashtable> Att = new System.Collections.Generic.List<Hashtable>();
                Hashtable i = new Hashtable(); i.Add("Att", ms); i.Add("Nm", "ExpLimRto.jpg"); Att.Add(i);
                Hashtable j = new Hashtable(); j.Add("Att", da); j.Add("Nm", "DiffAcc.jpg"); Att.Add(j);
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
            PageSec.Add("k01", "Calculate Expense Limit Ratio");
            PageSec.Add("k02", "Send Email");
        }
    }
}