using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp
{
    public partial class gSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected string getLinkData()
        {
            string xURL = string.Empty, xHID = string.Empty;

            if ("WO".Equals(Eval("Type"))) { xURL = "/WIP/Status.aspx"; xHID = Eval("HID").ToString(); }
            else if ("INV".Equals(Eval("Type"))) { xURL = "/Purchasing/AppliedPayment.aspx"; xHID = string.Format("{0}:{1}", Eval("Status"), Eval("HID")); }
            else if ("PO".Equals(Eval("Type")))
            {
                switch (Eval("Status").ToString())
                {
                    case "Open": xURL = "/purchasing/OpenPO.aspx"; break;
                    case "Received": xURL = "/purchasing/RecdPO.aspx"; break;
                    case "Verified": xURL = "/purchasing/VerifiedPO.aspx"; break;
                    case "Billed":
                    case "Billed_Sched":
                    case "Paid": xURL = "/purchasing/BilledPO.aspx"; break;
                } xHID = string.Format("{0}:{1}", Eval("Status"), Eval("HID"));
            }
            else //documents
            {
                xURL = "/Tools/Docs.aspx"; xHID = Eval("HID").ToString();
            }

            string lnk = string.Format("javascript:doLink('{0}','{1}');", xURL, xHID);
            return string.Format("<a onclick=\"{3}\" class=\"Pointer\">{0} | {1} | {2}</a>", Eval("Type"), Eval("Name"), Eval("Status"), lnk);
        }
    }
}