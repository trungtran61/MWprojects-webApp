using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webApp.Common;

namespace webApp.WIP
{
    public partial class CustomerReturnCar : pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("WIP/MW Internal Corrective"))
            {
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Edit Product Page");
            PageSec.Add("k02", "Edit Problem Analysis");
            PageSec.Add("k03", "Edit Direct Cause");
        }

        protected void fvBound(object sender, EventArgs e)
        {
            if (fvCar.CurrentMode == FormViewMode.Edit)
            {
                (fvCar.FindControl("txtProblemAnalysis") as TextBox).Enabled = isYN("k02");
                (fvCar.FindControl("txtDirectCause") as TextBox).Enabled = isYN("k03");
            }
            else if (fvCar.CurrentMode == FormViewMode.ReadOnly)
            {
                (fvCar.FindControl("btnEdit") as Button).Enabled = isYN("k01");
            }
        }

        protected void fvCmd(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Update"))
            {
                iMsg.ShowMsg("Thank you! Data has been saved.", true);
            }
        }
    }
}