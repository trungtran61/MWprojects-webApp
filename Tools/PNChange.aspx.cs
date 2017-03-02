using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using webApp.Common;

namespace webApp.Tools
{
    public partial class PNChange : pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Tools/PN-REV Change Approval");
        }
        protected void rwCmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("viewPair"))
            {
                var Rw = (new myBiz.DAL.clsPartNumber()).Pair_Logs_S(Convert.ToInt32(e.CommandArgument)).Rows[0];
                var action = Rw["Action"].ToString();
                var disAction = action.Equals("Approved") ? "Disapproved" : "Approved";

                litFirstPN.Text = Rw["FirstPN"].ToString();
                litSecondPN.Text = Rw["SecondPN"].ToString();
                litActionBy.Text = string.Format("{0} By:", action);
                litActionDate.Text = string.Format("{0} Date:", action);
                litPairBy.Text = Rw["PairBy"].ToString();
                litPairDate.Text = Rw["PairDate"].ToString();
                lblNote.Text = Rw["Note"].ToString();
                litActionNote.Text = string.Format("<br/><b>{0} Note:</b><br/>", action);
                litNewNote.Text = string.Format("<br/><b>{0} Note:</b><br/>", disAction);
                txtNote.Text = string.Empty;
                btnDisAction.Text = disAction;
                hfView.Value = string.Format("{0}:{1}", Rw["FirstID"], Rw["SecondID"]);

                btnDisAction.Visible = (disAction.Equals("Approved") && isYN("k01")) || (disAction.Equals("Disapproved") && isYN("k02"));

                if (!Convert.ToBoolean(Rw["isCurrent"]) && btnDisAction.Visible)
                {
                    jMsg.ShowErr(string.Format("You cannot '{0}' these PNs since this is not current.", disAction), false);
                    btnDisAction.Visible = false;
                }

                mpeView.Show();
            }
        }
        protected void disAction(object sender, EventArgs e)
        {
            string[] v = hfView.Value.Split(':');
            (new myBiz.DAL.clsPartNumber()).Pair_Logs(Convert.ToInt32(v[0]), Convert.ToInt32(v[1]), clsUser.uID, txtNote.Text, btnDisAction.Text);
            gvChange.DataBind();
        }
        protected void doApprove(object sender, EventArgs e)
        {
            if (!txtFirstPNN.Text.Equals(txtSecondPNN.Text))
            {
                (new myBiz.DAL.clsPartNumber()).Pair_Logs1(txtFirstPNN.Text, txtSecondPNN.Text, clsUser.uID, txtNoteN.Text, "Approved");
                iMsg.ShowMsg("You have successfully approved two Part Numbers.", true);
                gvChange.DataBind();
            }
            else
            {
                iMsg.ShowErr("Two Part Numbers cannot be the same.", true);
            }
        }

        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Allow Approve");
            PageSec.Add("k02", "Allow Disapprove");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnApprove.Visible = isYN("k01");
        }
    }
}