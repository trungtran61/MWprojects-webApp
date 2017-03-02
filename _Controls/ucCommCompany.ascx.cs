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

namespace webApp._Controls
{
    public partial class ucCommCompany : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (iSec.Count < 1) { iSec.Add("loadSec", true); this.myEvent(iSec); }
        }
        protected void aNewCompany(object sender, EventArgs e)
        {
            odsCompany.UpdateParameters["CompanyName"].DefaultValue = txtCompanyName.Text.Trim();
            odsCompany.UpdateParameters["CompanyID"].DefaultValue = txtCompanyID.Text.Trim();
            odsCompany.Update();
        }
        protected void ddlSelected(object sender, EventArgs e)
        {
            gvCompany.SelectedIndex = -1; gvSelected(null, null);
        }
        protected void gvSelected(object sender, EventArgs e)
        {
            Hashtable h = new Hashtable();
            h.Add("CompanyID", gvCompany.SelectedIndex < 0 ? 0 : gvCompany.SelectedDataKey.Value);
            myEvent(h);
        }
        protected void lMore(object sender, EventArgs e)
        {
            string isMore = lnkMoreCompany.Text.Equals("View All") ? "true" : "false";
            odsCompany.SelectParameters["isMore"].DefaultValue = isMore;
            odsCompany.DataBind(); gvCompany.DataBind();
            lnkMoreCompany.Text = isMore.Equals("true") ? "View Selected" : "View All";
            gvCompany.SelectedIndex = -1; gvSelected(null, null);
        }
        public string ClassID
        {
            set
            {
                odsCompany.SelectParameters["ClassID"].DefaultValue = value;
                gvCompany.SelectedIndex = -1; gvSelected(null, null);
            }
        }
        public int CompanyID { get { return gvCompany.SelectedIndex < 0 ? 0 : Convert.ToInt32(gvCompany.SelectedDataKey.Value); } }
        public bool isVisible
        {
            get
            {
                string ClassID = odsCompany.SelectParameters["ClassID"].DefaultValue;
                return !string.IsNullOrEmpty(ClassID) && Convert.ToInt32(ClassID) > 0;
            }
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            lnkNewCompany.Enabled = isYN("k09");
        }
        protected void rwCompanyCmd(object sender, GridViewCommandEventArgs e)
        {
            if (!e.CommandName.Equals("Select"))
            {
                gvCompany.SelectedIndex = -1;
                gvSelected(sender, e);
            }
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1 && (e.Row.RowState == DataControlRowState.Alternate || e.Row.RowState == DataControlRowState.Normal))
            {
                switch ((e.Row.FindControl("hfClassName") as HiddenField).Value)
                {
                    case "Customer": e.Row.Visible = isYN("k05"); break;
                    case "Supplier": e.Row.Visible = isYN("k06"); break;
                    case "Owner": e.Row.Visible = isYN("k07"); break;
                }
                if (e.Row.Visible) (e.Row.FindControl("lnkEdit")).Visible = isYN("k08");
            }
        }
        protected Hashtable iSec
        {
            set { ViewState["iSec"] = value; }
            get
            {
                if (ViewState["iSec"] == null) ViewState["iSec"] = new Hashtable();
                return ViewState["iSec"] as Hashtable;
            }
        }
        protected bool isYN(string key) { return iSec.ContainsKey(key) && Convert.ToBoolean(iSec[key]); }
    }
}