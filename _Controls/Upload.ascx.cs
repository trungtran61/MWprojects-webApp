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
    public partial class Upload : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;
        private string uID = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!isValid()) { Response.Redirect("../Errors/Invalid.aspx", true); }
        }
        protected void btn_Click(object sender, EventArgs e)
        {
            int GrpID = string.IsNullOrEmpty(Request.QueryString["gID"]) ? 1 : Convert.ToInt32(Request.QueryString["gID"]);
            Hashtable x = new Hashtable(); x.Add("UN", uID); x.Add("GrpID", GrpID);
            if (!string.IsNullOrEmpty(Request.QueryString["lID"])) x.Add("LnkID", Request.QueryString["lID"]);
            if (!string.IsNullOrEmpty(Request.QueryString["maxLen"])) x.Add("maxLen", Request.QueryString["maxLen"]);
            clsFile mF = new clsFile(); int Cnt = mF.saveDocs(Request.Files, x); this.myEvent(new Hashtable());
            if (Cnt == -1 && x.ContainsKey("maxLen")) litMsg.Text = string.Format("<font color=\"red\"><b>This file is over its size limit (Max: {0} kb)", x["maxLen"]);
            else litMsg.Text = string.Format("<font color=\"blue\"><b>Your {0} files have been uploaded successfully<br>at {1}</b></font>", Cnt, DateTime.Now);
        }
        protected bool isValid()
        {
            if (Common.clsUser.isValidated) uID = Common.clsUser.uID;
            else if (!string.IsNullOrEmpty(Request.QueryString["uID"])) uID = Request.QueryString["uID"];
            else uID = string.Empty;
            return !string.IsNullOrEmpty(uID);
        }
    }
}