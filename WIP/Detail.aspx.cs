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
using myBiz.DAL;

namespace webApp.WIP
{
    public partial class Detail : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("WIP/Work Order Detail"))
            {
                ucFile.PageSec = PageSec;
                if (!IsPostBack)
                {
                    DataTable Tb = (new clsWorkOrder()).Select(Convert.ToInt32(WOID), true);
                    if (Tb != null && Tb.Rows.Count > 0)
                    {
                        btnCheckInventory.Visible = Convert.ToBoolean(Tb.Rows[0]["useInv"]) && isYN("k06");
                        btnUseWO.Visible = Convert.ToInt32(Tb.Rows[0]["useWO"]) > 0 && isYN("k07");
                        btnCheckInventory.Enabled = btnUseWO.Enabled = !Convert.ToBoolean(Tb.Rows[0]["hasShipped"]);
                        resEdit = !btnUseWO.Enabled || btnUseWO.Visible || btnCheckInventory.Visible;
                    }
                }
            }
        }

        protected void lTral(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string url = string.Format("../File/Preview.aspx?Tt=OhYeah&FID=JobTraveler&Code=Traveler&HID={0}", Request.QueryString["WOID"]);
                string Klick = string.Format("javascript:{1}('{0}');return false;", url, "lPopup");
                (sender as LinkButton).OnClientClick = Klick;
            }
        }

        protected bool resEdit
        {
            set { ViewState["resEdit"] = value; }
            get { return ViewState["resEdit"] != null && Convert.ToBoolean(ViewState["resEdit"]); }
        }
        protected void doCheck(object sender, EventArgs e)
        {
            (new clsPartInv()).UndoCheck(WOID);
            btnCheckInventory.Visible = false;
            iMsg.ShowMsg("Thank You! You have successfully undone Check Inventory.", true);
        }
        protected void undoUseWO(object sender, EventArgs e)
        {
            (new clsQty2Make(WOID)).Undo();
            btnUseWO.Visible = false;
            iMsg.ShowMsg("Thank You! You have successfully undone Use Other.", true);
        }
        protected void fvPreRender(object sender, EventArgs e)
        {
            FormView fv = sender as FormView;
            if (resEdit && fv.CurrentMode == FormViewMode.Edit)
            {
                (fv.FindControl("txtWorkOrder") as TextBox).Enabled = false;
                (fv.FindControl("ddlCustomerID") as DropDownList).Enabled = false;
                (fv.FindControl("txtPartNumber") as TextBox).Enabled = false;
                (fv.FindControl("txtRevision") as TextBox).Enabled = false;
            }
            else if (fv.CurrentMode == FormViewMode.ReadOnly)
            {
                Button btn = fv.FindControl("btnEdit") as Button;
                string hf = (fv.FindControl("hfStatus") as HiddenField).Value;
                lnkTraveler.Visible = (fv.FindControl("btnReport") as Button).Visible = hf.Equals("Completed") && isYN("k05") && !curAction.Equals("Undo_PDA_Approve");
                fv.FindControl("btnEditSpec").Visible = isYN("k12") && hf.Equals("Completed") && (string.IsNullOrEmpty((fv.FindControl("litCompanyName") as Literal).Text) || (fv.FindControl("litUnitPrice") as Literal).Text.Equals("$0.00"));

                switch (hf)
                {
                    case "PostAudit":
                        btn.Text = "Validate PDA";
                        btn.CommandName = "Validate_PDA";
                        btn.OnClientClick = string.Empty;
                        btn.Visible = isYN("k02");
                        break;
                    case "PreCompleted":
                        btn.Text = "PDA Approve";
                        btn.CommandName = "PDA_Approve";
                        btn.OnClientClick = "return confirm('Are you sure you want to PDA Approve?');";
                        btn.Visible = isYN("k03") && !curAction.Equals("PDA_Approve");
                        ucFile.WOID = WOID;
                        break;
                    case "Completed":
                        btn.Text = "Undo PDA Approve";
                        btn.CommandName = "Undo_PDA_Approve";
                        btn.OnClientClick = "return confirm('Are you sure you want to Undo PDA Approve?');";
                        btn.Visible = isYN("k04") && !curAction.Equals("Undo_PDA_Approve");
                        break;
                    default:
                        btn.Text = "Edit";
                        btn.CommandName = "Edit";
                        btn.OnClientClick = string.Empty;
                        btn.Visible = isYN("k01");
                        break;
                }
            }
        }
        protected void fvCmd(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Validate_PDA"))
            {
                odsError.SelectParameters["isUpdate"].DefaultValue = true.ToString();
                odsError.SelectParameters["Status"].DefaultValue = "PreCompleted"; gvError.DataBind();
                if (!Util.isEmpty(gvError))
                {
                    ucFile.WOID = "0";
                    iMsg.ShowErr("Sorry! Validation has failed due to the following incomplete tasks.", true);
                }
                else
                {
                    ucFile.WOID = this.WOID; fvDetail.DataBind();
                    iMsg.ShowMsg("Congratulations! Work order is ready for final PDA.<br>Please verify content of files before final approval!", true);
                }
            }
            else if (e.CommandName.Equals("PDA_Approve"))
            {
                ucFile.WOID = "0";
                odsError.SelectParameters["isUpdate"].DefaultValue = true.ToString();
                odsError.SelectParameters["Status"].DefaultValue = "Completed"; gvError.DataBind();
                if (!Util.isEmpty(gvError))
                {
                    iMsg.ShowErr("Sorry! PDA cannot be approved due to the following incomplete tasks.", true);
                }
                else
                {
                    curAction = "PDA_Approve";
                    (new clsTraveler()).SaveTraveler(Convert.ToInt32(WOID), Common.clsUser.uID);
                    iMsg.ShowMsg("You have successfully approved the work order.", true);
                }
            }
            else if (e.CommandName.Equals("Undo_PDA_Approve"))
            {
                ucFile.WOID = "0"; curAction = "Undo_PDA_Approve";
                (new clsWorkOrder()).Update(WOID, "PostAudit", true);
                (new clsTraveler()).Undo_SavedTraveler(Convert.ToInt32(WOID));
                iMsg.ShowMsg("You have successfully undone PDA Approve the work order.", true);
            }
            else if (e.CommandName.Equals("ShowReport"))
            {
                ucFile.WOID = this.WOID;
            }
            else if (e.CommandName.Equals("EditSpec"))
            {
                fvDetail.FindControl("txtUnitPrice").Visible = fvDetail.FindControl("ddlCustomerID").Visible = fvDetail.FindControl("btnCanSpec").Visible = true;
                fvDetail.FindControl("litUnitPrice").Visible = fvDetail.FindControl("litCompanyName").Visible = false;
                (fvDetail.FindControl("btnReport") as Button).Enabled = (fvDetail.FindControl("btnEdit") as Button).Enabled = false;
                Button btn = fvDetail.FindControl("btnEditSpec") as Button; btn.Text = "Save"; btn.CommandName = "SaveSpec";
            }
            else if (e.CommandName.Equals("SaveSpec"))
            {
                TextBox txt = fvDetail.FindControl("txtUnitPrice") as TextBox;
                DropDownList ddl = fvDetail.FindControl("ddlCustomerID") as DropDownList;
                Literal litUP = fvDetail.FindControl("litUnitPrice") as Literal;
                Literal litCN = fvDetail.FindControl("litCompanyName") as Literal;

                if (myBiz.Tools.clsValidator.isNumeric(txt.Text))
                {
                    (new clsWorkOrder()).saveSpec(Convert.ToInt32(fvDetail.DataKey.Value), Convert.ToInt32(ddl.SelectedValue), txt.Text);

                    litUP.Text = string.Format("{0:c}", float.Parse(txt.Text));
                    litCN.Text = ddl.SelectedItem.Text;

                    txt.Visible = ddl.Visible = fvDetail.FindControl("btnCanSpec").Visible = false;
                    litUP.Visible = litCN.Visible = (fvDetail.FindControl("btnReport") as Button).Enabled = (fvDetail.FindControl("btnEdit") as Button).Enabled = true;
                    Button btn = fvDetail.FindControl("btnEditSpec") as Button; btn.Text = "Edit Special"; btn.CommandName = "EditSpec";

                    iMsg.ShowMsg("Updated successfully!", true);
                }
                else iMsg.ShowErr("Invalid Unit Price.", true);
            }
            else if (e.CommandName.Equals("CanSpec"))
            {
                fvDetail.FindControl("txtUnitPrice").Visible = fvDetail.FindControl("ddlCustomerID").Visible = fvDetail.FindControl("btnCanSpec").Visible = false;
                fvDetail.FindControl("litUnitPrice").Visible = fvDetail.FindControl("litCompanyName").Visible = true;
                (fvDetail.FindControl("btnReport") as Button).Enabled = (fvDetail.FindControl("btnEdit") as Button).Enabled = true;
                Button btn = fvDetail.FindControl("btnEditSpec") as Button; btn.Text = "Edit Special"; btn.CommandName = "EditSpec";
            }
        }
        protected void fvBound(object sender, EventArgs e)
        {
            FormView fv = sender as FormView;

            if (fv.CurrentMode == FormViewMode.Edit)
            {
                DropDownList ddl = fv.FindControl("ddlCustomerID") as DropDownList;
                ddl.Visible = isYN("k08"); fv.FindControl("litCompanyName").Visible = !ddl.Visible;

                TextBox txt = fv.FindControl("txtUnitPrice") as TextBox;
                txt.Visible = isYN("k09"); fv.FindControl("litUnitPrice").Visible = !txt.Visible;

                TextBox tDD = fv.FindControl("txtDueDate") as TextBox;
                tDD.Visible = isYN("k13"); fv.FindControl("litDueDate").Visible = !tDD.Visible;
            }
            else if (fv.CurrentMode == FormViewMode.ReadOnly)
            {
                if (!isYN("k08")) (fv.FindControl("litCompanyName") as Literal).Text = "N/A";
                if (!isYN("k09")) (fv.FindControl("litUnitPrice") as Literal).Text = "N/A";
                if (!isYN("k13")) (fv.FindControl("litDueDate") as Literal).Text = "N/A";
            }
        }
        protected string curAction
        {
            set { ViewState["curAction"] = value; }
            get { return Convert.ToString(ViewState["curAction"]); }
        }
        protected void fvUpdating(object sender, FormViewUpdateEventArgs e)
        {
            if (!e.OldValues["WorkOrder"].Equals(e.NewValues["WorkOrder"]))
            {
                string WO = e.NewValues["WorkOrder"] == null ? string.Empty : e.NewValues["WorkOrder"].ToString();
                System.Text.StringBuilder x = new System.Text.StringBuilder();
                x.Append(myBiz.Tools.clsValidator.gErrMsg("Integer", WO, "Work Order (number only)", true));
                if (x.Length > 0)
                {
                    iMsg.ShowErr("Work Order can NOT be updated", x.ToString(), true);
                    e.Cancel = true;
                }
                else
                {
                    if (!isYN("k08")) e.NewValues["CustomerID"] = e.OldValues["CustomerID"];
                    if (!isYN("k09")) e.NewValues["UnitPrice"] = e.OldValues["UnitPrice"];
                }
            }
        }
        private string WOID { get { return Request.QueryString["WOID"]; } }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Edit");
            PageSec.Add("k02", "Validate PDA");
            PageSec.Add("k03", "PDA Approve");
            PageSec.Add("k04", "Undo PDA Approve");
            PageSec.Add("k05", "Run Report");
            PageSec.Add("k06", "Undo Check Inventory");
            PageSec.Add("k07", "Undo Use Other");
            PageSec.Add("k08", "View Customer Name");
            PageSec.Add("k09", "View Unit Price");
            PageSec.Add("k10", "Customer PO (Report item)");
            PageSec.Add("k11", "Shipping Paperwork (Report item)");
            PageSec.Add("k12", "Edit Special");
            PageSec.Add("k13", "View Customer Due Date");
        }
    }
}