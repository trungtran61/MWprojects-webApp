using System;
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
using webApp.Common;
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class MaterialInfo : ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new myDelegate(mEvent);
            uMOGT.myEvent += new myDelegate(mogtEvent);
            if (!IsPostBack) gCmd("View");
        }

        protected void mogtEvent(Hashtable h)
        {
            if (h.ContainsKey("KeepOpen")) cpeSearch.Collapsed = false;
            else
            {
                Control Rw = Util.isEmpty(gvItems) ? gvItems.Controls[0].Controls[0] : gvItems.FooterRow;

                var ddlType = Rw.FindControl("ddlType") as DropDownList;
                var ddlAms = Rw.FindControl("ddlAms") as DropDownList;
                var ddlForm = Rw.FindControl("ddlForm") as DropDownList;
                var gvDmsList = Rw.FindControl("gvDmsList") as GridView;
                var odsDL = Rw.FindControl("odsDmsList") as ObjectDataSource;

                try { ddlType.SelectedValue = h["MatlTypeID"].ToString(); }
                catch { }
                try { ddlAms.DataBind(); ddlAms.SelectedValue = h["MatlAmsID"].ToString(); }
                catch { }
                try { ddlForm.SelectedValue = h["MatlFormID"].ToString(); }
                catch { }
                try { odsDL.SelectParameters["BDID"].DefaultValue = h["BDID"].ToString(); odsDL.DataBind(); gvDmsList.DataBind(); }
                catch { }

                cpeSearch.Collapsed = true;
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string DmsID, dVal, dUnit;
            bool isEmpty = ((Button)sender).ID.Equals("btnEmpty");
            Control Rw = isEmpty ? gvItems.Controls[0].Controls[0] : gvItems.FooterRow;
            exDmsVal(Rw.FindControl("gvDmsList") as GridView, out DmsID, out dVal, out dUnit);

            odsItems.UpdateParameters["HID"].DefaultValue = "-1";
            odsItems.UpdateParameters["IDs"].DefaultValue = Request.QueryString["IDs"];
            odsItems.UpdateParameters["MatlAmsID"].DefaultValue = (Rw.FindControl("ddlAms") as DropDownList).SelectedValue;
            odsItems.UpdateParameters["MatlFormID"].DefaultValue = (Rw.FindControl("ddlForm") as DropDownList).SelectedValue;
            odsItems.UpdateParameters["DmsID"].DefaultValue = DmsID;
            odsItems.UpdateParameters["dVal"].DefaultValue = dVal;
            odsItems.UpdateParameters["dUnit"].DefaultValue = dUnit;
            odsItems.UpdateParameters["ItemDesc"].DefaultValue = ((TextBox)Rw.FindControl("txtItemDesc")).Text.Trim();
            odsItems.UpdateParameters["LengthOrdered"].DefaultValue = isEmpty ? ((Literal)Rw.FindControl("litLengthOrdered")).Text.Trim() :
                ((TextBox)Rw.FindControl("txtLengthOrdered")).Text.Trim();
            odsItems.Update();
        }
        private void exDmsVal(GridView gv, out string DmsID, out string dVal, out string dUnit)
        {
            List<string> pID = new List<string>(), pVal = new List<string>(), pUnit = new List<string>();
            for (int i = 0; i < gv.Rows.Count; i++)
            {
                var Rw = gv.Rows[i];
                pID.Add((Rw.FindControl("hfHID") as HiddenField).Value);
                pVal.Add((Rw.FindControl("txtVal") as TextBox).Text);
                pUnit.Add((Rw.FindControl("ddlUnit") as DropDownList).SelectedValue);
            }
            DmsID = string.Join(":", pID.ToArray());
            dVal = string.Join(":", pVal.ToArray());
            dUnit = string.Join(":", pUnit.ToArray());
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Update"))
            {
                string DmsID, dVal, dUnit;
                var Rw = gvItems.Rows[gvItems.EditIndex];
                exDmsVal(Rw.FindControl("gvDmsList") as GridView, out DmsID, out dVal, out dUnit);

                odsItems.UpdateParameters["HID"].DefaultValue = gvItems.DataKeys[gvItems.EditIndex].Value.ToString();
                odsItems.UpdateParameters["IDs"].DefaultValue = Request.QueryString["IDs"];
                odsItems.UpdateParameters["MatlAmsID"].DefaultValue = (Rw.FindControl("ddlAms") as DropDownList).SelectedValue;
                odsItems.UpdateParameters["MatlFormID"].DefaultValue = (Rw.FindControl("ddlForm") as DropDownList).SelectedValue;
                odsItems.UpdateParameters["DmsID"].DefaultValue = DmsID;
                odsItems.UpdateParameters["dVal"].DefaultValue = dVal;
                odsItems.UpdateParameters["dUnit"].DefaultValue = dUnit;
                odsItems.UpdateParameters["ItemDesc"].DefaultValue = ((TextBox)Rw.FindControl("txtItemDesc")).Text.Trim();
                odsItems.UpdateParameters["LengthOrdered"].DefaultValue = ((TextBox)Rw.FindControl("txtLengthOrdered")).Text.Trim();

                odsItems.Update();
            }
        }
        protected void rBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowState.ToString().EndsWith("Edit"))
            {
                var ddlType = e.Row.FindControl("ddlType") as DropDownList;
                var ddlAms = e.Row.FindControl("ddlAms") as DropDownList;
                var ddlForm = e.Row.FindControl("ddlForm") as DropDownList;
                var gvDmsList = e.Row.FindControl("gvDmsList") as GridView;

                try { ddlType.DataBind(); ddlType.SelectedValue = (e.Row.FindControl("hfTypeID") as HiddenField).Value; } catch { }
                try { ddlAms.DataBind(); ddlAms.SelectedValue = (e.Row.FindControl("hfAmsID") as HiddenField).Value; } catch { }
                try { ddlForm.DataBind(); ddlForm.SelectedValue = (e.Row.FindControl("hfFormID") as HiddenField).Value; }
                catch { }
                finally { gvDmsList.DataBind(); }
            }
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.Footer)
            {
                try
                {
                    (e.Row.FindControl("ddlUnit") as DropDownList).SelectedValue = (e.Row.FindControl("hfUnit") as HiddenField).Value;
                }
                catch { }
            }
        }
        protected void gv_Bound(object sender, EventArgs e)
        {
            if (gvItems.EditIndex < 0)
            {
                if (gvItems.Rows.Count > 0)
                {
                    GridViewRow Rw = gvItems.Rows[gvItems.Rows.Count - 1];
                    ((DropDownList)gvItems.FooterRow.FindControl("ddlType")).SelectedValue = ((Literal)Rw.FindControl("litType")).Text;
                    ((DropDownList)gvItems.FooterRow.FindControl("ddlAms")).SelectedValue = ((Literal)Rw.FindControl("litAms")).Text;
                    //((TextBox)gvItems.FooterRow.FindControl("txtSize")).Text = ((Literal)Rw.FindControl("litSize")).Text;
                }
                else
                {
                    string iLen = ((Literal)fvMaterial.FindControl("litLength")).Text;
                    var v = iLen.Split('/').Select(r => Math.Ceiling(Convert.ToDouble(r) / 72) * 72);
                    ((Literal)gvItems.Controls[0].Controls[0].FindControl("litLengthOrdered")).Text = string.Join("/", v.ToArray());
                }
            }
        }
        protected void fvBound(object sender, EventArgs e)
        {
            gvItems.DataBind();
        }
        protected void odsUpdated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                if (e.Exception.InnerException != null) iMsg.ShowErr(e.Exception.InnerException.Message, true);
                else iMsg.ShowErr(e.Exception.Message, true);
            }
        }
        protected string mulLenNeed()
        {
            return AppCode.Equals("WIP") ? Eval("LengthNeeded").ToString() : Eval("mulLenVal").ToString();
        }
        protected override void dTask()
        {
            fvMaterial.ChangeMode(FormViewMode.Edit);
            gvItems.Enabled = imgSearch.Enabled = cpeSearch.Enabled = pnlSearch.Visible = true;
        }
        protected override void dEdit()
        {
            fvMaterial.ChangeMode(FormViewMode.Edit);
            gvItems.Enabled = imgSearch.Enabled = cpeSearch.Enabled = pnlSearch.Visible = true;
        }
        protected override void dView()
        {
            fvMaterial.ChangeMode(FormViewMode.ReadOnly);
            gvItems.Enabled = imgSearch.Enabled = cpeSearch.Enabled = pnlSearch.Visible = false;
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            if (!IsPostBack)
            {
                var supplier = (fvMaterial.FindControl("litSupplier") as Literal).Text;
                SetCompletable(supplier);
            }
        }

        protected void fvMaterial_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            var supplier = (fvMaterial.FindControl("ddlSupplier") as DropDownList).SelectedValue;
            odsMaterial.UpdateParameters["Foal"].DefaultValue = (fvMaterial.FindControl("txtFoal") as TextBox).Text;
            odsMaterial.UpdateParameters["Unit"].DefaultValue = (fvMaterial.FindControl("ddlUnit") as DropDownList).SelectedValue;
            odsMaterial.UpdateParameters["PID"].DefaultValue = (fvMaterial.FindControl("ddlProcessType") as DropDownList).SelectedValue;
            odsMaterial.UpdateParameters["Supplier"].DefaultValue = supplier;
            odsMaterial.UpdateParameters["ItemCommand"].DefaultValue = e.CommandName;
            odsMaterial.Update();
            SetCompletable(supplier);
        }

        protected void SetCompletable(string supplier)
        {
            myMode.Completable = gvItems.Rows.Count > 0 && isYN("t05") && !string.IsNullOrWhiteSpace(supplier);
        }
    }
}