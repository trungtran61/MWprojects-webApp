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
using webApp.Common;
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class OPSInfo : ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new myDelegate(mEvent);
            uMOGT.myEvent +=new myDelegate(mogtEvent);
            if (!IsPostBack) gCmd("View");
        }
        protected void mogtEvent(Hashtable h)
        {
            if (h.ContainsKey("KeepOpen")) cpeSearch.Collapsed = false;
            else
            {
                Control Rw = Util.isEmpty(gvItems) ? gvItems.Controls[0].Controls[0] : gvItems.FooterRow;

                var ddlType = Rw.FindControl("ddlType") as DropDownList;
                var ddlSpec = Rw.FindControl("ddlSpec") as DropDownList;
                var ddlDesc = Rw.FindControl("ddlDesc") as DropDownList;

                try { ddlType.SelectedValue = h["OPSTypeID"].ToString(); } catch { }
                try { ddlSpec.DataBind(); ddlSpec.SelectedValue = h["OPSSpecID"].ToString(); } catch { }
                try { ddlDesc.DataBind(); ddlDesc.SelectedValue = h["OPSDescID"].ToString(); } catch { }

                cpeSearch.Collapsed = true;
            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            bool isEmpty = (sender as Button).ID.Equals("btnEmpty");
            Control Rw = isEmpty ? gvItems.Controls[0].Controls[0] : gvItems.FooterRow;

            odsItems.UpdateParameters["HID"].DefaultValue = "-1";
            odsItems.UpdateParameters["OPSDescID"].DefaultValue = ((DropDownList)Rw.FindControl("ddlDesc")).SelectedValue;
            odsItems.UpdateParameters["Description"].DefaultValue = ((TextBox)Rw.FindControl("txtDescription")).Text.Trim();

            //commented this line out on 03/08/2015 because it showed -1 qty when adding first new row
            //odsItems.UpdateParameters["Qty"].DefaultValue = isEmpty ? "-1" : ((TextBox)Rw.FindControl("txtQty")).Text.Trim();
            odsItems.UpdateParameters["Qty"].DefaultValue = ((TextBox)Rw.FindControl("txtQty")).Text.Trim();

            odsItems.UpdateParameters["Unit"].DefaultValue = ((DropDownList)Rw.FindControl("ddlUnit")).SelectedValue;
            odsItems.Update();
        }
        protected void fvCmd(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Update")) iMsg.ShowMsg("Thank You! ProcessID has been updated!", true);
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Update"))
            {
                var Rw = gvItems.Rows[gvItems.EditIndex];
                odsItems.UpdateParameters["OPSDescID"].DefaultValue = ((DropDownList)Rw.FindControl("ddlDesc")).SelectedValue;
            }
        }
        protected void rBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowState.ToString().EndsWith("Edit"))
            {
                var ddlType = e.Row.FindControl("ddlType") as DropDownList;
                var ddlSpec = e.Row.FindControl("ddlSpec") as DropDownList;
                var ddlDesc = e.Row.FindControl("ddlDesc") as DropDownList;

                try { ddlType.DataBind(); ddlType.SelectedValue = (e.Row.FindControl("hfTypeID") as HiddenField).Value; } catch { }
                try { ddlSpec.DataBind(); ddlSpec.SelectedValue = (e.Row.FindControl("hfSpecID") as HiddenField).Value; } catch { }
                try { ddlDesc.DataBind(); ddlDesc.SelectedValue = (e.Row.FindControl("hfDescID") as HiddenField).Value; } catch { }
            }
        }
        protected void gv_Bound(object sender, EventArgs e)
        {
            DataRow Rw = getDefault;
            if (gvItems.Rows.Count > 0)
            {
                ((TextBox)gvItems.FooterRow.FindControl("txtDescription")).Text = Rw["Instruction"].ToString();
                ((TextBox)gvItems.FooterRow.FindControl("txtQty")).Text = Rw["mQty"].ToString();
            }
            else
            {
                ((TextBox)gvItems.Controls[0].Controls[0].FindControl("txtDescription")).Text = Rw["Instruction"].ToString();
                ((TextBox)gvItems.Controls[0].Controls[0].FindControl("txtQty")).Text = Common.clsUser.isWIP ? Rw["mQty"].ToString() : Rw["mulQty"].ToString();
            }
        }
        protected void ddlSelected(object sender, EventArgs e)
        {
            var Rw = (sender as DropDownList).NamingContainer as GridViewRow;
            (Rw.FindControl("ddlSpec") as DropDownList).DataBind();
            (Rw.FindControl("ddlDesc") as DropDownList).DataBind();
        }
        protected void odsUpdated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                if (e.Exception.InnerException != null) iMsg.ShowErr(e.Exception.InnerException.Message, true);
                else iMsg.ShowErr(e.Exception.Message, true);
            }
        }
        protected DataRow getDefault
        {
            get
            {
                DataTable Tb = null;
                if (ViewState["Default"] != null) Tb = (DataTable)ViewState["Default"];
                else
                {
                    clsOPS obj = new clsOPS(); Tb = obj.Default_Values(IDs[3], this.AppCode);
                    ViewState["Default"] = Tb;
                }
                return Tb != null && Tb.Rows.Count > 0 ? Tb.Rows[0] : null;
            }
        }
        protected override void dTask()
        {
            fvOPS.ChangeMode(FormViewMode.Edit);
            pnlTask.Enabled = true;
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            fvOPS.ChangeMode(FormViewMode.ReadOnly);
            pnlTask.Enabled = false;
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
            myMode.Completable = gvItems.Rows.Count > 0 && isYN("t05");
        }
    }
}