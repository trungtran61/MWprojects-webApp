using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.AdminPanel
{
    public partial class BudgetForcast : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Budget Forcast Setup"))
            {
                loadUsage();
            }
        }
        protected void loadUsage()
        {
            if (!IsPostBack && uPnlUsage.Visible)
            {
                var Rw = (new myBiz.DAL.clsBudget()).BudgetForcast_PctUsage_S();
                hfDateID.Value = Rw["DateID"].ToString();
                txtUsage.Text = Rw["PctUsage"] != null ? Rw["PctUsage"].ToString() : string.Empty;
            }
        }
        protected void saveUsage(object sender, EventArgs e)
        {
            var DateID = Convert.ToInt32(hfDateID.Value);
            var PctUsage = Convert.ToDecimal(string.IsNullOrWhiteSpace(txtUsage.Text) ? "0" : txtUsage.Text);
            (new myBiz.DAL.clsBudget()).BudgetForcast_PctUsage_U(DateID, PctUsage);
            jMsg.ShowMsg("Thank you! Percent Usage has been saved.", true);
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1)
            {
                if (e.Row.RowState.ToString().EndsWith("Edit"))
                {
                    if (e.Row.Cells[1].Text.Equals("Total"))
                    {
                        var txtBudAmt = e.Row.FindControl("txtBudgetAmt") as TextBox;
                        var txtBudget = e.Row.FindControl("txtBudget") as TextBox;

                        txtBudAmt.Text = txtBudget.Text = "0";
                        txtBudAmt.Enabled = txtBudget.Enabled = false;
                    }
                }
                else if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    var lnk = e.Row.FindControl("lnkEdit") as LinkButton;
                    lnk.Enabled = isYN("k01");
                }
            }
        }
        protected void odsUpdated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                if (e.Exception.InnerException != null) iMsg.ShowErr(e.Exception.InnerException.Message, true);
                else iMsg.ShowErr(e.Exception.Message, true);
                e.ExceptionHandled = true;
            }
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            uPnlUsage.Visible = isYN("k02");
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Edit Budget Forcast");
            PageSec.Add("k02", "Update Percent Usage");
        }
    }
}