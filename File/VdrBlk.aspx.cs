using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.File
{
    public partial class VdrBlk : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) lData(!string.IsNullOrEmpty(mID));
        }

        private void lData(bool isGood)
        {
            if (isGood)
            {
                switch (Request.QueryString["MOGT"])
                {
                    case "Matl":
                        ucMatl.Visible = true;
                        ucMatl.mID = mID;
                        ucMatl.VendorID = VendorID;
                        ucMatl.allowEdit = allowEdit;
                        break;
                    case "Gage":
                        ucGage.Visible = true;
                        ucGage.mID = mID;
                        ucGage.VendorID = VendorID;
                        ucGage.allowEdit = allowEdit;
                        break;
                    case "Tool":
                        ucTool.Visible = true;
                        ucTool.mID = mID;
                        ucTool.VendorID = VendorID;
                        ucTool.allowEdit = allowEdit;
                        break;
                    default: litMsg.Visible = true; break;
                }
            }
            else
            {
                litMsg.Visible = true;
                litMsg.Text = "This feature is only available to new data";
            }
        }
        private string mID { get { return Request.QueryString["mID"]; } }
        private string VendorID { get { return Request.QueryString["vID"]; } }
        private bool allowEdit { get { return !string.IsNullOrEmpty(Request.QueryString["aE"]) && Request.QueryString["aE"].Equals("1"); } }
    }
}