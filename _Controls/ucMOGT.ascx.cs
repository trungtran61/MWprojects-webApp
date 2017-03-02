using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace webApp._Controls
{
    public partial class ucMOGT : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) setContextKey();
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("useThis"))
            {
                switch (hfMOGT.Value)
                {
                    case "Matl": doMatl(Convert.ToInt32(e.CommandArgument)); break;
                    case "OPS": doOPS(Convert.ToInt32(e.CommandArgument)); break;
                    case "Gage": doGage(Convert.ToInt32(e.CommandArgument)); break;
                    case "Tool": doTool(Convert.ToInt32(e.CommandArgument)); break;
                }
            }
        }
        protected void gvBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
                (e.Row.FindControl("lnkSelect") as LinkButton).CommandArgument = e.Row.RowIndex.ToString();
        }

        protected void mSearch(object sender, EventArgs e)
        {
            Hashtable h = new Hashtable();
            h.Add("KeepOpen", true);
            this.myEvent(h);
        }
        protected void mReset(object sender, EventArgs e)
        {
        }
        protected void oSearch(object sender, EventArgs e)
        {
            Hashtable h = new Hashtable();
            h.Add("KeepOpen", true);
            this.myEvent(h);
        }
        protected void oReset(object sender, EventArgs e)
        {
        }
        protected void gSearch(object sender, EventArgs e)
        {
            //Hashtable h = new Hashtable();
            //h.Add("KeepOpen", true);
            //this.myEvent(h);
        }
        protected void gReset(object sender, EventArgs e)
        {
        }
        protected void tSearch(object sender, EventArgs e)
        {
            Hashtable h = new Hashtable();
            h.Add("KeepOpen", true);
            this.myEvent(h);
        }
        protected void tReset(object sender, EventArgs e)
        {
        }

        private void doMatl(int idx)
        {
            var k = gvMatl.DataKeys[idx];

            Hashtable h = new Hashtable();
            h.Add("MatlTypeID", k.Values["MatlTypeID"]);
            h.Add("MatlAmsID", k.Values["MatlAmsID"]);
            h.Add("MatlFormID", k.Values["MatlFormID"]);
            h.Add("BDID", k.Values["BDID"]);
            this.myEvent(h);
        }
        private void doOPS(int idx)
        {
            var k = gvOPS.DataKeys[idx];
            Hashtable h = new Hashtable();
            h.Add("OPSTypeID", k.Values["OPSTypeID"]);
            h.Add("OPSSpecID", k.Values["OPSSpecID"]);
            h.Add("OPSDescID", k.Values["OPSDescID"]);
            h.Add("BDID", k.Values["BDID"]);
            this.myEvent(h);
        }
        private void doGage(int idx)
        {
            var k = gvGage.DataKeys[idx];
            Hashtable h = new Hashtable();
            h.Add("GTNameID", k.Values["GTNameID"]);
            h.Add("BDID", k.Values["BDID"]);
            this.myEvent(h);
        }
        private void doTool(int idx)
        {
            var k = gvTool.DataKeys[idx];
            Hashtable h = new Hashtable();
            h.Add("GTTypeID", k.Values["GTTypeID"]);
            h.Add("GTNameID", k.Values["GTNameID"]);
            h.Add("BDID", k.Values["BDID"]);
            this.myEvent(h);
        }
        private void setContextKey()
        {
            var aCode = Common.clsUser.AppCode;
            switch (hfMOGT.Value)
            {
                case "Matl":
                    acePONumber.ContextKey = aceRFQNumber.ContextKey = aCode;
                    break;
                case "OPS":
                    aceOPSPONum.ContextKey = aceOPSRFQNum.ContextKey = aCode;
                    break;
                case "Gage":
                    aceGagePONum.ContextKey = aceGageRFQNum.ContextKey = aCode;
                    break;
                case "Tool":
                    aceToolPONum.ContextKey = aceToolRFQNum.ContextKey = aCode;
                    break;
            }
        }
        public string MOGT
        {
            set
            {
                hfMOGT.Value = value;
                uPnlMatl.Visible = value.Equals("Matl");
                uPnlOPS.Visible = value.Equals("OPS");
                uPnlGage.Visible = value.Equals("Gage");
                uPnlTool.Visible = value.Equals("Tool");
            }
        }
    }
}