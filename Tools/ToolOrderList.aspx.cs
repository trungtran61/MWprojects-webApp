using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common.DTO;
using myBiz.Tools;

namespace webApp.Tools
{
    public partial class ToolOrderList : Common.pgAbstract
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            if (!Page.ClientScript.IsStartupScriptRegistered("chkAllScript"))
            {
                System.Text.StringBuilder js = new System.Text.StringBuilder("function chkAll(chk, isAll){\n");
                js.AppendFormat(" var myBoxes = document.getElementById('{0}').value.split(':');\n", hfChkBox.ClientID);
                js.Append(" var len = myBoxes.length-1;\n var Cnt = 0;\n");
                js.Append(" for (var i = 0; i < len; i++) {\n");
                js.Append("  if (isAll) document.getElementById(myBoxes[i]).checked = chk.checked;\n");
                js.Append("  else if (document.getElementById(myBoxes[i]).checked) Cnt++;\n");
                js.Append(" }\n");
                js.Append(" if (!isAll) document.getElementById(myBoxes[len]).checked = Cnt == len;\n");
                js.Append("}\n");

                Page.ClientScript.RegisterStartupScript(typeof(Page), "chkAllScript", js.ToString(), true);
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Tools/Tool Order List");
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            var cmd = e.CommandName;
            var Rw = (e.CommandSource as Control).NamingContainer as GridViewRow;
            var lnkN = Rw.FindControl("lnkNewApp") as LinkButton;
            var lnkA = Rw.FindControl("lnkOrdApp") as LinkButton;
            var lit = Rw.FindControl("litECode") as Literal;

            var ordApp = cmd.Equals("UndoNew") ? 1 : cmd.Equals("doNew") || cmd.Equals("UndoApprove") ? 2 : cmd.Equals("doApprove") ? 3 : 4;
            (new myBiz.DAL.clsToolInventory()).OrdApp(Convert.ToInt32(e.CommandArgument), ordApp);

            switch (ordApp)
            {
                case 1: //New
                    lnkN.Text = "<span title=\"This is new!\">N</span>";
                    lnkN.CommandName = "doNew";
                    lnkN.Visible = isYN("k03");
                    lnkA.Text = string.Empty;
                    lnkA.CommandName = string.Empty;
                    lnkA.Visible = false;
                    lit.Text = lnkN.Visible ? "&nbsp;" : lnkN.Text;
                    break;
                case 2: //UnNew, Approve
                    lnkN.Text = "<span title=\"Undo New\">W</span>";
                    lnkN.CommandName = "UndoNew";
                    lnkN.Visible = isYN("k03");
                    lnkA.Text = "<span title=\"Approval is required!\">A</span>";
                    lnkA.CommandName = "doApprove";
                    lnkA.Visible = isYN("k02");
                    lit.Text = lnkN.Visible && lnkA.Visible ? "&nbsp;" : lnkN.Visible ? lnkA.Text : lnkA.Visible ? lnkN.Text : lnkN.Text + lnkA.Text;
                    break;
                case 3: //UnApprove
                    lnkN.Text = string.Empty;
                    lnkN.CommandName = string.Empty;
                    lnkN.Visible = false;
                    lnkA.Text = "<span title=\"Undo Approved\">U</span>";
                    lnkA.CommandName = "UndoApprove";
                    lnkA.Visible = isYN("k02");
                    break;
                default:
                    lnkN.Text = lnkA.Text = string.Empty;
                    lnkN.CommandName = lnkA.CommandName = string.Empty;
                    lnkN.Visible = lnkA.Visible = false;
                    break;
            }

            (Rw.FindControl("hfOrdApp") as HiddenField).Value = ordApp.ToString();
            lit.Visible = !string.IsNullOrEmpty(lit.Text);
        }

        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var lnkN = e.Row.FindControl("lnkNewApp") as LinkButton;
                var lnkA = e.Row.FindControl("lnkOrdApp") as LinkButton;
                var ordApp = Convert.ToInt32((e.Row.FindControl("hfOrdApp") as HiddenField).Value);
                var chk = e.Row.FindControl("chkItem") as CheckBox;
                var lit = e.Row.FindControl("litECode") as Literal;

