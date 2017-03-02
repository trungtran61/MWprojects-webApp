using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using myBiz.DAL;

namespace webApp.AdminPanel
{
    public partial class DefVals : webApp.Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Default Values Management"))
            {
                if (!IsPostBack)
                {
                    loadEPT();
                    ddlChanged(sender, e);
                }
            }
        }

        private void loadEPT()
        {
            DataTable Tb = clsDB.spAdmin_Variables_S("EngProTime:EngProTimeUnit:EngProTimeRate");

            foreach (DataRow Rw in Tb.Rows)
            {
                switch (Rw["nKey"].ToString())
                {
                    case "EngProTime": txtEPT.Text = Rw["iValue"].ToString(); break;
                    case "EngProTimeUnit":
                        var x = ddlEPT.Items.Cast<ListItem>().Where(i => i.Value.Equals(Rw["sValue"].ToString()));
                        ddlEPT.SelectedValue = x.Count() > 0 ? x.FirstOrDefault().Value : "Min";
                        break;
                    case "EngProTimeRate": txtRate.Text = Rw["sValue"].ToString(); break;
                }
            }
        }
        protected void saveEPT(object sender, EventArgs e)
        {
            string rMsg = string.Empty;
            if (string.IsNullOrEmpty(txtEPT.Text.Trim())) txtEPT.Text = "30";
            if (!myBiz.Tools.clsValidator.isNumeric(txtEPT.Text)) rMsg = "<font color=\"red\">You have entered invalid time. [{0}]</font>";
            else if (Convert.ToInt32(txtEPT.Text.Trim()) < 0) rMsg = "<font color=\"red\">The Time cannot be negative. [{0}]</font>";

            if (string.IsNullOrEmpty(rMsg))
            {
                System.Collections.Hashtable h = new System.Collections.Hashtable();
                h.Add("EngProTime", Convert.ToInt32(txtEPT.Text));
                h.Add("EngProTimeUnit", ddlEPT.SelectedValue);
                h.Add("EngProTimeRate", txtRate.Text);
                clsDB.spAdmin_Variables_Save(h);
                rMsg = "EPT Updated on {0}";
            }

            eMsg.Text = string.Format(rMsg, DateTime.Now.ToString("MM/dd/yyyy @ hh:mm:ss"));
        }

        protected void ddlChanged(object sender, EventArgs e)
        {
            switch (ddlStepName.SelectedValue)
            {
                case "RIM":
                    showCol("4:5:6:7");
                    gvDefVals.Columns[4].HeaderText = "MatlTrans<br>Time";
                    gvDefVals.Columns[5].HeaderText = "MatlTrans<br>Rate ($/hr)";
                    gvDefVals.Columns[6].HeaderText = "MatlInspect<br>Time";
                    gvDefVals.Columns[7].HeaderText = "MatlInspect<br>Rate ($/hr)";
                    break;
                case "OPS":
                    showCol("4:5:6:7:8:9");
                    gvDefVals.Columns[4].HeaderText = "Setup<br>Time";
                    gvDefVals.Columns[5].HeaderText = "Setup<br>Rate ($/hr)";
                    gvDefVals.Columns[6].HeaderText = "OpsInspect<br>Time Each";
                    gvDefVals.Columns[7].HeaderText = "OpsInspect<br>Rate ($/hr)";
                    gvDefVals.Columns[8].HeaderText = "OpsTrans<br>Time";
                    gvDefVals.Columns[9].HeaderText = "OpsTrans<br>Rate ($/hr)";
                    break;
                case "SHIP":
                    showCol("4:5");
                    gvDefVals.Columns[4].HeaderText = "Packing<br>Time";
                    gvDefVals.Columns[5].HeaderText = "Packing<br>Rate ($/hr)";
                    break;
                case "DEL":
                    showCol("4:5");
                    gvDefVals.Columns[4].HeaderText = "Delivery<br>Time";
                    gvDefVals.Columns[5].HeaderText = "Delivery<br>Rate ($/hr)";
                    break;
                default:
                    showCol("2:3:4:5:6:7:8:9:10");
                    gvDefVals.Columns[2].HeaderText = "Program<br>Time";
                    gvDefVals.Columns[3].HeaderText = "Program<br>Rate ($/hr)";
                    gvDefVals.Columns[4].HeaderText = "Setup<br>Time";
                    gvDefVals.Columns[5].HeaderText = "Setup<br>Rate ($/hr)";
                    gvDefVals.Columns[6].HeaderText = "Cycle<br>Time";
                    gvDefVals.Columns[7].HeaderText = "Cycle<br>Rate ($/hr)";
                    gvDefVals.Columns[8].HeaderText = "Fixture<br>Time";
                    gvDefVals.Columns[9].HeaderText = "Fixture<br>Rate ($/hr)";
                    break;
            }
        }
        private void showCol(string idx)
        {
            string[] v = idx.Split(':');
            int Cnt = gvDefVals.Columns.Count;
            for (int i = 2; i < Cnt; i++) gvDefVals.Columns[i].Visible = v.Contains(i.ToString());
        }
        protected override void enforceSecurity()
        {
        }
    }
}