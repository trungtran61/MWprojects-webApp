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
    public partial class Status : Common.pgAbstract
    {
        protected void Page_Init(object sender, EventArgs e) { hfValx.Value = Request.Form["hfVal"]; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!lnkControl.UniqueID.Equals(Request.Params["__EVENTTARGET"]))
            {
                if (loadSec("WIP/Status") && !IsPostBack && !string.IsNullOrEmpty(hfValx.Value))
                {
                    btnSearch_Click(sender, e);
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (cblStatus.Items[3].Selected && string.IsNullOrEmpty(txtWO.Text) && string.IsNullOrEmpty(txtPN.Text) && string.IsNullOrEmpty(txtCPO.Text)
                && string.IsNullOrEmpty(txtCNm.Text) && string.IsNullOrEmpty(txtDDf.Text) && string.IsNullOrEmpty(txtDDt.Text) && string.IsNullOrEmpty(txtCJ.Text))
            {
                iMsg.ShowErr("Sorry! Please enter something to search for History", true);
            }
            else doSearch();
        }
        protected void doSearch()
        {
            string[] v = Request.ServerVariables["PATH_INFO"].Split('/');
            System.Text.StringBuilder St = new System.Text.StringBuilder();
            string xSt = string.Empty; bool isSearch = !IsPostBack && !string.IsNullOrEmpty(hfValx.Value);

            foreach (ListItem i in cblStatus.Items)
                if (i.Selected || (isSearch && i.Enabled))
                {
                    if (i.Value.Contains(","))
                    {
                        string[] w = i.Value.Split(',');
                        St.Append(string.Format("{0}:", w[0]));
                        xSt = w[1];
                    }
                    else St.Append(string.Format("{0}:", i.Value));
                }

            string Host = string.Format("http://{0}/{1}", Request.ServerVariables["HTTP_HOST"], v[1]);
            decimal Total = clsDB.loadStatus(PageSec, Host, tblStatus, hfValx.Value, txtWO.Text.Trim(), txtPN.Text.Trim(),
                txtCPO.Text.Trim(), txtCNm.Text.Trim(), txtCJ.Text.Trim(), St.ToString(), xSt, txtDDf.Text.Trim(), txtDDt.Text.Trim(), Common.clsUser.uID);

            litCount.Visible = tblStatus.Visible; showTotal.Visible = isYN("k05") && tblStatus.Visible;
            if (!tblStatus.Visible) iMsg.ShowErr("Sorry! No Record Found!", true);
            else
            {
                litCount.Text = string.Format("[{0} {1}]", tblStatus.Rows.Count - 1, tblStatus.Rows.Count > 2 ? "records" : "record");
                if (showTotal.Visible) litTotal.Text = string.Format("[{0:C}]", Total);
            }
        }
        protected string gNextWO()
        {
            return (new clsWorkOrder()).NextWO;
        }
        protected void lnkCmd(object sender, EventArgs e)
        {
            if (lnkControl.UniqueID.Equals(Request.Params["__EVENTTARGET"]))
            {
                string[] pi = Request.ServerVariables["PATH_INFO"].Split('/');
                string[] v = Request.Params["__EVENTARGUMENT"].ToString().Split('|');
                Hashtable h = new Hashtable(); string u = string.Empty;
                if (v[0].Equals("/WIP/TaskList")) { u = string.Format("/WIP/TaskList.aspx?IDs={0}", v[1]); h = clsDB.getTaskTitle(v[1]); }
                else if (v[0].Equals("/WIP/Detail")) { u = string.Format("/WIP/Detail.aspx?WOID={0}", v[1]); }
                h.Add("URL", string.Format("http://{0}/{2}{1}", Request.ServerVariables["HTTP_HOST"], u, pi[1]));
                h.Add("Refresh", ClientScript.GetPostBackClientHyperlink(btnSearch, string.Empty));
                Util.newWindow(Master, h);
            }
        }
        protected void doAutoApprove(object sender, EventArgs e)
        {
            string eMsg;
            gvError.DataSource = (new clsWorkOrder()).AutoApprove(Common.clsUser.uID, out eMsg);
            gvError.DataBind();
            litAutoApprove.Text = string.Format("{0} [{1}]", eMsg, DateTime.Now);
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "WIP");
            PageSec.Add("k02", "PDA");
            PageSec.Add("k03", "History");
            PageSec.Add("k04", "Search Button");
            PageSec.Add("k05", "View Total");
            PageSec.Add("k06", "OIP");
            PageSec.Add("k07", "Cancel");
            PageSec.Add("k08", "Auto Approve Button");
            PageSec.Add("Sales", "Sales");
            PageSec.Add("Purchasing", "Purchasing");
            PageSec.Add("Engineer", "Engineer");
            PageSec.Add("Quality", "Quality");
            PageSec.Add("LATHE", "LATHE");
            PageSec.Add("MILL", "MILL");
            PageSec.Add("SAW", "SAW");
            PageSec.Add("RIM", "RIM");
            PageSec.Add("OPS", "OPS");
            PageSec.Add("HF", "HF");
            PageSec.Add("ASE", "ASE");
            PageSec.Add("FIN", "FIN");
            PageSec.Add("PAM", "PAM");
            PageSec.Add("Inventory", "Inventory");
            PageSec.Add("Shipping", "Shipping");
            PageSec.Add("Delivery", "Delivery");
            PageSec.Add("Billing", "Billing");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            cblStatus.Items[0].Enabled = isYN("k01");
            cblStatus.Items[1].Enabled = isYN("k06");
            cblStatus.Items[2].Enabled = isYN("k02");
            cblStatus.Items[3].Enabled = isYN("k03");
            cblStatus.Items[4].Enabled = isYN("k07");
            btnSearch.Visible = isYN("k04");
            uPnlAutoApprove.Visible = isYN("k08");

            if (!IsPostBack)
            {
                DataRow Rw = (new clsWorkOrder()).Counts();

                foreach (ListItem i in cblStatus.Items)
                    if (i.Text.Equals("WIP") || i.Text.Equals("OIP") || i.Text.Equals("PDA"))
                        i.Attributes.Add("title", Rw[string.Format("cnt{0}", i.Text)].ToString());
            }
        }
    }
}