using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class Progress : System.Web.UI.UserControl
    {
        protected void mLoad(object sender, EventArgs e)
        {
            ((AjaxControlToolkit.ModalPopupExtender)sender).Show();
        }
        public int DisplayAfter
        {
            get { return uProgress.DisplayAfter; }
            set { uProgress.DisplayAfter = value; }
        }
        public string AssociatedUpdatePanelID
        {
            get { return uProgress.AssociatedUpdatePanelID; }
            set { uProgress.AssociatedUpdatePanelID = value; }
        }
    }
}