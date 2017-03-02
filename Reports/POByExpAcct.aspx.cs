using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Reports
{
    public partial class POByExpAcct : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Report/PO By Expense Account");
            System.Threading.Thread.CurrentThread.CurrentCulture = new Common.clsCulture();
        }
        protected string gVdrName()
        {
            var vdrTerm = Eval("VdrTerm").ToString();
            var name = "<span title=\"{0}\">{1}{2}</span>";
            return string.Format(name, vdrTerm, Convert.ToBoolean(Eval("hasCCR")) ? "<span style=\"color:blue;\">&copy;</span> " : string.Empty, Eval("VendorName"));
        }
        protected override void enforceSecurity()
        {
        }
    }
}