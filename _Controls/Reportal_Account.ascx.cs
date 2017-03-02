using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Charting;
using System.Data;
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class Reportal_Account : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void LoadGraph(string graphName)
        {
            rChart.ChartTitle.TextBlock.Text = graphName;
            rChart.Appearance.BarOverlapPercent = 30;
            rChart.Appearance.BarWidthPercent = 80;

            ChartSeries value = new ChartSeries(); value.Type = ChartSeriesType.StackedBar;
            value.DataXColumn = "xCnt"; value.Name = value.DataYColumn = "Value";
            value.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.Nothing;
            value.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
            value.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml("#0000FF");
            value.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid;
            value.DefaultLabelValue = "#Y{#.##}"; rChart.Series.Add(value);

            ChartSeries goal = new ChartSeries(); goal.Type = ChartSeriesType.Bar;
            goal.DataXColumn = "xCnt"; goal.Name = goal.DataYColumn = "Goal";
            goal.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.Nothing;
            goal.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
            goal.Appearance.FillStyle.MainColor = System.Drawing.Color.FromArgb(70, System.Drawing.Color.LightGray);
            goal.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid;
            goal.Appearance.Border.Color = System.Drawing.Color.Red;
            goal.Appearance.FillStyle.GammaCorrection = true;
            goal.DefaultLabelValue = "#Y{#.##}"; rChart.Series.Add(goal);

            rChart.DataSource = (new clsReport()).Reportal_Account_S(graphName);
            rChart.DataBind();
        }
    }
}