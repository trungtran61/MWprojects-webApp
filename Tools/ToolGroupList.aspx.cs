using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class ToolGroupList : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Find Vendor") && !IsPostBack)
            {
                doSearch(sender, e);
            }
        }

        protected string gLnk()
        {
            string lnk = Eval("ToolGroupNum").ToString();

            if (isYN("k01"))
            {
                var bgColor = Convert.ToBoolean(Eval("isSent")) ? " style=\"background:#58FA58;\"" : string.Empty;
                lnk = string.Format("<span{3}><a href=\"javascript:xPopup('../File/sendEmail.aspx?AppCode={0}&FID=ToolGroup&HID={1}&Code=ToolGroup');\">{2}</a></span>", AppCode, Eval("HID"), Eval("ToolGroupNum"), bgColor);
            }

            return lnk;
        }
        protected void doSearch(object sender, EventArgs e)
        {
            var tgn = string.IsNullOrEmpty(txtTGN.Text) ? 0 : Convert.ToInt32(txtTGN.Text);
            var x = (new myBiz.DAL.clsToolInventory()).ToolGroupList_Count(tgn, txtItemNum.Text, txtVendorName.Text);
            litCount.Text = string.Format("TGN Count: {0}", x);
        }

        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Send Email");
        }
    }
}