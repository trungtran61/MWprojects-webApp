using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using myBiz.DAL;
using System.Data;
using Telerik.Charting;

namespace webApp._Controls
{
    public partial class Reportal_ExpLimRatio : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        public void LoadGraph(string graphName)
        {
            //(new clsBudget()).BudgetForcast_RefreshRange(dateFrom, dateTo);

            DrawExpLimRatioGraph(graphName);
            DrawBudgetDifferentGraph(graphName);
        }
        protected void DrawBudgetDifferentGraph(string graphName)
        {
            DataTable Tb = (new clsReport()).Reportal_BudgetDifferent_S(graphName);
            var columnNames = new[] { "dName", "xCnt" };
            var cols = Tb.Columns.Cast<DataColumn>().Where(r => !columnNames.Contains(r.ColumnName)).Select(r => r.ColumnName);

            foreach (var col in cols)
            {
                var x = new ChartSeries(); x.Type = ChartSeriesType.Bar;
                x.DataXColumn = "xCnt"; x.Name = x.DataYColumn = col;
                x.Appearance.LegendDisplayMode = ChartSeriesLegendDisplayMode.SeriesName;
                x.Appearance.TextAppearance.TextProperties.Color = System.Drawing.Color.Black;
                x.Appearance.FillStyle.MainColor = System.Drawing.ColorTranslator.FromHtml("#008000");
                chtBD.Series.Add(x);
            }

            var title = graphName.Split(' ').LastOrDefault();
            chtBD.ChartTitle.TextBlock.Text = string.Format("Budget Different for {0}", title);
            chtBD.DataSource = Tb; chtBD.DataBind();
        }

        protected void DrawExpLimRatioGraph(string graphName)
        {
            DataTable Tb = (new clsReport()).Reportal_ExpLimRatio_S(graphName);
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

            var title = graphName.Split(' ').LastOrDefault();
            rChart.ChartTitle.TextBlock.Text = string.Format("Expense-Limit Ratio for {0}", title);
            rChart.DataSource = Tb; rChart.DataBind();
        }
    }
}