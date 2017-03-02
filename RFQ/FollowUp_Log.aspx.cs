using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace webApp.RFQ
{
    public partial class FollowUp_Log : System.Web.UI.Page
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
                DataRow Rw = (new myBiz.DAL.clsRFQ_Quote()).NextVal(Convert.ToInt32(Request.QueryString["HID"]));

                litQuote.Text = Rw["QTENumber"].ToString();
                litCurStatus.Text = Rw["Status"].ToString();
                txtDate.Text = Convert.ToDateTime(Rw["NextDate"]).ToString(Common.clsUser.Util.DD_Format);
            }
        }
        protected void doSave(object sender, EventArgs e)
        {
            int QTEID = Convert.ToInt32(Request.QueryString["HID"]), RltID = Convert.ToInt32(ddlResult.SelectedValue);
            (new myBiz.DAL.clsFollowUp()).Log_Save(-1, QTEID, Request.QueryString["uID"], txtConNm.Text, ddlConBy.SelectedValue, RltID, txtCmt.Text, Convert.ToDateTime(txtDate.Text));
            iMsg.ShowMsg("Thank You! Your RFQ Log has been saved.", true);
        }
    }
}