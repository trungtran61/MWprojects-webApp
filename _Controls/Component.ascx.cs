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

namespace webApp._Controls
{
    public partial class Component : System.Web.UI.UserControl
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            string[] v = Request.QueryString["IDs"].Split(':');
            ViewState["WO"] = Common.clsUser.isWIP ? (new clsWorkOrder()).Select(Convert.ToInt32(v[0]), true).Rows[0] : (new clsRFQ()).Select(Convert.ToInt32(v[0]), true).Rows[0];
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            gvComponent.Visible = ((DataRow)ViewState["WO"])["Parent"].ToString().Equals("0");
            litTitle.Visible = gvComponent.Visible;
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.EmptyDataRow || e.Row.RowType == DataControlRowType.Footer)
            {
                DataRow Rw = (DataRow)ViewState["WO"];
                ((TextBox)e.Row.FindControl("txtPartNumber")).Text = Rw["PartNumber"].ToString();
                ((TextBox)e.Row.FindControl("txtRevision")).Text = Rw["Revision"].ToString();
                ((TextBox)e.Row.FindControl("txtoQty")).Text = Rw["oQty"].ToString();
                ((TextBox)e.Row.FindControl("txtDueDate")).Text = Convert.ToDateTime(Rw["DueDate"]).ToString("MM/dd/yy");
            }
        }
        protected void rwUpdate(object sender, EventArgs e) { }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Control Ct = ((Button)sender).ID.Equals("btnAdd") ? gvComponent.FooterRow : gvComponent.Controls[0].Controls[0];
            string PN = ((TextBox)Ct.FindControl("txtPartNumber")).Text.Trim();
            string RE = ((TextBox)Ct.FindControl("txtRevision")).Text.Trim();
            string Qt = ((TextBox)Ct.FindControl("txtoQty")).Text.Trim();
            string DD = ((TextBox)Ct.FindControl("txtDueDate")).Text.Trim();

            odsComponent.InsertParameters["PartNumber"].DefaultValue = PN;
            odsComponent.InsertParameters["Revision"].DefaultValue = RE;
            odsComponent.InsertParameters["oQty"].DefaultValue = Qt;
            odsComponent.InsertParameters["DueDate"].DefaultValue = DD;
            odsComponent.Insert();
        }
    }
}