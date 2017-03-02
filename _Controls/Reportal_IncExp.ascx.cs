using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using myBiz.DAL;
using Telerik.Charting;

namespace webApp._Controls
{
    public partial class Reportal_IncExp : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public void LoadGraph(string graphName)
        {
            DataSet Ds = (new clsReport()).Reportal_IncExp(graphName);

            DrawChartPt(Ds.Tables[1]);
            DrawChart(Ds.Tables[0]);
        }

        private void DrawChartPt(DataTable Tb)
        {
            ChartSeries x = new ChartSeries(); x.Type = ChartSeriesType.Line;
            x.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
            x.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
            x.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml("#0000FF");
            x.DefaultLabelValue = "#Y{#.##}"; x.Name = "Net %"; x.DataYColumn = "NetPt";
            rChartPt.Series.Add(x);

            ChartSeries xGoal = new ChartSeries(); xGoal.Type = ChartSeriesType.Line;
            xGoal.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
            xGoal.Appearance.TextAppearance.Visible = false;
            xGoal.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml("#FF0000");
            xGoal.DefaultLabelValue = "#Y{#.##}"; xGoal.Name = "Net Goal"; xGoal.DataYColumn = "NetGl";
            rChartPt.Series.Add(xGoal);

            rChartPt.DataSource = Tb; rChartPt.DataBind();
        }

        private void DrawChart(DataTable Tb)
        {
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
    }
}