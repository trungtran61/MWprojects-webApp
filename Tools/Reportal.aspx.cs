using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webApp._Controls;

namespace webApp.Tools
{
    public partial class Reportal : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Reportal"))
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            pnlReportal.Controls.Clear();

            if (isYN("k01")) loadGraph("Reportal_IncExp", "Income and Expense");
            if (isYN("k02")) loadGraph("Reportal_Sale", "Sale Customer PO");
            if (isYN("k03")) loadGraph("Reportal_ExpLimRatio", "Purchasing Commission");
            if (isYN("k04")) loadGraph("Reportal_ExpLimRatio", "Purchasing Deburr Tools");
            if (isYN("k05")) loadGraph("Reportal_ExpLimRatio", "Purchasing Donation");
            if (isYN("k06")) loadGraph("Reportal_ExpLimRatio", "Purchasing Freight");
            if (isYN("k07")) loadGraph("Reportal_ExpLimRatio", "Purchasing Gage-Calibration");
            if (isYN("k08")) loadGraph("Reportal_ExpLimRatio", "Purchasing Gage-New");
            if (isYN("k09")) loadGraph("Reportal_ExpLimRatio", "Purchasing Gage-Repair");
            if (isYN("k10")) loadGraph("Reportal_ExpLimRatio", "Purchasing Gas-Meal-Entertainment");
            if (isYN("k11")) loadGraph("Reportal_ExpLimRatio", "Purchasing Insurances");
            if (isYN("k12")) loadGraph("Reportal_ExpLimRatio", "Purchasing Labor");
            if (isYN("k13")) loadGraph("Reportal_ExpLimRatio", "Purchasing Labor Contract");
            if (isYN("k14")) loadGraph("Reportal_ExpLimRatio", "Purchasing Machine-Purchase");
            if (isYN("k15")) loadGraph("Reportal_ExpLimRatio", "Purchasing Maintenance");
            if (isYN("k16")) loadGraph("Reportal_ExpLimRatio", "Purchasing Material Costs");
            if (isYN("k17")) loadGraph("Reportal_ExpLimRatio", "Purchasing Office Supplies");
            if (isYN("k18")) loadGraph("Reportal_ExpLimRatio", "Purchasing Outside Process Service");
            if (isYN("k19")) loadGraph("Reportal_ExpLimRatio", "Purchasing Rent");
            if (isYN("k20")) loadGraph("Reportal_ExpLimRatio", "Purchasing Shop Supplies");
            if (isYN("k21")) loadGraph("Reportal_ExpLimRatio", "Purchasing Toolings-New");
            if (isYN("k22")) loadGraph("Reportal_ExpLimRatio", "Purchasing Toolings-Repair");
            if (isYN("k23")) loadGraph("Reportal_ExpLimRatio", "Purchasing Total");
            if (isYN("k24")) loadGraph("Reportal_ExpLimRatio", "Purchasing Utilities");
            if (isYN("k25")) loadGraph("Reportal_OTD", "OTD Trend C-OTD");
            if (isYN("k26")) loadGraph("Reportal_OTD", "OTD Trend Sales");
            if (isYN("k27")) loadGraph("Reportal_OTD", "OTD Trend Engineer");
            if (isYN("k28")) loadGraph("Reportal_OTD", "OTD Trend Quality");
            if (isYN("k29")) loadGraph("Reportal_OTD", "OTD Trend Inventory");
            if (isYN("k30")) loadGraph("Reportal_OTD", "OTD Trend Shipping");
            if (isYN("k31")) loadGraph("Reportal_OTD", "OTD Trend Delivery");
            if (isYN("k32")) loadGraph("Reportal_OTD", "OTD Trend Billing");
            if (isYN("k33")) loadGraph("Reportal_OTD", "OTD Trend Purchasing");
            if (isYN("k34")) loadGraph("Reportal_OTD", "OTD Trend LATHE");
            if (isYN("k35")) loadGraph("Reportal_OTD", "OTD Trend MILL");
            if (isYN("k36")) loadGraph("Reportal_OTD", "OTD Trend RIM");
            if (isYN("k37")) loadGraph("Reportal_OTD", "OTD Trend SAW");
            if (isYN("k38")) loadGraph("Reportal_OTD", "OTD Trend OPS");
            if (isYN("k39")) loadGraph("Reportal_OTD", "OTD Trend HF");
            if (isYN("k40")) loadGraph("Reportal_OTD", "OTD Trend FIN");
            if (isYN("k41")) loadGraph("Reportal_OTD", "OTD Trend ASE");
            if (isYN("k42")) loadGraph("Reportal_OTD", "OTD Trend PAM");
            if (isYN("k43")) loadGraph("Reportal_OTD", "OTD Trend RO");
            if (isYN("k44")) loadGraph("Reportal_OTD", "OTD Trend VO");
            if (isYN("k45")) loadGraph("Reportal_OTD", "OTD Trend EB");
            if (isYN("k46")) loadGraph("Reportal_OTD", "OTD Trend PB");
            if (isYN("k47")) loadGraph("Reportal_OTD", "OTD Trend UI");
            if (isYN("k48")) loadGraph("Reportal_OTD", "OTD Trend AP");
            if (isYN("k49")) loadGraph("Reportal_Account", "Accounting Detail");
            if (isYN("k50")) loadGraph("Reportal_Account", "AP Detail");
        }

        protected void loadGraph(string ctrlName, string graphName)
        {
            var ctrl = LoadControl(string.Format("~/_Controls/{0}.ascx", ctrlName));
            ctrl.ID = string.Format("uc{0}", graphName.Replace(" ", string.Empty));

            switch (ctrlName)
            {
                case "Reportal_Account":
                    (ctrl as Reportal_Account).LoadGraph(graphName);
                    break;
                case "Reportal_IncExp":
                    (ctrl as Reportal_IncExp).LoadGraph(graphName);
                    break;
                case "Reportal_ExpLimRatio":
                    (ctrl as Reportal_ExpLimRatio).LoadGraph(graphName);
                    break;
                case "Reportal_Sale":
                    (ctrl as Reportal_Sale).LoadGraph(graphName);
                    break;
                case "Reportal_OTD":
                    (ctrl as Reportal_OTD).LoadGraph(graphName);
                    break;
            }
            
            pnlReportal.Controls.Add(ctrl);
            //pnlReportal.Controls.Add(new LiteralControl("<br /><br />"));
        }

        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Income and Expense");
            PageSec.Add("k02", "Sale Customer PO");
            PageSec.Add("k03", "Purchasing Commission");
            PageSec.Add("k04", "Purchasing Deburr Tools");
            PageSec.Add("k05", "Purchasing Donation");
            PageSec.Add("k06", "Purchasing Freight");
            PageSec.Add("k07", "Purchasing Gage-Calibration");
            PageSec.Add("k08", "Purchasing Gage-New");
            PageSec.Add("k09", "Purchasing Gage-Repair");
            PageSec.Add("k10", "Purchasing Gas-Meal-Entertainment");
            PageSec.Add("k11", "Purchasing Insurances");
            PageSec.Add("k12", "Purchasing Labor");
            PageSec.Add("k13", "Purchasing Labor Contract");
            PageSec.Add("k14", "Purchasing Machine-Purchase");
            PageSec.Add("k15", "Purchasing Maintenance");
            PageSec.Add("k16", "Purchasing Material Costs");
            PageSec.Add("k17", "Purchasing Office Supplies");
            PageSec.Add("k18", "Purchasing Outside Process Service");
            PageSec.Add("k19", "Purchasing Rent");
            PageSec.Add("k20", "Purchasing Shop Supplies");
            PageSec.Add("k21", "Purchasing Toolings-New");
            PageSec.Add("k22", "Purchasing Toolings-Repair");
            PageSec.Add("k23", "Purchasing Total");
            PageSec.Add("k24", "Purchasing Utilities");
            PageSec.Add("k25", "OTD Trend C-OTD");
            PageSec.Add("k26", "OTD Trend Sales");
            PageSec.Add("k27", "OTD Trend ENgineer");
            PageSec.Add("k28", "OTD Trend Quality");
            PageSec.Add("k29", "OTD Trend Inventory");
            PageSec.Add("k30", "OTD Trend Shipping");
            PageSec.Add("k31", "OTD Trend Delivery");
            PageSec.Add("k32", "OTD Trend Billing");
            PageSec.Add("k33", "OTD Trend Purchasing");
            PageSec.Add("k34", "OTD Trend LATHE");
            PageSec.Add("k35", "OTD Trend MILL");
            PageSec.Add("k36", "OTD Trend RIM");
            PageSec.Add("k37", "OTD Trend SAW");
            PageSec.Add("k38", "OTD Trend OPS");
            PageSec.Add("k39", "OTD Trend HF");
            PageSec.Add("k40", "OTD Trend FIN");
            PageSec.Add("k41", "OTD Trend ASE");
            PageSec.Add("k42", "OTD Trend PAM");
            PageSec.Add("k43", "OTD Trend RO");
            PageSec.Add("k44", "OTD Trend VO");
            PageSec.Add("k45", "OTD Trend EB");
            PageSec.Add("k46", "OTD Trend PB");
            PageSec.Add("k47", "OTD Trend UI");
            PageSec.Add("k48", "OTD Trend AP");
            PageSec.Add("k49", "Accounting Detail");
            PageSec.Add("k50", "AP Detail");
        }
    }
}