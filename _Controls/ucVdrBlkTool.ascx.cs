using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class ucVdrBlkTool : System.Web.UI.UserControl
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
                this.Visible = !(new myBiz.DAL.clsVendor()).Vendor_Unblock(hfID.Value, hfVendorID.Value, "Tool");

            if (this.Visible) gvBlkTool.DataBind();
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
            string blkType = string.Empty, blkName = string.Empty;
            List<string> vHID = new List<string>(), vBlk = new List<string>();

            for (int i = 0; i < gvBlkTool.Rows.Count; i++)
            {
                var chkBlk = (gvBlkTool.Rows[i].FindControl("chkBlk") as CheckBox).Checked;

                switch (gvBlkTool.DataKeys[i].Values["pKey"].ToString())
                {
                    case "Type": blkType = chkBlk.ToString(); break;
                    case "Name": blkName = chkBlk.ToString(); break;
                    default:
                        vHID.Add(gvBlkTool.DataKeys[i].Values["pHID"].ToString());
                        vBlk.Add(chkBlk ? "1" : "0");
                        break;
                }
            }

            odsVdrBlkTool.UpdateParameters["blkType"].DefaultValue = blkType;
            odsVdrBlkTool.UpdateParameters["blkName"].DefaultValue = blkName;
            odsVdrBlkTool.UpdateParameters["vHID"].DefaultValue = string.Join(":", vHID.ToArray());
            odsVdrBlkTool.UpdateParameters["vBlk"].DefaultValue = string.Join(":", vBlk.ToArray());
            odsVdrBlkTool.Update();
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