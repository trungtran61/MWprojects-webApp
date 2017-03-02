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
    public partial class ucCommContact : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (iSec.Count < 1) { iSec.Add("loadSec", true); this.myEvent(iSec); }
        }
        protected void sContact(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(CompanyID))
            {
                odsContact.UpdateParameters["HID"].DefaultValue = hfHID.Value;
                odsContact.UpdateParameters["CompanyID"].DefaultValue = CompanyID;
                odsContact.UpdateParameters["Dept"].DefaultValue = txtDept.Text.Trim();
                odsContact.UpdateParameters["FirstName"].DefaultValue = txtFirstName.Text.Trim();
                odsContact.UpdateParameters["LastName"].DefaultValue = txtLastName.Text.Trim();
                odsContact.UpdateParameters["MiddleName"].DefaultValue = txtMiddleName.Text.Trim();
                odsContact.UpdateParameters["Phone"].DefaultValue = txtPhone.Text.Trim();
                odsContact.UpdateParameters["Fax"].DefaultValue = txtFax.Text.Trim();
                odsContact.UpdateParameters["Cell"].DefaultValue = txtCell.Text.Trim();
                odsContact.UpdateParameters["TollFree"].DefaultValue = txtTollFree.Text.Trim();
                odsContact.UpdateParameters["Email"].DefaultValue = txtEmail.Text.Trim();
                odsContact.Update(); clearForm();
            }
        }
        private void clearForm()
        {
            hfHID.Value = "0";
            txtFirstName.Text = txtLastName.Text = txtMiddleName.Text = txtDept.Text = string.Empty;
            txtPhone.Text = txtFax.Text = txtCell.Text = txtTollFree.Text = txtEmail.Text = string.Empty;
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("pEdit"))
            {
                int i = Convert.ToInt32(e.CommandArgument); GridViewRow Rw = gvContact.Rows[i];
                hfHID.Value = gvContact.DataKeys[i].Value.ToString();
                txtFirstName.Text = (Rw.FindControl("lnkSelect") as LinkButton).Text;
                txtLastName.Text = clsSpace(Rw.Cells[2].Text);
                txtMiddleName.Text = clsSpace(Rw.Cells[3].Text);
                txtDept.Text = clsSpace(Rw.Cells[4].Text);
                txtPhone.Text = clsSpace(Rw.Cells[5].Text);
                txtFax.Text = clsSpace(Rw.Cells[6].Text);
                txtCell.Text = clsSpace(Rw.Cells[7].Text);
                txtTollFree.Text = clsSpace(Rw.Cells[8].Text);
                txtEmail.Text = clsSpace(Rw.Cells[9].Text);
                mpeNewContact.Show();
            }
            if (!e.CommandName.Equals("Select"))
            {
                gvContact.SelectedIndex = -1;
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
                btn.Visible = isYN("k10");
                if (btn.Visible) btn.CommandArgument = e.Row.RowIndex.ToString();
            }
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            lnkNewContact.Enabled = isYN("k11");
        }
        protected void gvSelected(object sender, EventArgs e)
        {
            Hashtable h = new Hashtable();
            h.Add("ContactID", gvContact.SelectedIndex < 0 ? 0 : gvContact.SelectedDataKey.Value);
            myEvent(h);
        }
        protected void lMore(object sender, EventArgs e)
        {
            string isMore = lnkMoreContact.Text.Equals("View All") ? "true" : "false";
            odsContact.SelectParameters["isMore"].DefaultValue = isMore;
            odsContact.DataBind(); gvContact.DataBind();
            lnkMoreContact.Text = isMore.Equals("true") ? "View Selected" : "View All";
            gvContact.SelectedIndex = -1; gvSelected(null, null);
        }
        protected void lNew(object sender, EventArgs e)
        {
            clearForm();
            mpeNewContact.Show();
        }
        public int ContactID { get { return gvContact.SelectedIndex < 0 ? 0 : Convert.ToInt32(gvContact.SelectedDataKey.Value); } }
        public string CompanyID
        {
            set { setParameter("CompanyID", value); }
            get { return odsContact.SelectParameters["CompanyID"].DefaultValue; }
        }
        public string ClassID { set { setParameter("ClassID", value); } }
        public string TypeID { set { setParameter("TypeID", value); } }
        public bool isVisible
        {
            get
            {
                string ClassID = odsContact.SelectParameters["ClassID"].DefaultValue;
                string CompanyID = odsContact.SelectParameters["CompanyID"].DefaultValue;
                return isValid(ClassID) && isValid(CompanyID);
            }
        }
        public bool isMore
        {
            set
            {
                odsContact.SelectParameters["isMore"].DefaultValue = value.ToString();
                lnkMoreContact.Text = value ? "View Selected" : "View All";
            }
        }
        private bool isValid(string key)
        {
            return !string.IsNullOrEmpty(key) && Convert.ToInt32(key) > 0;
        }

        private void setParameter(string key, string val)
        {
            odsContact.SelectParameters[key].DefaultValue = val;
            gvContact.SelectedIndex = -1; gvSelected(null, null);
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