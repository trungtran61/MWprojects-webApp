using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.RFQ
{
    public partial class gtSelect : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            uMOGT.myEvent += new Common.myDelegate(mogtEvent);
            if (!IsPostBack)
            {
                gvGageTool.Enabled = imgSearch.Enabled = cpeSearch.Enabled = pnlSearch.Visible = Request.QueryString["vW"] == null;
                if (imgSearch.Enabled) uMOGT.MOGT = Request.QueryString["GageTool"];
            }
        }
        protected void mogtEvent(System.Collections.Hashtable h)
        {
            string GT = _isGage ? "G" : "T";
            Control Rw = myBiz.Tools.clsUtils.myUtil.isEmpty(gvGageTool) ? gvGageTool.Controls[0].Controls[0] : gvGageTool.FooterRow;
            var ddlName = Rw.FindControl(string.Format("ddl{0}Name", GT)) as DropDownList;
            var gvDmsList = Rw.FindControl(string.Format("gv{0}DmsList", GT)) as GridView;
            var odsDL = Rw.FindControl(string.Format("ods{0}DmsList", GT)) as ObjectDataSource;

            if (!_isGage)
            {
                try { (Rw.FindControl("ddlTType") as DropDownList).SelectedValue = h["GTTypeID"].ToString(); }
                catch { }
            }

            try { ddlName.DataBind(); ddlName.SelectedValue = h["GTNameID"].ToString(); }
            catch { }

            try { odsDL.SelectParameters["BDID"].DefaultValue = h["BDID"].ToString(); odsDL.DataBind(); gvDmsList.DataBind(); }
            catch { }
        }
        private bool exDmsVal(GridView gv, out string DmsID, out string dVal, out string dUnit)
        {
            bool isGood = true;
            List<string> pID = new List<string>(), pVal = new List<string>(), pUnit = new List<string>();
            for (int i = 0; i < gv.Rows.Count && isGood; i++)
            {
                var Rw = gv.Rows[i];
                var xVal = (Rw.FindControl("txtVal") as TextBox).Text;
                var xUnit = (Rw.FindControl("ddlUnit") as DropDownList).SelectedValue;
                isGood = !string.IsNullOrEmpty(xVal) && !string.IsNullOrEmpty(xUnit);

                if (isGood)
                {
                    pID.Add((Rw.FindControl("hfHID") as HiddenField).Value);
                    pVal.Add(xVal);
                    pUnit.Add(xUnit);
                }
            }
            DmsID = string.Join(":", pID.ToArray());
            dVal = string.Join(":", pVal.ToArray());
            dUnit = string.Join(":", pUnit.ToArray());

            return isGood;
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew") || e.CommandName.Equals("InsertNew"))
            {
                string DmsID, dVal, dUnit;
                string GT = _isGage ? "G" : "T";

                Control Rw = e.CommandName.Equals("AddNew") ? gvGageTool.FooterRow : gvGageTool.Controls[0].Controls[0];
                if (exDmsVal(Rw.FindControl(string.Format("gv{0}DmsList", GT)) as GridView, out DmsID, out dVal, out dUnit))
                {
                    odsGageTool.InsertParameters["GTDesc"].DefaultValue = (Rw.FindControl("txtGTDesc") as TextBox).Text;
                    odsGageTool.InsertParameters["Qty"].DefaultValue = (Rw.FindControl("txtQty") as TextBox).Text;
                    odsGageTool.InsertParameters["PID"].DefaultValue = (Rw.FindControl("ddlProCate") as DropDownList).SelectedValue;
                    odsGageTool.InsertParameters["GTNameID"].DefaultValue = (Rw.FindControl(string.Format("ddl{0}Name", GT)) as DropDownList).SelectedValue;
                    odsGageTool.InsertParameters["DmsID"].DefaultValue = DmsID;
                    odsGageTool.InsertParameters["dVal"].DefaultValue = dVal;
                    odsGageTool.InsertParameters["dUnit"].DefaultValue = dUnit;
                    odsGageTool.Insert();
                    iMsg.ShowMsg("Thank you! New item has been added.", true);
                }
                else iMsg.ShowErr("Sorry! All dimensions are required.", true);
            }
        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            bool isGage = _isGage;
            if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.Header) e.Row.Cells[3].Visible = !isGage;

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[3].Visible = !isGage;
                e.Row.FindControl("ddlTName").Visible = e.Row.FindControl("gvTDmsList").Visible = !isGage;
                e.Row.FindControl("ddlGName").Visible = e.Row.FindControl("gvGDmsList").Visible = isGage;
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.FindControl("rptTDmsList").Visible = !isGage;
                e.Row.FindControl("rptGDmsList").Visible = isGage;
            }
            else if (e.Row.RowType == DataControlRowType.EmptyDataRow)
            {
                e.Row.FindControl("tdKType").Visible = e.Row.FindControl("tdVType").Visible = !isGage;
                e.Row.FindControl("ddlTName").Visible = e.Row.FindControl("gvTDmsList").Visible = !isGage;
                e.Row.FindControl("ddlGName").Visible = e.Row.FindControl("gvGDmsList").Visible = isGage;
            }
        }
        protected void ddlSelected(object sender, EventArgs e)
        {
            var Rw = (sender as DropDownList).NamingContainer as GridViewRow;
            (Rw.FindControl("ddlTName") as DropDownList).DataBind();
            (Rw.FindControl("gvTDmsList") as GridView).DataBind();
        }
        protected void lblLoad(object sender, EventArgs e)
        {
            (sender as Label).Text = string.Format("{0}s: #{1}: {2}", Request.QueryString["GageTool"], Request.QueryString["sNo"], Request.QueryString["sNm"]);
        }
        protected string qHeader()
        {
            return Request.QueryString["GageTool"].Equals("Tool") ? "Part<br>/Tool" : "Qty";
        }
        protected void odsDeleted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception.InnerException != null)
            {
                iMsg.ShowErr(e.Exception.InnerException.Message, true);
                e.ExceptionHandled = true;
            }
        }
        private bool _isGage { get { return Request.QueryString["GageTool"].Equals("Gage"); } }
    }
}