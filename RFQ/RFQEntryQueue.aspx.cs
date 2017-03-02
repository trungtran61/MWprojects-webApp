using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webApp.Common;
using myBiz.DAL;

namespace webApp.RFQ
{
    public partial class RFQEntryQueue : pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("RFQ/RFQ Entry Queue");
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            bool isReady = (sender as GridView).ID.Equals("gvReady");
            if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList ddl = e.Row.FindControl(isReady ? "ddlReadyDisplay" : "ddlRFQEnteredDisplay") as DropDownList;
                ddl.SelectedIndex = isReady ? ReadyIndex : EnteredIndex;
            }
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("viewRFQ"))
            {
                string[] v = e.CommandArgument.ToString().Split(':');
                int LnkID = Convert.ToInt32(v[0]), GrpID = Convert.ToInt32(myBiz.Tools.clsUtils.myUtil.AppSetting(string.Format("{0}RFQ", v[1])));
                myBiz.DAL.clsFile.Show(Page, pnlPopup, "DL", "View RFQ", string.Empty, GrpID, LnkID, string.Empty);
            }
        }
        protected void doEntering(object sender, EventArgs e)
        {
            var isEntered = (sender as Button).ID.Equals("btnEnter");
            GridView iGV = isEntered ? gvReady : gvRFQEntered; int Cnt = iGV.Rows.Count;

            System.Text.StringBuilder x = new System.Text.StringBuilder();
            System.Text.StringBuilder y = new System.Text.StringBuilder();

            for (int i = 0; i < Cnt; i++)
            {
                GridViewRow Rw = iGV.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                {
                    if (iGV.DataKeys[i].Values["CustType"].ToString().Equals("CustFU"))
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
                if (x.Length > 0) (new clsCustFU()).CustFU_EnterRFQ(Common.clsUser.uID, x.ToString(), isEntered ? "Entered RFQ" : "RFQ Ready");
                if (y.Length > 0) (new clsPoCustFU()).PoCustFU_EnterRFQ(Common.clsUser.uID, y.ToString(), isEntered ? "Entered RFQ" : "RFQ Ready");
                gvReady.DataBind(); gvRFQEntered.DataBind();
            }
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl.ID.Equals("ddlRFQRecdDisplay"))
            {
                gvReady.PageSize = Convert.ToInt32(ddl.SelectedValue);
                ReadyIndex = ddl.SelectedIndex;
            }
            else if (ddl.ID.Equals("ddlRFQEnteredDisplay"))
            {
                gvRFQEntered.PageSize = Convert.ToInt32(ddl.SelectedValue);
                EnteredIndex = ddl.SelectedIndex;
            }
        }
        private int ReadyIndex
        {
            get { return ViewState["ReadyIndex"] != null ? Convert.ToInt32(ViewState["ReadyIndex"]) : 0; }
            set { ViewState["ReadyIndex"] = value; }
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
        protected string gNote()
        {
            return string.Format("<a onclick=\"javascript:xPopup('{2}_Log.aspx?AppCode=RFQ&HID={0}&cNm={1}&vLog=1'); return false;\" class=\"mLink\">View</a>", Eval("HID"), Eval("CompanyName"), Eval("CustType"));
        }
        protected override void enforceSecurity()
        {
        }
    }
}