                if (string.IsNullOrEmpty(lit.Text)) //all clear
                {
                    switch (ordApp)
                    {
                        case 1: //New
                            lnkN.Text = "<span title=\"This is new!\">N</span>";
                            lnkN.CommandName = "doNew";
                            lnkN.Visible = isYN("k03");
                            lnkA.Text = string.Empty;
                            lnkA.CommandName = string.Empty;
                            lnkA.Visible = false;
                            lit.Text = lnkN.Visible ? "&nbsp;" : lnkN.Text;
                            break;
                        case 2: //UnNew, Approve
                            lnkN.Text = "<span title=\"Undo New\">W</span>";
                            lnkN.CommandName = "UndoNew";
                            lnkN.Visible = isYN("k03");
                            lnkA.Text = "<span title=\"Approval is required!\">A</span>";
                            lnkA.CommandName = "doApprove";
                            lnkA.Visible = isYN("k02");
                            lit.Text = lnkN.Visible && lnkA.Visible ? "&nbsp;" : lnkN.Visible ? lnkA.Text : lnkA.Visible ? lnkN.Text : lnkN.Text + lnkA.Text;
                            break;
                        case 3: //UnApprove
                            lnkN.Text = string.Empty;
                            lnkN.CommandName = string.Empty;
                            lnkN.Visible = false;
                            lnkA.Text = "<span title=\"Undo Approved\">U</span>";
                            lnkA.CommandName = "UndoApprove";
                            lnkA.Visible = isYN("k02");
                            break;
                        default:
                            lnkN.Text = lnkA.Text = string.Empty;
                            lnkN.CommandName = lnkA.CommandName = string.Empty;
                            lnkN.Visible = lnkA.Visible = false;
                            break;
                    }

                    //if (ordApp == 3)
                    //{
                    //    lnk.Text = "<span title=\"Approval is required!\">A</span>";
                    //    lnk.CommandName = "Approve";
                    //    lnk.Visible = isYN("k02");
                    //    if (!lnk.Visible)
                    //    {
                    //        lit.Text = "<span title=\"Approval is required!\">A</span>";
                    //    }
                    //    else
                    //    {
                    //        lit.Text = "&nbsp;";
                    //    }
                    //}
                    //else if (ordApp == 4)
                    //{
                    //    lnk.Text = "<span title=\"Undo Approved\">U</span>";
                    //    lnk.CommandName = "UnApprove";
                    //    lnk.Visible = isYN("k02");
                    //}
                    //else
                    //{
                    //    lnk.Text = string.Empty;
                    //    lnk.CommandName = string.Empty;
                    //    lnk.Visible = false;
                    //}
                }
                else
                {
                    lnkN.Text = lnkA.Text = string.Empty;
                    lnkN.CommandName = lnkA.CommandName = string.Empty;
                    lnkN.Visible = lnkA.Visible = false;
                }

                lit.Visible = !string.IsNullOrEmpty(lit.Text);
                chk.Visible = !lit.Visible;

