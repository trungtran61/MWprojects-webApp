using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class childWindow : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e) { MPE.Show(); }
        public void setInfo(Hashtable h)
        {
            if (h.Contains("ForeColor") && !string.Empty.Equals(h["ForeColor"])) trTitle.ForeColor = System.Drawing.ColorTranslator.FromHtml(h["ForeColor"].ToString());
            if (h.Contains("BackColor") && !string.Empty.Equals(h["BackColor"])) trTitle.BackColor = System.Drawing.ColorTranslator.FromHtml(h["BackColor"].ToString());
            if (h.Contains("Refresh")) imgClose.OnClientClick = h["Refresh"].ToString();
            litTitle.Text = h.Contains("Title") ? h["Title"].ToString() : string.Empty;
            tblPopup.Width = h.Contains("Width") ? Unit.Pixel(Convert.ToInt32(h["Width"])) : Unit.Percentage(99);
            tblPopup.Height = h.Contains("Height") ? Unit.Pixel(Convert.ToInt32(h["Height"])) : Unit.Pixel(500);

            if (h.Contains("URL"))
            {
                litURL.Text = string.Format("<iframe style=\"width:100%; height:100%\" src=\"{0}\" scrolling=\"yes\" frameborder=\"0\"></iframe>", h["URL"]);
            }
            else litURL.Text = "<b>I don't know what to do here.</b>";
        }
    }
}