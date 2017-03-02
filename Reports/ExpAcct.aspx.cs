using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;
using myBiz.DAL;

namespace webApp.Reports
{
    public partial class ExpAcct : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Report/Expense Account");
            lSec("Report/PO By Expense Account");
            System.Threading.Thread.CurrentThread.CurrentCulture = new Common.clsCulture();
        }

        protected void doCalculate(object sender, EventArgs e)
        {
            DataSet Ds = (new clsReport()).ExpAcct(Convert.ToDateTime(txtDf.Text), Convert.ToDateTime(txtDt.Text));
            var Rw = Ds.Tables[0].Rows[0];

            DataTable Tb = new DataTable();
            Tb.Columns.Add("Title", typeof(string));
            Tb.Columns.Add("RealTime", typeof(string));
            Tb.Columns.Add("Predict", typeof(string));

            Tb.Rows.Add("INCOME ($)", string.Format("{0:C}", Rw["rInc"]), string.Format("{0:C}", Rw["pInc"]));
            Tb.Rows.Add("EXPENSES ($; %)", string.Format("{0:C}; {1:#.##} %", Rw["rExp"], Rw["rExpPt"]), string.Format("{0:C}; {1:#.##} %", Rw["rExp"], Rw["pExpPt"]));
            Tb.Rows.Add("PROFIT ($; %)", string.Format("{0:C}; {1:#.##} %", Rw["rNet"], Rw["rNetPt"]), string.Format("{0:C}; {1:#.##} %", Rw["pNet"], Rw["pNetPt"]));

            gvDetail.DataSource = Tb; gvDetail.DataBind();
            gvExpAcct.DataSource = Ds.Tables[1]; gvExpAcct.DataBind();
        }
        protected string gExp()
        {
            string t = Eval("tExpAcct").ToString();
            return t.Equals("Outside Process Service") ? string.Format("<a href=\"javascript:xPopup('ExpAcct4OPS.aspx?Df={0}&Dt={1}');\">{2}</a>", txtDf.Text, txtDt.Text, t) : t;
        }
        protected string gExpLink()
        {
            return isYN01("k00") && !Eval("tExpAcct").ToString().Equals("Total") ? string.Format("<a href=\"javascript:lPopup('POByExpAcct.aspx?tExpAcct={0}&df={2}&dt={3}');\">{1:N}</a>", Eval("tExpAcct"), Eval("Amt"), txtDf.Text, txtDt.Text) : Eval("Amt", "{0:N}");
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Calculate Expense Account");
        }
        protected void lSec(string PageName)
        {
            if (PgSec.Count < 1)
            {
                PgSec = new Hashtable(); PgSec.Add("k00", "Page Access");
                PgSec = webApp.Common.clsUser.prepareSecurity(PageName, PgSec);
            }
        }
        protected Hashtable PgSec
        {
            set { ViewState["PgSec"] = value; }
            get
            {
                if (ViewState["PgSec"] == null) ViewState["PgSec"] = new Hashtable();
                return ViewState["PgSec"] as Hashtable;
            }
        }
        protected bool isYN01(string key) { return PgSec.ContainsKey(key) && Convert.ToBoolean(PgSec[key]); }
    }
}