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
    public partial class ucCommAddress : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (iSec.Count < 1) { iSec.Add("loadSec", true); this.myEvent(iSec); }
        }
        protected void sAddress(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(CompanyID))
            {
                odsAddress.UpdateParameters["HID"].DefaultValue = hfHID.Value;
                odsAddress.UpdateParameters["CompanyID"].DefaultValue = CompanyID;
                odsAddress.UpdateParameters["Address1"].DefaultValue = txtAddress1.Text.Trim();
                odsAddress.UpdateParameters["Address2"].DefaultValue = txtAddress2.Text.Trim();
                odsAddress.UpdateParameters["City"].DefaultValue = txtCity.Text.Trim();
                odsAddress.UpdateParameters["State"].DefaultValue = txtState.Text.Trim();
                odsAddress.UpdateParameters["Zip"].DefaultValue = txtZip.Text.Trim();
                odsAddress.UpdateParameters["Country"].DefaultValue = txtCountry.Text.Trim();
                odsAddress.UpdateParameters["Website"].DefaultValue = txtWebsite.Text.Trim();
                odsAddress.Update(); clearForm();
            }
        }
        private void clearForm()
        {
            hfHID.Value = "0";
            txtAddress1.Text = txtAddress2.Text = txtCity.Text = txtState.Text = string.Empty;
            txtZip.Text = txtCountry.Text = txtWebsite.Text = string.Empty;
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("pEdit"))
            {
                int i = Convert.ToInt32(e.CommandArgument); GridViewRow Rw = gvAddress.Rows[i];
                hfHID.Value = gvAddress.DataKeys[i].Value.ToString();
                txtAddress1.Text = (Rw.FindControl("lnkSelect") as LinkButton).Text;
                txtAddress2.Text = clsSpace(Rw.Cells[2].Text);
                txtCity.Text = clsSpace(Rw.Cells[3].Text);
                txtState.Text = clsSpace(Rw.Cells[4].Text);
                txtZip.Text = clsSpace(Rw.Cells[5].Text);
                txtCountry.Text = clsSpace(Rw.Cells[6].Text);
                txtWebsite.Text = clsSpace(Rw.Cells[7].Text);
                mpeNewAddress.Show();
            }

            if (!e.CommandName.Equals("Select"))
            {
                gvAddress.SelectedIndex = -1;
                gvSelected(sender, e);
            }
        }
        private string clsSpace(string x)
        {
            return x.Equals("&nbsp;") ? string.Empty : x;
        }
        protected void gvBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1 && (e.Row.RowState == DataControlRowState.Alternate || e.Row.RowState == DataControlRowState.Normal))
            {
                Button btn = e.Row.FindControl("btnEdit") as Button;
                btn.Visible = isYN("k12");
                if (btn.Visible) btn.CommandArgument = e.Row.RowIndex.ToString();
            }
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            lnkNewAddress.Enabled = isYN("k13");
        }
        protected void gvSelected(object sender, EventArgs e)
        {
            Hashtable h = new Hashtable();
            h.Add("AddressID", gvAddress.SelectedIndex < 0 ? 0 : gvAddress.SelectedDataKey.Value);
            myEvent(h);
        }
        protected void lMore(object sender, EventArgs e)
        {
            string isMore = lnkMoreAddress.Text.Equals("View All") ? "true" : "false";
            odsAddress.SelectParameters["isMore"].DefaultValue = isMore;
            odsAddress.DataBind(); gvAddress.DataBind();
            lnkMoreAddress.Text = isMore.Equals("true") ? "View Selected" : "View All";
            gvAddress.SelectedIndex = -1; gvSelected(null, null);
        }
        protected void lNew(object sender, EventArgs e)
        {
            clearForm();
            mpeNewAddress.Show();
        }
        public int AddressID { get { return gvAddress.SelectedIndex < 0 ? 0 : Convert.ToInt32(gvAddress.SelectedDataKey.Value); } }
        public string CompanyID
        {
            set { setParameter("CompanyID", value); }
            get { return odsAddress.SelectParameters["CompanyID"].DefaultValue; }
        }
        public string ClassID { set { setParameter("ClassID", value); } }
        public string TypeID { set { setParameter("TypeID", value); } }
        public string ContactID { set { setParameter("ContactID", value); } }
        public bool isVisible
        {
            get
            {
                string ClassID = odsAddress.SelectParameters["ClassID"].DefaultValue;
                string CompanyID = odsAddress.SelectParameters["CompanyID"].DefaultValue;
                string TypeID = odsAddress.SelectParameters["TypeID"].DefaultValue;
                string ContactID = odsAddress.SelectParameters["ContactID"].DefaultValue;
                return isValid(ClassID) && isValid(CompanyID);
            }
        }
        public bool isMore
        {
            set
            {
                odsAddress.SelectParameters["isMore"].DefaultValue = value.ToString();
                lnkMoreAddress.Text = value ? "View Selected" : "View All";
            }
        }
        private bool isValid(string key)
        {
            return !string.IsNullOrEmpty(key) && Convert.ToInt32(key) > 0;
        }

        private void setParameter(string key, string val)
        {
            odsAddress.SelectParameters[key].DefaultValue = val;
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