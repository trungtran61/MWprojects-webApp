using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.RFQ
{
    public partial class CustFU_Log : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) lData();
        }
        private void lData()
        {
            uPnlViewLog.Visible = !string.IsNullOrEmpty(Request.QueryString["vLog"]);
            uPnlLog.Visible = !uPnlViewLog.Visible;

            if (uPnlLog.Visible)
            {
                DataRow Rw = (new myBiz.DAL.clsCustFU()).CustFU_Company(Convert.ToInt32(Request.QueryString["HID"]));

                litCustomerName.Text = Rw["CompanyName"].ToString();
                litCurStatus.Text = Rw["Status"].ToString();
            }
        }
        protected void ddlSelected(object sender, EventArgs e)
        {
            DataRow Rw = (new myBiz.DAL.clsCustFU()).NextVal(Convert.ToInt32(Request.QueryString["HID"]), Convert.ToInt32(ddlResult.SelectedValue));
            txtDate.DbSelectedDate = Rw["NextDate"];
        }
        protected void doSave(object sender, EventArgs e)
        {
            int CustFUID = Convert.ToInt32(Request.QueryString["HID"]), RltID = Convert.ToInt32(ddlResult.SelectedValue);
            (new myBiz.DAL.clsCustFU()).Log_Save(-1, CustFUID, Request.QueryString["uID"], txtConNm.Text, ddlConBy.SelectedValue, RltID, txtCmt.Text, txtDate.SelectedDate.Value);
            iMsg.ShowMsg("Thank You! Your Customer Log has been saved.", true);
        }
    }
}