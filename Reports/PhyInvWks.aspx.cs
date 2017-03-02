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
using myBiz.DAL;

namespace webApp.Reports
{
    public partial class PhyInvWks : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Report/Physical Inventory Worksheet");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnGo.Visible = isYN("k01");
            btnDownload.Visible = isYN("k02");
        }
        protected void cblPreRender(object sender, EventArgs e)
        {
            if (!IsPostBack) cblLocation.Items[0].Text = "All Locations";
        }
        protected void doPreview(object sender, EventArgs e) { gvPhy.DataBind(); }
        protected void doDownload(object sender, EventArgs e)
        {
            DataTable Tb = (new clsReport()).PhyInvWks_S(cblLocation.SelectedValues, Convert.ToInt32(ddlCustomer.SelectedValue));
            Hashtable hashForm = new Hashtable();
            hashForm.Add("TodayDate", DateTime.Now);
            hashForm.Add("CustomerName", ddlCustomer.SelectedItem.Text);
            Hashtable h = new Hashtable(); h.Add("hashForm", hashForm); h.Add("RowList", Tb);
            myBiz.Tools.clsPDF objPdf = new myBiz.Tools.clsPDF(Util.AppSetting("FormPath"), "PhyInvWks");
            objPdf.DF = "MMMM dd, yyyy";
            Response.ClearHeaders(); Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", string.Format("attachment;filename={0}.pdf", "PhyInvWks"));
            System.IO.MemoryStream os = objPdf.getPdf(h);
            Response.BinaryWrite(os.GetBuffer());
            os.Close();
            Response.End();
        }
        protected void ddlPreRender(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlCustomer.Items[0].Text = "All Customers";
            }
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            gvPhy.AllowPaging = !ddl.SelectedValue.Equals("*");
            if (gvPhy.AllowPaging) gvPhy.PageSize = Convert.ToInt32(ddl.SelectedValue);
            ddlIndex = ddl.SelectedIndex;
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header) (e.Row.FindControl("ddlDisplay") as DropDownList).SelectedIndex = ddlIndex;
        }
        private int ddlIndex
        {
            get { return ViewState["ddlIndex"] != null ? Convert.ToInt32(ViewState["ddlIndex"]) : 1; }
            set { ViewState["ddlIndex"] = value; }
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Preview");
            PageSec.Add("k02", "Download PDF");
        }
    }
}