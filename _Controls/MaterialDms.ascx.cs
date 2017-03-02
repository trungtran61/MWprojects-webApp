using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class MaterialDms : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void rwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var isYN = CurrentMode.Equals("Item");
                e.Row.FindControl("litVal").Visible = isYN;
                e.Row.FindControl("txtVal").Visible = e.Row.FindControl("ddlUnit").Visible = !isYN;
            }
        }
        protected string dVal()
        {
            return "test";
            //return string.Format("{0}: {1}{2}", Eval("MatlDms"), Eval("dVal"), Eval("dUnit"));
        }
        public string CurrentMode
        {
            get { return hfCurrentMode.Value; }
            set { hfCurrentMode.Value = value; }
        }
        public int mID
        {
            set
            {
                if (CurrentMode.Equals("Item"))
                {
                    var objDms = new myBiz.DAL.clsMaterial();
                    gvDmsList.DataSource = CurrentMode.Equals("Footer") ? objDms.Material_Dms_S(2, 1) : objDms.Material_DmsVal_S(value);
                    gvDmsList.DataBind();
                }
            }
        }
    }
}