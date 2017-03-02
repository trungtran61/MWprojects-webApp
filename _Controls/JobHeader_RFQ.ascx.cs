using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace webApp._Controls
{
    public partial class JobHeader_RFQ : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void fvCmd(object sender, FormViewCommandEventArgs e)
        {
            int GrpID = Convert.ToInt32(Common.clsUser.Util.AppSetting(e.CommandName));
            int LnkID = Convert.ToInt32(e.CommandArgument);
            string GrpIDs = e.CommandName.Equals("BluePrint") ? string.Format("{0}:", Common.clsUser.Util.AppSetting("bBluePrint")) : string.Empty;
            string LnkIDs = e.CommandName.Equals("BluePrint") ? string.Format("{0}:", e.CommandArgument) : string.Empty;
            myBiz.DAL.clsFile.Show(Page, pnlPopup, "DL", false, "View Document", string.Empty, GrpID, LnkID, GrpIDs, LnkIDs, string.Empty);
        }
        public bool showDueDate
        {
            set
            {
                if (!value) (fvHeader.FindControl("litDueDate") as Literal).Text = "N/A";
            }
        }
        public bool lnkPartNumber
        {
            set
            {
                LinkButton lnk = fvHeader.FindControl("lnkBP") as LinkButton;
                if (!value)
                {
                    lnk.OnClientClick = "return false;";
                    lnk.CssClass = "lnkDisable";
                }
            }
        }
        public bool lnkCustomerPO
        {
            set
            {
                LinkButton lnk = fvHeader.FindControl("lnkCPO") as LinkButton;
                if (!value)
                {
                    lnk.OnClientClick = "return false;";
                    lnk.CssClass = "lnkDisable";
                }
            }
        }
        protected string gDD(string k)
        {
            DateTime DD = Common.clsUser.Util.gDate(Eval(k).ToString(), "DueDate");
            return DD.Equals(DateTime.MinValue) ? "No Date" : DD.ToString(Common.clsUser.Util.DD_Format);
        }
    }
}