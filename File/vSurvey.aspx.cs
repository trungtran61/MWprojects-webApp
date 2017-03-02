using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.File
{
    public partial class vSurvey : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gData();
            }
        }

        protected void doSubmit(object sender, EventArgs e)
        {
            string rMsg = mySurvey.SaveData();
            bool isGood = string.IsNullOrWhiteSpace(rMsg);
            iMsg.Text = isGood ? "Thank you for your survey!" : rMsg;
            btnSubmit.Visible = litVendorName.Visible = !isGood;
        }
        protected void gData()
        {
            mySurvey.CertID = !string.IsNullOrEmpty(Request.QueryString["CID"]) ? Request.QueryString["CID"] : "-1";
            mySurvey.VendorID = Request.QueryString["VID"];
            mySurvey.ProcessID = Request.QueryString["PID"];
            litVendorName.Text = mySurvey.VendorName = Request.QueryString["VNM"];
            litSurvey.Text = Request.QueryString["PNM"];
            Page.ClientScript.RegisterStartupScript(this.GetType(), "doCert", string.Format("<script>{0}</script>", mySurvey.isCertClientID));

            if (!mySurvey.CertID.Equals("-1")) btnSubmit.Text = "Save";
        }
    }
}