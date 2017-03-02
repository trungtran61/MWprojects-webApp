using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class ucVdrBlkToolNew : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void ddlSelected(object sender, EventArgs e) { odsVdrBlkTool.SelectParameters["ToolType"].DefaultValue = string.Empty; }
        protected void doLoad(object sender, EventArgs e)
        {
            odsVdrBlkTool.SelectParameters["ToolTypeID"].DefaultValue = ddlType.SelectedValue;
            odsVdrBlkTool.SelectParameters["ToolType"].DefaultValue = ddlType.SelectedItem.Text;
            odsVdrBlkTool.SelectParameters["ToolNameID"].DefaultValue = ddlName.SelectedValue;
            odsVdrBlkTool.SelectParameters["ToolName"].DefaultValue = ddlName.SelectedItem.Text;
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string[] v = { "Type", "Name" };
                bool isYN = v.Contains(gvBlkTool.DataKeys[e.Row.RowIndex].Values["pKey"].ToString());

                e.Row.FindControl("litVal").Visible = isYN;
                e.Row.FindControl("txtVal").Visible = e.Row.FindControl("ddlUnit").Visible = !isYN;
            }
        }
        protected void gvBound(object sender, EventArgs e) { btnSave.Visible = gvBlkTool.Rows.Count > 0; }
        protected void doSave(object sender, EventArgs e)
        {
            string blkType = string.Empty, blkName = string.Empty;
            List<string> DmsID = new List<string>(), dVal = new List<string>(), dUnit = new List<string>(), dBlk = new List<string>();
            bool isReady = false;

            for (int i = 0; i < gvBlkTool.Rows.Count; i++)
            {
                var Rw = gvBlkTool.Rows[i];
                var chkBlk = (Rw.FindControl("chkBlk") as CheckBox).Checked;
                if (!isReady) isReady = chkBlk;

                switch (gvBlkTool.DataKeys[i].Values["pKey"].ToString())
                {
                    case "Type": blkType = chkBlk.ToString(); break;
                    case "Name": blkName = chkBlk.ToString(); break;
                    default:
                        DmsID.Add(gvBlkTool.DataKeys[i].Values["pHID"].ToString());
                        dVal.Add((Rw.FindControl("txtVal") as TextBox).Text);
                        dUnit.Add((Rw.FindControl("ddlUnit") as DropDownList).SelectedValue);
                        dBlk.Add(chkBlk ? "1" : "0");
                        break;
                }
            }

            if (isReady)
            {
                odsVdrBlkTool.InsertParameters["blkType"].DefaultValue = blkType;
                odsVdrBlkTool.InsertParameters["blkName"].DefaultValue = blkName;
                odsVdrBlkTool.InsertParameters["DmsID"].DefaultValue = string.Join(":", DmsID.ToArray());
                odsVdrBlkTool.InsertParameters["dVal"].DefaultValue = string.Join(":", dVal.ToArray());
                odsVdrBlkTool.InsertParameters["dUnit"].DefaultValue = string.Join(":", dUnit.ToArray());
                odsVdrBlkTool.InsertParameters["dBlk"].DefaultValue = string.Join(":", dBlk.ToArray());
                odsVdrBlkTool.Insert();
                doRefresh();
            }
            else iMsg.ShowErr("Unable to register if no item is checked.", true);
        }
        private void doRefresh()
        {
            odsVdrBlkTool.SelectParameters["ToolType"].DefaultValue = string.Empty;
            System.Collections.Hashtable h = new System.Collections.Hashtable();
            h.Add("Cmd", "Refresh");
            this.myEvent(h);
        }
        public string VendorID { set { hfVendorID.Value = value; } }
    }
}