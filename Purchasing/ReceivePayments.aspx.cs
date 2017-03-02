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
using myBiz.DAL;

namespace webApp.Purchasing
{
    public partial class ReceivePayments : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Purchasing/Receive Payment");
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("pUpload"))
            {
                doCmd("UL", Convert.ToInt32(e.CommandArgument));
            }
            else if (e.CommandName.Equals("pView"))
            {
                doCmd("DL", Convert.ToInt32(e.CommandArgument));
            }
        }
        protected void doUpload(object sender, EventArgs e)
        {
            doCmd("UL", 0);
        }
        private void doCmd(string cmd, int LnkID)
        {
            int GrpID = Convert.ToInt32(Util.AppSetting("CheckImage"));
            if (LnkID == 0) LnkID = (new clsFile()).getCheckID(GrpID);
            string Ref = ClientScript.GetPostBackClientHyperlink(lnkRefresh, string.Empty);
            DataTable Tb = clsDB.spAdmin_Variables_S("UploadLimitCheck");
            string maxLen = Tb != null && Tb.Rows.Count > 0 ? Tb.Rows[0]["iValue"].ToString() : string.Empty;
            clsFile.Show(Page, pnlPopup, cmd, isYN("k04"), "Uploading Checks", Ref, GrpID, LnkID, maxLen);
        }
        protected void lRefresh(object sender, EventArgs e)
        {
            (new clsFile()).CheckImage_DD(Convert.ToInt32(Util.AppSetting("CheckImage")));
            gvChecks.DataBind();
        }
        protected string gDD(string k)
        {
            try
            {
                string fColor = string.Empty;
                switch (Eval("lMode").ToString())
                {
                    case "beLate": fColor = " style=\"color:Brown;\""; break;
                    case "Late": fColor = " style=\"color:Red;\""; break;
                }

                DateTime DD = Convert.ToDateTime(Eval(k));
                return string.Format("<span{0}>{1}</span>", fColor, DD.ToString(Util.DD_Format));
            }
            catch
            {
                return "No Date";
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Edit");
            PageSec.Add("k02", "View");
            PageSec.Add("k03", "Upload New File");
            PageSec.Add("k04", "Delete File");
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ((Button)e.Row.FindControl("btnUpload")).Enabled = isYN("k01");
                ((Button)e.Row.FindControl("btnView")).Enabled = isYN("k02");
            }
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnUpload.Visible = isYN("k03");
        }
    }
}