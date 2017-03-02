using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class chkInvByLoc : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) doCheck();
        }
        public void doCheck() { this.Visible = LocID > 0; hfUID.Value = Common.clsUser.uID; }
        public int LocID
        {
            set { hfLocID.Value = value.ToString(); doCheck(); }
            get { return Convert.ToInt32(hfLocID.Value); }
        }
        public string PN
        {
            set { hfPN.Value = value; }
            get { return hfPN.Value; }
        }
        public string RV
        {
            set { hfRV.Value = value; }
            get { return hfRV.Value; }
        }
        public string WO
        {
            set { hfWO.Value = value; }
            get { return hfWO.Value; }
        }
    }
}