                if (chk.Visible)
                {
                    chk.Attributes.Add("onclick", string.Format("javascript:chkAll({0},false);", chk.ClientID));
                    hfChkBox.Value += string.IsNullOrEmpty(hfChkBox.Value) ? chk.ClientID : string.Format(":{0}", chk.ClientID);
                }
            }
        }
        protected void gvBound(object sender, EventArgs e)
        {
            if (gvOrderList.Rows.Count > 0)
            {
                var chk = gvOrderList.HeaderRow.FindControl("chkItem") as CheckBox;
                chk.Visible = gvOrderList.Rows.Cast<GridViewRow>().Any(r => (r.FindControl("chkItem") as CheckBox).Visible);

                if (chk.Visible)
                {
                    chk.Attributes.Add("onclick", string.Format("javascript:chkAll({0},true);", chk.ClientID));
                    hfChkBox.Value += string.IsNullOrEmpty(hfChkBox.Value) ? chk.ClientID : string.Format(":{0}", chk.ClientID);
                }
            }
        }
        protected void doGenerate(object sender, EventArgs e)
        {
            var selectedData = from r in gvOrderList.Rows.Cast<GridViewRow>()
                               let chk = r.FindControl("chkItem") as CheckBox
                               where chk.Visible && chk.Checked
                               select new ToolOrderDTO
                               {
                                   HID = gvOrderList.DataKeys[r.RowIndex].Value.ToString(),
                                   tExpAcct = r.Cells[1].Text,
                                   Balance = Convert.ToDecimal(clsValidator.isNumeric(r.Cells[3].Text) ? r.Cells[3].Text : "0"),
                                   Amount = Convert.ToDecimal(clsValidator.isNumeric(r.Cells[12].Text) ? r.Cells[12].Text : "0"),
                                   Enforced = Convert.ToBoolean((r.FindControl("hfEnforced") as HiddenField).Value)
                               };

            var sData = selectedData.ToList();
            if (sData.Count < 1)
            {
                iMsg.ShowErr("Please select items to generate PO.", true);
                ShowReport(true);
            }
            else
            {
                LoadReport(sData);
            }
        }
        private void LoadReport(List<ToolOrderDTO> selectedData)
        {
            var Tb = new System.Data.DataTable();
            Tb.Columns.Add("tExpAcct", typeof(string));
            Tb.Columns.Add("NumItem", typeof(int));
            Tb.Columns.Add("Total", typeof(decimal));
            Tb.Columns.Add("Balance", typeof(decimal));
            Tb.Columns.Add("Createable", typeof(bool));

            var uniques = selectedData.GroupBy(x => x.tExpAcct)
                .Select(x => new
                {
                    tExpAcct = x.Key,
                    Enforced = x.First().Enforced,
                    Balance = x.First().Balance,
                    NumItem = x.Count(),
                    Total = x.Sum(y => y.Amount)
                }).ToList();

            foreach (var item in uniques)
            {
                Tb.Rows.Add(item.tExpAcct, item.NumItem, item.Total, item.Balance, !item.Enforced || item.Balance >= item.Total);
            }

            var validAccts = uniques.Where(x => !x.Enforced || x.Balance >= x.Total).Select(x => x.tExpAcct).ToList();
            var HIDs = selectedData.Where(x => validAccts.Contains(x.tExpAcct)).Select(x => x.HID);

            hfIDs.Value = string.Join(":", HIDs.ToArray());
            gvReport.DataSource = Tb; gvReport.DataBind();
            ShowReport(true);
        }
        protected void doOK(object sender, EventArgs e)
        {
            var Tb = (new myBiz.DAL.clsTool()).RFQPO_Batch(Common.clsUser.uID, hfIDs.Value);
            iMsg.ShowMsg("The following PO(s) have been created!", true);
            btnOK.Enabled = btnCancel.Enabled = false;
            gvPOs.Visible = btnReturn.Visible = true;
            gvPOs.DataSource = Tb; gvPOs.DataBind();
        }
        protected void doCancel(object sender, EventArgs e)
        {
            ShowReport(false);
        }
        protected string gDD(string k)
        {
            try
            {
                var useCompletion = Eval("NewAppDate") != DBNull.Value;
                var fColor = useCompletion ? " style=\"color:#58FA58;\"" : string.Empty;
                var DD = useCompletion ? Convert.ToDateTime(Eval("NewAppDate")) : Convert.ToDateTime(Eval(k));

                if (!useCompletion)
                {
                    switch (Eval("lMode").ToString())
                    {
                        case "beLate": fColor = " style=\"color:Brown;\""; break;
                        case "Late": fColor = " style=\"color:Red;\""; break;
                    }
                }
                
                return string.Format("<span{0}>{1}</span>", fColor, DD.ToString(Util.DD_Format));
            }
            catch
            {
                return "No Date";
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Generate PO");
            PageSec.Add("k02", "Approve Order List");
            PageSec.Add("k03", "Unmark New Order List");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnGen.Visible = btnGenerate.Visible = !btnOK.Visible && isYN("k01");
        }
        private void ShowReport(bool yn)
        {
            btnGen.Visible = btnGenerate.Visible = gvOrderList.Visible = !yn;
            btnOK.Visible = btnCancel.Visible = gvReport.Visible = yn;
            btnOK.Enabled = !string.IsNullOrEmpty(hfIDs.Value);
        }
    }
}