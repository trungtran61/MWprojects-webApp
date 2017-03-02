using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using myBiz.DAL;

namespace webApp.WIP
{
    public partial class CustomerReturnLog : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("WIP/Customer Return Log"))
            {
            }
        }

        protected string gLnk(string code)
        {
            if (code.Equals("HID"))
            {
                return string.Format("<a onclick=\"javascript:lPopup('CustomerReturnProduct.aspx?HID={0}'); return false;\" class=\"mLink\">{0}</a>", Eval("HID"));
            }
            else
            {
                var carID = Convert.ToInt32(Eval("CarID"));
                return carID > 0 ? string.Format("<a onclick=\"javascript:lPopup('CustomerReturnCar.aspx?HID={0}'); return false;\" class=\"mLink\">{1}</a>", Eval("CarID"), Eval("CarNum")) : Eval("CarNum").ToString();
            }
        }

        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("InsertNew") || e.CommandName.Equals("AddNew"))
            {
                var ctrl = e.CommandName.Equals("InsertNew") ? gvCustomerReturnLog.Controls[0].Controls[0] : gvCustomerReturnLog.FooterRow;
                odsCustomerReturnLog.UpdateParameters["HID"].DefaultValue = "0";
                odsCustomerReturnLog.UpdateParameters["ReturnedDate"].DefaultValue = (ctrl.FindControl("txtReturnedDate") as TextBox).Text;
                odsCustomerReturnLog.UpdateParameters["PackID"].DefaultValue = (ctrl.FindControl("ddlPackingList") as DropDownList).SelectedValue;
                odsCustomerReturnLog.UpdateParameters["ScarNum"].DefaultValue = (ctrl.FindControl("txtScarNum") as TextBox).Text;
                odsCustomerReturnLog.UpdateParameters["ReturnedQty"].DefaultValue = (ctrl.FindControl("txtQty") as TextBox).Text;
                odsCustomerReturnLog.Update();
            }
            else if (e.CommandName.Equals("uScar") || e.CommandName.Equals("dScar"))
            {
                int GrpID = Convert.ToInt32(ConfigurationManager.AppSettings["CustScar"]);
                int LnkID = Convert.ToInt32(gvCustomerReturnLog.DataKeys[Convert.ToInt32(e.CommandArgument)].Value);
                DataTable Tb = clsDB.spAdmin_Variables_S("UploadLimitScar");
                string maxLen = Tb != null && Tb.Rows.Count > 0 ? Tb.Rows[0]["iValue"].ToString() : string.Empty;
                clsFile.Show(Page, Master.FindControl("pnlPopup") as Panel, e.CommandName.Equals("uScar") ? "UL" : "DL", "Scar", string.Empty, GrpID, LnkID, maxLen);
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            gvCustomerReturnLog.Columns[0].Visible = isYN("k01");
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Add/Edit Customer Return Log");
        }
    }
}