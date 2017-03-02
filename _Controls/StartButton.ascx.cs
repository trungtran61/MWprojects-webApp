using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace webApp._Controls
{
    public partial class StartButton : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lSec("StartButton/Navigation");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            runSec(mnStart.Items[0]);
        }
        private void lSec(string PageName)
        {
            Hashtable h = new Hashtable();
            buildSec(mnStart.Items[0], mnStart.Items[0].Text, h);
            mnuSec = Common.clsUser.prepareSecurity(PageName, h);
        }
        private void buildSec(MenuItem i, string txt, Hashtable h)
        {
            h.Add(i.Value, txt);
            foreach (MenuItem item in i.ChildItems) buildSec(item, string.Format("{0}/{1}", txt, item.Text), h);
        }

        private void runSec(MenuItem c)
        {
            if (isYN(c.Value))
            {
                var x = c.ChildItems.Cast<MenuItem>().ToList();
                foreach (var y in x) runSec(y);
            }
            else
            {
                MenuItem p = c.Parent;
                if (p != null) p.ChildItems.Remove(c);
                else mnStart.Visible = false;
            }
        }
        protected Hashtable mnuSec
        {
            set { ViewState["mnuSec"] = value; }
            get
            {
                if (ViewState["mnuSec"] == null) ViewState["mnuSec"] = new Hashtable();
                return ViewState["mnuSec"] as Hashtable;
            }
        }

        //check if a person has access to the page or functions of a page
        protected bool isYN(string key) { return mnuSec.ContainsKey(key) && Convert.ToBoolean(mnuSec[key]); }
    }
}