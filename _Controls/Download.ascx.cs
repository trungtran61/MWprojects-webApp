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
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class Download : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["aDel"]) && Request.QueryString["aDel"].Equals("0"))
                AllowDelete = false;
        }
        protected void Rw_Cmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Download")) downloadDoc(e.CommandArgument.ToString());
        }
        protected void downloadDoc(string FileID)
        {
            clsFile mF = new clsFile(); Hashtable h = mF.getDoc(FileID);
            if (h.Contains("errMsg")) litMsg.Text = h["errMsg"].ToString();
            else
            {
                Response.Clear(); Response.ContentType = h["Type"].ToString();
                Response.AddHeader("content-disposition", "attachment; filename=" + h["Name"].ToString());
                Response.BinaryWrite((byte[])h["FileData"]); Response.End();
            }
        }
        protected void gvBound(object sender, EventArgs e)
        {
            if (gvDownload.Rows.Count == 1) (gvDownload.Rows[0].FindControl("lnkDelete") as LinkButton).Visible = false;
        }
        public override void DataBind()
        {
            gvDownload.DataBind();
        }
        public bool AllowDelete
        {
            set { ViewState["AllowDelete"] = value; }
            get { return ViewState["AllowDelete"] == null ? true : Convert.ToBoolean(ViewState["AllowDelete"]); }
        }
    }
}