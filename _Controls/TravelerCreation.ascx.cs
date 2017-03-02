using System;
using System.Data;
using System.Linq;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using myBiz.Tools;
using myBiz.DAL;
using webApp.Common;

namespace webApp._Controls
{
    public partial class TravelerCreation : ucAbstract
    {
        private clsUtils Util = clsUtils.myUtil;

        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new myDelegate(mEvent);
            if (!IsPostBack) { pnlTask.Visible = !myMode.reqTask; gCmd("View"); }
        }
        protected void loadPartName(object sender, EventArgs e)
        {
            if (!IsPostBack) txtPartName.Text = (new clsTraveler()).getPartName(IDs[0]);
        }
        protected void savePartName(object sender, EventArgs e)
        {
            (new clsTraveler()).savePartName(IDs[0], txtPartName.Text);
            litMsg.Text = string.Format("Updated on {0}", DateTime.Now.ToString("MM/dd/yyyy @ hh:mm:ss"));
        }
        protected void LoadCustPackSpec(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var data = (new clsTraveler()).GetCustPackSpec(IDs[0]);
                ddlPackage.DataSource = data.Tables[1];
                ddlPackage.DataBind();

                if (data.Tables[0].Rows.Count > 0) ddlPackage.SelectedValue = data.Tables[0].Rows[0][0].ToString();
            }
        }
        protected void SaveCustPackSpec(object sender, EventArgs e)
        {
            (new clsTraveler()).SaveCustPackSpec(IDs[0], ddlPackage.SelectedValue);
            litMsg.Text = string.Format("Updated on {0}", DateTime.Now.ToString("MM/dd/yyyy @ hh:mm:ss"));
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Control Ct = gvTraveler.FooterRow; string SN = ((TextBox)Ct.FindControl("txtStepNo")).Text.Trim();
            if (string.IsNullOrEmpty(SN)) SN = "0";
            if (clsValidator.isInteger(SN))
            {
                int StepNo = Convert.ToInt32(SN);
                if (StepNo < 0)
                {
                    StepNo *= -1;
                    odsTraveler.DeleteParameters["StepNo"].DefaultValue = StepNo.ToString();
                    odsTraveler.Delete();
                }
                else
                {
                    DropDownList ddl = Ct.FindControl("ddlProcessList") as DropDownList;

                    string MPID = string.Empty, MIDs = string.Empty;
                    string OpNo = ((DropDownList)Ct.FindControl("ddlOpNo")).SelectedValue;
                    string ESTime = ((TextBox)Ct.FindControl("txtESTime")).Text.Trim();
                    string ESUnit = ((DropDownList)Ct.FindControl("ddlESUnit")).SelectedValue;
                    string ECTime = ((TextBox)Ct.FindControl("txtECTime")).Text.Trim();
                    string ECUnit = ((DropDownList)Ct.FindControl("ddlECUnit")).SelectedValue;
                    string Instruction = ((TextBox)Ct.FindControl("txtInstruction")).Text.Trim();

                    if (ddl.Visible) MPID = ddl.SelectedValue;
                    else
                    {
                        RadioButtonList StepName = Ct.FindControl("rblStepName") as RadioButtonList;
                        if (StepName.SelectedIndex > -1)
                        {
                            HiddenField hf = Ct.FindControl("hfMIDs") as HiddenField; string[] v = hf.Value.Split(':');
                            if (string.IsNullOrEmpty(v[0])) MPID = string.Format("{0}:-1:-1", StepName.SelectedValue);
                            else
                            {
                                MPID = string.Format("{0}:{1}:-1", StepName.SelectedValue, v[0]);
                                MIDs = v.Length > 1 ? string.Join(":", v, 1, v.Length - 1) : string.Empty;
                            }
                        }
                    }

                    System.Text.StringBuilder x = new System.Text.StringBuilder();
                    x.Append(clsValidator.gErrMsg("String", MPID, "StepID", true));
                    x.Append(Validate(StepNo.ToString(), ESTime, ESUnit, ECTime, ECUnit));

                    if (x.Length > 0) getError(x.ToString());
                    else
                    {
                        odsTraveler.InsertParameters["MPID"].DefaultValue = MPID;
                        odsTraveler.InsertParameters["OpNo"].DefaultValue = OpNo;
                        odsTraveler.InsertParameters["ESTime"].DefaultValue = ESTime;
                        odsTraveler.InsertParameters["ESUnit"].DefaultValue = ESUnit;
                        odsTraveler.InsertParameters["ECTime"].DefaultValue = ECTime;
                        odsTraveler.InsertParameters["ECUnit"].DefaultValue = ECUnit;
                        odsTraveler.InsertParameters["MIDs"].DefaultValue = MIDs;
                        odsTraveler.InsertParameters["Instruction"].DefaultValue = Instruction;
                        odsTraveler.InsertParameters["StepNo"].DefaultValue = StepNo.ToString();
                        odsTraveler.Insert();
                    }
                }
            }
            else
            {
                iMsg.ShowErr("Sorry! You have entered invalid StepNo", true);
            }
        }
        private string Validate(string StepNo, string ESTime, string ESUnit, string ECTime, string ECUnit)
        {
            StepNo = StepNo.Equals("0") ? "to add" : string.Format("at Step {0}", StepNo);
            System.Text.StringBuilder x = new System.Text.StringBuilder();

            x.Append(clsValidator.gErrMsg("Numeric", ESTime, string.Format("Estimated Setup Time {0}", StepNo), false));
            x.Append(clsValidator.gErrMsg("String", ESUnit, string.Format("The Unit (Estimated Setup Time) {0}", StepNo), !string.IsNullOrEmpty(ESTime)));
            x.Append(clsValidator.gErrMsg("Numeric", ECTime, string.Format("Estimated Cycle Time {0}", StepNo), false));
            x.Append(clsValidator.gErrMsg("String", ECUnit, string.Format("The Unit (Estimated Cycle Time) {0}", StepNo), !string.IsNullOrEmpty(ECTime)));

            return x.ToString();
        }
        private void getError(string x)
        {
            iMsg.ShowErr("Work Traveler can NOT be saved", x, false);
        }
        protected void btnAddDefault_Click(object sender, EventArgs e)
        {
            Control Rw = gvTraveler.Controls[0].Controls[0];
            string SN = string.Empty, SID = string.Empty, MID = string.Empty, PID = string.Empty, OpNo = string.Empty, Instr = string.Empty;
            string ESTime = string.Empty, ESUnit = string.Empty, ECTime = string.Empty, ECUnit = string.Empty;

            System.Text.StringBuilder x = new System.Text.StringBuilder();

            for (int i = 1; i < 10; i++)
            {
                string ProcessList = ((DropDownList)Rw.FindControl(string.Format("ddlProcessList_{0}", i))).SelectedValue;
                if (!string.IsNullOrEmpty(ProcessList))
                {
                    string EST = ((TextBox)Rw.FindControl(string.Format("txtESTime_{0}", i))).Text.Trim().Replace(':', ';');
                    string ESU = ((DropDownList)Rw.FindControl(string.Format("ddlESUnit_{0}", i))).SelectedValue;
                    string ECT = ((TextBox)Rw.FindControl(string.Format("txtECTime_{0}", i))).Text.Trim().Replace(':', ';');
                    string ECU = ((DropDownList)Rw.FindControl(string.Format("ddlECUnit_{0}", i))).SelectedValue;
                    x.Append(Validate(i.ToString(), EST, ESU, ECT, ECU));

                    if (x.Length < 1)
                    {
                        string[] u = ProcessList.Split(':'); SID += string.Format("{0}:", u[0]);
                        MID += string.Format("{0}:", u[1]); PID += string.Format("{0}:", u[2]);
                        SN += string.Format("{0}:", ((Literal)Rw.FindControl(string.Format("litStepNo_{0}", i))).Text);
                        OpNo += string.Format("{0}:", ((DropDownList)Rw.FindControl(string.Format("ddlOpNo_{0}", i))).SelectedValue);
                        ESTime += string.Format("{0}:", EST);
                        ESUnit += string.Format("{0}:", ESU);
                        ECTime += string.Format("{0}:", ECT);
                        ECUnit += string.Format("{0}:", ECU);
                        Instr += string.Format("{0}:", ((TextBox)Rw.FindControl(string.Format("txtInstruction_{0}", i))).Text.Trim().Replace(':', ';'));
                    }
                }
            }

            if (x.Length > 0) getError(x.ToString());
            else
            {
                if (!string.IsNullOrEmpty(SN))
                {
                    clsTraveler Tv = new clsTraveler();
                    Tv.Default(Convert.ToInt32(this.IDs[0]), SN, SID, MID, PID, OpNo, ESTime, ESUnit, ECTime, ECUnit, Instr); gvTraveler.DataBind();
                    iMsg.ShowMsg("Thank You! All your default steps have been added.", true);
                }
                else
                {
                    iMsg.ShowErr("Sorry! No default step has been added.", true);
                }
            }
        }
        protected void loadOpList(string xID, string xVal)
        {
            string WOID = IDs[0], UID = Common.clsUser.uID; clsTraveler x = new clsTraveler();

            if (!string.IsNullOrEmpty(xID) && !string.IsNullOrEmpty(xVal)) x.setOpList(UID, WOID, xVal);
            else x.genOpList(UID, WOID);

            if (Util.isEmpty(gvTraveler))
            {
                Control Ct = gvTraveler.Controls[0].Controls[0];
                for (int i = 1; i < 10; i++)
                {
                    DropDownList ddl = Ct.FindControl(string.Format("ddlOpNo_{0}", i)) as DropDownList;
                    if (!ddl.ID.Equals(xID))
                    {
                        string val = ddl.SelectedIndex > -1 ? ddl.SelectedValue : string.Empty;
                        ddl.DataSource = x.getOpList(UID, WOID, val); ddl.DataBind();
                        if (!string.IsNullOrEmpty(val)) ddl.SelectedValue = val;
                    }
                }
            }
            else
            {
                if (string.IsNullOrEmpty(xID) || xID.Equals("ddlOpNo"))
                {
                    for (int i = 0; i < gvTraveler.Rows.Count; i++)
                    {
                        GridViewRow Rw = gvTraveler.Rows[i];
                        if (Rw.RowState.ToString().Contains("Edit"))
                        {
                            DropDownList ddl = Rw.FindControl("ddlOpNo1") as DropDownList;
                            //string val = ddl.SelectedIndex > -1 ? ddl.SelectedValue : string.Empty;
                            string val = ((HiddenField)Rw.FindControl("hfOpNo")).Value;
                            //<asp:HiddenField ID="hfOpNo" runat="server" Value='<%# Bind("OpNo") %>' />
                            ddl.DataSource = x.getOpList(UID, WOID, val); ddl.DataBind();
                            if (!string.IsNullOrEmpty(val)) ddl.SelectedValue = val;
                            i = gvTraveler.Rows.Count;
                        }
                    }
                }
                if (string.IsNullOrEmpty(xID) || xID.Equals("ddlOpNo1"))
                {
                    DropDownList ddl = gvTraveler.FooterRow.FindControl("ddlOpNo") as DropDownList;
                    string val = ddl.SelectedIndex > -1 ? ddl.SelectedValue : string.Empty;
                    ddl.DataSource = x.getOpList(UID, WOID, val); ddl.DataBind();
                    if (!string.IsNullOrEmpty(val)) ddl.SelectedValue = val;
                }
            }
        }
        protected void opSelected(object sender, EventArgs e)
        {
            System.Text.StringBuilder x = new System.Text.StringBuilder();
            DropDownList ddl = sender as DropDownList;
            foreach (ListItem i in ddl.Items) if (!i.Selected) x.Append(string.Format("{0}:", i.Value));
            loadOpList(ddl.ID, x.ToString());
        }
        protected void opSelectedEdit(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            (gvTraveler.Rows[gvTraveler.EditIndex].FindControl("hfOpNo") as HiddenField).Value = ddl.SelectedValue;
        }
        protected void rblSN_Change(object sender, EventArgs e)
        {
            Control Rw = gvTraveler.Controls[0].Controls[0];
            RadioButtonList StepName = (RadioButtonList)sender;
            string[] v = StepName.ID.Split('_'); string PL = string.Format("ddlProcessList_{0}", v[1]);
            DropDownList ProcessList = ((DropDownList)Rw.FindControl(PL));
            ProcessList.DataSource = getProTbl(Convert.ToInt32(StepName.SelectedValue)); ProcessList.DataBind();
        }
        protected void uTraveler(object sender, GridViewUpdateEventArgs e)
        {
            string MPID = string.Empty, MIDs = string.Empty;
            bool EST = e.NewValues["ESTime"] != null && !string.IsNullOrEmpty(e.NewValues["ESTime"].ToString());
            bool ESU = e.NewValues["ESUnit"] != null && !string.IsNullOrEmpty(e.NewValues["ESUnit"].ToString());
            bool ECT = e.NewValues["ECTime"] != null && !string.IsNullOrEmpty(e.NewValues["ECTime"].ToString());
            bool ECU = e.NewValues["ECUnit"] != null && !string.IsNullOrEmpty(e.NewValues["ECUnit"].ToString());

            System.Text.StringBuilder x = new System.Text.StringBuilder();
            if (EST && !ESU) x.Append("<li>The Unit (Estimated Setup Time) is required.</li>");
            if (ECT && !ECU) x.Append("<li>The Unit (Estimated Cycle Time) is required.</li>");

            if (x.Length == 0)
            {
                GridViewRow Rw = (sender as GridView).Rows[e.RowIndex];
                DropDownList ddl = Rw.FindControl("ddlProcessList") as DropDownList;

                if (ddl.Visible) MPID = ddl.SelectedValue;
                else
                {
                    RadioButtonList StepName = Rw.FindControl("rblStepName") as RadioButtonList;
                    if (StepName.SelectedIndex > -1)
                    {
                        HiddenField hf = Rw.FindControl("hfMIDs") as HiddenField; string[] v = hf.Value.Split(':');
                        if (string.IsNullOrEmpty(v[0])) x.Append("<li>No machine selected</li>");
                        else
                        {
                            MPID = string.Format("{0}:{1}:-1", StepName.SelectedValue, v[0]);
                            MIDs = v.Length > 1 ? string.Join(":", v, 1, v.Length - 1) : string.Empty;
                        }
                    }
                    else x.Append("<li>No step name selected</li>");
                }
            }

            if (x.Length == 0)
            {
                odsTraveler.UpdateParameters["MPID"].DefaultValue = MPID;
                odsTraveler.UpdateParameters["MIDs"].DefaultValue = MIDs;
            }
            else
            {
                iMsg.ShowErr("Cannot update work traveler", x.ToString(), true);
                e.Cancel = true;
            }
        }
        protected void rblStepName_Change(object sender, EventArgs e)
        {
            GridViewRow Rw = gvTraveler.EditIndex > -1 ? gvTraveler.Rows[gvTraveler.EditIndex] : gvTraveler.FooterRow;
            DropDownList ProcessList = ((DropDownList)Rw.FindControl("ddlProcessList"));
            RadioButtonList StepName = (RadioButtonList)sender;
            HyperLink lnk = Rw.FindControl("lnkMacSel") as HyperLink;
            (Rw.FindControl("hfMIDs") as HiddenField).Value = string.Empty;

            ProcessList.DataSource = getProTbl(Convert.ToInt32(StepName.SelectedValue)); ProcessList.DataBind();
            string yMPID = ProcessList.Items[ProcessList.Items.Count - 1].Value; string[] v = yMPID.Split(':');
            lnk.Visible = Convert.ToInt32(v[1]) > 0; ProcessList.Visible = !lnk.Visible;

            if (gvTraveler.EditIndex > -1 && ProcessList.Visible)
            {
                try { ProcessList.SelectedValue = (Rw.FindControl("hfMPID") as HiddenField).Value; }
                catch { ProcessList.SelectedIndex = -1; }
            }
        }
        protected void RwBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Footer || e.Row.RowState.ToString().Contains("Edit"))
            {
                LinkButton lBtn = (LinkButton)e.Row.FindControl("lCmd");
                TextBox Instr = (TextBox)e.Row.FindControl("txtInstruction");
                lBtn.Attributes.Add("onclick", string.Format("gInstr('{0}','{1}');return false;", lBtn.ClientID, Instr.ClientID));
                DropDownList ProcessList = ((DropDownList)e.Row.FindControl("ddlProcessList"));
                RadioButtonList StepName = (RadioButtonList)e.Row.FindControl("rblStepName");
                HyperLink lnk = e.Row.FindControl("lnkMacSel") as HyperLink;

                if (e.Row.RowState.ToString().Contains("Edit"))
                {
                    lnk.NavigateUrl = string.Format("javascript:openMacSel({0},'{1}','{2}');", gvTraveler.DataKeys[e.Row.RowIndex].Value, StepName.ClientID, e.Row.FindControl("hfMIDs").ClientID);

                    if (StepName.SelectedIndex > -1)
                    {
                        ProcessList.DataSource = getProTbl(Convert.ToInt32(StepName.SelectedValue)); ProcessList.DataBind();
                        string yMPID = ProcessList.Items[ProcessList.Items.Count - 1].Value; string[] v = yMPID.Split(':');
                        lnk.Visible = Convert.ToInt32(v[1]) > 0; ProcessList.Visible = !lnk.Visible;

                        if (ProcessList.Visible)
                        {
                            try { ProcessList.SelectedValue = (e.Row.FindControl("hfMPID") as HiddenField).Value; }
                            catch { ProcessList.SelectedIndex = -1; }
                        }
                    }
                    else lnk.Visible = ProcessList.Visible = false;
                }
                else
                {
                    lnk.Visible = ProcessList.Visible = false;
                    lnk.NavigateUrl = string.Format("javascript:openMacSel({0},'{1}','{2}');", -1, StepName.ClientID, e.Row.FindControl("hfMIDs").ClientID);
                }
            }
        }
        protected void gvBound(object sender, EventArgs e)
        {
            myCmp.Visible = !Util.isEmpty(gvTraveler); pnlMoveSwap.Visible = myCmp.Visible;
            if (!myCmp.Visible)
            {
                Control Rw = gvTraveler.Controls[0].Controls[0];
                for (int i = 1; i < 10; i++)
                {
                    LinkButton lBtn = (LinkButton)Rw.FindControl(string.Format("lCmd_{0}", i));
                    TextBox Instr = (TextBox)Rw.FindControl(string.Format("txtInstruction_{0}", i));
                    lBtn.Attributes.Add("onclick", string.Format("gInstr('{0}','{1}');return false;", lBtn.ClientID, Instr.ClientID));
                }
            }
            loadOpList(string.Empty, string.Empty);
        }
        protected void btnCmp_Click(object sender, EventArgs e)
        {
            iMsg.ShowMsg("If the current workorder is a component, should we create component?", true);
        }
        protected DataTable getProTbl(int StepID)
        {
            DataTable Tb = (new clsStepName()).getStepName_ProcessList(StepID);
            Tb.Columns.RemoveAt(0); DataRow R = Tb.NewRow(); R["mText"] = string.Empty;
            R["MPID"] = string.Format("{0}:-1:-1", StepID); Tb.Rows.InsertAt(R, 0); return Tb;
        }
        protected void btn_Click(object sender, EventArgs e)
        {
            string errMsg = string.Empty;

            errMsg += clsValidator.gErrMsg("Integer", txtoSN.Text, "From StepNo", true);
            errMsg += clsValidator.gErrMsg("Integer", txtnSN.Text, "To StepNo", true);

            if (string.IsNullOrEmpty(errMsg))
            {
                clsTraveler Tv = new clsTraveler(); bool isSwap = ddlSwap.SelectedValue.Equals("Yes");
                errMsg = Tv.MoveSwap(this.IDs[0], Convert.ToInt32(txtoSN.Text.Trim()), Convert.ToInt32(txtnSN.Text.Trim()), isSwap);
            }

            if (!string.IsNullOrEmpty(errMsg)) iMsg.ShowErr(string.Format("Sorry! <font color=red><ul>{0}</ul></font>", errMsg), true);
            else
            {
                gvTraveler.DataBind(); txtnSN.Text = string.Empty; txtoSN.Text = string.Empty;
                iMsg.ShowMsg("Thank You! Your StepNos have been moved/swapped.", true);
            }
        }
        protected void Instr_Click(object sender, EventArgs e)
        {
            LinkButton lID = (LinkButton)sender;
            if (lID.ID.Equals("lEdit"))
            {
                lID.Text = ((TextBox)gvTraveler.Rows[gvTraveler.EditIndex].FindControl("txtInstruction")).Text.Substring(0, 50);
            }
        }
        protected string gInstr()
        {
            string mInstr = Eval("Instruction").ToString(); if (string.IsNullOrEmpty(mInstr)) mInstr = "&#8597;";
            int i = mInstr.Length > 50 ? 50 : mInstr.Length; return mInstr.Substring(0, i);
        }
        protected void rblDefault(object sender, EventArgs e)
        {
            RadioButtonList rbl = sender as RadioButtonList;
            switch (rbl.ID)
            {
                case "rblStepName_1":
                    rbl.SelectedValue = rbl.Items.Cast<ListItem>().Where(r => r.Text.Equals("RIM")).Select(r => r.Value).FirstOrDefault();
                    rblSN_Change(sender, e);
                    break;
                case "rblStepName_2":
                    rbl.SelectedValue = rbl.Items.Cast<ListItem>().Where(r => r.Text.Equals("SAW")).Select(r => r.Value).FirstOrDefault();
                    rblSN_Change(sender, e);
                    break;
            }
        }
        protected void ddlDefault(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            ddl.SelectedValue = ddl.Items.Cast<ListItem>().Where(r => r.Text.Equals("Min")).Select(r => r.Value).FirstOrDefault();
        }
        protected override void dTask()
        {
            pnlTask.Enabled = true;
        }
        protected override void dEdit()
        {
            dTask();
        }
        protected override void dView()
        {
            if (!IsPostBack) btnPrtForm.OnClientClick = string.Format("javascript:loadPreview({0});return false;", this.IDs[0]);
            pnlTask.Enabled = false;
        }
        protected override void enforceSecurity()
        {
            TaskSec.Add("t01", myMode.ActionName);
            TaskSec.Add("t02", "Edit");
            TaskSec.Add("t03", "View");
            TaskSec.Add("t04", "Print");
            TaskSec.Add("t05", "Mark Complete");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            string woStatus = myMode.woStatus;
            bool isPDA = woStatus.Equals("PostAudit") || woStatus.Equals("PreCompleted");
            myMode.Taskable = !isPDA && isYN("t01");
            myMode.Editable = !isPDA && isYN("t02");
            myMode.Viewable = !isPDA && isYN("t03");
            myMode.Printable = isYN("t04");
            myMode.Completable = !isPDA && isYN("t05");
        }
    }
}