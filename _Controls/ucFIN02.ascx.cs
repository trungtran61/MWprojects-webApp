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
    public partial class ucFIN02 : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack)
            {
                gCmd("loadSec"); loadForm();
                generateForm(sender, e);
            }
        }
        protected void xmlBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header || e.Row.RowType == DataControlRowType.DataRow)
            {
                string YN = e.Row.RowType == DataControlRowType.Header ? "true" : "false";
                CheckBox chk = e.Row.FindControl("chkItem") as CheckBox;
                chk.Attributes.Add("onclick", string.Format("javascript:chkAll({0},{1});", chk.ClientID, YN));
                hfChkBox.Value += string.IsNullOrEmpty(hfChkBox.Value) ? chk.ClientID : string.Format(":{0}", chk.ClientID);
            }
        }
        private void loadForm()
        {
            myMode.ViewTarget = "dvForm3";
            frmInspection.FormPath = frmOne.FormPath = frmTwo.FormPath = ConfigurationManager.AppSettings["FormPath"];
            frmInspection.FormID = myMode.FormID;

            myMode.PrintItems[0].Value = "dvForm1"; myMode.PrintItems[0].Text = string.Format("Print Form 1: Part Number Accountability::javascript:loadForm('{0}','FirstArtDetail',{1})", frmOne.FormID, IDs[0]);
            myMode.PrintItems.Add(new ListItem(string.Format("Print Form 2: Product Accountability::javascript:loadForm('{0}','FirstArtDetail',{1})", frmTwo.FormID, IDs[0]), "dvForm2"));
            myMode.PrintItems.Add(new ListItem(string.Format("Print Form 3: Characteristic Accountability::javascript:loadForm('{0}','FirstArtData',{1})", myMode.FormID, IDs[0]), "dvForm3"));

            myMode.PrintItems[0].Selected = true;
            myMode.PrintItems[1].Selected = true;
            myMode.PrintItems[2].Selected = true;

            Hashtable h = (new cls1stArticle()).FirstArticle_getDetail(IDs[0]);
            frmOne.Update(h); frmTwo.Update(h);
        }
        protected void generateForm(object sender, EventArgs e)
        {
            frmInspection.Update((new cls1stArticle()).FirstArticle_getData(IDs[0]));
            if (IsPostBack)
                iMsg.ShowMsg("Thank you! 1st article inspection report has been generated.", true);
        }
        protected void doXML(object sender, EventArgs e)
        {
            System.Text.StringBuilder s = new System.Text.StringBuilder();
            for (int i = 0; i < gvXML.Rows.Count; i++)
            {
                CheckBox chk = gvXML.Rows[i].FindControl("chkItem") as CheckBox;
                if (chk.Checked) s.Append(string.Format("{0}:", gvXML.DataKeys[i].Value));
            }
            if (s.Length > 0)
            {
                (new cls1stArticle()).Transfer(IDs[0], s.ToString());
                gvXML.DataBind(); gv1stArticle.DataBind();
                iMsg.ShowMsg("Thank You! Data has been transferred!", true);
            }
        }
        protected override void dTask()
        {
            pnlTask.Enabled = true;
        }
        protected override void dEdit()
        {
            iMsg.ShowErr("What exactly do you want to edit?", true);
        }
        protected override void dView() { }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Control Rw = ((Button)sender).ID.Equals("btnEmpty") ? gv1stArticle.Controls[0].Controls[0] : gv1stArticle.FooterRow;
            ods1stArticle.UpdateParameters["CharNo"].DefaultValue = ((TextBox)Rw.FindControl("txtCharNo")).Text.Trim();
            ods1stArticle.UpdateParameters["Location"].DefaultValue = ((TextBox)Rw.FindControl("txtLocation")).Text.Trim();
            ods1stArticle.UpdateParameters["DrawReq"].DefaultValue = ((TextBox)Rw.FindControl("txtDrawReq")).Text.Trim();
            ods1stArticle.UpdateParameters["MeasureEquip"].DefaultValue = ((TextBox)Rw.FindControl("txtMeasureEquip")).Text.Trim();
            ods1stArticle.Update();
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
            myMode.Completable = isYN("t05");
        }
    }
}