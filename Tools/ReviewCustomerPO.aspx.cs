using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webApp.Common;

namespace webApp.Tools
{
    public partial class ReviewCustomerPO : pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Tools/Review Customer POs");
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            bool isNew = (sender as GridView).ID.Equals("gvNew");
            if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList ddl = e.Row.FindControl(isNew ? "ddlNewDisplay" : "ddlReviewedDisplay") as DropDownList;
                ddl.SelectedIndex = isNew ? NewIndex : ReviewedIndex;
            }
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("viewCustomerPO"))
            {
                var v = e.CommandArgument.ToString().Split(':');
                var key = v[1].Equals("FU") ? "CustFURFQ" : "CustomerPOFile";
                int LnkID = Convert.ToInt32(v[0]), GrpID = Convert.ToInt32(myBiz.Tools.clsUtils.myUtil.AppSetting("CustFURFQ"));
                myBiz.DAL.clsFile.Show(Page, pnlPopup, "DL", "View Customer PO", string.Empty, GrpID, LnkID, string.Empty);
            }
        }
        protected void doReviewing(object sender, EventArgs e)
        {
            var isReviewed = (sender as Button).ID.Equals("btnReview");
            GridView iGV = isReviewed ? gvNew : gvReviewed; int Cnt = iGV.Rows.Count;

            System.Text.StringBuilder x = new System.Text.StringBuilder();
            System.Text.StringBuilder y = new System.Text.StringBuilder();

            for (int i = 0; i < Cnt; i++)
            {
                GridViewRow Rw = iGV.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                {
                    if (iGV.DataKeys[i].Values["Code"].ToString().Equals("PO"))
                    {
                        x.Append(string.Format("{0}:", iGV.DataKeys[i].Value));
                    }
                    else
                    {
                        y.Append(string.Format("{0}:", iGV.DataKeys[i].Value));
                    }
                }
            }

            if (x.Length > 0 || y.Length > 0)
            {
                if (x.Length > 0) (new myBiz.DAL.clsFile()).CustomerPO_Review(Common.clsUser.uID, x.ToString(), isReviewed ? "Reviewed" : "New");
                if (y.Length > 0) (new myBiz.DAL.clsCustFU()).CustFU_ReviewPO(Common.clsUser.uID, y.ToString(), isReviewed ? "PO Reviewed" : "PO Ready");
                gvNew.DataBind(); gvReviewed.DataBind();
            }
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl.ID.Equals("ddlNewDisplay"))
            {
                gvNew.PageSize = Convert.ToInt32(ddl.SelectedValue);
                NewIndex = ddl.SelectedIndex;
            }
            else if (ddl.ID.Equals("ddlReviewedDisplay"))
            {
                gvReviewed.PageSize = Convert.ToInt32(ddl.SelectedValue);
                ReviewedIndex = ddl.SelectedIndex;
            }
        }
        private int NewIndex
        {
            get { return ViewState["NewIndex"] != null ? Convert.ToInt32(ViewState["NewIndex"]) : 0; }
            set { ViewState["NewIndex"] = value; }
        }
        private int ReviewedIndex
        {
            get { return ViewState["ReviewedIndex"] != null ? Convert.ToInt32(ViewState["ReviewedIndex"]) : 0; }
            set { ViewState["ReviewedIndex"] = value; }
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
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Complete");
            PageSec.Add("k02", "Undo Complete");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnReview.Visible = isYN("k01");
            btnUndoReview.Visible = isYN("k02");
        }
    }
}