using System;
using System.Text;
using System.Linq;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using myBiz.DAL;
using myBiz.Tools;

namespace webApp.RFQ
{
    public partial class Detail : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("RFQ/Quote Detail"))
            {
                if (!IsPostBack) resEdit = false;
            }
        }
        private bool resEdit
        {
            set { ViewState["resEdit"] = value; }
            get { return ViewState["resEdit"] != null && Convert.ToBoolean(ViewState["resEdit"]); }
        }
        protected void fvPreRender(object sender, EventArgs e)
        {
            FormView fv = sender as FormView;
            if (resEdit && fv.CurrentMode == FormViewMode.Edit)
            {
                (fv.FindControl("txtRFQ") as TextBox).Enabled = false;
                (fv.FindControl("ddlCustomerID") as DropDownList).Enabled = false;
                (fv.FindControl("txtPartNumber") as TextBox).Enabled = false;
                (fv.FindControl("txtRevision") as TextBox).Enabled = false;
            }
            else if (fv.CurrentMode == FormViewMode.ReadOnly)
            {
                fv.FindControl("btnEdit").Visible = isYN("k01");
                string hf = (fv.FindControl("hfStatus") as HiddenField).Value;
                fv.FindControl("btnEditSpec").Visible = isYN("k04") && hf.Equals("Completed") && (string.IsNullOrEmpty((fv.FindControl("litCompanyName") as Literal).Text) || (fv.FindControl("litUnitPrice") as Literal).Text.Equals("$0.00"));
            }
        }
        protected void fvCmd(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("EditSpec"))
            {
                fvDetail.FindControl("txtUnitPrice").Visible = fvDetail.FindControl("ddlCustomerID").Visible = fvDetail.FindControl("btnCanSpec").Visible = true;
                fvDetail.FindControl("litUnitPrice").Visible = fvDetail.FindControl("litCompanyName").Visible = false;
                (fvDetail.FindControl("btnEdit") as Button).Enabled = false;
                Button btn = fvDetail.FindControl("btnEditSpec") as Button; btn.Text = "Save"; btn.CommandName = "SaveSpec";
            }
            else if (e.CommandName.Equals("SaveSpec"))
            {
                TextBox txt = fvDetail.FindControl("txtUnitPrice") as TextBox;
                DropDownList ddl = fvDetail.FindControl("ddlCustomerID") as DropDownList;
                Literal litUP = fvDetail.FindControl("litUnitPrice") as Literal;
                Literal litCN = fvDetail.FindControl("litCompanyName") as Literal;

                if (clsValidator.isNumeric(txt.Text))
                {
                    (new clsRFQ()).saveSpec(Convert.ToInt32(fvDetail.DataKey.Value), Convert.ToInt32(ddl.SelectedValue), txt.Text);

                    litUP.Text = string.Format("{0:c}", float.Parse(txt.Text));
                    litCN.Text = ddl.SelectedItem.Text;

                    txt.Visible = ddl.Visible = fvDetail.FindControl("btnCanSpec").Visible = false;
                    litUP.Visible = litCN.Visible = (fvDetail.FindControl("btnEdit") as Button).Enabled = true;
                    Button btn = fvDetail.FindControl("btnEditSpec") as Button; btn.Text = "Edit Special"; btn.CommandName = "EditSpec";

                    iMsg.ShowMsg("Updated successfully!", true);
                }
                else iMsg.ShowErr("Invalid Unit Price.", true);
            }
            else if (e.CommandName.Equals("CanSpec"))
            {
                fvDetail.FindControl("txtUnitPrice").Visible = fvDetail.FindControl("ddlCustomerID").Visible = fvDetail.FindControl("btnCanSpec").Visible = false;
                fvDetail.FindControl("litUnitPrice").Visible = fvDetail.FindControl("litCompanyName").Visible = true;
                (fvDetail.FindControl("btnEdit") as Button).Enabled = true;
                Button btn = fvDetail.FindControl("btnEditSpec") as Button; btn.Text = "Edit Special"; btn.CommandName = "EditSpec";
            }
        }
        protected void fvBound(object sender, EventArgs e)
        {
            FormView fv = sender as FormView;

            if (fv.CurrentMode == FormViewMode.Edit)
            {
                DropDownList ddl = fv.FindControl("ddlCustomerID") as DropDownList;
                ddl.Visible = isYN("k02"); fv.FindControl("litCompanyName").Visible = !ddl.Visible;

                TextBox txt = fv.FindControl("txtUnitPrice") as TextBox;
                txt.Visible = isYN("k03"); fv.FindControl("litUnitPrice").Visible = !txt.Visible;

                TextBox tDD = fv.FindControl("txtDueDate") as TextBox;
                tDD.Visible = isYN("k05"); fv.FindControl("litDueDate").Visible = !tDD.Visible;

                var qtys = (fv.FindControl("hfmulQty") as HiddenField).Value.Split('/');
                var plh = fvDetail.FindControl("plhOrderQty") as PlaceHolder;
                LoadQtys(plh, qtys);
            }
            else if (fv.CurrentMode == FormViewMode.ReadOnly)
            {
                if (!isYN("k02")) (fv.FindControl("litCompanyName") as Literal).Text = "N/A";
                if (!isYN("k03")) (fv.FindControl("litUnitPrice") as Literal).Text = "N/A";
                if (!isYN("k05")) (fv.FindControl("litDueDate") as Literal).Text = "N/A";
            }
        }

        private void LoadQtys(PlaceHolder plh, string[] qtys)
        {
            var cnt = 0;
            var canEdit = !Convert.ToBoolean((fvDetail.FindControl("hfEnfQty") as HiddenField).Value) || !Convert.ToBoolean((fvDetail.FindControl("hfhasRouter") as HiddenField).Value);

            foreach(var s in qtys)
            {
                cnt++;
                var txt = plh.FindControl(string.Format("txtOrderQty{0}", cnt)) as TextBox;
                txt.Visible = true;
                txt.Text = s;
                txt.Enabled = canEdit;
            }

            BoxCount = cnt;
            fvDetail.FindControl("lnkNewBox").Visible = canEdit;
        }
        protected void fvUpdating(object sender, FormViewUpdateEventArgs e)
        {
            var validate = ValidateQtys();
            if (validate.Length > 0)
            {
                iMsg.ShowErr("Quote can NOT be updated", validate.ToString(), true);
                e.Cancel = true;
            }
            else
            {
                e.NewValues["mulQty"] = OrderQty;
                if (!e.OldValues["RFQ"].Equals(e.NewValues["RFQ"]))
                {
                    string RFQ = e.NewValues["RFQ"] == null ? string.Empty : e.NewValues["RFQ"].ToString();
                    StringBuilder x = new StringBuilder();
                    x.Append(clsValidator.gErrMsg("Integer", RFQ, "Quote (number only)", true));
                    if (x.Length > 0)
                    {
                        iMsg.ShowErr("Quote can NOT be updated", x.ToString(), true);
                        e.Cancel = true;
                    }
                    else
                    {
                        if (!isYN("k02")) e.NewValues["CustomerID"] = e.OldValues["CustomerID"];
                        if (!isYN("k03")) e.NewValues["UnitPrice"] = e.OldValues["UnitPrice"];
                    }
                }
            }
        }
        protected void odsUpdated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null && e.Exception.InnerException != null)
            {
                iMsg.ShowErr(e.Exception.InnerException.Message, true);
                e.ExceptionHandled = true;
            }
        }
        protected void newBox(object sender, EventArgs e)
        {
            var plh = fvDetail.FindControl("plhOrderQty") as PlaceHolder;
            var cnt = BoxCount + 1;
            plh.FindControl("txtOrderQty2").Visible = cnt >= 2;
            plh.FindControl("txtOrderQty3").Visible = cnt >= 3;
            plh.FindControl("txtOrderQty4").Visible = cnt >= 4;
            plh.FindControl("txtOrderQty5").Visible = cnt >= 5;
            plh.FindControl("txtOrderQty6").Visible = cnt >= 6;
            plh.FindControl("txtOrderQty7").Visible = cnt >= 7;
            plh.FindControl("txtOrderQty8").Visible = cnt >= 8;
            plh.FindControl("txtOrderQty9").Visible = cnt >= 9;
            plh.FindControl("txtOrderQty10").Visible = cnt >= 10;
            plh.FindControl("txtOrderQty11").Visible = cnt >= 11;
            plh.FindControl("txtOrderQty12").Visible = cnt >= 12;
            BoxCount = cnt;
        }
        private string RFQID { get { return Request.QueryString["RFQID"]; } }
        private string OrderQty
        {
            get
            {
                var txt = (fvDetail.FindControl("plhOrderQty") as PlaceHolder).Controls.Cast<Control>().Where(x => x.Visible).Select(x => (x as TextBox).Text).ToList();
                var filteredData = txt.Where(x => !string.IsNullOrWhiteSpace(x));
                return string.Join("/", filteredData);
            }
        }
        private int BoxCount
        {
            get { return Convert.ToInt32((fvDetail.FindControl("hfBoxCount") as HiddenField).Value); }
            set { (fvDetail.FindControl("hfBoxCount") as HiddenField).Value = value.ToString(); }
        }
        private StringBuilder ValidateQtys()
        {
            var x = new StringBuilder();
            var plh = fvDetail.FindControl("plhOrderQty") as PlaceHolder;

            x.Append(clsValidator.gErrMsg("Integer", (plh.FindControl("txtOrderQty1") as TextBox).Text, "Order Qty (box 1)", true));
            x.Append(clsValidator.gErrMsg("Integer", (plh.FindControl("txtOrderQty2") as TextBox).Text, "Order Qty (box 2)", false));
            x.Append(clsValidator.gErrMsg("Integer", (plh.FindControl("txtOrderQty3") as TextBox).Text, "Order Qty (box 3)", false));
            x.Append(clsValidator.gErrMsg("Integer", (plh.FindControl("txtOrderQty4") as TextBox).Text, "Order Qty (box 4)", false));
            x.Append(clsValidator.gErrMsg("Integer", (plh.FindControl("txtOrderQty5") as TextBox).Text, "Order Qty (box 5)", false));
            x.Append(clsValidator.gErrMsg("Integer", (plh.FindControl("txtOrderQty6") as TextBox).Text, "Order Qty (box 6)", false));
            x.Append(clsValidator.gErrMsg("Integer", (plh.FindControl("txtOrderQty7") as TextBox).Text, "Order Qty (box 7)", false));
            x.Append(clsValidator.gErrMsg("Integer", (plh.FindControl("txtOrderQty8") as TextBox).Text, "Order Qty (box 8)", false));
            x.Append(clsValidator.gErrMsg("Integer", (plh.FindControl("txtOrderQty9") as TextBox).Text, "Order Qty (box 9)", false));
            x.Append(clsValidator.gErrMsg("Integer", (plh.FindControl("txtOrderQty10") as TextBox).Text, "Order Qty (box 10)", false));
            x.Append(clsValidator.gErrMsg("Integer", (plh.FindControl("txtOrderQty11") as TextBox).Text, "Order Qty (box 11)", false));
            x.Append(clsValidator.gErrMsg("Integer", (plh.FindControl("txtOrderQty12") as TextBox).Text, "Order Qty (box 12)", false));
            return x;
        }

        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Edit");
            PageSec.Add("k02", "View Customer Name");
            PageSec.Add("k03", "View Unit Price");
            PageSec.Add("k04", "Edit Special");
            PageSec.Add("k05", "View Customer Due Date");
        }
    }
}