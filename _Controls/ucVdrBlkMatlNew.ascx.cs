using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class ucVdrBlkMatlNew : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void ddlSelected(object sender, EventArgs e) { odsVdrBlkMatl.SelectParameters["MatlType"].DefaultValue = string.Empty; }
        protected void doLoad(object sender, EventArgs e)
        {
            odsVdrBlkMatl.SelectParameters["MatlTypeID"].DefaultValue = ddlType.SelectedValue;
            odsVdrBlkMatl.SelectParameters["MatlType"].DefaultValue = ddlType.SelectedItem.Text;
            odsVdrBlkMatl.SelectParameters["MatlAmsID"].DefaultValue = ddlAms.SelectedValue;
            odsVdrBlkMatl.SelectParameters["MatlAms"].DefaultValue = ddlAms.SelectedItem.Text;
            odsVdrBlkMatl.SelectParameters["MatlFormID"].DefaultValue = ddlForm.SelectedValue;
            odsVdrBlkMatl.SelectParameters["MatlForm"].DefaultValue = ddlForm.SelectedItem.Text;
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string[] v = { "Type", "Ams", "Form" };
                bool isYN = v.Contains(gvBlkMatl.DataKeys[e.Row.RowIndex].Values["pKey"].ToString());

                e.Row.FindControl("litVal").Visible = isYN;
                e.Row.FindControl("txtVal").Visible = e.Row.FindControl("ddlUnit").Visible = !isYN;
            }
        }
        protected void gvBound(object sender, EventArgs e) { btnSave.Visible = gvBlkMatl.Rows.Count > 0; }
        protected void doSave(object sender, EventArgs e)
        {
            string blkType = string.Empty, blkAms = string.Empty, blkForm = string.Empty;
            List<string> DmsID = new List<string>(), dVal = new List<string>(), dUnit = new List<string>(), dBlk = new List<string>();
            bool isReady = false;

            for (int i = 0; i < gvBlkMatl.Rows.Count; i++)
            {
                var Rw =gvBlkMatl.Rows[i];
                var chkBlk = (Rw.FindControl("chkBlk") as CheckBox).Checked;
                if (!isReady) isReady = chkBlk;

                switch (gvBlkMatl.DataKeys[i].Values["pKey"].ToString())
                {
                    case "Type": blkType = chkBlk.ToString(); break;
                    case "Ams": blkAms = chkBlk.ToString(); break;
                    case "Form": blkForm = chkBlk.ToString(); break;
                    default:
                        DmsID.Add(gvBlkMatl.DataKeys[i].Values["pHID"].ToString());
                        dVal.Add((Rw.FindControl("txtVal") as TextBox).Text);
                        dUnit.Add((Rw.FindControl("ddlUnit") as DropDownList).SelectedValue);
                        dBlk.Add(chkBlk ? "1" : "0");
                        break;
                }
            }

            if (isReady)
            {
                odsVdrBlkMatl.InsertParameters["blkType"].DefaultValue = blkType;
                odsVdrBlkMatl.InsertParameters["blkAms"].DefaultValue = blkAms;
                odsVdrBlkMatl.InsertParameters["blkForm"].DefaultValue = blkForm;
                odsVdrBlkMatl.InsertParameters["DmsID"].DefaultValue = string.Join(":", DmsID.ToArray());
                odsVdrBlkMatl.InsertParameters["dVal"].DefaultValue = string.Join(":", dVal.ToArray());
                odsVdrBlkMatl.InsertParameters["dUnit"].DefaultValue = string.Join(":", dUnit.ToArray());
                odsVdrBlkMatl.InsertParameters["dBlk"].DefaultValue = string.Join(":", dBlk.ToArray());
                odsVdrBlkMatl.Insert();
                doRefresh();
            }
            else iMsg.ShowErr("Unable to register if no item is checked.", true);
        }
        private void doRefresh()
        {
            odsVdrBlkMatl.SelectParameters["MatlType"].DefaultValue = string.Empty;
            System.Collections.Hashtable h = new System.Collections.Hashtable();
            h.Add("Cmd", "Refresh");
            this.myEvent(h);
        }
        public string VendorID { set { hfVendorID.Value = value; } }
    }
}