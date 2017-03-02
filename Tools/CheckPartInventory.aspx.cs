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

namespace webApp.Tools
{
    public partial class CheckPartInventory : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("Tools/Check Part Inventory"))
            {
                chkInv.myEvent += new Common.myDelegate(chkInv_myEvent);
                ucInvU.myEvent += new Common.myDelegate(ucInvU_myEvent);
            }
        }

        protected void ucInvU_myEvent(Hashtable h)
        {
            chkInv.Refresh();
        }
        protected void doCheck(object sender, EventArgs e)
        {
            chkInv.WOID = 0;
            string[] x = { " Rev. " };
            string[] v = txtPartNumber.Text.Trim().Split(x, StringSplitOptions.None);

            if (ddlLocation.SelectedIndex > 0)
            {
                chkInvByLoc.WO = txtWO.Text.Trim(); chkInv.WO = chkInv.PN = chkInv.RV = string.Empty;
                try { chkInvByLoc.PN = v[0]; chkInvByLoc.RV = v[1]; }
                catch { chkInvByLoc.PN = chkInvByLoc.RV = string.Empty; }
                chkInvByLoc.LocID = Convert.ToInt32(ddlLocation.SelectedValue);
                pnlIU.Visible = btnInvUpdate.Visible = PrtInfo.Visible = false;
            }
            else
            {
                chkInvByLoc.LocID = -1; chkInvByLoc.WO = chkInvByLoc.PN = chkInvByLoc.RV = string.Empty;
                try { chkInv.PN = v[0]; chkInv.RV = v[1]; }
                catch { chkInv.PN = chkInv.RV = string.Empty; }

                if (!string.IsNullOrEmpty(chkInv.PN) && !string.IsNullOrEmpty(chkInv.RV))
                {
                    chkInv.WO = string.Empty;
                }
                else if (myBiz.Tools.clsValidator.isNumeric(txtWO.Text.Replace("-", string.Empty)))
                {
                    chkInv.WO = txtWO.Text.Trim();
                }
                else
                {
                    chkInv.WO = string.Empty;
                    iMsg.ShowErr("Please enter valid Work Order or Part Number before continue.", true);
                }
                pnlIU.Visible = btnInvUpdate.Visible = !string.IsNullOrEmpty(chkInv.WO) && isYN("k02");
            }
            chkInv.doCheck(); chkInvByLoc.doCheck();
        }
        protected void chkInv_myEvent(Hashtable h)
        {
            if (Convert.ToBoolean(h["Success"]))
            {
                if (btnInvUpdate.Visible) pnlIU.Visible = btnInvUpdate.Visible = Convert.ToBoolean(h["AllowUpdate"]);
                if (btnInvUpdate.Visible) ucInvU.WOID = chkInv.WOID;
                PrtInfo.PartID = Convert.ToInt32(h["PartID"]);
                PrtInfo.PN = chkInv.PN;
                PrtInfo.RV = chkInv.RV;
                PrtInfo.PartName = Convert.ToString(h["PartName"]);
                btnPrintPreview.Visible = PrtInfo.Visible && isYN("k01");
                btnPrintPreview.OnClientClick = string.Format("javascript:loadPreview({0});return false;", PrtInfo.PartID);
            }
            else
            {
                iMsg.ShowErr("No record found!", true);
                btnPrintPreview.Visible = PrtInfo.Visible = pnlIU.Visible = btnInvUpdate.Visible = false;
            }
        }
        protected void doReset(object sender, EventArgs e)
        {
            chkInvByLoc.Visible = btnPrintPreview.Visible = chkInv.Visible = PrtInfo.Visible = pnlIU.Visible = btnInvUpdate.Visible = false;
            txtWO.Text = txtPartNumber.Text = string.Empty; ddlLocation.SelectedIndex = 0;
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Print Preview");
            PageSec.Add("k02", "Update");
            PageSec.Add("k03", "Check");
            PageSec.Add("k04", "Reset");
            PageSec.Add("k05", "Upload Part Picture");
            PageSec.Add("k06", "Delete Part Picture");
            PageSec.Add("k07", "Override Edit");
            PageSec.Add("k08", "Edit Location Only");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnCheck.Visible = isYN("k03");
            btnReset.Visible = isYN("k04");
            PrtInfo.isUpload = isYN("k05");
            PrtInfo.isDelete = isYN("k06");
            ucInvU.isOverride = isYN("k07");
            ucInvU.isLocOnly = isYN("k08");
        }
    }
}