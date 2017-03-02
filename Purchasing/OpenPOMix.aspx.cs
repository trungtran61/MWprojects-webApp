using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using myBiz.DAL;

namespace webApp.Purchasing
{
    public partial class OpenPOMix : Common.pgAbstract
    {
        protected void Page_Init(object sender, EventArgs e) { hfUID.Value = Common.clsUser.uID; }
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Purchasing/Receive Orders");
        }

        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList ddl = e.Row.FindControl("ddlOpenDisplay") as DropDownList;
                ddl.SelectedIndex = OpenIndex;
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Button btn = e.Row.FindControl("btnLnk") as Button;
                btn.Visible = isYN("k01");

                if (btn.Visible)
                {
                    string IDs = (e.Row.FindControl("hfMixIDs") as HiddenField).Value;// "1300:1:0:48860";// string.Format("{0}:{1}", Request.QueryString["IDs"], Eval("HID"));
                    string url = IDs.Contains(":-1:-1:") ? string.Format("OpenPOMix_Task.aspx?AppCode=WIP&IDs={0}", IDs) : string.Format("../myTask.aspx?AppCode=WIP&IDs={0}", IDs);

                    btn.OnClientClick = Util.popupURL(url, IDs.Replace(":", "_").Replace("-", string.Empty));
                }
            }
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            gvOpenPO.PageSize = Convert.ToInt32(ddl.SelectedValue);
            OpenIndex = ddl.SelectedIndex;
        }
        private int OpenIndex
        {
            get { return ViewState["OpenIndex"] != null ? Convert.ToInt32(ViewState["OpenIndex"]) : 0; }
            set { ViewState["OpenIndex"] = value; }
        }
        public string gLink(string key)
        {
            string FC = key.Equals("dTaskName") ? "#000000" : Eval("FC").ToString();
            string IDs = string.Format("{0}:{1}", Request.QueryString["IDs"], Eval("HID"));
            string url = string.Format("../myTask.aspx?AppCode=WIP&IDs={0}", IDs), style = Util.fColor(FC);
            return string.Format("<a href=\"javascript:void(0)\" onclick=\"{0}\" style=\"{2}\">{1}</a>", Util.popupURL(url, IDs.Replace(":", "_")), Eval(key), style);
        }
        protected string gDD(string k)
        {
            try
            {
                string fColor = string.Empty;
                switch (Eval("lMode").ToString())
                {
                    case "beLate": fColor = " style=\"color:Brown;\""; break;
                    case "Late": fColor = " style=\"color:Red;\""; break;
                }

                DateTime DD = Convert.ToDateTime(Eval(k));
                return string.Format("<span{0}>{1}</span>", fColor, DD.ToString(Util.DD_Format));
            }
            catch
            {
                return "No Date";
            }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Update Material (RIM09)");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
        }
    }
}