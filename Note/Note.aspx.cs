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

namespace webApp.Note
{
    public partial class Note : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e) { hfUID.Value = Common.clsUser.uID; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) this.Title = (new clsChatLog()).ChatLog_Title(Request.QueryString["lDB"], Request.QueryString["lID"]);
        }
        protected void gvCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Select"))
            {
                fvChatLog.ChangeMode(FormViewMode.Edit);
            }
        }
        protected void fvCmd(object sender, FormViewCommandEventArgs e)
        {
            gvChatLog.SelectedIndex = -1;
        }
        protected void fvUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            gvChatLog.DataBind();
        }
        protected void fvInserted(object sender, FormViewInsertedEventArgs e)
        {
            gvChatLog.DataBind();
        }
        protected void fvUpdating(object sender, FormViewUpdateEventArgs e)
        {
            wcLibrary.ChkBoxList chk = (sender as FormView).FindControl("cblGrpIDs") as wcLibrary.ChkBoxList;
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            foreach (ListItem i in chk.Items) if (i.Selected) x.Append(string.Format("{0}:", i.Value));
            e.NewValues["GrpIDs"] = x.ToString();
        }
        protected void fvInserting(object sender, FormViewInsertEventArgs e)
        {
            wcLibrary.ChkBoxList chk = (sender as FormView).FindControl("cblGrpIDs") as wcLibrary.ChkBoxList;
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            foreach (ListItem i in chk.Items) if (i.Selected) x.Append(string.Format("{0}:", i.Value));
            e.Values["GrpIDs"] = x.ToString();
        }
    }
}