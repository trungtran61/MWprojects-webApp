using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class ucVdrBlkOPSNew : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void ddlSelected(object sender, EventArgs e) { odsVdrBlkOPS.SelectParameters["OPSType"].DefaultValue = string.Empty; }
        protected void doLoad(object sender, EventArgs e)
        {
            odsVdrBlkOPS.SelectParameters["OPSTypeID"].DefaultValue = ddlType.SelectedValue;
            odsVdrBlkOPS.SelectParameters["OPSType"].DefaultValue = ddlType.SelectedItem.Text;
            odsVdrBlkOPS.SelectParameters["OPSSpecID"].DefaultValue = ddlSpec.SelectedValue;
            odsVdrBlkOPS.SelectParameters["OPSSpec"].DefaultValue = ddlSpec.SelectedItem.Text;
            odsVdrBlkOPS.SelectParameters["OPSDescID"].DefaultValue = ddlDesc.SelectedValue;
            odsVdrBlkOPS.SelectParameters["OPSDesc"].DefaultValue = ddlDesc.SelectedItem.Text;
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string[] v = { "Type", "Spec", "Desc" };
                bool isYN = v.Contains(gvBlkOPS.DataKeys[e.Row.RowIndex].Values["pKey"].ToString());

                e.Row.FindControl("litVal").Visible = isYN;
            }
        }
        protected void gvBound(object sender, EventArgs e) { btnSave.Visible = gvBlkOPS.Rows.Count > 0; }
        protected void doSave(object sender, EventArgs e)
        {
            string blkType = string.Empty, blkSpec = string.Empty, blkDesc = string.Empty;
            bool isReady = false;

            for (int i = 0; i < gvBlkOPS.Rows.Count; i++)
            {
                var Rw = gvBlkOPS.Rows[i];
                var chkBlk = (Rw.FindControl("chkBlk") as CheckBox).Checked;
                if (!isReady) isReady = chkBlk;

                switch (gvBlkOPS.DataKeys[i].Values["pKey"].ToString())
                {
                    case "Type": blkType = chkBlk.ToString(); break;
                    case "Spec": blkSpec = chkBlk.ToString(); break;
                    case "Desc": blkDesc = chkBlk.ToString(); break;
                }
            }

            if (isReady)
            {
                odsVdrBlkOPS.InsertParameters["blkType"].DefaultValue = blkType;
                odsVdrBlkOPS.InsertParameters["blkSpec"].DefaultValue = blkSpec;
                odsVdrBlkOPS.InsertParameters["blkDesc"].DefaultValue = blkDesc;
                odsVdrBlkOPS.Insert();
                doRefresh();
            }
            else iMsg.ShowErr("Unable to register if no item is checked.", true);
        }
        private void doRefresh()
        {
            odsVdrBlkOPS.SelectParameters["OPSType"].DefaultValue = string.Empty;
            System.Collections.Hashtable h = new System.Collections.Hashtable();
            h.Add("Cmd", "Refresh");
            this.myEvent(h);
        }
        public string VendorID { set { hfVendorID.Value = value; } }
    }
}