using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using myBiz.DAL;

namespace webApp.Tools
{
    public partial class ReceiveCustomerPO : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Tools/Receive CustomerPOs");
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
            int GrpID = Convert.ToInt32(Util.AppSetting("CustomerPOFile"));
            if (LnkID == 0) LnkID = (new clsFile()).getCustomerPOID(txtCustomerPO.Text);
            string Ref = ClientScript.GetPostBackClientHyperlink(lnkRefresh, string.Empty);
            DataTable Tb = clsDB.spAdmin_Variables_S("UploadLimitPOFile");
            string maxLen = Tb != null && Tb.Rows.Count > 0 ? Tb.Rows[0]["iValue"].ToString() : string.Empty;
            clsFile.Show(Page, pnlPopup, cmd, isYN("k04"), "Uploading CustomerPOs", Ref, GrpID, LnkID, maxLen);
        }
        protected void lRefresh(object sender, EventArgs e)
        {
            (new clsFile()).CustomerPO_DD(Convert.ToInt32(Util.AppSetting("CustomerPOFile")), "Review");
            gvCustomerPOs.DataBind();
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
            PageSec.Add("k05", "Delete Customer PO");
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ((Button)e.Row.FindControl("btnUpload")).Enabled = isYN("k01");
                ((Button)e.Row.FindControl("btnView")).Enabled = isYN("k02");
                e.Row.FindControl("btnDelete").Visible = isYN("k05");
            }
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnUpload.Visible = isYN("k03");
        }
    }
}