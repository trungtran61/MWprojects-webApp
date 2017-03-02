using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class Budget : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Budget Table"))
            {
                lSec("Report/PO By Expense Account");
                if (!IsPostBack)
                {
                    Title = string.Format("BUDGETS FOR {0:MMMM, yyyy}", DateTime.Today).ToUpper();
                }
            }
        }
        protected void gvBound(object sender, EventArgs e)
        {
            GridViewRow Total = null;
            double Lim = 0, Cur = 0, Dif = 0;

            var row = gvBudget.Rows.Cast<GridViewRow>().Where(r => r.Visible);
            foreach (GridViewRow Rw in row)
            {
                if (Rw.Cells[0].Text.Equals("Total")) Total = Rw;
                else
                {
                    var curAmt = (Rw.Cells[2].FindControl("hfCurAmt") as HiddenField).Value;
                    Lim += Convert.ToDouble((Rw.Cells[1].FindControl("hfLimAmt") as HiddenField).Value);
                    Cur += Convert.ToDouble(curAmt);
                    Dif += Convert.ToDouble((Rw.Cells[3].FindControl("hfDifAmt") as HiddenField).Value);
                }
            }

            if (Total != null)
            {
                Total.Cells[1].Text = string.Format("{0:0.00}", Lim);
                Total.Cells[2].Text = string.Format("{0:0.00}", Cur);
                Total.Cells[3].Text = string.Format("{0:0.00}", Dif);
            }
        }

        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                switch (e.Row.Cells[0].Text)
                {
                    case "Commission": e.Row.Visible = isYN("k01"); break;
                    case "Contract": e.Row.Visible = isYN("k02"); break;
                    case "Deburr Tools": e.Row.Visible = isYN("k03"); break;
                    case "Freight": e.Row.Visible = isYN("k04"); break;
                    case "Gage-Calibration": e.Row.Visible = isYN("k05"); break;
                    case "Gage-New": e.Row.Visible = isYN("k06"); break;
                    case "Gage-Repair": e.Row.Visible = isYN("k07"); break;
                    case "Gas-Meal-Entertainment": e.Row.Visible = isYN("k08"); break;
                    case "Insurances": e.Row.Visible = isYN("k09"); break;
                    case "Labor": e.Row.Visible = isYN("k10"); break;
                    case "Machine-Purchase": e.Row.Visible = isYN("k11"); break;
                    case "Maintenance": e.Row.Visible = isYN("k12"); break;
                    case "Material Costs": e.Row.Visible = isYN("k13"); break;
                    case "Office Supplies": e.Row.Visible = isYN("k14"); break;
                    case "Outside Process Service": e.Row.Visible = isYN("k15"); break;
                    case "Rent": e.Row.Visible = isYN("k16"); break;
                    case "Shop Supplies": e.Row.Visible = isYN("k17"); break;
                    case "Toolings-New": e.Row.Visible = isYN("k18"); break;
                    case "Toolings-Repair": e.Row.Visible = isYN("k19"); break;
                    case "Utilities": e.Row.Visible = isYN("k20"); break;
                    case "Donation": e.Row.Visible = isYN("k21"); break;
                    case "Labor Contract": e.Row.Visible = isYN("k22"); break;
                }
            }
        }
        protected string gExpLink()
        {
            return isYN01("k00") && !Eval("tExpAcct").ToString().Equals("Total") ? string.Format("<a href=\"javascript:loadReport('../Reports/POByExpAcct.aspx?tExpAcct={0}');\">{1:0.00}</a>", Eval("tExpAcct"), Eval("CurAmt")) : Eval("CurAmt", "{0:0.00}");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            litOTLimit.Visible = isYN("k23");

            if (litOTLimit.Visible)
            {
                litOTLimit.Text = string.Format("OT LIMIT PER WEEK (HRS):  {0:0.00}<br><br>", (new myBiz.DAL.clsMisc()).GetOTLimit());
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Commission");
            PageSec.Add("k02", "Contract");
            PageSec.Add("k03", "Deburr Tools");
            PageSec.Add("k04", "Freight");
            PageSec.Add("k05", "Gage-Calibration");
            PageSec.Add("k06", "Gage-New");
            PageSec.Add("k07", "Gage-Repair");
            PageSec.Add("k08", "Gas-Meal-Entertainment");
            PageSec.Add("k09", "Insurances");
            PageSec.Add("k10", "Labor");
            PageSec.Add("k11", "Machine-Purchase");
            PageSec.Add("k12", "Maintenance");
            PageSec.Add("k13", "Material Costs");
            PageSec.Add("k14", "Office Supplies");
            PageSec.Add("k15", "Outside Process Service");
            PageSec.Add("k16", "Rent");
            PageSec.Add("k17", "Shop Supplies");
            PageSec.Add("k18", "Toolings-New");
            PageSec.Add("k19", "Toolings-Repair");
            PageSec.Add("k20", "Utilities");
            PageSec.Add("k21", "Donation");
            PageSec.Add("k22", "Labor Contract");
            PageSec.Add("k23", "View OT Limit");
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