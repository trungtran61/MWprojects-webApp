using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class GageTrak : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/GageTrak Management"))
            {
                hfToken.Value = Util.AppSetting("Token");
                hfChannel.Value = Util.AppSetting("Channel");
                hfApiListUrl.Value = string.Format(Util.AppSetting("ApiUrl"), "List/GetAutoList");
            }
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1)
            {
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
                {
                    e.Row.FindControl("lnkEdit").Visible = isYN("k01");
                }
                else if (e.Row.RowState.ToString().Contains("Edit"))
                {
                    (e.Row.FindControl("txtGrpNum") as TextBox).Enabled = isYN("k09");
                    (e.Row.FindControl("ddlGrad") as DropDownList).Enabled = isYN("k02");
                    (e.Row.FindControl("ddlLow") as DropDownList).Enabled = isYN("k03");
                    (e.Row.FindControl("ddlHigh") as DropDownList).Enabled = isYN("k04");
                    (e.Row.FindControl("lbxCheck") as ListBox).Enabled = isYN("k05");
                    (e.Row.FindControl("txtOwner") as TextBox).Enabled = isYN("k06");
                    (e.Row.FindControl("ddlIntLoc") as DropDownList).Enabled = isYN("k07");
                    (e.Row.FindControl("ddlExtLoc") as DropDownList).Enabled = isYN("k08");
                    (e.Row.FindControl("txtQty") as TextBox).Enabled = isYN("k10");

                    string v = (e.Row.FindControl("hfCheck") as HiddenField).Value;
                    ListBox ddl = e.Row.FindControl("lbxCheck") as ListBox;
                    foreach (ListItem item in ddl.Items)
                    {
                        item.Selected = !string.IsNullOrEmpty(item.Value) && v.Contains(item.Value);
                    }
                }
            }
        }
        protected string gDD(string k)
        {
            try
            {
                var DD = Convert.ToDateTime(Eval(k));
                var fColor = DateTime.Compare(DD, DateTime.Today) > 0 ? string.Empty : " style=\"color:Red;\"";
                return string.Format("<span{0}>{1}</span>", fColor, DD.ToString("MM/dd/yyyy"));
            }
            catch
            {
                return "No Date";
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Edit GageTrak");
            PageSec.Add("k02", "Edit Graduation");
            PageSec.Add("k03", "Edit Low Limit");
            PageSec.Add("k04", "Edit High Limit");
            PageSec.Add("k05", "Edit Checking Method");
            PageSec.Add("k06", "Edit Owner");
            PageSec.Add("k07", "Edit Internal Location");
            PageSec.Add("k08", "Edit External Location");
            PageSec.Add("k09", "Edit Gage Group Number");
            PageSec.Add("k10", "Edit Qty");
        }

        protected void rwUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string intLocID = (gvGageTrak.Rows[e.RowIndex].FindControl("ddlIntLoc") as DropDownList).SelectedValue;
            string extLocID = (gvGageTrak.Rows[e.RowIndex].FindControl("ddlExtLoc") as DropDownList).SelectedValue;

            e.NewValues["IntLocID"] = intLocID;
            e.NewValues["ExtLocID"] = extLocID;

            ListBox ddl = gvGageTrak.Rows[e.RowIndex].FindControl("lbxCheck") as ListBox;
            int[] idx = ddl.GetSelectedIndices();

            List<string> vals = new List<string>();
            foreach (int i in idx)
            {
                vals.Add(ddl.Items[i].Value);
            }

            e.NewValues["CheckingMethod"] = string.Join(";", vals.ToArray());
        }
        protected void clickSearch(object sender, EventArgs e)
        {
            odsGageTrak.SelectParameters["isSearch"].DefaultValue = "True";
        }
    }
}