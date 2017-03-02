using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace webApp.Tools
{
    public partial class MachineInfo : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/MachineInfo") && !IsPostBack)
            {
                DataTable Tb = myBiz.DAL.clsDB.spAdmin_Variables_S("AutoRefresh");
                int arf = Tb != null && Tb.Rows.Count > 0 ? Convert.ToInt32(Tb.Rows[0]["iValue"].ToString()) : 30;

                tRefresh.Interval = 1000 * arf;
            }
        }
        #region Status
        protected string showMachine()
        {
            string DF = Util.AppSetting("DueDateFormat");
            string xSt = Eval("curStatus").ToString(), IDs = string.Format("{0}:{1}:{2}", Eval("WOID"), Eval("StepNo"), 0);
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.AppendFormat("<div style=\"background-color:{0}; color:{1}; width:400px; height:220px; overflow:hidden; border-style: outset;\">\n", Eval("BackColor"), Eval("ForeColor"));
            sb.AppendFormat("<div style=\"float:right;border:2px outset White;font-weight:bold;\">{0}</div><br><br>", gStamp());
            sb.AppendFormat("<div style=\"margin:20px;\">\n<span style=\"font-size:19px; font-weight:bold;\">{0} : {1}</span><br>\n", Eval("MachineID"), Eval("Name"));

            switch (xSt)
            {
                case "Setup":
                    sb.Append("<span style=\"font-size:18px;\">");
                    sb.AppendFormat("Setup: {0}<br>\n", gDate("AstDate", DF));
                    sb.AppendFormat("WO: {0}; QTY: {1}.<br>\n", gLink(IDs, Eval("WorkOrder").ToString()), Eval("OpQty"));
                    sb.AppendFormat("PN: {0} REV. {1}; OP# {2}<br>\n", Eval("PartNumber"), Eval("Revision"), Eval("OpNo"));
                    sb.AppendFormat("BY: {0}<br>\n", Eval("AstFullName"));
                    sb.AppendFormat("Due Date: {0}\n", gDate("xDD", DF));
                    sb.Append("</span>");
                    break;
                case "Buy Off":
                    sb.Append("<span style=\"font-size:18px;\">");
                    sb.AppendFormat("Buy Off: {0}<br>\n", gDate("SetDate", DF));
                    sb.AppendFormat("WO: {0}; QTY: {1}.<br>\n", gLink(IDs, Eval("WorkOrder").ToString()), Eval("OpQty"));
                    sb.AppendFormat("PN: {0} REV. {1}; OP# {2}<br>\n", Eval("PartNumber"), Eval("Revision"), Eval("OpNo"));
                    sb.AppendFormat("BY: {0}<br>\n", Eval("SetFullName"));
                    sb.AppendFormat("Due Date: {0}\n", gDate("xDD", DF));
                    sb.Append("</span>");
                    break;
                case "Running":
                    sb.Append("<span style=\"font-size:18px;\">");
                    sb.AppendFormat("Running: {0}<br>\n", gDate("OpDate", DF));
                    sb.AppendFormat("WO: {0}; QTY: {1}.<br>\n", gLink(IDs, Eval("WorkOrder").ToString()), Eval("OpQty"));
                    sb.AppendFormat("PN: {0} REV. {1}; OP# {2}<br>\n", Eval("PartNumber"), Eval("Revision"), Eval("OpNo"));
                    sb.AppendFormat("ACT: {0} {1}. ", Eval("OpCycle"), Eval("OpUnit"));
                    sb.AppendFormat("ART: {0}<br>\n", gTime("ART"));
                    sb.AppendFormat("ECD: {0}<br>\n", gDate("ECD", DF));
                    sb.AppendFormat("Due Date: {0}\n", gDate("xDD", DF));
                    sb.Append("</span>");
                    break;
                case "Suggested":
                    sb.Append("<span style=\"font-size:18px;\">");
                    sb.AppendFormat("ESD: {0}<br>\n", gDate("ESD", DF));
                    sb.AppendFormat("WO: {0}; QTY: {1}.<br>\n", gLink(IDs, Eval("WorkOrder").ToString()), Eval("OpQty"));
                    sb.AppendFormat("PN: {0} REV. {1}; OP# {2}<br>\n", Eval("PartNumber"), Eval("Revision"), Eval("OpNo"));
                    sb.AppendFormat("ECT: {0} {1}. ", Eval("ECUnit"), Eval("ECTime"));
                    sb.AppendFormat("ERT: {0}<br>\n", gTime("ERT"));
                    sb.AppendFormat("Due Date: {0}\n", gDate("DueDate", DF));
                    sb.Append("</span>");
                    break;
                case "Available":
                    if (Eval("curTaskID") != DBNull.Value && Convert.ToInt32(Eval("curTaskID")) > 0)
                    {
                        sb.Append("<span style=\"font-size:18px;\">");
                        sb.AppendFormat("Available: {0}<br>\n", gDate("OpDate", DF));
                        sb.AppendFormat("WO: {0}; aQTY: {1}.<br>\n", gLink(IDs, Eval("WorkOrder").ToString()), Eval("aQty"));
                        sb.AppendFormat("PN: {0} REV. {1}; OP# {2}<br>\n", Eval("PartNumber"), Eval("Revision"), Eval("OpNo"));
                        sb.AppendFormat("ACT: {0} {1}. ", Eval("OpCycle"), Eval("OpUnit"));
                        sb.AppendFormat("ART: {0}<br>\n", gTime("ART"));
                        sb.AppendFormat("ACD: {0}<br>\n", gDate("aECD", DF));
                        sb.AppendFormat("Due Date: {0}\n", gDate("xDD", DF));
                        sb.Append("</span>");
                    }
                    else
                    {
                        sb.Append("<span style=\"font-size:18px;\">");
                        sb.Append("AVAILABLE. PLEASE USE ME !!!<br>");
                        sb.Append("</span>");
                    }
                    break;
                default:
                    sb.Append("<span style=\"font-size:15px;\">");
                    sb.Append("Machine down?");
                    sb.Append("</span>");
                    break;
            }

            sb.AppendLine("</div></div>");
            return sb.ToString();
        }
        private string gLink(string IDs, string WO)
        {
            string lnk = "<a style=\"text-decoration:underline; cursor:pointer\" onclick=\"{0}\">{1}</a>";
            string[] pi = Request.ServerVariables["PATH_INFO"].Split('/');
            string url = string.Format("http://{0}/{2}/WIP/TaskList.aspx?IDs={1}", Request.ServerVariables["HTTP_HOST"], IDs, pi[1]);
            return string.Format(lnk, Util.popupURL(url, IDs.Replace(":", "_")), WO);
        }
        private string gStamp()
        {
            string TU = Convert.ToBoolean(Eval("isThumbUp")) ? "<img src=\"../App_Themes/thumbsUp.png\" title=\"Ready!\">" :
                Eval("curStatus").ToString().Equals("Running") && Eval("pMacID") != null ? Eval("pMacID").ToString() :
                Eval("curStatus").ToString().Equals("Available") && Eval("curTaskID") != DBNull.Value && Convert.ToInt32(Eval("curTaskID")) > 0 ? "&#10004;" : string.Empty;
            System.Text.StringBuilder xPSMI = new System.Text.StringBuilder();

            string lnk = "&nbsp;&nbsp;<a style=\"text-decoration:underline; cursor:pointer;{3}\" onclick=\"{0}\" title=\"{2}\">{1}</a> ";
            string[] pi = Request.ServerVariables["PATH_INFO"].Split('/');

            string[] u = Eval("PSMI").ToString().Split(',');
            for (int i = 0; i < u.Length; i++)
            {
                if (!string.IsNullOrEmpty(u[i]))
                {
                    string[] v = u[i].Split(':');
                    string IDs = string.Format("{0}:{1}:0:{2}", Eval("WOID"), Eval("StepNo"), v[1]);
                    string url = string.Format("http://{0}/{2}/myTask.aspx?AppCode=WIP&IDs={1}", Request.ServerVariables["HTTP_HOST"], IDs, pi[1]);
                    xPSMI.AppendFormat(lnk, Util.popupURL(url, IDs.Replace(":", "_")), string.Format("&nbsp;{0}{1}&nbsp;", v[0], v.Length > 3 ? v[3] : string.Empty), v[0].Equals("P") ? "Program" : v[0].Equals("S") ? "Setup Sheet" :
                        v[0].Equals("T") ? "Tool" : v[0].Equals("M") ? "M.O.T" : "Inspection Sheet", v[2].Equals("0") ? "background-color:#FFFFFF; color:Red;" : string.Empty);
                }
            }

            if (xPSMI.Length > 0) xPSMI.Append("&nbsp;&nbsp;");
            return string.Format("{0}{1}", TU, xPSMI.ToString());
        }
        #endregion

        #region Schedule
        protected System.Drawing.Color gColor(string ID)
        {
            return System.Drawing.ColorTranslator.FromHtml(Eval(ID).ToString());
        }
        protected string sColor(string k)
        {
            return Convert.ToBoolean(Eval("isCur")) ? string.Format("<span style=\"background-color:{1}; color:{2}\">{0}</span>", Eval(k), Eval("BC"), Eval("FC")) :
                Eval("sugBC") != null && Eval("sugFC") != null ? string.Format("<span style=\"background-color:{1}; color:{2}\">{0}</span>", Eval(k), Eval("sugBC"), Eval("sugFC")) : Eval(k).ToString();
        }
        protected string sDate(string key)
        {
            string DD = !string.IsNullOrEmpty(Eval(key).ToString()) ? Convert.ToDateTime(Eval(key)).ToString(Util.AppSetting("DueDateFormat")) : string.Empty;
            return Convert.ToBoolean(Eval("isCur")) ? string.Format("<span style=\"background-color:{1}; color:{2}\">{0}</span>", DD, Eval("BC"), Eval("FC")) : DD;
        }
        protected string gDD()
        {
            DateTime DD = Convert.ToDateTime(Eval("DueDate"));
            string fColor = DateTime.Compare(DD, DateTime.Now) < 0 ? " style=\"color:Red;\"" : string.Empty;

            return string.Format("<span{0}>{1}</span>", fColor, DD.ToString(Util.DD_Format));
        }
        #endregion

        protected string gDate(string key, string iDF)
        {
            string xSt = Eval("curStatus").ToString(), rDD = "{0}";
            DateTime DD = Eval(key) != DBNull.Value ? Convert.ToDateTime(Eval(key)) : DateTime.MinValue;
            if (!DD.Equals(DateTime.MinValue) && (key.Equals("xDD") || (xSt.Equals("Running") && key.Equals("ECD")) || (xSt.Equals("Suggested") && key.Equals("DueDate"))) && DD.CompareTo(DateTime.Now) < 0)
            {
                rDD = "<span style=\"background-color:#FFFFFF; color:Red;\">{0}</span>";
            }
            return string.Format(rDD, DD.Equals(DateTime.MinValue) ? "No Date" : DD.ToString(iDF));
        }
        protected string gTime(string key)
        {
            if (Eval(key) != DBNull.Value)
            {
                TimeSpan ts = TimeSpan.FromSeconds(Convert.ToInt32(Eval(key)));
                return string.Format("{0} hrs {1} min", (ts.Days * 24) + ts.Hours, ts.Minutes);
            }
            else return "No Data";
        }
        protected void doReset(object sender, EventArgs e)
        {
            (new myBiz.DAL.clsMachine()).Machine_Suggest_Reset();
            doRefresh(sender, e);
        }
        protected void doRefresh(object sender, EventArgs e)
        {
            dlMacStatus.DataBind();
            gvMacSched.DataBind();
            litScRefresh.Text = litStRefresh.Text = string.Format("Last Updated: {0}", DateTime.Now);
        }
        protected void hfLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HiddenField hf = sender as HiddenField;

                System.Collections.Generic.List<string> s = new System.Collections.Generic.List<string>();
                if (hf.ID.Equals("hfStType"))
                {
                    if (isYN("k01")) s.Add("Lathe");
                    if (isYN("k02")) s.Add("Mill");
                    if (isYN("k03")) s.Add("Saw");
                    if (isYN("k04")) s.Add("Grinder");
                    if (isYN("k09")) s.Add("Deburr");
                    if (isYN("k11")) s.Add("ASE");
                    if (isYN("k12")) s.Add("FIN");
                }
                else
                {
                    if (isYN("k05")) s.Add("Lathe");
                    if (isYN("k06")) s.Add("Mill");
                    if (isYN("k07")) s.Add("Saw");
                    if (isYN("k08")) s.Add("Grinder");
                    if (isYN("k10")) s.Add("Deburr");
                    if (isYN("k13")) s.Add("ASE");
                    if (isYN("k14")) s.Add("FIN");
                }

                hf.Value = string.Join(":", s.ToArray());
            }
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnReset.Visible = isYN("k15");
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Lathe (Status)");
            PageSec.Add("k02", "Mill (Status)");
            PageSec.Add("k03", "Saw (Status)");
            PageSec.Add("k04", "Grinder (Status)");
            PageSec.Add("k09", "Deburr (Status)");
            PageSec.Add("k11", "ASE (Status)");
            PageSec.Add("k12", "FIN (Status)");

            PageSec.Add("k05", "Lathe (Schedule)");
            PageSec.Add("k06", "Mill (Schedule)");
            PageSec.Add("k07", "Saw (Schedule)");
            PageSec.Add("k08", "Grinder (Schedule)");
            PageSec.Add("k10", "Deburr (Schedule)");
            PageSec.Add("k13", "ASE (Schedule)");
            PageSec.Add("k14", "FIN (Schedule)");

            PageSec.Add("k15", "Reset Button");
        }
    }
}