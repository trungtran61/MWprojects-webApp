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

namespace webApp._Controls
{
    public partial class PartInfo : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) this.Visible = PartID > 0;
        }
        protected string showImage()
        {
            return string.Format("~/File/ShowImage.aspx?FileID={0}&fd={1}", Eval("HID"), DateTime.Now.Ticks);
        }
        protected void iniFiles(object sender, EventArgs e)
        {
            odsFiles.SelectParameters["GrpID"].DefaultValue = Common.clsUser.Util.AppSetting("PartPicture");
        }
        protected void dlCmd(object sender, DataListCommandEventArgs e)
        {
            if (e.CommandName.Equals("Delete"))
            {
                iMsg.ShowMsg("Thank you! Your image has been deleted.", true);
                string[] v = e.CommandArgument.ToString().Split(':');
                odsFiles.DeleteParameters["HID"].DefaultValue = v[0];
                odsFiles.DeleteParameters["Ext"].DefaultValue = v[1];
                odsFiles.Delete();
            }
        }
        public int PartID
        {
            set
            {
                this.Visible = value > 0;
                hfPartID.Value = value.ToString();
                odsFiles.DataBind(); dlPartInfo.DataBind();
            }
            get
            {
                return Convert.ToInt32(hfPartID.Value);
            }
        }
        public string PN { set { litPN.Text = value; } }
        public string RV { set { litRV.Text = value; } }
        public string PartName { set { litPartName.Text = value; } }
        protected void doUpload(object sender, EventArgs e)
        {
            int GrpID = Convert.ToInt32(Common.clsUser.Util.AppSetting("PartPicture"));
            myBiz.DAL.clsFile.Show(Page, pnlPopup, "UL", "Picture of Part", string.Empty, GrpID, PartID, string.Empty);
        }
        protected void doCopy(object sender, EventArgs e)
        {
            Hashtable h = new Hashtable(); h.Add("Title", "Transfer Images");
            h.Add("URL", string.Format("../File/ShowImage.aspx?PN={0}&RV={1}&gID={2}&lID={3}", litPN.Text, litRV.Text, Common.clsUser.Util.AppSetting("PartPicture"), hfPartID.Value));

            Common.clsUser.Util.newWindow(Page, pnlPopup, h);
        }
        public bool isUpload { set { btnUpload.Visible = value; } }
        public bool isDelete
        {
            set { hfIsDelete.Value = value.ToString(); }
            get { return Convert.ToBoolean(hfIsDelete.Value); }
        }
    }
}