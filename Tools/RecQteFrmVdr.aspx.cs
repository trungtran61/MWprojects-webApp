using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class RecQteFrmVdr : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Receive Quote"))
            {
            }
        }
        protected string gLnk()
        {
            var isMat = Eval("MO").ToString().Equals("Material");
            return !isMat ? "N/A" : string.Format("<a onclick=\"javascript:xPopup('../File/VdrBlk.aspx?vID={0}&mID={1}&aE=0&MOGT=Matl'); return false;\" class=\"mLink\">No Bid</a>", Eval("VendorID"), Eval("BDID"));
        }

        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("viewFile"))
            {
                btn_Click("DL", e.CommandArgument.ToString());
            }
            else if (e.CommandName.Equals("uploadFile"))
            {
                btn_Click("UL", e.CommandArgument.ToString());
            }
        }
        protected void btn_Click(string cmd, string arg)
        {
            var v = arg.Split(':');
            var GrpID = Convert.ToInt32(Util.AppSetting(v[1].Equals("Material") ? string.Format("MaterialRFQFile{0}", ddlAppCode.SelectedValue) : string.Format("OPSRFQFile{0}", ddlAppCode.SelectedValue)));
            myBiz.DAL.clsFile.Show(Page, pnlPopup, cmd, isYN("k02"), "Attachments", string.Empty, GrpID, Convert.ToInt32(v[0]), "500");
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1)
            {
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
                {
                    var lit = e.Row.FindControl("litCnt") as Literal;
                    var isHistory = Convert.ToInt32(lit.Text) > 0;
                    lit.Visible = isHistory;
                    e.Row.FindControl("lnkEdit").Visible = isYN("k01") && !isHistory;
                }
            }
        }
        protected void clickSearch(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtWO_QTE.Text) && string.IsNullOrEmpty(txtStepNo.Text) && string.IsNullOrEmpty(txtRFQNumber.Text) && string.IsNullOrEmpty(txtItemNo.Text) && string.IsNullOrEmpty(txtVendorName.Text) && string.IsNullOrEmpty(txtUnitPrice.Text) && string.IsNullOrEmpty(txtLeadTime.Text))
            {
                iMsg.ShowErr("Please enter something to search.", true);
                odsQuote.SelectParameters["isSearch"].DefaultValue = "False";
                gvQuote.EmptyDataText = string.Empty;
            }
            else
            {
                odsQuote.SelectParameters["isSearch"].DefaultValue = "True";
                gvQuote.EmptyDataText = string.Format("No Record Found! {0}", DateTime.Now);
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Edit Quote");
            PageSec.Add("k02", "Delete File");
        }
    }
}