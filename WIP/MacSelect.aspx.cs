using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace webApp.WIP
{
    public partial class MacSelect : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfcID.Value = Request.QueryString["cID"];
                lData("NULL");
            }
        }
        protected void btnClick(object sender, EventArgs e)
        {
            bool doReload = false;
            List<string> lIDs = new List<string>();
            foreach (ListItem i in lbxSelMac.Items) lIDs.Add(i.Value);

            switch ((sender as Control).ID)
            {
                case "btnAdd":
                    if (lbxUnselMac.SelectedIndex > -1)
                    {
                        doReload = true;
                        int[] idxes = lbxUnselMac.GetSelectedIndices();
                        foreach (int i in idxes) lIDs.Add(lbxUnselMac.Items[i].Value);
                        selIndex = lIDs.Count - 1;
                    }
                    break;
                case "btnRemove":
                    if (lbxSelMac.SelectedIndex > -1)
                    {
                        doReload = true;
                        int[] idxes = lbxSelMac.GetSelectedIndices();
                        foreach (int i in idxes) lIDs.Remove(lbxSelMac.Items[i].Value);
                        selIndex = -1;
                    }
                    break;
                case "btnMoveUp":
                    if (lbxSelMac.SelectedIndex > -1)
                    {
                        int[] idxes = lbxSelMac.GetSelectedIndices();
                        if (idxes.Length > 1) iMsg.ShowErr("Please select only one machine before you can move up or down.", true);
                        else
                        {
                            int idx = idxes[0];
                            if (idx > 0)
                            {
                                doReload = true;
                                lIDs.RemoveAt(idx);
                                lIDs.Insert(idx - 1, lbxSelMac.Items[idx].Value);
                                selIndex = idx - 1;
                            }
                        }
                    }
                    break;
                case "btnMoveDown":
                    if (lbxSelMac.SelectedIndex > -1)
                    {
                        int[] idxes = lbxSelMac.GetSelectedIndices();
                        if (idxes.Length > 1) iMsg.ShowErr("Please select only one machine before you can move up or down.", true);
                        else
                        {
                            int idx = idxes[0];
                            if (idx < lIDs.Count - 1)
                            {
                                doReload = true;
                                lIDs.RemoveAt(idx);
                                lIDs.Insert(idx + 1, lbxSelMac.Items[idx].Value);
                                selIndex = idx + 1;
                            }
                        }
                    }
                    break;
            }

            if (doReload) lData(string.Join(":", lIDs.ToArray()));
            lIDs.Clear();
        }
        private void lData(string MIDs)
        {
            DataSet Ds = (new myBiz.DAL.clsMachine()).WOTrvlr_MacSel(TrvlrID, StepID, MIDs);
            lbxSelMac.DataSource = Ds.Tables[0]; lbxSelMac.DataBind(); lbxSelMac.SelectedIndex = selIndex;
            lbxUnselMac.DataSource = Ds.Tables[1]; lbxUnselMac.DataBind();

            List<string> lIDs = new List<string>();
            foreach (ListItem i in lbxSelMac.Items) lIDs.Add(i.Value);
            hfMIDs.Value = string.Join(":", lIDs.ToArray()); lIDs.Clear();
        }
        private int TrvlrID { get { return Convert.ToInt32(Request.QueryString["TrvlrID"]); } }
        private int StepID { get { return Convert.ToInt32(Request.QueryString["StepID"]); } }
        private int selIndex
        {
            get { return ViewState["selIndex"] == null ? -1 : (int)ViewState["selIndex"]; }
            set { ViewState["selIndex"] = value; }
        }
    }
}