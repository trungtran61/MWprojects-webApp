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

namespace webApp.RFQ
{
    public partial class TaskList : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("RFQ/TaskList"))
            {
                if (!goodEntry()) Response.Redirect("../Errors/InvalidPopup.aspx");
                else if (IsPostBack) reloadTasks();
                else if (!string.IsNullOrEmpty(Request.QueryString["IDs"]))
                {
                    Hashtable h = myBiz.DAL.clsDB.getTaskTitle(Request.QueryString["IDs"]);
                    ((_MasterPage.MiniMaster)Master).setInfo(h);
                    pgTitle = h["pgTitle"].ToString();
                }
                this.Title = pgTitle;
            }
        }
        private DataTable gFilter(DataView Dv, string colName)
        {
            if (colName.Equals("dStepNo")) Dv.Sort = "dStepNo ASC";
            DataTable Tb = Dv.ToTable(true, colName); Tb.Rows.InsertAt(Tb.NewRow(), 0);
            return Tb;
        }
        //protected void stLoad(object sender, EventArgs e)
        //{
        //    Literal lit = sender as Literal;
        //    string[] v = Request.QueryString["IDs"].Split(':');
        //    DataTable Tb = (new myBiz.DAL.clsWorkOrder()).curStatus(Convert.ToInt32(v[0]));
        //    if (Tb != null && Tb.Rows.Count > 0)
        //    {
        //        lit.Text = string.Format("<b>Status:</b> {0}<br><b>Location:</b> {1}", Tb.Rows[0]["curStatus"], Tb.Rows[0]["curLocation"]);
        //    }
        //    else lit.Text = string.Empty;
        //}
        protected void rwCmd(object sender, CommandEventArgs e)
        {
            if (e.CommandName.Equals("markComplete"))
            {
                odsTask.UpdateParameters["HID"].DefaultValue = e.CommandArgument.ToString();
                odsTask.Update();
            }
        }
        protected void gvBound(object sender, EventArgs e) { reloadTasks(); }
        protected void gvPreRender(object sender, EventArgs e)
        {
            if (gvTask.Rows.Count > 0)
            {
                gvTask.UseAccessibleHeader = true;
                gvTask.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex > -1 && (e.Row.RowState == DataControlRowState.Alternate || e.Row.RowState == DataControlRowState.Normal))
            {
                Control lnk = e.Row.FindControl("lnkComplete");
                lnk.Visible = false;// !(e.Row.Cells[5].Text.Equals("Completed") || (e.Row.FindControl("lblName") as Literal).Text.Contains("Upload"));
                e.Row.FindControl("litComplete").Visible = !lnk.Visible;
            }
            else if (e.Row.RowType == DataControlRowType.Header)
            {
                var x = new myBiz.DAL.clsTaskList(); DataView Dv = x.Select_RFQ(Request.QueryString["IDs"]).DefaultView;
                DropDownList ddlStepNo = e.Row.FindControl("ddlStepNo") as DropDownList;
                DropDownList ddlTaskey = e.Row.FindControl("ddlTaskey") as DropDownList;
                DropDownList ddlTaskName = e.Row.FindControl("ddlTaskName") as DropDownList;

                ddlStepNo.DataSource = gFilter(Dv, "dStepNo"); ddlStepNo.DataBind(); ddlStepNo.SelectedValue = xStepNo;
                ddlTaskey.DataSource = gFilter(Dv, "Taskey"); ddlTaskey.DataBind(); ddlTaskey.SelectedValue = xTaskey;
                ddlTaskName.DataSource = gFilter(Dv, "dTaskName"); ddlTaskName.DataBind(); ddlTaskName.SelectedValue = xTaskName;
            }
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            switch (ddl.ID)
            {
                case "ddlStepNo": odsTask.SelectParameters["StepNo"].DefaultValue = xStepNo = ddl.SelectedValue; break;
                case "ddlTaskey": odsTask.SelectParameters["Taskey"].DefaultValue = xTaskey = ddl.SelectedValue; break;
                case "ddlTaskName": odsTask.SelectParameters["TaskName"].DefaultValue = xTaskName = ddl.SelectedValue; break;
            }
            odsTask.DataBind(); gvTask.DataBind();
        }
        protected void reloadTasks() { }
        //protected void reloadTasks1()
        //{
        //    foreach (GridViewRow Rw in gvTask.Rows)
        //    {
        //        Panel pnlTask = (Panel)Rw.FindControl("pnlTask"); pnlTask.Controls.Clear();
        //        pnlTask.Controls.Add(gControl(((HiddenField)Rw.FindControl("hfUC")).Value));
        //    }
        //}
        protected void lTral(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string[] v = Request.QueryString["IDs"].Split(':');
                bool isTral = (sender as Control).ID.Equals("lnkTraveler");
                string url = isTral ? string.Format("../File/Preview.aspx?Tt=OhYeah&FID=Router&Code=Router&HID={0}", v[0]) :
                    string.Format("../Note/Note.aspx?lDB=RFQ&lID={0}", v[0]);
                string Klick = string.Format("javascript:{1}('{0}');return false;", url, isTral ? "lPopup" : "xPopup");

                if (isTral) (sender as LinkButton).OnClientClick = Klick;
                else
                {
                    ImageButton btn = sender as ImageButton;
                    btn.OnClientClick = Klick;
                    btn.ImageUrl = string.Format("~/App_Themes/{0}", (new clsWorkOrder()).btnEdit(Convert.ToInt32(v[0]), Common.clsUser.uID));
                }
            }
        }
        //private UserControl gControl(string ucFile)
        //{
        //    if (string.IsNullOrEmpty(ucFile)) ucFile = "notAvailable";
        //    UserControl x = (UserControl)LoadControl(string.Format("~/UserControl/{0}.ascx", ucFile)); x.ID = string.Format("uc{0}", ucFile);
        //    Delegate D = Delegate.CreateDelegate(x.GetType().GetEvent("myEvent").EventHandlerType, this, "mEvent");
        //    x.GetType().GetEvent("myEvent").AddEventHandler(x, D); return x;
        //}
        protected void mEvent(Hashtable h) { }
        private bool goodEntry()
        {
            Response.AddHeader("pragma", "no-cache");
            Response.AddHeader("cache-control", "private");
            Response.CacheControl = "no-cache";
            Response.Cache.SetExpires(DateTime.Now.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            return !string.IsNullOrEmpty(Request.QueryString["IDs"]);
            //&& Request.UrlReferrer != null
            //&& Request.UrlReferrer.ToString().Contains("/myWIP/")
        }
        public System.Drawing.Color gColor(string ID)
        {
            return System.Drawing.ColorTranslator.FromHtml(Eval(ID).ToString());
        }
        private string pgTitle
        {
            get { return Convert.ToString(ViewState["pgTitle"]); }
            set { ViewState["pgTitle"] = value; }
        }
        private string xStepNo
        {
            get { return ViewState["xStepNo"] != null ? ViewState["xStepNo"].ToString() : string.Empty; }
            set { ViewState["xStepNo"] = value; }
        }
        private string xTaskey
        {
            get { return ViewState["xTaskey"] != null ? ViewState["xTaskey"].ToString() : string.Empty; }
            set { ViewState["xTaskey"] = value; }
        }
        private string xTaskName
        {
            get { return ViewState["xTaskName"] != null ? ViewState["xTaskName"].ToString() : string.Empty; }
            set { ViewState["xTaskName"] = value; }
        }
        public string gLink(string key)
        {
            string FC = key.Equals("dTaskName") ? "#000000" : Eval("FC").ToString();
            string IDs = string.Format("{0}:{1}", Request.QueryString["IDs"], Eval("HID"));
            string url = string.Format("../myTask.aspx?AppCode=RFQ&IDs={0}", IDs), style = Util.fColor(FC);
            string glight = key.Equals("dTaskName") && Convert.ToInt32(Eval("RFQCnt")) > 0 ? "<img src=\"../App_Themes/GreenLight.jpg\">" : string.Empty;
            return string.Format("<a href=\"javascript:void(0)\" onclick=\"{0}\" style=\"{2}\">{1}{3}</a>", Util.popupURL(url, IDs.Replace(":", "_")), Eval(key), style, glight);
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "View Blue Print");
            PageSec.Add("k02", "View Customer RFQ");
            PageSec.Add("k03", "View Traveler");
            PageSec.Add("k04", "View Customer Due Date");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            ucHeader.lnkPartNumber = isYN("k01");
            ucHeader.lnkCustomerPO = isYN("k02");
            ucHeader.showDueDate = isYN("k04");
            lnkTraveler.Visible = isYN("k03");
        }
    }
}