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
    public partial class PartLabel : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public int PartID
        {
            set
            {
                if (value > 0)
                {
                    DataTable Tb = (new myBiz.DAL.clsPartInv()).getPartImage(value, Common.clsUser.Util.AppSetting("PartPicture"));
                    if (Tb != null && Tb.Rows.Count > 0)
                    {
                        imgFile.ImageUrl = string.Format("~/File/ShowImage.aspx?FileID={0}&fd={1}", Tb.Rows[0]["FileID"], DateTime.Now.Ticks);
                        litPartNumber.Text = Tb.Rows[0]["PartNumber"].ToString();
                        litRevision.Text = Tb.Rows[0]["Revision"].ToString();
                        //this.Visible = true;
                    }
                    //else this.Visible = false;
                }
                //else this.Visible = false;
            }
        }
    }
}