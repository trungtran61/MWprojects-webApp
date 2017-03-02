using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Charting;
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class Reportal_OTD : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public void LoadGraph(string graphName)
        {
            DataTable Tb = (new clsReport()).Reportal_DeptOTDTrend_S(graphName);
            var columnNames = new[] { "dName", "xCnt" };
            var cols = Tb.Columns.Cast<DataColumn>().Where(r => !columnNames.Contains(r.ColumnName)).Select(r => r.ColumnName);

            foreach (var col in cols)
            {
                var x = new ChartSeries(); x.Type = ChartSeriesType.Line;
                x.DataXColumn = "xCnt"; x.Name = x.DataYColumn = col;
                x.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
                x.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;

                var clr = string.Empty;

                switch (col.ToUpper())
                {
                    case "GOAL":
                        clr = "#FF0000";
                        x.Appearance.TextAppearance.Visible = false;
                        break;
                    default:
                        clr = "#008000";
                        break;
                }

                if (!string.IsNullOrEmpty(clr)) x.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml(clr);
                rChart.Series.Add(x);
            }

            rChart.ChartTitle.TextBlock.Text = graphName;
            rChart.DataSource = Tb; rChart.DataBind();
        }
    }
}