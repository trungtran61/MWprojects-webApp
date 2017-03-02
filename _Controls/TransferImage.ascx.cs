using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class TransferImage : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnTransfer.Visible = dlTrImg.Items.Count > 0;
                litNoRecord.Visible = !btnTransfer.Visible;
            }
        }

        protected void doTransfer(object sender, EventArgs e)
        {
            List<string> Img = new List<string>();
            foreach (DataListItem item in dlTrImg.Items)
                if ((item.FindControl("chkItem") as CheckBox).Checked) Img.Add((item.FindControl("hfFN") as HiddenField).Value.Replace('/', '\\'));

            iMsg.ShowMsg(saveImages(Img), true);
        }

        private string saveImages(List<string> Img)
        {
            if (Img.Count > 0)
            {
                int GrpID = string.IsNullOrEmpty(Request.QueryString["gID"]) ? 1 : Convert.ToInt32(Request.QueryString["gID"]);
                System.Collections.Hashtable x = new System.Collections.Hashtable(); x.Add("UN", Common.clsUser.uID); x.Add("GrpID", GrpID);
                if (!string.IsNullOrEmpty(Request.QueryString["lID"])) x.Add("LnkID", Request.QueryString["lID"]);
                return string.Format("{0} images have been transferred!", (new myBiz.DAL.clsFile()).saveDocs(x, Img));
            }
            else return "No image has been tranferred!";
        }

        public string PN
        {
            get { return hfPN.Value; }
            set { hfPN.Value = value; }
        }
        public string RV
        {
            get { return hfRV.Value; }
            set { hfRV.Value = value; }
        }
    }
}