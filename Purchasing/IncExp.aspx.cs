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

namespace webApp.Purchasing
{
    public partial class IncExp : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Report/Income Expense");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnGo.Visible = isYN("k01");
        }
        protected void chartInit(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChartSeries x = new ChartSeries(); x.Type = ChartSeriesType.Line;
                x.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
                x.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
                x.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml("#0000FF");
                x.DefaultLabelValue = "#Y{#.##}"; x.Name = "Net %"; x.DataYColumn = "NetPt"; rChartPt.Series.Add(x);

                ChartSeries y = new ChartSeries(); y.Type = ChartSeriesType.Line;
                y.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
                y.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
                y.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml("#FF0000");
                y.DefaultLabelValue = "#Y{#.##}"; y.Name = "Exp %"; y.DataYColumn = "ExpPt"; rChartPt.Series.Add(y);


                ChartSeries xAvg = new ChartSeries(); xAvg.Type = ChartSeriesType.Line;
                xAvg.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
                xAvg.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
                xAvg.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml("#CC00FF");
                xAvg.DefaultLabelValue = "#Y{#.##}"; xAvg.Name = "Net Avg"; xAvg.DataYColumn = "aNet"; rChartPt.Series.Add(xAvg);

                ChartSeries yAvg = new ChartSeries(); yAvg.Type = ChartSeriesType.Line;
                yAvg.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
                yAvg.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
                yAvg.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml("#FF00CC");
                yAvg.DefaultLabelValue = "#Y{#.##}"; yAvg.Name = "Exp Avg"; yAvg.DataYColumn = "aExp"; rChartPt.Series.Add(yAvg);
            }
        }

        private void prChart(DataTable Tb)
        {
            rChart.Series.Clear();
            rChart.Appearance.BarOverlapPercent = 100;
            rChart.Appearance.BarWidthPercent = 100;
            double valpInc = 0, valInc = 0, valExp = 0, valNet = 0;

            foreach (DataRow Rw in Tb.Rows)
            {
                valpInc += Convert.ToDouble(Rw["pInc"]);
                valInc += Convert.ToDouble(Rw["xInc"]);
                valExp += Convert.ToDouble(Rw["xExp"]);
                valNet += Convert.ToDouble(Rw["xNet"]);
            }

            ChartSeries xInc = new ChartSeries(); xInc.Type = ChartSeriesType.StackedBar; xInc.Name = string.Format("{0:C}", valInc);
            xInc.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
            xInc.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid;
            xInc.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml("#0000FF");
            xInc.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
            xInc.DefaultLabelValue = "#Y{#.##}"; xInc.DataYColumn = "xInc"; rChart.Series.Add(xInc);

            ChartSeries pInc = new ChartSeries(); pInc.Type = ChartSeriesType.Bar; pInc.Name = string.Format("{0:C}", valpInc);
            pInc.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
            pInc.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid;
            pInc.Appearance.FillStyle.MainColor = System.Drawing.Color.FromArgb(70, System.Drawing.Color.LightGray);
            pInc.Appearance.FillStyle.GammaCorrection = true;
            pInc.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
            pInc.DefaultLabelValue = "#Y{#.##}"; pInc.DataYColumn = "pInc"; rChart.Series.Add(pInc);

            ChartSeries xExp = new ChartSeries(); xExp.Type = ChartSeriesType.StackedBar; xExp.Name = string.Format("{0:C}", -valExp);
            xExp.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
            xExp.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid;
            xExp.Appearance.FillStyle.MainColor = System.Drawing.Color.Red;
            xExp.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
            xExp.DefaultLabelValue = "#Y{#.##}"; xExp.DataYColumn = "xExp"; rChart.Series.Add(xExp);

            ChartSeries xNet = new ChartSeries(); xNet.Type = ChartSeriesType.Line; xNet.Name = string.Format("{0:C}", valNet);
            xNet.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
            xNet.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.White;
            xNet.DefaultLabelValue = "#Y{#.##}"; xNet.DataYColumn = "xNet"; rChart.Series.Add(xNet);

            rChart.DataSource = Tb; rChart.DataBind();
        }

        protected void chartBound(object sender, EventArgs e)
        {
            ChartSeries aNet = rChartPt.Series[2], aExp = rChartPt.Series[3];
            for (int i = 1; i < aNet.Items.Count - 1; i++) aNet.Items[i].Label.TextBlock.Appearance.Visible = false;
            for (int i = 1; i < aExp.Items.Count - 1; i++) aExp.Items[i].Label.TextBlock.Appearance.Visible = false;
        }
        protected void doCalculate(object sender, EventArgs e)
        {
            DataSet Ds = (new clsReport()).IncExp(Convert.ToDateTime(txtDf.Text), Convert.ToDateTime(txtDt.Text));

            prChart(Ds.Tables[0]);
            rChartPt.DataSource = Ds.Tables[1]; rChartPt.DataBind();

            btnEmail.Visible = isYN("k02") && rChart.Series[0].Items.Count > 0;
            if (btnEmail.Visible)
            {
                DataRow Rw = (new clsUser()).getUserEmail(Common.clsUser.uID, "OTDGraphEmail");
                txtFrom.Text = Rw["Email"].ToString();
                //txtBody.Text = Rw["Body"].ToString().Replace("\r", "<br>").Replace("\n", "<br>");
                litEmail.Text = generateAddress;
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
                hEmail.Add("Subject", txtSubject.Text.Trim()); hEmail.Add("Body", txtBody.Text.Trim());

                System.Collections.Generic.List<Hashtable> Att = new System.Collections.Generic.List<Hashtable>();

                System.IO.MemoryStream msI = new System.IO.MemoryStream();
                rChart.Save(msI, System.Drawing.Imaging.ImageFormat.Jpeg); msI.Position = 0;
                Hashtable i = new Hashtable(); i.Add("Att", msI); i.Add("Nm", "IncExpRpt.jpg"); Att.Add(i);

                System.IO.MemoryStream msJ = new System.IO.MemoryStream();
                rChartPt.Save(msJ, System.Drawing.Imaging.ImageFormat.Jpeg); msJ.Position = 0;
                Hashtable j = new Hashtable(); j.Add("Att", msJ); j.Add("Nm", "IncExpPct.jpg"); Att.Add(j);

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
            PageSec.Add("k01", "Calculate Income/Expense");
            PageSec.Add("k02", "Send Email");
        }
    }
}