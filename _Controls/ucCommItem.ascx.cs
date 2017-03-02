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
    public partial class ucCommItem : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (iSec.Count < 1) { iSec.Add("loadSec", true); this.myEvent(iSec); }
        }
        protected void gvItemCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {
                odsItem.UpdateParameters["Item"].DefaultValue = ((TextBox)gvItem.FooterRow.FindControl("txtItem")).Text.Trim();
                odsItem.Update();
            }
            if (!e.CommandName.Equals("Select"))
            {
                gvItem.SelectedIndex = -1;
            }
        }
        protected void lMore(object sender, EventArgs e)
        {
            string isMore = lnkMoreItem.Text.Equals("View All") ? "true" : "false";
            odsItem.SelectParameters["isMore"].DefaultValue = isMore;
            odsItem.DataBind(); gvItem.DataBind();
            lnkMoreItem.Text = isMore.Equals("true") ? "View Selected" : "View All";
            gvItem.SelectedIndex = -1;
        }
        public int ItemID { get { return gvItem.SelectedIndex < 0 ? 0 : Convert.ToInt32(gvItem.SelectedDataKey.Value); } }

        public string CompanyID { set { setParameter("CompanyID", value); } }
        public string ClassID { set { setParameter("ClassID", value); } }
        public string TypeID { set { setParameter("TypeID", value); } }
        public string ContactID { set { setParameter("ContactID", value); } }
        public string AddressID { set { setParameter("AddressID", value); } }
        public bool isVisible
        {
            get
            {
                string ClassID = odsItem.SelectParameters["ClassID"].DefaultValue;
                string CompanyID = odsItem.SelectParameters["CompanyID"].DefaultValue;
                string TypeID = odsItem.SelectParameters["TypeID"].DefaultValue;
                string ContactID = odsItem.SelectParameters["ContactID"].DefaultValue;
                string AddressID = odsItem.SelectParameters["AddressID"].DefaultValue;
                return isValid(ClassID) && isValid(CompanyID) && isValid(TypeID) && isValid(ContactID) && isValid(AddressID);
            }
        }
        private bool isValid(string key)
        {
            return !string.IsNullOrEmpty(key) && Convert.ToInt32(key) > 0;
        }

        private void setParameter(string key, string val)
        {
            odsItem.SelectParameters[key].DefaultValue = val;
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            gvItem.ShowFooter = isYN("k15");
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1 && (e.Row.RowState == DataControlRowState.Alternate || e.Row.RowState == DataControlRowState.Normal))
            {
                (e.Row.FindControl("btnEdit")).Visible = isYN("k14");
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