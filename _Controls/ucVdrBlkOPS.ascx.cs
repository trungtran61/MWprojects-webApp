using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class ucVdrBlkOPS : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                (e.Row.FindControl("chkBlk") as CheckBox).Enabled = isEdit;
            }
        }
        protected void doCmd(object sender, EventArgs e)
        {
            var btn = sender as Button;
            isEdit = btn.CommandName.Equals("Edit");
            if (btn.CommandName.Equals("Save")) doSave();
            else if (btn.CommandName.Equals("Unblock"))
                this.Visible = !(new myBiz.DAL.clsVendor()).Vendor_Unblock(hfID.Value, hfVendorID.Value, "OPS");

            if (this.Visible) gvBlkOPS.DataBind();
        }
        protected void odsUpdated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (!hfVendorID.Value.Equals("0"))
            {
                mID = e.ReturnValue.ToString();
                VendorID = "0";
            }
        }
        protected void odsSelected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (!hfVendorID.Value.Equals("0"))
            {
                mID = e.OutputParameters["outBlkID"].ToString();
                VendorID = "0";
            }
        }
        private void doSave()
        {
            string blkType = string.Empty, blkSpec = string.Empty, blkDesc = string.Empty;

            for (int i = 0; i < gvBlkOPS.Rows.Count; i++)
            {
                var chkBlk = (gvBlkOPS.Rows[i].FindControl("chkBlk") as CheckBox).Checked;

                switch (gvBlkOPS.DataKeys[i].Values["pKey"].ToString())
                {
                    case "Type": blkType = chkBlk.ToString(); break;
                    case "Spec": blkSpec = chkBlk.ToString(); break;
                    case "Desc": blkDesc = chkBlk.ToString(); break;
                }
            }

            odsVdrBlkOPS.UpdateParameters["blkType"].DefaultValue = blkType;
            odsVdrBlkOPS.UpdateParameters["blkSpec"].DefaultValue = blkSpec;
            odsVdrBlkOPS.UpdateParameters["blkDesc"].DefaultValue = blkDesc;
            odsVdrBlkOPS.Update();
        }
        private bool isEdit
        {
            get
            {
                if (string.IsNullOrEmpty(hfIsEdit.Value)) hfIsEdit.Value = false.ToString();
                return Convert.ToBoolean(hfIsEdit.Value);
            }
            set
            {
                hfIsEdit.Value = value.ToString();
                btnCancel.Visible = btnSave.Visible = value;
                btnUnblock.Visible = btnEdit.Visible = !value;
            }
        }
        public bool allowEdit { set { btnEdit.Visible = value; } }
        public string mID { set { hfID.Value = value; } }
        public string VendorID { set { hfVendorID.Value = value; } }
    }
}