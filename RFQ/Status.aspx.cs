using System;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using myBiz.DAL;

namespace webApp.RFQ
{
    public partial class Status : Common.pgAbstract
    {
        protected void Page_Init(object sender, EventArgs e) { hfValx.Value = Request.Form["hfVal"]; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!lnkControl.UniqueID.Equals(Request.Params["__EVENTTARGET"]))
            {
                if (loadSec("RFQ/Status") && !IsPostBack && !string.IsNullOrEmpty(hfValx.Value))
                {
                    btnSearch_Click(sender, e);
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            doSearch();
        }
        protected void doSearch()
        {
            string[] v = Request.ServerVariables["PATH_INFO"].Split('/');
            var status = cblStatus.Items.Cast<ListItem>().Where(x => x.Selected).Select(x => x.Value).ToArray();

            var statuses = "Open"; //by default
            if (status.Length > 0) statuses = string.Join(":", status);

            string Host = string.Format("http://{0}/{1}", Request.ServerVariables["HTTP_HOST"], v[1]);
            decimal Total = clsDB.loadStatusRFQ(PageSec, Host, tblStatus, hfValx.Value, txtRFQ.Text.Trim(), txtPN.Text.Trim(), txtCRFQ.Text.Trim(), txtCNm.Text.Trim(), statuses, txtDDf.Text.Trim(), txtDDt.Text.Trim(), Common.clsUser.uID);

            litCount.Visible = tblStatus.Visible; showTotal.Visible = isYN("k02") && tblStatus.Visible;
            if (!tblStatus.Visible) iMsg.ShowErr("Sorry! No Record Found!", true);
            else
            {
                litCount.Text = string.Format("[{0} {1}]", tblStatus.Rows.Count - 1, tblStatus.Rows.Count > 2 ? "records" : "record");
                if (showTotal.Visible) litTotal.Text = string.Format("[{0:C}]", Total);
            }
        }
        protected string gNextRFQ() { return (new clsRFQ()).NextRFQ; }
        protected void lnkCmd(object sender, EventArgs e)
        {
            if (lnkControl.UniqueID.Equals(Request.Params["__EVENTTARGET"]))
            {
                string[] pi = Request.ServerVariables["PATH_INFO"].Split('/');
                string[] v = Request.Params["__EVENTARGUMENT"].ToString().Split('|');
                Hashtable h = new Hashtable(); string u = string.Empty;
                if (v[0].Equals("/RFQ/TaskList")) { u = string.Format("/RFQ/TaskList.aspx?IDs={0}", v[1]); h = clsDB.getTaskTitle(v[1]); }
                else if (v[0].Equals("/RFQ/Detail")) { u = string.Format("/RFQ/Detail.aspx?RFQID={0}", v[1]); }
                h.Add("URL", string.Format("http://{0}/{2}{1}", Request.ServerVariables["HTTP_HOST"], u, pi[1]));
                h.Add("Refresh", ClientScript.GetPostBackClientHyperlink(btnSearch, string.Empty));
                Util.newWindow(Master, h);
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Search Button");
            PageSec.Add("k02", "View Total");
            PageSec.Add("Sales", "Sales");
            PageSec.Add("Engineer", "Engineer");
            PageSec.Add("FinalQuote", "Final Quote");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnSearch.Visible = isYN("k01");
        }
    }
}