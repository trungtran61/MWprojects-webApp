using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Telerik.Web.UI;
using myBiz.Tools;

namespace webApp.AdminPanel
{
    public partial class OpHrs : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Operation Hours"))
            {
                if (!IsPostBack) gvOpHrs.ShowFooter = isYN("k01");
            }
        }
        protected void gvBound(object sender, EventArgs e) { gvTotalHrs.DataBind(); }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1 && (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate))
            {
                ((LinkButton)e.Row.FindControl("lnkEdit")).Enabled = isYN("k02");
                ((LinkButton)e.Row.FindControl("lnkDelete")).Enabled = isYN("k03");
            }
        }
        protected void ttBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1 && (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate))
            {
                if (e.Row.Cells[0].Text.Equals("Weekly Total"))
                {
                    e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#507CD1");
                    e.Row.ForeColor = System.Drawing.Color.White;
                }

                //((LinkButton)e.Row.FindControl("lnkEdit")).Enabled = isYN("k02");
                //((LinkButton)e.Row.FindControl("lnkDelete")).Enabled = isYN("k03");
            }
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {
                string DoW = (gvOpHrs.FooterRow.FindControl("ddlDoW") as DropDownList).SelectedValue;
                RadTimePicker sDate = gvOpHrs.FooterRow.FindControl("rtpsDate") as RadTimePicker;
                RadTimePicker eDate = gvOpHrs.FooterRow.FindControl("rtpeDate") as RadTimePicker;
                (new myBiz.DAL.clsOpHrs()).OpHrs_Save(-1, DoW, sDate.SelectedDate.Value, eDate.SelectedDate.Value);
                gvOpHrs.DataBind();
            }
            iMsg.ShowMsg("Thank You! Operation hours have been saved successfully.", true);
        }
        protected string getDuration(string key)
        {
            TimeSpan ts = TimeSpan.FromSeconds(Convert.ToInt32(Eval(key)));
            return string.Format("{0} hrs {1} min<br>\n", (ts.Days * 24) + ts.Hours, ts.Minutes);
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Add");
            PageSec.Add("k02", "Edit");
            PageSec.Add("k03", "Delete");
        }
    }
}