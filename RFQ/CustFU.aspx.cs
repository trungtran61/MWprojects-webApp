using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webApp.Common;

namespace webApp.RFQ
{
    public partial class CustFU : pgAbstract
    {
        protected void Page_Init(object sender, EventArgs e) { hfUID.Value = Common.clsUser.uID; }
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("RFQ/Customer Follow Up");
        }
        protected string gDD(string k)
        {
            try
            {
                string fColor = string.Empty;

                switch (Eval("lMode").ToString())
                {
                    case "Late": fColor = " style=\"color:Red;\""; break;
                    case "beLate": fColor = " style=\"color:Brown;\""; break;
                    case "Early": fColor = " style=\"color:Gray;\""; break;
                }

                DateTime DD = Convert.ToDateTime(Eval(k));
                return string.Format("<span{0}>{1}</span>", fColor, DD.ToString(Util.DD_Format));
            }
            catch
            {
                return "No Date";
            }
        }
        protected string gLnk()
        {
            return string.Format("<a onclick=\"javascript:lPopup('../File/Preview.aspx?AppCode=RFQ&FID=CustFU&Code=CustFU&HID={0}&uID={2}'); return false;\" class=\"mLink\">{1}</a>",
                Eval("HID"), Eval("CompanyName"), Common.clsUser.uID);
        }
        protected string gNote()
        {
            return string.Format("<a onclick=\"javascript:xPopup('CustFU_Log.aspx?AppCode=RFQ&HID={0}&cNm={1}&vLog=1'); return false;\" class=\"mLink\">View</a>", Eval("HID"), Eval("CompanyName"));
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("pEdit"))
            {
                GridViewRow Rw = (e.CommandSource as Control).NamingContainer as GridViewRow;
                txtRFQ.Text = (Rw.FindControl("lnkRFQ") as LinkButton).Text;
                hfHID.Value = gvFoURecd.DataKeys[Rw.RowIndex].Value.ToString();
                mpeRFQ.Show();
            }
            else if (e.CommandName.Equals("uploadRFQ"))
            {
                int LnkID = Convert.ToInt32(e.CommandArgument), GrpID = Convert.ToInt32(myBiz.Tools.clsUtils.myUtil.AppSetting("CustFURFQ"));
                lnkRefresh.CommandArgument = string.Format("{0}:{1}", LnkID, GrpID);
                myBiz.DAL.clsFile.Show(Page, pnlPopup, "UL", "Upload RFQ", Page.ClientScript.GetPostBackClientHyperlink(lnkRefresh, string.Empty), GrpID, LnkID, string.Empty);
            }
            else if (e.CommandName.Contains("viewRFQ"))
            {
                int LnkID = Convert.ToInt32(e.CommandArgument), GrpID = Convert.ToInt32(myBiz.Tools.clsUtils.myUtil.AppSetting("CustFURFQ"));
                myBiz.DAL.clsFile.Show(Page, e.CommandName.Equals("viewRFQ") ? pnlPopup : pnlUpload, "DL", "View RFQ", string.Empty, GrpID, LnkID, string.Empty);
            }
        }
        protected void doRefresh(object sender, EventArgs e)
        {
            var v = lnkRefresh.CommandArgument.Split(':');
            (new myBiz.DAL.clsCustFU()).CustFU_Status_U(v[0], v[1]);
            odsFoURecd.DataBind(); gvFoURecd.DataBind();
        }
        protected void saveRFQ(object sender, EventArgs e)
        {
            (new myBiz.DAL.clsCustFU()).CustFU_SaveRFQ(hfHID.Value, txtRFQ.Text);
            odsFoURecd.DataBind(); gvFoURecd.DataBind();
        }
        protected void doReady(object sender, EventArgs e)
        {
            var isReady = (sender as Button).ID.Equals("btnReady");
            GridView iGV = isReady ? gvFoURecd : gvReady; int Cnt = iGV.Rows.Count;

            System.Text.StringBuilder x = new System.Text.StringBuilder();
            for (int i = 0; i < Cnt; i++)
            {
                GridViewRow Rw = iGV.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    x.Append(string.Format("{0}:", iGV.DataKeys[i].Value));
            }

            if (x.Length > 0)
            {
                (new myBiz.DAL.clsCustFU()).CustFU_ReadyRFQ(x.ToString(), isReady ? "Ready" : "Uploaded");
                gvFoURecd.DataBind(); gvReady.DataBind();
            }
        }
        protected override void enforceSecurity()
        {
        }
    }
}