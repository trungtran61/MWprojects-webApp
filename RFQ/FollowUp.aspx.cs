using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webApp.Common;

namespace webApp.RFQ
{
    public partial class FollowUp : pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("RFQ/Follow Up");
        }
        protected string gDD(string k)
        {
            try
            {
                string fColor = string.Empty;
                bool isConfirmed = Eval("Status").ToString().Equals("Confirming");

                switch (Eval("lMode").ToString())
                {
                    case "Late": fColor = " style=\"color:Red;\""; break;
                    case "beLate": fColor = isConfirmed ? string.Empty : " style=\"color:Brown;\""; break;
                    case "Early": fColor = isConfirmed ? string.Empty : " style=\"color:Gray;\""; break;
                }

                DateTime DD = Convert.ToDateTime(Eval(k));
                return string.Format("<span{0}>{1}</span>", fColor, DD.ToString(Util.DD_Format));
            }
            catch
            {
                return "No Date";
            }
        }
        protected string gLnk()
        {
            return string.Format("<a onclick=\"javascript:lPopup('../File/Preview.aspx?AppCode=RFQ&FID=QTE&Code=FinQte&HID={0}&uID={2}'); return false;\" class=\"mLink\">{1}</a>",
                Eval("QTEID"), Eval("QTENumber"), Common.clsUser.uID);
        }
        protected string gNote()
        {
            return string.Format("<a onclick=\"javascript:xPopup('FollowUp_Log.aspx?AppCode=RFQ&HID={0}&qNum={1}&vLog=1'); return false;\" class=\"mLink\">View</a>", Eval("QTEID"), Eval("QTENumber"));
        }
        protected override void enforceSecurity()
        {
        }
    }
}