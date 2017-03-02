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
using myBiz.Tools;

namespace webApp._Controls
{
    public partial class QueueActivity : UserControl
    {
        private clsUtils Util = clsUtils.myUtil;

        protected void Page_Init(object sender, EventArgs e) { hfUID.Value = Common.clsUser.uID; }
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("WIP/QueueActivity");
        }
        protected void Rw_Bound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                switch (e.Row.Cells[0].Text)
                {
                    case "Sales": e.Row.Visible = isYN("k01"); break;
                    case "Purchasing": e.Row.Visible = isYN("k33"); break;
                    case "Engineer": e.Row.Visible = isYN("k02"); break;
                    case "Quality": e.Row.Visible = isYN("k03"); break;
                    case "Inventory": e.Row.Visible = isYN("k04"); break;
                    case "Shipping": e.Row.Visible = isYN("k05"); break;
                    case "Delivery": e.Row.Visible = isYN("k06"); break;
                    case "Billing": e.Row.Visible = isYN("k07"); break;
                    case "ASE": e.Row.Visible = isYN("k08"); break;
                    case "LATHE": e.Row.Visible = isYN("k09"); break;
                    case "MILL": e.Row.Visible = isYN("k10"); break;
                    case "OPS": e.Row.Visible = isYN("k11"); break;
                    case "RIM": e.Row.Visible = isYN("k12"); break;
                    case "SAW": e.Row.Visible = isYN("k13"); break;
                    case "FIN": e.Row.Visible = isYN("k14"); break;
                    case "HF": e.Row.Visible = isYN("k15"); break;
                    case "Open Order": e.Row.Visible = isYN("k26"); break;
                    case "Receive Order": e.Row.Visible = isYN("k16"); break;
                    case "Verify Order": e.Row.Visible = isYN("k17"); break;
                    case "Enter Bill": e.Row.Visible = isYN("k18"); break;
                    case "Pay Bill": e.Row.Visible = isYN("k19"); break;
                    case "Unpaid Invoices": e.Row.Visible = isYN("k20"); break;
                    case "Apply Payment": e.Row.Visible = isYN("k21"); break;
                    case "Q - Sales": e.Row.Visible = isYN("k22"); break;
                    case "Q - Engineer": e.Row.Visible = isYN("k23"); break;
                    case "Q - Final Quote": e.Row.Visible = isYN("k24"); break;
                    case "Q - Follow Up": e.Row.Visible = isYN("k25"); break;
                    case "Customer Follow Up": e.Row.Visible = isYN("k27"); break;
                    case "New Customer RFQs": e.Row.Visible = isYN("k28"); break;
                    case "P-Customer Follow Up": e.Row.Visible = isYN("k29"); break;
                    case "New Customer POs": e.Row.Visible = isYN("k30"); break;
                    case "PAM": e.Row.Visible = isYN("k31"); break;
                    case "Review New POs": e.Row.Visible = isYN("k32"); break;
                }
            }
        }
        protected void Rw_Cmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("cmdTotal") || e.CommandName.Equals("cmdLate") || e.CommandName.Equals("cmdBeLate"))
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int DeptID = Convert.ToInt32(gvQueue.DataKeys[index].Values["DeptID"]);
                int StepID = Convert.ToInt32(gvQueue.DataKeys[index].Values["StepID"]);
                string AppCode = Convert.ToString(gvQueue.DataKeys[index].Values["AppCode"]);
                string lMode = e.CommandName.Equals("cmdTotal") ? "Total" : e.CommandName.Equals("cmdLate") ? "Late" : "beLate";

                if (DeptID == 0 && StepID == 0) loadPg(gvQueue.DataKeys[index].Values["Name"].ToString(), lMode);
                else
                {
                    bool isStep = DeptID < 0, isWIP = AppCode.Equals("WIP");
                    odsQueue2.SelectParameters["mID"].DefaultValue = isStep ? StepID.ToString() : DeptID.ToString();
                    odsQueue2.SelectParameters["isD"].DefaultValue = isStep ? "0" : "1";
                    odsQueue2.SelectParameters["LateMode"].DefaultValue = lMode;
                    odsQueue2.SelectParameters["UN"].DefaultValue = Common.clsUser.uID;
                    odsQueue2.SelectParameters["AppCode"].DefaultValue = AppCode;
                    odsQueue2.DataBind(); gvQueue.SelectedIndex = index;
                    ViewState.Add("mID", isStep ? StepID : DeptID);
                    ViewState.Add("isD", isStep ? 0 : 1);
                    gvQueue2.Columns[5].Visible = isStep && isWIP;
                    gvQueue2.Columns[6].Visible = !isWIP;
                    gvQueue2.Columns[8].Visible = gvQueue2.Columns[9].Visible = isWIP;
                    gvQueue2.Columns[1].HeaderText = isWIP ? "WO#" : "QTE#";
                }
            }
        }
        private void loadPg(string Nm, string lMode)
        {
            if (lMode.Equals("Total")) lMode = string.Empty;
            else lMode = string.Format("?lMode={0}", lMode);

            switch (Nm)
            {
                case "Open Order": Response.Redirect(string.Format("Purchasing/OpenPO.aspx{0}", lMode), true); break;
                case "Receive Order": Response.Redirect(string.Format("Purchasing/OpenPOMix.aspx{0}", lMode), true); break;
                case "Verify Order": Response.Redirect(string.Format("Purchasing/RecdPO.aspx{0}", lMode), true); break;
                case "Enter Bill": Response.Redirect(string.Format("Purchasing/VerifiedPO.aspx{0}", lMode), true); break;
                case "Pay Bill": Response.Redirect(string.Format("Purchasing/BilledPO.aspx{0}", lMode), true); break;
                case "Unpaid Invoices": Response.Redirect(string.Format("Purchasing/AppliedPayment.aspx{0}", lMode), true); break;
                case "Apply Payment": Response.Redirect(string.Format("Purchasing/AppliedPayment.aspx{0}", lMode.Replace("lMode", "xMode")), true); break;
                case "Q - Follow Up": Response.Redirect(string.Format("RFQ/FollowUp.aspx{0}", lMode), true); break;
                case "Customer Follow Up": Response.Redirect(string.Format("RFQ/CustFU.aspx{0}", lMode), true); break;
                case "New Customer RFQs": Response.Redirect(string.Format("RFQ/RFQEntryQueue.aspx{0}", lMode), true); break;
                case "P-Customer Follow Up": Response.Redirect(string.Format("RFQ/PoCustFU.aspx{0}", lMode), true); break;
                case "New Customer POs": Response.Redirect(string.Format("Tools/QueueCustomerPO.aspx{0}", lMode), true); break;
                case "Review New POs": Response.Redirect(string.Format("Tools/ReviewCustomerPO.aspx{0}", lMode), true); break;
            }
        }
        protected string gPN()
        {
            var xSt = Eval("xSt").ToString();
            var style = !string.IsNullOrWhiteSpace(xSt) ? string.Format("<span style=\"{1}\">{0}</span>", xSt, Util.AppSetting("StatusStyle")) : string.Empty;

            return string.Format("{0}{1}", Eval("PartNumber"), style);
        }
        protected string gDD()
        {
            try
            {
                string fColor = string.Empty;
                switch (Eval("lMode").ToString())
                {
                    case "beLate": fColor = " style=\"color:Brown;\""; break;
                    case "Late": fColor = " style=\"color:Red;\""; break;
                }

                DateTime DD = Convert.ToDateTime(Eval("DueDate"));
                return string.Format("<span{0}>{1}</span>", fColor, DD.ToString(Util.DD_Format));
            }
            catch
            {
                return "No Date";
            }
        }
        protected string cStatus()
        {
            string macStyle = clsUtils.myUtil.AppSetting("MachineStyle"), macBold = "font-weight:bold";
            string mStyle = Eval("mStyle").ToString();
            string mpID = mStyle.Equals("GoodCntComplete") ? string.Format("<span style=\"{1}\">{0}</span>", Eval("MPID"), macBold) :
            mStyle.Equals("useAST") ? string.Format("<span style=\"{1}\">{0}</span>", Eval("MPID"), macStyle) : Eval("MPID").ToString();
            return string.Format("{0} {1} {2}", Eval("curStatus"), mpID, Eval("OpNo"));
        }
        public string gLink()
        {
            string[] pi = Request.ServerVariables["PATH_INFO"].Split('/');
            int mID = Convert.ToInt32(ViewState["isD"]) == 0 ? Convert.ToInt32(Eval("StepNo")) : Convert.ToInt32(ViewState["mID"]);
            string IDs = string.Format("{0}:{1}:{2}", Eval("HID"), mID, ViewState["isD"]);
            string url = string.Format("http://{0}/{3}/{2}/TaskList.aspx?AppCode={2}&IDs={1}", Request.ServerVariables["HTTP_HOST"], IDs, Eval("AppCode"), pi[1]);
            return Util.popupURL(url, IDs.Replace(":", "_"));
        }

        private void loadSec(string PageName)
        {
            if (!IsPostBack && PageSec.Count < 1)
            {
                enforceSecurity();
                PageSec = Common.clsUser.prepareSecurity(PageName, PageSec);
                //Util.getPageSec(enforceSecurity(), PageName, Request.ServerVariables["URL"].ToLower(), PageSec);
            }
        }
        private Hashtable PageSec
        {
            set { ViewState["PageSec"] = value; }
            get
            {
                if (ViewState["PageSec"] == null) ViewState["PageSec"] = new Hashtable();
                return ViewState["PageSec"] as Hashtable;
            }
        }
        //check if a person has access to the page or functions of a page
        private bool isYN(string key) { return PageSec.ContainsKey(key) && Convert.ToBoolean(PageSec[key]); }
        private void enforceSecurity()
        {
            PageSec.Add("k01", "Sales");
            PageSec.Add("k02", "Engineer");
            PageSec.Add("k03", "Quality");
            PageSec.Add("k04", "Inventory");
            PageSec.Add("k05", "Shipping");
            PageSec.Add("k06", "Delivery");
            PageSec.Add("k07", "Billing");
            PageSec.Add("k08", "ASE");
            PageSec.Add("k09", "LATHE");
            PageSec.Add("k10", "MILL");
            PageSec.Add("k11", "OPS");
            PageSec.Add("k12", "RIM");
            PageSec.Add("k13", "SAW");
            PageSec.Add("k14", "FIN");
            PageSec.Add("k15", "HF");
            PageSec.Add("k26", "Open Order");
            PageSec.Add("k16", "Receive Order");
            PageSec.Add("k17", "Verify Order");
            PageSec.Add("k18", "Enter Bill");
            PageSec.Add("k19", "Pay Bills");
            PageSec.Add("k20", "Unpaid Invoices");
            PageSec.Add("k21", "Apply Payment");
            PageSec.Add("k22", "Q - Sales");
            PageSec.Add("k23", "Q - Engineer");
            PageSec.Add("k24", "Q - Final Quote");
            PageSec.Add("k25", "Q - Follow Up");
            PageSec.Add("k27", "Customer Follow Up");
            PageSec.Add("k28", "New Customer RFQs");
            PageSec.Add("k29", "P-Customer Follow Up");
            PageSec.Add("k30", "New Customer POs");
            PageSec.Add("k31", "PAM");
            PageSec.Add("k32", "Review New POs");
            PageSec.Add("k33", "Purchasing");
        }
    }
}