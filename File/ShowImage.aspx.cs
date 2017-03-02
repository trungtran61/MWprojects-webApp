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

namespace webApp.File
{
    public partial class ShowImage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["FileID"]))
            {
                downloadDoc(Request.QueryString["FileID"]);
                prtForm.Visible = false;
            }
            else if (!string.IsNullOrEmpty(Request.QueryString["PrtImg"]))
            {
                PrtLbl.PartID = Convert.ToInt32(Request.QueryString["PrtImg"]);
                prtForm.Visible = true; shipLabel.Visible = false;
            }
            else if (!string.IsNullOrEmpty(Request.QueryString["PackID"]))
            {
                shipLabel.PackingID = Convert.ToInt32(Request.QueryString["PackID"]);
                prtForm.Visible = shipLabel.Visible = true;
                PrtLbl.Visible = false;
            }
            else if (!string.IsNullOrEmpty(Request.QueryString["PN"]) && !string.IsNullOrEmpty(Request.QueryString["RV"]))
            {
                trImage.Visible = true; prtForm.Visible = false;
                trImage.PN = Request.QueryString["PN"];
                trImage.RV = Request.QueryString["RV"];
            }
            else
            {
                prtForm.Visible = PrtLbl.Visible = shipLabel.Visible = false;
            }
        }
        protected void downloadDoc(string FileID)
        {
            myBiz.DAL.clsFile mF = new myBiz.DAL.clsFile(); Hashtable h = mF.getDoc(FileID);
            if (h.Contains("errMsg")) litMsg.Text = h["errMsg"].ToString();
            else
            {
                Response.Clear(); Response.ContentType = h["Type"].ToString();
                Response.AddHeader("content-disposition", "attachment; filename=" + h["Name"].ToString());
                Response.BinaryWrite((byte[])h["FileData"]); Response.End();
            }
        }
    }
}