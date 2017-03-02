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

namespace webApp._Controls
{
    public partial class ucAST : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) { fvAst.Visible = !myMode.reqTask; gCmd("View"); }
        }
        protected void fvSave(object sender, EventArgs e)
        {
            if (fvAst.DataItemCount > 0) fvAst.UpdateItem(true);
            else fvAst.InsertItem(true);
        }
        protected void fvUpdating(object sender, FormViewUpdateEventArgs e)
        {
            e.NewValues["SMPID"] = (fvAst.FindControl("ddlMPID") as DropDownList).SelectedValue.Replace(":Y", string.Empty).Replace(":N", string.Empty);
        }
        protected void fvInserting(object sender, FormViewInsertEventArgs e)
        {
            e.Values["SMPID"] = (fvAst.FindControl("ddlMPID") as DropDownList).SelectedValue.Replace(":Y", string.Empty).Replace(":N", string.Empty);
        }
        protected void fvBound(object sender, EventArgs e)
        {
            if (fvAst.CurrentMode == FormViewMode.Edit || fvAst.CurrentMode == FormViewMode.Insert)
            {
                Telerik.Web.UI.RadDateTimePicker DD = fvAst.FindControl("txtDate") as Telerik.Web.UI.RadDateTimePicker;
                if (DD.DbSelectedDate == null) DD.DbSelectedDate = DateTime.Now;

                DropDownList ddl = fvAst.FindControl("ddlMPID") as DropDownList;
                ObjectDataSource ods = fvAst.FindControl("odsMPID") as ObjectDataSource;
                HiddenField hf = fvAst.FindControl("hfSMPID") as HiddenField;
                ods.DataBind(); ddl.DataBind();
                bool iFound = false;

                for (int i = 0; i < ddl.Items.Count && !iFound; i++)
                {
                    ListItem item = ddl.Items[i];
                    if (item.Value.StartsWith(hf.Value))
                    {
                        item.Selected = true;
                        iFound = true;
                    }
                }

                if (!iFound)
                {
                    HiddenField oldhf = fvAst.FindControl("hfoldSMPID") as HiddenField;
                    for (int i = 0; i < ddl.Items.Count && !iFound; i++)
                    {
                        ListItem item = ddl.Items[i];
                        if (item.Value.StartsWith(oldhf.Value))
                        {
                            item.Selected = true;
                            iFound = true;
                        }
                    }
                }

                if (!iFound || ddl.SelectedValue.EndsWith(":N")) ddl.SelectedIndex = 0;
            }

            myMode.Completable = isYN("t05") && fvAst.CurrentMode == FormViewMode.ReadOnly && !string.IsNullOrEmpty((fvAst.FindControl("litAstDate") as Literal).Text);
        }
        protected bool xReset()
        {
            return !myMode.pTask && isYN("t06") && !string.IsNullOrEmpty(Eval("MPID").ToString()) && !string.IsNullOrEmpty(Eval("MPName").ToString()) && !string.IsNullOrEmpty(Eval("AstFullName").ToString());
        }
        protected override void dTask()
        {
            if (fvAst.DataItemCount > 0) fvAst.ChangeMode(FormViewMode.Edit);
            else fvAst.ChangeMode(FormViewMode.Insert);
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            fvAst.ChangeMode(FormViewMode.ReadOnly);
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "Reset");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
        }
        protected void ddlPreRender(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            foreach (ListItem i in ddl.Items)
            {
                if (i.Value.EndsWith(":N")) i.Attributes.Add("style", "color:gray;");
            }
        }
    }
}