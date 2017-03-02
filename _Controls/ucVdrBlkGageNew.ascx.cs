using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class ucVdrBlkGageNew : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void ddlSelected(object sender, EventArgs e) { odsVdrBlkGage.SelectParameters["GageName"].DefaultValue = string.Empty; }
        protected void doLoad(object sender, EventArgs e)
        {
            odsVdrBlkGage.SelectParameters["GageNameID"].DefaultValue = ddlName.SelectedValue;
            odsVdrBlkGage.SelectParameters["GageName"].DefaultValue = ddlName.SelectedItem.Text;
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string[] v = { "Name" };
                bool isYN = v.Contains(gvBlkGage.DataKeys[e.Row.RowIndex].Values["pKey"].ToString());

                e.Row.FindControl("litVal").Visible = isYN;
                e.Row.FindControl("txtVal").Visible = e.Row.FindControl("ddlUnit").Visible = !isYN;
            }
        }
        protected void gvBound(object sender, EventArgs e) { btnSave.Visible = gvBlkGage.Rows.Count > 0; }
        protected void doSave(object sender, EventArgs e)
        {
            string blkName = string.Empty;
            List<string> DmsID = new List<string>(), dVal = new List<string>(), dUnit = new List<string>(), dBlk = new List<string>();
            bool isReady = false;

            for (int i = 0; i < gvBlkGage.Rows.Count; i++)
            {
                var Rw = gvBlkGage.Rows[i];
                var chkBlk = (Rw.FindControl("chkBlk") as CheckBox).Checked;
                if (!isReady) isReady = chkBlk;

                switch (gvBlkGage.DataKeys[i].Values["pKey"].ToString())
                {
                    case "Name": blkName = chkBlk.ToString(); break;
                    default:
                        DmsID.Add(gvBlkGage.DataKeys[i].Values["pHID"].ToString());
                        dVal.Add((Rw.FindControl("txtVal") as TextBox).Text);
                        dUnit.Add((Rw.FindControl("ddlUnit") as DropDownList).SelectedValue);
                        dBlk.Add(chkBlk ? "1" : "0");
                        break;
                }
            }

            if (isReady)
            {
                odsVdrBlkGage.InsertParameters["blkName"].DefaultValue = blkName;
                odsVdrBlkGage.InsertParameters["DmsID"].DefaultValue = string.Join(":", DmsID.ToArray());
                odsVdrBlkGage.InsertParameters["dVal"].DefaultValue = string.Join(":", dVal.ToArray());
                odsVdrBlkGage.InsertParameters["dUnit"].DefaultValue = string.Join(":", dUnit.ToArray());
                odsVdrBlkGage.InsertParameters["dBlk"].DefaultValue = string.Join(":", dBlk.ToArray());
                odsVdrBlkGage.Insert();
                doRefresh();
            }
            else iMsg.ShowErr("Unable to register if no item is checked.", true);
        }
        private void doRefresh()
        {
            odsVdrBlkGage.SelectParameters["GageName"].DefaultValue = string.Empty;
            System.Collections.Hashtable h = new System.Collections.Hashtable();
            h.Add("Cmd", "Refresh");
            this.myEvent(h);
        }
        public string VendorID { set { hfVendorID.Value = value; } }
    }
}