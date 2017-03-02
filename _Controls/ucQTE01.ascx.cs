using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using webApp.Common;

namespace webApp._Controls
{
    public partial class ucQTE01 : ucAbstract
    {
        protected override void OnInit(EventArgs e)
        {
            if (!Page.ClientScript.IsStartupScriptRegistered("chkAllScript"))
            {
                System.Text.StringBuilder js = new System.Text.StringBuilder("function chkAll(chk, isAll){\n");
                js.AppendFormat(" var chkAllID = document.getElementById('{0}').value;\n", hfChkAllID.ClientID);
                js.Append(string.Format(" var myBoxes = document.getElementById('{0}').value.split(':');\n", hfChkBox.ClientID));
                js.Append(" var len = myBoxes.length;\n var Cnt = 1;\n");
                js.Append(" for (var i = 0; i < len; i++) {\n");
                js.Append("  if (isAll) document.getElementById(myBoxes[i]).checked = chk.checked;\n");
                js.Append("  else if (document.getElementById(myBoxes[i]).checked && i > 0) Cnt++;\n");
                js.Append(" }\n");
                js.Append(" if (!isAll) document.getElementById(chkAllID).checked = Cnt == len;\n");
                js.Append("}\n\n");

                js.Append("function getPriceMarkups() {\n");
                js.Append(" var vals = '';\n");
                js.AppendFormat(" var IDs = document.getElementById('{0}').value.split(':');\n", hfPriceIDs.ClientID);
                js.Append(" var len = IDs.length;\n");
                js.Append(" for (var i = 0; i < len; i++) {\n");
                js.Append("  vals += document.getElementById(IDs[i]).value + ':'\n");
                js.Append(" }\n");
                js.AppendFormat(" document.getElementById('{0}').value = vals;\n", hfPriceVal.ClientID);
                js.Append("}\n");

                Page.ClientScript.RegisterStartupScript(typeof(Page), "chkAllScript", js.ToString(), true);
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new myDelegate(mEvent);
            if (!IsPostBack) gCmd("View");
        }

        protected void doMasterReset(object sender, EventArgs e)
        {
            (new myBiz.DAL.clsFinQte()).FinQte_MasterReset(IDs[0]);
            iMsg.ShowMsg("You have reset the system.", true);
        }
        protected override void dTask()
        {
            pnlTask.Enabled = true;
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            pnlTask.Enabled = false;
        }
        protected string gLnk()
        {
            string lnk = string.Format("javascript:lPopup('File/Preview.aspx?AppCode={1}&FID=QTE&Code=FinQte&Q01=1&HID={0}');", Eval("HID"), this.AppCode);
            return string.Format("<a onclick=\"{0}\" style=\"cursor:pointer;\">{1}</a>", lnk, Eval("QTENumber"));
        }
        protected void doSubmit(object sender, EventArgs e)
        {
            var defaultPrice = txtPctPE.Text;
            var selLN = from r in gvFinQteTb.Rows.Cast<GridViewRow>()
                        where (r.FindControl("chkLn") as CheckBox).Checked
                        select new
                        {
                            Ln = (r.FindControl("lnkLn") as LinkButton).Text,
                            Price = (r.FindControl("txtPriceMarkup") as TextBox).Text
                        };

            if (selLN.Count() > 0)
            {
                odsFinQteTb.InsertParameters["PriceVal"].DefaultValue = string.Join(":", selLN.Select(x => !string.IsNullOrWhiteSpace(x.Price) ? x.Price : defaultPrice).ToArray());
                odsFinQteTb.InsertParameters["Ln"].DefaultValue = string.Join(":", selLN.Select(x => x.Ln).ToArray());
                odsFinQteTb.Insert(); gvQTE.DataBind();
                iMsg.ShowMsg("Thank You! Your Final Quote for customer has been created.", true);
            }
            else iMsg.ShowErr("Please select line number(s) to create Final Quote here.", true);
        }
        protected void doSchedule(object sender, EventArgs e)
        {
            var selQTE = from r in gvQTE.Rows.Cast<GridViewRow>()
                        where (r.FindControl("chkQTE") as CheckBox).Checked
                        select (r.FindControl("hfHID") as HiddenField).Value;
            
            if (selQTE.Count() > 0)
            {
                (new myBiz.DAL.clsRFQ_Quote()).RFQ_Quote_I(string.Join(":", selQTE.ToArray()), Common.clsUser.uID); gvQTE.DataBind();
                kMsg.ShowMsg("Thank You! Your selected Final Quote has been scheduled.", true);
            }
            else kMsg.ShowErr("Please select the Final Quote to be sent", true);
        }
        protected void odsDeleted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if ((bool)e.ReturnValue) iMsg.ShowMsg("Thank You! Your Final Quote for customer has been deleted!", true);
            else iMsg.ShowErr("Sorry! Please delete all related Customer Quote before deleting this Final Quote.", true); 
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (!e.CommandName.Equals("Select")) gvFinQteTb.SelectedIndex = -1;
            if (e.CommandName.Equals("Add"))
            {
                var rMsg = doAddNew();
                if (string.IsNullOrEmpty(rMsg))
                {
                    jMsg.ShowMsg("Thank you", true);
                }
                else
                {
                    jMsg.ShowErr(rMsg, true);
                }
            }
        }
        protected void gvUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string iSN, iC, iL, rMsg; int iQty;
            getData((sender as GridView).Rows[e.RowIndex], out iQty, out iSN, out iC, out iL, out rMsg);
            if (string.IsNullOrEmpty(rMsg))
            {
                e.NewValues["Qty"] = iQty;
                e.NewValues["iSN"] = iSN;
                e.NewValues["iC"] = iC;
                e.NewValues["iL"] = iL;
            }
            else
            {
                e.Cancel = true;
                jMsg.ShowErr(rMsg, true);
            }
        }
        protected void rwQteBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && !e.Row.RowState.ToString().Contains("Edit"))
            {
                e.Row.FindControl("btnDelete").Visible = isYN("t09");
            }
        }

        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                var chk = e.Row.FindControl("chkAlls") as CheckBox;
                chk.Attributes.Add("onclick", "javascript:chkAll(this,true);");
                hfChkAllID.Value = chk.ClientID;
            }
            else if (e.Row.RowType == DataControlRowType.DataRow && !e.Row.RowState.ToString().Contains("Edit"))
            {
                e.Row.FindControl("btnDelete").Visible = e.Row.FindControl("btnEdit").Visible = !Convert.ToBoolean((e.Row.FindControl("hfisAuto") as HiddenField).Value);
                var chk = e.Row.FindControl("chkLn") as CheckBox;
                chk.Attributes.Add("onclick", "javascript:chkAll(this,false);");

                if (!hfChkBox.Value.Contains(chk.ClientID))
                    hfChkBox.Value += string.IsNullOrEmpty(hfChkBox.Value) ? chk.ClientID : string.Format(":{0}", chk.ClientID);


                var priceMarkup = e.Row.FindControl("txtPriceMarkup") as TextBox;
                if (!hfPriceIDs.Value.Contains(priceMarkup.ClientID))
                    hfPriceIDs.Value += string.IsNullOrEmpty(hfPriceIDs.Value) ? priceMarkup.ClientID : string.Format(":{0}", priceMarkup.ClientID);
            }
        }
        protected void gvBound(object sender, EventArgs e)
        {
            GridViewRow Rw = gvFinQte.FooterRow;
            if (Rw != null)
            {
                Literal lC = Rw.FindControl("litCost") as Literal;
                Literal lT = Rw.FindControl("litTime") as Literal;

                var r = (new myBiz.DAL.clsRouter()).getTotals(IDs[0], Convert.ToInt32(gvFinQteTb.SelectedValue));
                lC.Text = string.Format("<span style=\"background-color:White; color:Black;\">{0:C}</span><br />{1:C}", r["cEP"], r["ttCost"]);
                lT.Text = string.Format("<span style=\"background-color:White; color:Black;\">{0:0.0}</span><br />{1:0.0}", r["tEP"], r["ttTime"]);
            }
        }
        protected void gvQteBound(object sender, EventArgs e)
        {
            var completable = gvQTE.Rows.Cast<GridViewRow>()
                .Any(x => !Convert.ToBoolean((x.FindControl("hfSched") as HiddenField).Value));
            myMode.Completable = isYN("t05") && completable;
            btnSchedule.Visible = isYN("t08") && gvQTE.Rows.Count > 0;
        }
        private string doAddNew()
        {
            string iSN, iC, iL, rMsg; int iQty;
            getData(gvFinQteTb.FooterRow, out iQty, out iSN, out iC, out iL, out rMsg);

            if (string.IsNullOrWhiteSpace(rMsg))
            {
                odsFinQteTb.UpdateParameters["Ln"].DefaultValue = "-1";
                odsFinQteTb.UpdateParameters["Qty"].DefaultValue = iQty.ToString();
                odsFinQteTb.UpdateParameters["iSN"].DefaultValue = iSN;
                odsFinQteTb.UpdateParameters["iC"].DefaultValue = iC;
                odsFinQteTb.UpdateParameters["iL"].DefaultValue = iL;
                odsFinQteTb.Update(); odsFinQteTb.DataBind();
            }

            return rMsg;
        }
        private void getData(GridViewRow gvRow, out int vQty, out string vSN, out string vC, out string vL, out string rMsg)
        {
            var Tb = (new myBiz.DAL.clsFinQte()).FinQte_Col(Convert.ToInt32(IDs[0]));
            StringBuilder iSN = new StringBuilder(), iC = new StringBuilder(), iL = new StringBuilder();

            foreach (System.Data.DataRow Rw in Tb.Rows)
            {
                TextBox txtC = gvRow.FindControl(string.Format("txtvC_{0}_{1}", Rw["StepName"], Rw["StepNo"])) as TextBox;
                TextBox txtL = gvRow.FindControl(string.Format("txtvL_{0}_{1}", Rw["StepName"], Rw["StepNo"])) as TextBox;

                iSN.AppendFormat("{0}:", Rw["StepNo"]);
                iC.AppendFormat("{0}:", txtC.Text);
                iL.AppendFormat("{0}:", txtL.Text);
            }

            var qty = (gvRow.FindControl("txtQty") as TextBox).Text;
            rMsg = myBiz.Tools.clsValidator.gErrMsg("Integer", qty, "Qty", true);

            vQty = !string.IsNullOrEmpty(rMsg) ? 0 : Convert.ToInt32(qty);

            if (string.IsNullOrEmpty(rMsg) && vQty < 1)
            {
                rMsg = "Qty must be greater than 0.";
            }

            if (!string.IsNullOrEmpty(rMsg))
            {
                rMsg = rMsg.Replace("<li>", string.Empty).Replace("</li>", string.Empty);
            }
            
            vSN = iSN.ToString(); vC = iC.ToString(); vL = iL.ToString();
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "Allow Master Reset");
            TaskSec.Add("t07", "Allow Generate Quote");
            TaskSec.Add("t08", "Allow Schedule Quote");
            TaskSec.Add("t09", "Allow Delete Quote");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            //myMode.Completable = isYN("t05");
            btnMasterReset.Visible = isYN("t06");
            btnSubmit.Visible = isYN("t07");
        }

        protected string GTLnk(string GT)
        {
            if (Convert.ToInt32(Eval(string.Format("{0}Cnt", GT))) > 0)
            {
                string lnk = "<a href=\"javascript:loadGT({1},{2},'{3}','{4}',{5});\">{0}</a>";
                return string.Format(lnk, Eval(string.Format("{0}Price", GT), "{0:C}"), IDs[0], Eval("StepNo"), Eval("StepName"), GT, Eval("PartQty"));
            }
            else return string.Empty;
        }
        protected void gvInit(object sender, EventArgs e)
        {
            GridView gv = sender as GridView; gv.Columns.Clear();
            gv.Columns.Add(new TemplateField
            {
                ItemTemplate = new clsTemplateField("Command", new myBiz.DAL.clsColumn { colName = "E:Edit,D:Delete", addHF = "isAuto" }),
                EditItemTemplate = new clsTemplateField("Command", new myBiz.DAL.clsColumn { colName = "Update:Update,Cancel:Cancel" }),
                FooterTemplate = new clsTemplateField("Command", new myBiz.DAL.clsColumn { colName = "Add:Add" })
            });

            gv.Columns.Add(new TemplateField
            {
                //HeaderTemplate = new clsTemplateField("ChkAllBox", new myBiz.DAL.clsColumn { colName = "<input id=\"chkAlls\" type=\"checkbox\" name=\"chkAlls\" onclick=\"javascript:chkAll(this,true);\" />" }),
                HeaderTemplate = new clsTemplateField("CheckBox", new myBiz.DAL.clsColumn { colName = "Alls" }),
                ItemTemplate = new clsTemplateField("CheckBox", new myBiz.DAL.clsColumn { colName = "Ln" }),
                EditItemTemplate = new clsTemplateField("N/A", new myBiz.DAL.clsColumn())
            });

            var cl = (new myBiz.DAL.clsFinQte()).getCols(Convert.ToInt32(IDs[0]));
            foreach (var i in cl) gv.Columns.Add(tField(i));

            gv.Columns.Add(new TemplateField
            {
                HeaderTemplate = new clsTemplateField("Literal", new myBiz.DAL.clsColumn { headerText = "Price", colName="PriceMarkup" }),
                ItemTemplate = new clsTemplateField("TextBox", new myBiz.DAL.clsColumn { colName = "PriceMarkup", fieldWidth = 40 }),
                EditItemTemplate = new clsTemplateField("N/A", new myBiz.DAL.clsColumn()),
                FooterTemplate = new clsTemplateField("N/A", new myBiz.DAL.clsColumn())
            });
        }

        private TemplateField tField(myBiz.DAL.clsColumn cl)
        {
            TemplateField x = new TemplateField { HeaderText = cl.headerText, SortExpression = cl.colName };
            x.ItemStyle.HorizontalAlign = x.FooterStyle.HorizontalAlign = x.HeaderStyle.HorizontalAlign = cl.horizontalAlign;

            if (!string.IsNullOrEmpty(cl.lnkPopup)) x.ItemTemplate = new clsTemplateField("LnkPopup", cl);
            else if (cl.isSelect) x.ItemTemplate = new clsTemplateField("LinkSelect", cl);
            else x.ItemTemplate = new clsTemplateField("Literal", cl);

            if (cl.readOnly)
            {
                x.EditItemTemplate = new clsTemplateField("Literal", cl);
                x.FooterTemplate = new clsTemplateField("Literal", cl);
            }
            else
            {
                x.EditItemTemplate = new clsTemplateField("TextBox", cl);
                x.FooterTemplate = new clsTemplateField("TextBox", cl);
            }
            return x;
        }
    }
}