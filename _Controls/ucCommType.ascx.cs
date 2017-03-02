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
    public partial class ucCommType : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (iSec.Count < 1) { iSec.Add("loadSec", true); this.myEvent(iSec); }
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (!e.CommandName.Equals("Select"))
            {
                gvType.SelectedIndex = -1;
                gvSelected(sender, e);
            }
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1)
            {
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
                {
                    var isBlk = Convert.ToInt32((e.Row.FindControl("hfBlkID") as HiddenField).Value) > 0;
                    (e.Row.FindControl("lnkSelect") as LinkButton).Enabled = !isBlk;
                    var chkBlk = e.Row.FindControl("chkBlk") as CheckBox;
                    chkBlk.Checked = isBlk;
                    (e.Row.FindControl("chkCVT") as CheckBox).Enabled = isYN("k17");
                    (e.Row.FindControl("chkBlk") as CheckBox).Enabled = isYN("k18");
                    //chkBlk.Enabled = isInAct;
                }
            }
        }
        protected void chkChanged(object sender, EventArgs e)
        {
            var Rw = (sender as CheckBox).NamingContainer as GridViewRow;
            var hf = Rw.FindControl("hfBlkID") as HiddenField;

            var xVdr = new myBiz.DAL.clsVendor();
            int HID = xVdr.Vendor_BlkType_Save(Convert.ToInt32(hf.Value), Convert.ToInt32(hfCompanyID.Value), Convert.ToInt32(gvType.DataKeys[Rw.RowIndex].Value));

            hf.Value = HID.ToString();
            (Rw.FindControl("lnkSelect") as LinkButton).Enabled = HID < 1;
        }
        protected void chkChangedCVT(object sender, EventArgs e)
        {
            var Rw = (sender as CheckBox).NamingContainer as GridViewRow;
            var chk = Rw.FindControl("chkCVT") as CheckBox;

            var xVdr = new myBiz.DAL.clsVendor();
            xVdr.Vendor_CVT_Save(Convert.ToInt32(gvType.DataKeys[Rw.RowIndex].Value), chk.Checked);
        }
        protected void gvSelected(object sender, EventArgs e)
        {
            Hashtable h = new Hashtable();
            h.Add("TypeID", gvType.SelectedIndex < 0 ? 0 : gvType.SelectedDataKey.Value);
            myEvent(h);
        }
        protected void lMore(object sender, EventArgs e)
        {
            string isMore = lnkMoreType.Text.Equals("View All") ? "true" : "false";
            odsType.SelectParameters["isMore"].DefaultValue = isMore;
            odsType.DataBind(); gvType.DataBind();
            lnkMoreType.Text = isMore.Equals("true") ? "View Selected" : "View All";
            gvType.SelectedIndex = -1; gvSelected(null, null);
        }

        public int TypeID { get { return gvType.SelectedIndex < 0 ? 0 : Convert.ToInt32(gvType.SelectedDataKey.Value); } }
        public string CompanyID
        {
            set
            {
                hfCompanyID.Value = value;
                setParameter("CompanyID", value);
            }
        }
        public string ClassID { set { setParameter("ClassID", value); } }

        public bool isVisible
        {
            get
            {
                string ClassID = odsType.SelectParameters["ClassID"].DefaultValue;
                string CompanyID = odsType.SelectParameters["CompanyID"].DefaultValue;
                return isValid(ClassID) && isValid(CompanyID);
            }
        }
        public bool isInAct
        {
            get
            {
                return Convert.ToBoolean(hfIsInAct.Value);
            }
            set
            {
                hfIsInAct.Value = value.ToString();
            }
        }
        private bool isValid(string key)
        {
            return !string.IsNullOrEmpty(key) && Convert.ToInt32(key) > 0;
        }
        private void setParameter(string key, string val)
        {
            odsType.SelectParameters[key].DefaultValue = val;
            gvType.SelectedIndex = -1; gvSelected(null, null);
        }
        public Hashtable iSec
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