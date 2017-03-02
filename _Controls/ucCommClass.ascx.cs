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
    public partial class ucCommClass : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (iSec.Count < 1) { iSec.Add("loadSec", true); this.myEvent(iSec); }
        }
        protected void gvClassCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {
                odsClass.UpdateParameters["ClassName"].DefaultValue = ((TextBox)gvClass.FooterRow.FindControl("txtClassName")).Text.Trim();
                odsClass.Update();
            }

            if (!e.CommandName.Equals("Select"))
            {
                gvClass.SelectedIndex = -1;
                gvSelected(sender, e);
            }
        }
        protected void gvSelected(object sender, EventArgs e)
        {
            Hashtable h = new Hashtable();
            h.Add("ClassID", gvClass.SelectedIndex < 0 ? 0 : gvClass.SelectedDataKey.Value);
            myEvent(h);
        }
        public int ClassID { get { return gvClass.SelectedIndex < 0 ? 0 : Convert.ToInt32(gvClass.SelectedDataKey.Value); } }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            gvClass.ShowFooter = isYN("k04");
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && !e.Row.RowState.ToString().EndsWith("Edit"))
            {
                switch ((e.Row.FindControl("lnkSelect") as LinkButton).Text)
                {
                    case "Customer": e.Row.Visible = isYN("k05"); break;
                    case "Supplier": e.Row.Visible = isYN("k06"); break;
                    case "Owner": e.Row.Visible = isYN("k07"); break;
                }
                if (e.Row.Visible) (e.Row.FindControl("btnEdit")).Visible = isYN("k03");
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