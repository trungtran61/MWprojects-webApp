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
    public partial class InvUpdate : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public int WOID { set { hfIDs.Value = string.Format("{0}:1:1:1", value); odsInvCnt.DataBind(); gvInvCnt.DataBind(); } }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {
                Control Ct = e.CommandArgument.ToString().Equals("Footer") ? gvInvCnt.FooterRow : gvInvCnt.Controls[0].Controls[0];
                string LocID = ((DropDownList)Ct.FindControl("ddlLocation")).SelectedValue;
                if (!LocID.Equals("-1"))
                {
                    odsInvCnt.UpdateParameters["HID"].DefaultValue = "0";
                    odsInvCnt.UpdateParameters["EnteredBy"].DefaultValue = Common.clsUser.uID;
                    odsInvCnt.UpdateParameters["Qty"].DefaultValue = ((TextBox)Ct.FindControl("txtQty")).Text.Trim();
                    odsInvCnt.UpdateParameters["LocID"].DefaultValue = LocID;
                    odsInvCnt.Update();
                }
                else iMsg.ShowErr("Sorry! Location is required.", true);
            }

            LocOnly = e.CommandName.Equals("Edit") && e.CommandArgument.ToString().Equals("LocOnly");
            if (e.CommandName.Equals("AddNew") || e.CommandName.Equals("Update")) this.myEvent(new Hashtable());
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1)
            {
                int iQty = Convert.ToInt32((e.Row.FindControl("litiQty") as Literal).Text);
                litTotal.Text = ((e.Row.RowIndex == 0 ? 0 : Convert.ToInt32(litTotal.Text)) + iQty).ToString();
            }

            if (e.Row.RowState.ToString().EndsWith("Edit"))
            {
                HiddenField hf = e.Row.FindControl("hfLocation") as HiddenField;
                DropDownList ddl = e.Row.FindControl("ddlLocation") as DropDownList;

                try { ddl.SelectedValue = hf.Value; }
                catch { ddl.SelectedIndex = 0; }

                bool isEdit = Convert.ToBoolean((e.Row.FindControl("hfisEdit") as HiddenField).Value);
                if (!isEdit && LocOnly)
                {
                    e.Row.FindControl("litQty").Visible = e.Row.FindControl("litiQty").Visible = true;
                    e.Row.FindControl("txtQty").Visible = e.Row.FindControl("txtiQty").Visible = e.Row.FindControl("rfviQty").Visible = false;
                }
                else
                {
                    e.Row.FindControl("txtQty").Visible = e.Row.FindControl("litiQty").Visible = !isEdit;
                    e.Row.FindControl("litQty").Visible = e.Row.FindControl("txtiQty").Visible = e.Row.FindControl("rfviQty").Visible = isEdit;
                }
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                bool isEdit = Convert.ToBoolean((e.Row.FindControl("hfisEdit") as HiddenField).Value);
                e.Row.FindControl("lnkEdit").Visible = isEdit;
                e.Row.FindControl("lnkLocOnly").Visible = !isEdit && isLocOnly;
                e.Row.FindControl("pnlOverride").Visible = e.Row.FindControl("btnOverride").Visible = !isEdit;
            }
        }
        protected void gvUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string LocID = (gvInvCnt.Rows[e.RowIndex].FindControl("ddlLocation") as DropDownList).SelectedValue;
            if (LocID.Equals("-1"))
            {
                iMsg.ShowErr("Sorry! Location is required.", true);
                e.Cancel = true;
            }
            else
            {
                TextBox txt = gvInvCnt.Rows[e.RowIndex].FindControl("txtiQty") as TextBox;
                int Qty = 0; bool isGood = txt.Visible || LocOnly;

                if (txt.Visible) Qty = Convert.ToInt32(txt.Text.Trim());
                else if (LocOnly) Qty = Convert.ToInt32((gvInvCnt.Rows[e.RowIndex].FindControl("litiQty") as Literal).Text);
                else
                {
                    try
                    {
                        int newOnHand = Convert.ToInt32((gvInvCnt.Rows[e.RowIndex].FindControl("txtQty") as TextBox).Text.Trim());
                        int oldAvailable = Convert.ToInt32((gvInvCnt.Rows[e.RowIndex].FindControl("litAvailable") as Literal).Text);
                        int oldOnHand = Convert.ToInt32((gvInvCnt.Rows[e.RowIndex].FindControl("litQty") as Literal).Text);
                        int oldEntered = Convert.ToInt32((gvInvCnt.Rows[e.RowIndex].FindControl("litiQty") as Literal).Text);

                        isGood = newOnHand >= oldOnHand - oldAvailable;
                        if (isGood) Qty = oldEntered + (newOnHand - oldOnHand);
                    }
                    catch { isGood = false; }
                }

                if (isGood)
                {
                    e.NewValues["LocID"] = LocID;
                    e.NewValues["Qty"] = Qty;
                }
                else
                {
                    iMsg.ShowErr("Sorry! Invalid On-Hand value.", true);
                    e.Cancel = true;
                }
            }
        }
        protected void gvEditing(object sender, GridViewEditEventArgs e)
        {
            bool isAllowE = isAllowEdit(gvInvCnt.Rows[e.NewEditIndex]);
            if (!isAllowE)
            {
                iMsg.ShowErr("Sorry! Override failed.", true);
                e.Cancel = true;
            }
        }
        private bool isAllowEdit(GridViewRow Rw)
        {
            bool isEdit = Convert.ToBoolean((Rw.FindControl("hfisEdit") as HiddenField).Value) || LocOnly;
            if (!isEdit)
            {
                string tUN = (Rw.FindControl("txtUN") as TextBox).Text;
                string tPW = (Rw.FindControl("txtPW") as TextBox).Text;
                Hashtable xSec = (new myBiz.DAL.clsUser()).getPageSec(tUN, "Tools/Check Part Inventory", Request.ServerVariables["URL"].ToLower(), hSec);
                isEdit = isOverride && Common.clsUser.chkLogin(tUN, tPW) && xSec.ContainsKey("k07") && Convert.ToBoolean(xSec["k07"]);
            }

            return isEdit;
        }
        private bool LocOnly
        {
            set { ViewState["LocOnly"] = value; }
            get { return ViewState["LocOnly"] != null ? Convert.ToBoolean(ViewState["LocOnly"]) : false; }
        }
        public bool isLocOnly
        {
            set { ViewState["isLocOnly"] = value; }
            get { return ViewState["isLocOnly"] != null ? Convert.ToBoolean(ViewState["isLocOnly"]) : false; }
        }
        public bool isOverride
        {
            set { ViewState["isOverride"] = value; }
            get { return ViewState["isOverride"] != null ? Convert.ToBoolean(ViewState["isOverride"]) : false; }
        }
        private Hashtable hSec
        {
            get
            {
                Hashtable xH = new Hashtable();
                xH.Add("k00", "Page Access");
                xH.Add("k01", "Print Preview");
                xH.Add("k02", "Update");
                xH.Add("k03", "Check");
                xH.Add("k04", "Reset");
                xH.Add("k05", "Upload Part Picture");
                xH.Add("k06", "Delete Part Picture");
                xH.Add("k07", "Override Edit");
                xH.Add("k08", "Edit Location Only");
                return xH;
            }
        }
    }
}