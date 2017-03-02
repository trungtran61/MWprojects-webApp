using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Charting;

namespace webApp._Controls
{
    public partial class Reportal_Sale : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public void LoadGraph(string graphName)
        {
            ChartSeries x = new ChartSeries(); x.Type = ChartSeriesType.Line;
            x.DataXColumn = "xCnt"; x.Name = x.DataYColumn = "Sale";
            x.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
            x.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
            x.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml("#4169E1");
            rChart.Series.Add(x);

            ChartSeries y = new ChartSeries(); y.Type = ChartSeriesType.Line;
            y.DataXColumn = "xCnt"; y.Name = y.DataYColumn = "Goal";
            y.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
            y.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml("#FF0000");
            y.Appearance.TextAppearance.Visible = false;
            rChart.Series.Add(y);

            rChart.ChartTitle.TextBlock.Text = graphName;
            rChart.DataSource = (new myBiz.DAL.clsReport()).Reportal_Sale_S(graphName); rChart.DataBind();
        }
    }
}