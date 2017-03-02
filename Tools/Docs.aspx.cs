using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace webApp.Tools
{
    public partial class Docs : Common.pgAbstract
    {
        protected void Page_Init(object sender, EventArgs e) { hfValx.Value = Request.Form["hfVal"]; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Document") && !IsPostBack)
            {
                gvDocs.ShowFooter = isYN("k01");
                if (Util.isEmpty(gvDocs)) gvDocs.Controls[0].Controls[0].Visible = isYN("k01");
            }
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddEmpty") || e.CommandName.Equals("AddNew"))
            {
                Control Ctrl = e.CommandName.Equals("AddEmpty") ? gvDocs.Controls[0].Controls[0] : gvDocs.FooterRow;
                odsDocs.UpdateParameters["HID"].DefaultValue = "0";
                odsDocs.UpdateParameters["Type"].DefaultValue = (Ctrl.FindControl("ddlDocType") as DropDownList).SelectedValue;
                odsDocs.UpdateParameters["Name"].DefaultValue = (Ctrl.FindControl("txtName") as TextBox).Text.Trim();
                odsDocs.UpdateParameters["Description"].DefaultValue = (Ctrl.FindControl("txtDescription") as TextBox).Text.Trim();
                odsDocs.UpdateParameters["Status"].DefaultValue = (Ctrl.FindControl("ddlDocStatus") as DropDownList).SelectedValue;
                odsDocs.Update();
            }
            else if (e.CommandName.Equals("showFile"))
            {
                string[] v = e.CommandArgument.ToString().Split(':');
                string lRef = v[0].Equals("UL") ? ClientScript.GetPostBackClientHyperlink(lnkRefresh, string.Empty) : string.Empty;
                myBiz.DAL.clsFile.Show(Page, pnlPopup, v[0], "Document", lRef, Convert.ToInt32(ConfigurationManager.AppSettings["Document"]), Convert.ToInt32(v[1]), string.Empty);
            }
        }
        protected void gvBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.RowState == DataControlRowState.Alternate || e.Row.RowState == DataControlRowState.Normal)
                {
                    (e.Row.FindControl("lnkEdit") as LinkButton).Visible = isYN("k02");
                    (e.Row.FindControl("lnkFileU") as LinkButton).Visible = isYN("k03");
                    (e.Row.FindControl("lnkFileD") as LinkButton).Visible = isYN("k04");
                }
            }
        }
        protected void lRefresh(object sender, EventArgs e) { gvDocs.DataBind(); }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "New Document");
            PageSec.Add("k02", "Edit");
            PageSec.Add("k03", "Upload");
            PageSec.Add("k04", "View");
        }
    }
}