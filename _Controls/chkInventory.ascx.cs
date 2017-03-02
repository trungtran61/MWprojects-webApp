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

namespace webApp._Controls
{
    public partial class chkInventory : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) doCheck();
        }
        protected void ddlChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            gvSold.AllowPaging = !ddl.SelectedValue.Equals("*");
            if (gvSold.AllowPaging) gvSold.PageSize = Convert.ToInt32(ddl.SelectedValue);
            //ddlIndex = ddl.SelectedIndex;
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            DataTable Tb = (new myBiz.DAL.clsPartInv()).Check_Variables(WO, WOID, PN, RV);
            Hashtable h = new Hashtable();
            if (Tb != null && Tb.Rows.Count > 0 && Convert.ToInt32(Tb.Rows[0]["PartID"]) > 0)
            {
                h.Add("Success", true);
                h.Add("PartID", Tb.Rows[0]["PartID"]);
                h.Add("PartName", Tb.Rows[0]["PartName"]);
                isGood = Convert.ToBoolean(Tb.Rows[0]["isGood"]);
                h.Add("AllowUpdate", Convert.ToBoolean(Tb.Rows[0]["AllowUpdate"]));
                hfWOID.Value = Tb.Rows[0]["WOID"].ToString();
                hfPN.Value = Tb.Rows[0]["PartNumber"].ToString();
                hfRV.Value = Tb.Rows[0]["Revision"].ToString();

                litAvailable.Text = Tb.Rows[0]["Available"].ToString();
                litAllocated.Text = Tb.Rows[0]["Allocated"].ToString();
                litOnHand.Text = Tb.Rows[0]["OnHand"].ToString();
                litCommitted.Text = Tb.Rows[0]["Committed"].ToString();
                litTotalSoldMade.Text = string.Format("[Sold: {0}; Total Made: {1}]", Tb.Rows[0]["Sold"], Tb.Rows[0]["ttMade"]);
                litIncompleted.Text = Tb.Rows[0]["Incompleted"].ToString();
                litNeed.Text = Tb.Rows[0]["Needed"].ToString();
                litResult.Text = isGood ? "Yes, Enough!" : "No, Not Enough!";
                if (trUsePart.Visible && !isGood) gvAvailable.Columns[0].Visible = btnUsePart.Visible = false;
                else if (trUsePart.Visible && isGood && Convert.ToBoolean(Tb.Rows[0]["hasTraveler"]))
                {
                    gvAvailable.Columns[0].Visible = btnUsePart.Visible = false;
                    litResult.Text = "There is already a Job traveler for this Work Order";
                }
            }
            else
            {
                h.Add("Success", false); this.Visible = false;
            }
            this.myEvent(h);
        }
        public void doCheck()
        {
            this.Visible = WOID > 0 || !string.IsNullOrEmpty(WO) || (!string.IsNullOrEmpty(PN) && !string.IsNullOrEmpty(RV));
        }
        public bool isGood
        {
            get { return Convert.ToBoolean(hfIsGood.Value); }
            set { hfIsGood.Value = value.ToString(); }
        }
        public int WOID
        {
            set { hfWOID.Value = value.ToString(); gvAvailable.Columns[0].Visible = trUsePart.Visible = string.IsNullOrEmpty(WO) && value > 0; }
            get { return Convert.ToInt32(hfWOID.Value); }
        }
        public string PN
        {
            set { hfPN.Value = value; }
            get { return hfPN.Value; }
        }
        public string RV
        {
            set { hfRV.Value = value; }
            get { return hfRV.Value; }
        }
        public string WO
        {
            set { hfWO.Value = value; }
            get { return hfWO.Value; }
        }
        protected void usePart(object sender, EventArgs e)
        {
            string iIDs = string.Empty;
            for (int i = 0; i < gvAvailable.Rows.Count; i++)
            {
                GridViewRow Rw = gvAvailable.Rows[i];
                if ((Rw.FindControl("chkItem") as CheckBox).Checked)
                    iIDs += string.Format("{0}:", gvAvailable.DataKeys[i].Value);
            }
            var x = new myBiz.DAL.clsPartInv();
            if (x.usePart(WOID, iIDs))
                iMsg.ShowMsg("Thank You! You have successfully used the part for this order.", true);
            else iMsg.ShowErr("Sorry! You cannot use the part for this order.", true);
            pnlUsePart.Visible = false;
        }
        public void Refresh()
        {
            odsAllocated.DataBind(); gvAllocated.DataBind();
            odsAvailable.DataBind(); gvAvailable.DataBind();
            odsCommitted.DataBind(); gvCommitted.DataBind();
            odsSold.DataBind(); gvSold.DataBind();
        }
    }
}