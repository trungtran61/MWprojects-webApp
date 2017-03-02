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
using System.IO;

namespace webApp._Controls
{
    public partial class BrowseDirectory : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) doLoading(Common.clsUser.Util.AppSetting("rootPath"));
        }
        protected void doLoading(string path)
        {
            lbxList.Items.Clear();
            foreach (string i in Directory.GetDirectories(path)) lbxList.Items.Add(new ListItem(i.Replace(Path.GetDirectoryName(i), string.Empty), i));
            foreach (string j in Directory.GetFiles(path)) lbxList.Items.Add(new ListItem(Path.GetFileName(j), j));
            hfCurrentDirectory.Value = path;
        }
        protected void btnUp_Click(object sender, EventArgs e)
        {
            if (hfCurrentDirectory.Value != Common.clsUser.Util.AppSetting("rootpath"))
            {
                DirectoryInfo df = new DirectoryInfo(hfCurrentDirectory.Value);
                doLoading(df.Parent.FullName);
            }
        }
        protected void btnOpen_Click(object sender, EventArgs e)
        {
            if (lbxList.SelectedIndex > -1)
            {
                string x = lbxList.SelectedValue;
                try { doLoading(x); }
                catch
                {
                    txtFile.Text = x; pnlList.Visible = false;
                    doLoading(hfCurrentDirectory.Value);
                }
            }
        }
        public string FileName { get { return txtFile.Text; } }
        public StreamReader getStreamReader { get { return new StreamReader(txtFile.Text); } }
        protected void btnBrowse_Click(object sender, EventArgs e) { pnlList.Visible = !pnlList.Visible; }
    }
}