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
    public partial class InvCount : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) gCmd("View");
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {
                bool isFooter = e.CommandArgument.ToString().Equals("Footer");
                Control Ct = isFooter ? gvInvCnt.FooterRow : gvInvCnt.Controls[0].Controls[0];
                string LocID = ((DropDownList)Ct.FindControl("ddlLocation")).SelectedValue;
                if (!LocID.Equals("-1"))
                {
                    odsInvCnt.UpdateParameters["HID"].DefaultValue = "0";
                    odsInvCnt.UpdateParameters["EnteredBy"].DefaultValue = Common.clsUser.uID;
                    odsInvCnt.UpdateParameters["Qty"].DefaultValue = ((TextBox)Ct.FindControl("txtQty")).Text.Trim();
                    odsInvCnt.UpdateParameters["LocID"].DefaultValue = LocID;
                    odsInvCnt.Update();
                    //if (!isFooter)
                    //{
                    //    int WOID = Convert.ToInt32(IDs[0]);
                    //    int HID = (new clsTraveler()).SaveTraveler(WOID, Profile.uID);
                    //    if (HID > 0) (new clsFile()).Copy(WOID, HID);
                    //}
                }
                else iMsg.ShowErr("Sorry! Location is required.", true);
            }
        }
        protected void gvUpdating(object sender, GridViewUpdateEventArgs e)
        {
            if (e.NewValues["LocID"].ToString().Equals("-1"))
            {
                iMsg.ShowErr("Sorry! Location is required.", true);
                e.Cancel = true;
            }
        }
        protected void gvBound(object sender, EventArgs e)
        {
            DataTable Tb = (new myBiz.DAL.clsPartInv()).Check_Variables(string.Empty, Convert.ToInt32(IDs[0]), string.Empty, string.Empty);
            if (Tb != null && Tb.Rows.Count > 0)
            {
                litaQty.Text = Tb.Rows[0]["Available"].ToString();
                litOnHand.Text = Tb.Rows[0]["OnHand"].ToString();
            }
        }
        protected override void dTask()
        {
            gvInvCnt.Enabled = true;
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            gvInvCnt.Enabled = false;
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = isYN("t05");
        }
    }
}