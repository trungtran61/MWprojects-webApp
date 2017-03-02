using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class DmsLib : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Dimension Library"))
            {
            }
        }
        protected void ddlSelected(object sender, EventArgs e)
        {
            gvDmsList.SelectedIndex = -1;
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            var iGV = sender as GridView;
            if (e.CommandName.Equals("AddNew") || e.CommandName.Equals("InsertNew"))
            {
                Control Rw = e.CommandName.Equals("AddNew") ? iGV.FooterRow : iGV.Controls[0].Controls[0];
                switch (iGV.ID)
                {
                    case "gvDmsList":
                        odsDmsList.UpdateParameters["HID"].DefaultValue = "-1";
                        odsDmsList.UpdateParameters["GenDms"].DefaultValue = (Rw.FindControl("txtGenDms") as TextBox).Text;
                        odsDmsList.Update();
                        iMsg.ShowMsg("Thank you! New Dimension has been added.", true);
                        break;
                    case "gvUnitList":
                        odsUnitList.UpdateParameters["HID"].DefaultValue = "-1";
                        odsUnitList.UpdateParameters["GenUnitTxt"].DefaultValue = (Rw.FindControl("txtGenUnitTxt") as TextBox).Text;
                        odsUnitList.UpdateParameters["GenUnitVal"].DefaultValue = (Rw.FindControl("txtGenUnitVal") as TextBox).Text;
                        odsUnitList.Update();
                        iMsg.ShowMsg("Thank you! New Unit has been added.", true);
                        break;
                }
            }

            if (!e.CommandName.Equals("Select")) iGV.SelectedIndex = -1;

            switch (iGV.ID)
            {
                case "gvDmsList": gvUnitList.SelectedIndex = -1; break;
            }
        }
        protected override void enforceSecurity()
        {
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            uPnlUnit.Visible = uPnlDms.Visible && gvDmsList.SelectedIndex > -1;
        }
    }
}