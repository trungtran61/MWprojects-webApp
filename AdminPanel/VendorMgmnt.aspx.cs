using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using System.Text;

namespace webApp.AdminPanel
{
    public partial class VendorMgmnt : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("AdminPanel/Vendor Management");
        }
        protected void doSave(object sender, EventArgs e)
        {
            var bID = (sender as Button).ID;

            if (bID.Equals("btnSaveVendorCust"))
            {
                if (ddlCust.SelectedIndex > 0 && ddlType.SelectedIndex > 0)
                {
                    odsVendor.Update();
                    iMsg.ShowMsg("Thank You! Your approved vendor list have been saved.", true);
                }
                else iMsg.ShowErr("Please select Customer and Type before you can save.", true);
            }
            else if (bID.Equals("btnCtrlVendor"))
            {
                odsCtrlVendor.Update();
                iCtrlVendorMsg.ShowMsg("Thank You! Your controled vendor have been saved.", true);
            }
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            if (!Page.ClientScript.IsStartupScriptRegistered("chkAllScript"))
            {
                System.Text.StringBuilder js = new System.Text.StringBuilder("function chkAll(chk, isAll){\n");
                js.AppendFormat(" $('#{0}').hide();", btnSendEmail.ClientID);
                js.Append(string.Format(" var myBoxes = document.getElementById('{0}').value.split(':');\n", hfChkBox.ClientID));
                js.Append(" var len = myBoxes.length;\n var Cnt = 1;\n");
                js.Append(" for (var i = 0; i < len; i++) {\n");
                js.Append("  if (isAll) document.getElementById(myBoxes[i]).checked = chk.checked;\n");
                js.Append("  else if (document.getElementById(myBoxes[i]).checked && i > 0) Cnt++;\n");
                js.Append(" }\n");
                js.Append(" if (!isAll) document.getElementById(myBoxes[0]).checked = Cnt == len;\n");
                js.Append("}\n");

                Page.ClientScript.RegisterStartupScript(typeof(Page), "chkAllScript", js.ToString(), true);
            }
            if (!Page.ClientScript.IsStartupScriptRegistered("chkAllAvlScript"))
            {
                System.Text.StringBuilder js = new System.Text.StringBuilder("function chkAllAvl(chk, isAll){\n");
                js.AppendFormat(" $('#{0}').hide();", btnSendEmailAvl.ClientID);
                js.Append(string.Format(" var myBoxes = document.getElementById('{0}').value.split(':');\n", hfChkBoxAvl.ClientID));
                js.Append(" var len = myBoxes.length;\n var Cnt = 1;\n");
                js.Append(" for (var i = 0; i < len; i++) {\n");
                js.Append("  if (isAll) document.getElementById(myBoxes[i]).checked = chk.checked;\n");
                js.Append("  else if (document.getElementById(myBoxes[i]).checked && i > 0) Cnt++;\n");
                js.Append(" }\n");
                js.Append(" if (!isAll) document.getElementById(myBoxes[0]).checked = Cnt == len;\n");
                js.Append("}\n");

                Page.ClientScript.RegisterStartupScript(typeof(Page), "chkAllAvlScript", js.ToString(), true);
            }
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header || e.Row.RowType == DataControlRowType.DataRow)
            {
                var isCert = (sender as GridView).ID.Equals("gvCertSurvey");

                string YN = e.Row.RowType == DataControlRowType.Header ? "true" : "false";
                CheckBox chk = e.Row.FindControl("chkItem") as CheckBox;
                chk.Attributes.Add("onclick", string.Format("javascript:chkAll{2}({0},{1});", chk.ClientID, YN, !isCert ? "Avl" : string.Empty));

                if (isCert)
                {
                    hfChkBox.Value += string.IsNullOrEmpty(hfChkBox.Value) ? chk.ClientID : string.Format(":{0}", chk.ClientID);
                }
                else
                {
                    hfChkBoxAvl.Value += string.IsNullOrEmpty(hfChkBoxAvl.Value) ? chk.ClientID : string.Format(":{0}", chk.ClientID);
                }

                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    var lit = e.Row.FindControl("litCertNo") as Literal;
                    var lnk = e.Row.FindControl("lnkCertNo") as LinkButton;
                    lnk.Visible = Convert.ToInt32(lnk.CommandArgument) > 0;
                    lit.Visible = !lnk.Visible;
                }
            }
        }
        protected void rwBoundHis(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var lit = e.Row.FindControl("litCertNo") as Literal;
                var lnk = e.Row.FindControl("lnkCertNo") as LinkButton;
                lnk.Visible = Convert.ToInt32(lnk.CommandArgument) > 0;
                lit.Visible = !lnk.Visible;
                e.Row.FindControl("btnDelete").Visible = isYN("k06");
            }
        }
        protected void gvBound(object sender, EventArgs e)
        {
            if ((sender as GridView).ID.Equals("gvCertSurvey"))
            {
                btnGenerate.Visible = gvCertSurvey.Rows.Count > 0;
            }
            else
            {
                btnGenerateAvl.Visible = gvAvlSurvey.Rows.Count > 0;
            }
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            var isCert = (sender as GridView).ID.Equals("gvCertSurvey");

            if (e.CommandName.Equals("LoadCert"))
            {
                myBiz.DAL.clsFile.Show(Page, isCert ? pnlPopup : pnlPopupAvl, "DL", "Certificate", string.Empty, Convert.ToInt32(Util.AppSetting("VendorCertification")), Convert.ToInt32(e.CommandArgument), string.Empty);
            }
            else if (e.CommandName.Equals("Sort"))
            {
                if (isCert) btnSendEmail.Visible = false;
                else btnSendEmailAvl.Visible = false;
            }
        }
        protected void rwCmdHis(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("LoadCert"))
            {
                myBiz.DAL.clsFile.Show(Page, pnlPopupHis, "DL", "Certificate", string.Empty, Convert.ToInt32(Util.AppSetting("VendorCertification")), Convert.ToInt32(e.CommandArgument), string.Empty);
            }
        }
        protected void doGenerate(object sender, EventArgs e)
        {
            hfSelIDs.Value = string.Empty;
            var q = from i in gvCertSurvey.Rows.Cast<GridViewRow>()
                    where (i.FindControl("chkItem") as CheckBox).Checked
                    select gvCertSurvey.DataKeys[i.RowIndex].Value.ToString();

            hfSelIDs.Value = string.Join(":", q.ToArray());
            btnSendEmail.Visible = !string.IsNullOrWhiteSpace(hfSelIDs.Value);
        }
        protected void doGenerateAvl(object sender, EventArgs e)
        {
            hfSelAvlIDs.Value = string.Empty;
            var q = from i in gvAvlSurvey.Rows.Cast<GridViewRow>()
                    where (i.FindControl("chkItem") as CheckBox).Checked
                    select gvAvlSurvey.DataKeys[i.RowIndex].Value.ToString();

            hfSelAvlIDs.Value = string.Join(":", q.ToArray());
            btnSendEmailAvl.Visible = !string.IsNullOrWhiteSpace(hfSelAvlIDs.Value);
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            hfSelIDs.Value = hfChkBox.Value = string.Empty;
            btnSendEmail.Visible = false;
        }
        protected void ddlChangedAvl(object sender, EventArgs e)
        {
            hfSelAvlIDs.Value = hfChkBoxAvl.Value = string.Empty;
            btnSendEmailAvl.Visible = false;
        }
        protected string gLink(string type)
        {
            var rStr = string.Empty;

            if (type.Equals("His")) rStr = ddlHisProType.SelectedValue.Equals("0") ? Eval("CompanyName").ToString() : string.Format("<a onclick=\"javascript:load{2}Survey({3},{0},'{1}');\" class=\"Pointer\">{1}</a>", Eval("HID"), Eval("CompanyName"), type, Eval("CertID"));
            else rStr = ddlAvlProType.SelectedValue.Equals("0") && type.Equals("Avl") ? Eval("CompanyName").ToString() : string.Format("<a onclick=\"javascript:load{2}Survey({0},'{1}');\" class=\"Pointer\">{1}</a>", Eval("HID"), Eval("CompanyName"), type);

            return rStr;
        }
        protected string gDD(string f)
        {
            try
            {
                DateTime DD = Convert.ToDateTime(Eval(f));
                return string.Format("<span{0}>{1}</span>", DD.CompareTo(DateTime.Now) < 0 ? " style=\"color:Red;\"" : string.Empty, DD.ToString("MM/dd/yy"));
            }
            catch
            {
                return "No Date";
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Controled Vendors");
            PageSec.Add("k02", "Approved Vendors");
            PageSec.Add("k03", "Vendor Profile");
            PageSec.Add("k04", "Certificate");
            PageSec.Add("k05", "Approved Vendor List");
            PageSec.Add("k06", "Delete Survey");
            PageSec.Add("k07", "Vendor History");
            PageSec.Add("k08", "Approved Dates");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tabCtrlVendor.Visible = isYN("k01");
                tabCustLink.Visible = isYN("k02");
                tabProfile.Visible = isYN("k03");
                tabCert.Visible = isYN("k04");
                tabAvl.Visible = isYN("k05");
                tabHis.Visible = isYN("k07");
                tabApp.Visible = isYN("k08");

                var tIdx = tabCtrlVendor.Visible ? 0 :
                    tabCustLink.Visible ? 1 :
                    tabProfile.Visible ? 2 :
                    tabCert.Visible ? 3 :
                    tabAvl.Visible ? 4 :
                    tabHis.Visible ? 5 :
                    tabApp.Visible ? 6 : -1;

                tabVendor.ActiveTabIndex = tIdx;
                tabVendor.Visible = tIdx > -1;
            }

            if (tabVendor.Visible) FixTabPanelVisible(tabVendor);
        }

        protected void FixTabPanelVisible(TabContainer tabcontainer)
        {
            foreach (TabPanel tp in tabcontainer.Tabs)
            {
                if (!tp.Visible || !Convert.ToBoolean(ViewState[tp.UniqueID + "_Display"] ?? true))
                {
                    ViewState[tp.UniqueID + "_Display"] = false;
                    tp.Visible = true;
                    DisableTab(tabcontainer, tabcontainer.Tabs.IndexOf(tp));
                }
            }
            StringBuilder fixScript = new StringBuilder();
            fixScript.Append("function DisableTab(container, index) {$get(container.get_tabs()[index].get_id() + \"_tab\").style.display = \"none\";}");
            //fixScript.Append("function EnableTab(container, index) {$get(container.get_tabs()[index].get_id() + \"_tab\").style.display = \"block\";}");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "FixScriptReg", fixScript.ToString(), true);
        }

        //protected void EnableTab(TabContainer container, int index)
        //{
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "EnableTabFun" + index,
        //        "Sys.Application.add_load(function () {EnableTab($find('" + container.ClientID + "')," + index + ");});", true);
        //}

        protected void DisableTab(TabContainer container, int index)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "DisableTabFun" + index,
                "Sys.Application.add_load(function () {DisableTab($find('" + container.ClientID + "')," + index + ");});", true);
        }

        protected void rwUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string term = (gvProfile.Rows[e.RowIndex].FindControl("txtTerm") as TextBox).Text;
            e.NewValues["Term"] = !string.IsNullOrWhiteSpace(term) ? Convert.ToInt32(term) : -1;
        }
    }
}