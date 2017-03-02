using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class RanChkPrtInv : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Tools/Random Check Part Inventory");
        }
        protected string showImg()
        {
            return string.Format("<img src=\"../App_Themes/{0}.png\" />", Convert.ToInt32(Eval("oQty")) > Convert.ToInt32(Eval("aQty")) ? "ExclamationMark" : "thumbsUp");
        }
        protected override void enforceSecurity()
        {
        }
    }
}