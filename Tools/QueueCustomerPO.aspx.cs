using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webApp.Common;

namespace webApp.Tools
{
    public partial class QueueCustomerPO : pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Tools/New Customer PO");
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            bool isReviewed = (sender as GridView).ID.Equals("gvReviewed");
            if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList ddl = e.Row.FindControl(isReviewed ? "ddlReviewedDisplay" : "ddlEnteredDisplay") as DropDownList;
                ddl.SelectedIndex = isReviewed ? ReviewedIndex : EnteredIndex;
            }
        }
        protected void gvEntered_DataBound(object sender, EventArgs e)
        {
            var chkBox = string.Empty;
            decimal totalVal = 0;

            foreach (GridViewRow rw in gvEntered.Rows)
            {
                CheckBox chk = rw.FindControl("chkItem") as CheckBox;
                var val = Convert.ToDecimal((rw.FindControl("hfDollar") as HiddenField).Value);
                chk.Attributes.Add("onclick", string.Format("javascript:dCnt(this,{0},false);", val));
                chkBox += string.IsNullOrEmpty(chkBox) ? chk.ClientID : string.Format(":{0}", chk.ClientID);
                totalVal += val;
                
            }

            hfChkBox.Value = chkBox;
            hfTotalVal.Value = totalVal.ToString();
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("viewCustomerPO"))
            {
                int LnkID = Convert.ToInt32(e.CommandArgument), GrpID = Convert.ToInt32(myBiz.Tools.clsUtils.myUtil.AppSetting("CustomerPOFile"));
                myBiz.DAL.clsFile.Show(Page, pnlPopup, "DL", "View Customer PO", string.Empty, GrpID, LnkID, string.Empty);
            }
        }
        protected void doEntering(object sender, EventArgs e)
        {
            var isEntered = (sender as Button).ID.Equals("btnEnter");
            GridView iGV = isEntered ? gvReviewed : gvEntered; int Cnt = iGV.Rows.Count;

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
                if (x.Length > 0) (new myBiz.DAL.clsFile()).CustomerPO_Enter(Common.clsUser.uID, x.ToString(), isEntered ? "Entered" : "Reviewed");
                if (y.Length > 0) (new myBiz.DAL.clsCustFU()).CustFU_EnterRFQ(Common.clsUser.uID, y.ToString(), isEntered ? "Entered PO" : "PO Reviewed");
                gvReviewed.DataBind(); gvEntered.DataBind();
            }
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl.ID.Equals("ddlReviewedDisplay"))
            {
                gvReviewed.PageSize = Convert.ToInt32(ddl.SelectedValue);
                ReviewedIndex = ddl.SelectedIndex;
            }
            else if (ddl.ID.Equals("ddlEnteredDisplay"))
            {
                gvEntered.PageSize = Convert.ToInt32(ddl.SelectedValue);
                EnteredIndex = ddl.SelectedIndex;
            }
        }
        private int ReviewedIndex
        {
            get { return ViewState["ReviewedIndex"] != null ? Convert.ToInt32(ViewState["ReviewedIndex"]) : 0; }
            set { ViewState["ReviewedIndex"] = value; }
        }
        private int EnteredIndex
        {
            get { return ViewState["EnteredIndex"] != null ? Convert.ToInt32(ViewState["EnteredIndex"]) : 0; }
            set { ViewState["EnteredIndex"] = value; }
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
            btnEnter.Visible = isYN("k01");
            btnUndoEnter.Visible = isYN("k02");
        }
    }
}