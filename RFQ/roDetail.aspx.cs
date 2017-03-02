using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.RFQ
{
    public partial class roDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void lblLoad(object sender, EventArgs e)
        {
            (sender as Label).Text = string.Format("Ln# {0}: STEP#{1}: {2}", Request.QueryString["Ln"], Request.QueryString["sNo"], Request.QueryString["sNm"]).ToUpper();
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Select"))
            {
                var Rw = (e.CommandSource as Button).NamingContainer as GridViewRow;
                odsDetail.UpdateParameters["Total"].DefaultValue = Rw.Cells[7].Text.Replace(",", string.Empty).Replace("$", string.Empty);
                odsDetail.UpdateParameters["LeadTime"].DefaultValue = Rw.Cells[8].Text;
                odsDetail.Update();
            }
            else if (e.CommandName.Equals("viewFile"))
            {
                btn_Click("DL", Convert.ToInt32(e.CommandArgument));
            }
        }
        protected void btn_Click(string cmd, int HID)
        {
            var GrpID = Convert.ToInt32(myBiz.Tools.clsUtils.myUtil.AppSetting(string.Format("{0}RFQFileRFQ", Request.QueryString["sNm"].Equals("RIM") ? "Material" : "OPS")));
            myBiz.DAL.clsFile.Show(Page, pnlPopup, cmd, false, "Attachments", string.Empty, GrpID, HID, "500");
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var code = (e.Row.FindControl("hfCode") as HiddenField).Value;
                var yn = Convert.ToBoolean((e.Row.FindControl("hfSelected") as HiddenField).Value);
                if (!yn)
                {
                    switch (code)
                    {
                        case "Maximum": e.Row.BackColor = System.Drawing.Color.LightGreen; break;
                        case "Median": e.Row.BackColor = System.Drawing.Color.Yellow; break;
                        case "Minimum": e.Row.BackColor = System.Drawing.Color.Tomato; break;
                    }
                    
                }
            }
        }

        protected void gvBound(object sender, EventArgs e)
        {
            var r = gvDetail.Rows.Cast<GridViewRow>().FirstOrDefault(x => Convert.ToBoolean((x.FindControl("hfSelected") as HiddenField).Value));
            if (r != null)
            {
                gvDetail.SelectedIndex = r.RowIndex;
            }
        }
    }
}