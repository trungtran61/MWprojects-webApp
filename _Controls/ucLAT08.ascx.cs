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
    public partial class ucLAT08 : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack)
            {
                gCmd("loadSec");
                myMode.PrintItems[0].Value = "dvForm";
                myMode.ViewTarget = "dvForm";
                frmInspection.FormPath = ConfigurationManager.AppSettings["FormPath"];
                frmInspection.FormID = myMode.FormID;
                generateForm(sender, e);
            }
        }
        protected override void OnInit(EventArgs e)
        {
            if (!Page.ClientScript.IsStartupScriptRegistered("chkAllScript"))
            {
                System.Text.StringBuilder js = new System.Text.StringBuilder("function chkAll(chk, isAll){\n");
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
        protected void generateForm(object sender, EventArgs e)
        {
            clsInspectionReport objIns = new clsInspectionReport();
            frmInspection.Update(objIns.FirstPiece_getData(Request.QueryString["IDs"]));
            if (IsPostBack)
                iMsg.ShowMsg("Thank you! 1st piece inspection report has been generated.", true);
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
                (new clsFirstPieceInspection()).Transfer(IDs[3], s.ToString());
                gvXML.DataBind(); gv1stPiece.DataBind();
                iMsg.ShowMsg("Thank You! Data has been transferred!", true);
            }
        }
        protected override void dTask()
        {
            pnlTask.Enabled = true;
            fvInNum.Enabled = true;
        }
        protected override void dEdit()
        {
            iMsg.ShowErr("What exactly do you want to edit?", true);
        }
        protected override void dView() { }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Control Rw = ((Button)sender).ID.Equals("btnEmpty") ? gv1stPiece.Controls[0].Controls[0] : gv1stPiece.FooterRow;
            ods1stPiece.UpdateParameters["CharNo"].DefaultValue = ((TextBox)Rw.FindControl("txtCharNo")).Text.Trim();
            ods1stPiece.UpdateParameters["Location"].DefaultValue = ((TextBox)Rw.FindControl("txtLocation")).Text.Trim();
            ods1stPiece.UpdateParameters["DrawReq"].DefaultValue = ((TextBox)Rw.FindControl("txtDrawReq")).Text.Trim();
            ods1stPiece.UpdateParameters["MeasureEquip"].DefaultValue = ((TextBox)Rw.FindControl("txtMeasureEquip")).Text.Trim();
            ods1stPiece.Update();
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