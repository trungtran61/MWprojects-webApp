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
using System.Text;
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class Qty2Make : Common.ucAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new Common.myDelegate(mEvent);
            if (!IsPostBack) { gCmd("loadSec"); DisplayDetail(); }
            byPass();
        }
        protected override void dTask()
        {
            clsQty2Make mObj = new clsQty2Make(IDs[0]);
            gvQ2M.DataSource = mObj.Select(); gvQ2M.DataBind(); btnSave.Visible = isYN("t06"); btnClear.Visible = isYN("t07");
            if (Util.isEmpty(gvQ2M)) iMsg.ShowErr("Sorry! There is no other work order that match with this order.", true);
        }
        protected override void dEdit() { dTask(); }
        protected override void dView() { iMsg.ShowMsg("How do you want the View to look?", true); }

        private void DisplayDetail()
        {
            clsWorkOrder mWO = new clsWorkOrder();
            DataRow Rw = mWO.Select(Convert.ToInt32(IDs[0]), true).Rows[0];
            litoQty.Text = Rw["oQty"].ToString();
            litmQty.Text = Rw["mQty"].ToString();
            litUseWO.Text = Rw["uWO"].ToString();
        }

        private void byPass()
        {
            if (!litUseWO.Text.Trim().Equals("None")) myMode.Msg = ":This work order has been made by other work order";
        }
        protected void btn_Submit(object sender, EventArgs e)
        {
            string IDs = string.Empty;
            for (int i = 0; i < gvQ2M.Rows.Count; i++)
            {
                GridViewRow Rw = gvQ2M.Rows[i];
                if (((CheckBox)Rw.FindControl("chkUse")).Checked) IDs += string.Format("{0}:", gvQ2M.DataKeys[i].Value);
            }
            if (string.IsNullOrEmpty(IDs)) IDs = "0";
            clsQty2Make mObj = new clsQty2Make(this.IDs[0]); mObj.Update(IDs); DisplayDetail();
            iMsg.ShowMsg("Thank You! Your Qty to Make has been submitted.", true);
        }
        protected void btn_Clear(object sender, EventArgs e)
        {
            clsQty2Make mObj = new clsQty2Make(this.IDs[0]); mObj.Clear(); DisplayDetail(); dTask();
            iMsg.ShowMsg("Thank You! Quantity to make for this work order has been cleared.", true);
        }
        protected override void OnInit(EventArgs e)
        {
            if (!Page.ClientScript.IsStartupScriptRegistered("countScript"))
            {
                StringBuilder js = new StringBuilder("function dCount(chk, val){\n");
                js.Append(string.Format(" var Cnt = document.getElementById('{0}');\n", lblCount.ClientID));
                js.Append(" if (chk.checked) Cnt.innerText = parseInt(Cnt.innerText) + parseInt(val);\n");
                js.Append(" else Cnt.innerText = parseInt(Cnt.innerText) - parseInt(val);\n");
                js.Append("}\n");

                Page.ClientScript.RegisterStartupScript(typeof(Page), "countScript", js.ToString(), true);
            }
        }
        protected void gvBound(object sender, EventArgs e)
        {
            int val = Convert.ToInt32(litoQty.Text);
            foreach (GridViewRow i in gvQ2M.Rows)
            {
                CheckBox chk = i.FindControl("chkUse") as CheckBox;
                if (chk != null)
                {
                    if (chk.Checked) val += Convert.ToInt32(i.Cells[1].Text);
                    chk.Attributes.Add("onclick", string.Format("javascript:dCount({0},{1});", chk.ClientID, i.Cells[1].Text));
                }
            }
            lblCount.Text = val.ToString();
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
            TaskSec.Add("t06", "Submit");
            TaskSec.Add("t07", "Clear");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            myMode.Taskable = isYN("t01");
            myMode.Editable = isYN("t02");
            myMode.Viewable = isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = isYN("t05") && !string.IsNullOrEmpty(litmQty.Text) && Convert.ToInt32(litmQty.Text) > 0;
        }
    }
}