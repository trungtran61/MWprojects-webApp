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

namespace webApp.AdminPanel
{
    public partial class MachineProcess : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Machine & Process"))
            {
                if (!IsPostBack)
                {
                    gvProcess.ShowFooter = gvMachine.ShowFooter = isYN("k01");
                }
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (((Button)sender).ID.Equals("btnAddProcess"))
            {
                odsProcess.InsertParameters["ProcessID"].DefaultValue = ((TextBox)gvProcess.FooterRow.FindControl("txtProcessID")).Text.Trim();
                odsProcess.InsertParameters["Name"].DefaultValue = ((TextBox)gvProcess.FooterRow.FindControl("txtName")).Text.Trim();
                odsProcess.InsertParameters["TimeMargin"].DefaultValue = ((TextBox)gvProcess.FooterRow.FindControl("txtTimeMargin")).Text.Trim();
                odsProcess.InsertParameters["ProCate"].DefaultValue = ((DropDownList)gvProcess.FooterRow.FindControl("ddlProCate")).SelectedValue;
                odsProcess.InsertParameters["isActive"].DefaultValue = ((CheckBox)gvProcess.FooterRow.FindControl("chkActive")).Checked ? "True" : "False";
                odsProcess.InsertParameters["GeneralUsed"].DefaultValue = ((CheckBox)gvProcess.FooterRow.FindControl("chkGenUsed")).Checked ? "True" : "False";
                odsProcess.Insert();
            }
            else
            {
                odsMachine.InsertParameters["MachineID"].DefaultValue = ((TextBox)gvMachine.FooterRow.FindControl("txtMachineID")).Text.Trim();
                odsMachine.InsertParameters["Name"].DefaultValue = ((TextBox)gvMachine.FooterRow.FindControl("txtName")).Text.Trim();
                odsMachine.InsertParameters["Manufacture"].DefaultValue = ((TextBox)gvMachine.FooterRow.FindControl("txtManufacture")).Text.Trim();
                odsMachine.InsertParameters["Serial"].DefaultValue = ((TextBox)gvMachine.FooterRow.FindControl("txtSerial")).Text.Trim();
                odsMachine.InsertParameters["Model"].DefaultValue = ((TextBox)gvMachine.FooterRow.FindControl("txtModel")).Text.Trim();
                odsMachine.InsertParameters["Type"].DefaultValue = ((DropDownList)gvMachine.FooterRow.FindControl("ddlMachineType")).SelectedValue;
                odsMachine.InsertParameters["isActive"].DefaultValue = ((CheckBox)gvMachine.FooterRow.FindControl("chkActive")).Checked ? "True" : "False";
                odsMachine.Insert();
            }
        }
        protected void gv_Bound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1)
            {
                if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
                {
                    ((LinkButton)e.Row.FindControl("lnkEdit")).Enabled = isYN("k02");
                    ((LinkButton)e.Row.FindControl("lnkDelete")).Enabled = isYN("k03");

                    if ((sender as GridView).ID.Equals("gvProcess") && e.Row.RowType == DataControlRowType.DataRow)
                        (e.Row.FindControl("lnkEdit") as LinkButton).CommandArgument = e.Row.RowIndex.ToString();
                }
            }
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("pEdit"))
            {
                int i = Convert.ToInt32(e.CommandArgument); GridViewRow Rw = gvProcess.Rows[i];
                hfHID.Value = gvProcess.DataKeys[i].Value.ToString();
                txtTimeMargin.Text = clsSpace((Rw.FindControl("litTimeMargin") as Literal).Text);
                chkActive.Checked = (Rw.FindControl("chkActive") as CheckBox).Checked;
                chkGenUsed.Checked = (Rw.FindControl("chkGenUsed") as CheckBox).Checked;
                txtvDefAcct.Text = (Rw.FindControl("hfvDefAcct") as HiddenField).Value;
                txtTnv.Text = clsSpace((Rw.FindControl("litTnv") as Literal).Text);
                
                try { ddlProCate.SelectedValue = (Rw.FindControl("hfProCate") as HiddenField).Value; }
                catch { ddlProCate.SelectedIndex = 0; }

                cblExpAcct.DataSource = (new myBiz.DAL.clsProcessType()).ExpAcct_Select((Rw.FindControl("hfExpAcct") as HiddenField).Value, this.AppCode);
                cblExpAcct.DataBind(); mpeProcess.Show();
            }
        }
        protected void sData(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            x.Append(myBiz.Tools.clsValidator.gErrMsg("Numeric", txtTimeMargin.Text, "Time", false));
            x.Append(myBiz.Tools.clsValidator.gErrMsg("Integer", txtvDefAcct.Text, "Default Account", false));
            x.Append(myBiz.Tools.clsValidator.gErrMsg("Integer", txtTnv.Text, "TNV", false));

            if (x.Length < 1)
            {
                if (Convert.ToDecimal(txtTimeMargin.Text.Trim()) < 0) x.Append("<li>Invalid Time [non-negative number only]</li>");
                if (Convert.ToDecimal(txtvDefAcct.Text.Trim()) < 0) x.Append("<li>Invalid Default Account [non-negative number only]</li>");
            }

            if (x.Length > 0) { jMsg.ShowErr("<br>Cannot save data", x.ToString(), true); mpeProcess.Show(); }
            else
            {
                foreach (ListItem i in cblExpAcct.Items) if (i.Selected) x.Append(string.Format("{0}:", i.Value));
                odsProcess.UpdateParameters["HID"].DefaultValue = hfHID.Value;
                odsProcess.UpdateParameters["TimeMrg"].DefaultValue = txtTimeMargin.Text.Trim();
                odsProcess.UpdateParameters["ExpAcct"].DefaultValue = x.ToString();
                odsProcess.UpdateParameters["vEAcct"].DefaultValue = txtvDefAcct.Text.Trim();
                odsProcess.UpdateParameters["ProCate"].DefaultValue = ddlProCate.SelectedValue;
                odsProcess.UpdateParameters["isActive"].DefaultValue = chkActive.Checked.ToString();
                odsProcess.UpdateParameters["GeneralUsed"].DefaultValue = chkGenUsed.Checked.ToString();
                odsProcess.UpdateParameters["Tnv"].DefaultValue = txtTnv.Text.Trim();
                odsProcess.Update(); gvProcess.DataBind();
            }
        }
        private string clsSpace(string x)
        {
            return x.Equals("&nbsp;") ? string.Empty : x;
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Add Machine/Process");
            PageSec.Add("k02", "Edit Machine/Process");
            PageSec.Add("k03", "Delete Machine/Process");
        }
    }
}