using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using myBiz.Tools;
using myBiz.DAL;
using webApp.Common;

namespace webApp._Controls
{
    public partial class ucRouter : ucAbstract
    {
        //private clsUtils Util = clsUtils.myUtil;

        protected void Page_Load(object sender, EventArgs e)
        {
            myMode.myEvent += new myDelegate(mEvent);
            if (!IsPostBack)
            {
                pnlTask.Visible = !myMode.reqTask; gCmd("View");
                if (pnlTask.Visible) loadEPT();
            }
        }
        private void loadEPT()
        {
            var Rw = (new clsRFQ()).getEPT(IDs[0]);
            txtEPT.Text = Rw["EPT"].ToString();
            try
            {
                ddlEPT.SelectedValue = Rw["EPTUnit"].ToString();
            }
            catch
            {
                ddlEPT.SelectedValue = "Min";
            }
        }
        protected void saveEPT(object sender, EventArgs e)
        {
            (new clsRFQ()).saveEPT(IDs[0], Convert.ToDecimal(txtEPT.Text), ddlEPT.SelectedValue);
            eMsg.Text = string.Format("EPT Updated on {0}", DateTime.Now.ToString("MM/dd/yyyy @ hh:mm:ss"));
        }
        protected void loadPartName(object sender, EventArgs e)
        {
            if (!IsPostBack) txtPartName.Text = (new clsRouter()).getPartName(IDs[0]);
        }
        protected void savePartName(object sender, EventArgs e)
        {
            (new clsRouter()).savePartName(IDs[0], txtPartName.Text);
            litMsg.Text = string.Format("Updated on {0}", DateTime.Now.ToString("MM/dd/yyyy @ hh:mm:ss"));
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Control Ct = gvRouter.FooterRow; string SN = ((TextBox)Ct.FindControl("txtStepNo")).Text.Trim();
            if (string.IsNullOrEmpty(SN)) SN = "0";
            if (clsValidator.isInteger(SN))
            {
                int StepNo = Convert.ToInt32(SN);
                if (StepNo < 0)
                {
                    StepNo *= -1;
                    odsRouter.DeleteParameters["StepNo"].DefaultValue = StepNo.ToString();
                    odsRouter.Delete();
                }
                else
                {
                    string MPID = ((DropDownList)Ct.FindControl("ddlProcessList")).SelectedValue;
                    string OpNo = ((DropDownList)Ct.FindControl("ddlOpNo")).SelectedValue;
                    string EPTime = ((TextBox)Ct.FindControl("txtEPTime")).Text.Trim();
                    string EPUnit = ((DropDownList)Ct.FindControl("ddlEPUnit")).SelectedValue;
                    string ESTime = ((TextBox)Ct.FindControl("txtESTime")).Text.Trim();
                    string ESUnit = ((DropDownList)Ct.FindControl("ddlESUnit")).SelectedValue;
                    string ECTime = ((TextBox)Ct.FindControl("txtECTime")).Text.Trim();
                    string ECUnit = ((DropDownList)Ct.FindControl("ddlECUnit")).SelectedValue;
                    string EFTime = ((TextBox)Ct.FindControl("txtEFTime")).Text.Trim();
                    string EFUnit = ((DropDownList)Ct.FindControl("ddlEFUnit")).SelectedValue;
                    string FixMatl = ((TextBox)Ct.FindControl("txtFixMatl")).Text.Trim();
                    string Instruction = ((TextBox)Ct.FindControl("txtInstruction")).Text.Trim();

                    System.Text.StringBuilder x = new System.Text.StringBuilder();
                    x.Append(clsValidator.gErrMsg("String", MPID, "StepID", true));
                    x.Append(Validate(StepNo.ToString(), ESTime, ESUnit, ECTime, ECUnit));

                    if (x.Length > 0) getError(x.ToString());
                    else
                    {
                        odsRouter.InsertParameters["MPID"].DefaultValue = MPID;
                        odsRouter.InsertParameters["OpNo"].DefaultValue = OpNo;
                        odsRouter.InsertParameters["EPTime"].DefaultValue = EPTime;
                        odsRouter.InsertParameters["EPUnit"].DefaultValue = EPUnit;
                        odsRouter.InsertParameters["ESTime"].DefaultValue = ESTime;
                        odsRouter.InsertParameters["ESUnit"].DefaultValue = ESUnit;
                        odsRouter.InsertParameters["ECTime"].DefaultValue = ECTime;
                        odsRouter.InsertParameters["ECUnit"].DefaultValue = ECUnit;
                        odsRouter.InsertParameters["EFTime"].DefaultValue = EFTime;
                        odsRouter.InsertParameters["EFUnit"].DefaultValue = EFUnit;
                        odsRouter.InsertParameters["FixMatl"].DefaultValue = FixMatl;
                        odsRouter.InsertParameters["Instruction"].DefaultValue = Instruction;
                        odsRouter.InsertParameters["StepNo"].DefaultValue = StepNo.ToString();
                        odsRouter.Insert();
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
            iMsg.ShowErr("Work Router can NOT be saved", x, false);
        }
        protected void btnAddDefault_Click(object sender, EventArgs e)
        {
            Control Rw = gvRouter.Controls[0].Controls[0];
            string SN = string.Empty, SID = string.Empty, MID = string.Empty, PID = string.Empty, OpNo = string.Empty, Instr = string.Empty;
            string EPTime = string.Empty, EPUnit = string.Empty, ESTime = string.Empty, ESUnit = string.Empty, ECTime = string.Empty, ECUnit = string.Empty, EFTime = string.Empty, EFUnit = string.Empty;
            string FixMatl = string.Empty;

            System.Text.StringBuilder x = new System.Text.StringBuilder();

            for (int i = 1; i < 10; i++)
            {
                string ProcessList = ((DropDownList)Rw.FindControl(string.Format("ddlProcessList_{0}", i))).SelectedValue;
                if (!string.IsNullOrEmpty(ProcessList))
                {
                    string EPT = ((TextBox)Rw.FindControl(string.Format("txtEPTime_{0}", i))).Text.Trim().Replace(':', ';');
                    string EPU = ((DropDownList)Rw.FindControl(string.Format("ddlEPUnit_{0}", i))).SelectedValue;
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
                        EPTime += string.Format("{0}:", EPT);
                        EPUnit += string.Format("{0}:", EPU);
                        ESTime += string.Format("{0}:", EST);
                        ESUnit += string.Format("{0}:", ESU);
                        ECTime += string.Format("{0}:", ECT);
                        ECUnit += string.Format("{0}:", ECU);
                        EFTime += string.Format("{0}:", ((TextBox)Rw.FindControl(string.Format("txtEFTime_{0}", i))).Text.Trim().Replace(':', ';'));
                        EFUnit += string.Format("{0}:", ((DropDownList)Rw.FindControl(string.Format("ddlEFUnit_{0}", i))).SelectedValue);
                        FixMatl += string.Format("{0}:", ((TextBox)Rw.FindControl(string.Format("txtFixMatl_{0}", i))).Text.Trim().Replace(':', ';'));
                        Instr += string.Format("{0}:", ((TextBox)Rw.FindControl(string.Format("txtInstruction_{0}", i))).Text.Trim().Replace(':', ';'));
                    }
                }
            }

            if (x.Length > 0) getError(x.ToString());
            else
            {
                if (!string.IsNullOrEmpty(SN))
                {
                    clsRouter Tv = new clsRouter();
                    Tv.Default(Convert.ToInt32(this.IDs[0]), SN, SID, MID, PID, OpNo, EPTime, EPUnit, ESTime, ESUnit, ECTime, ECUnit, EFTime, EFUnit, FixMatl, Instr); gvRouter.DataBind();
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
            string RFQID = IDs[0], UID = Common.clsUser.uID; clsRouter x = new clsRouter();

            if (!string.IsNullOrEmpty(xID) && !string.IsNullOrEmpty(xVal)) x.setOpList(UID, RFQID, xVal);
            else x.genOpList(UID, RFQID);

            if (Util.isEmpty(gvRouter))
            {
                Control Ct = gvRouter.Controls[0].Controls[0];
                for (int i = 1; i < 10; i++)
                {
                    DropDownList ddl = Ct.FindControl(string.Format("ddlOpNo_{0}", i)) as DropDownList;
                    if (!ddl.ID.Equals(xID))
                    {
                        string val = ddl.SelectedIndex > -1 ? ddl.SelectedValue : string.Empty;
                        ddl.DataSource = x.getOpList(UID, RFQID, val); ddl.DataBind();
                        if (!string.IsNullOrEmpty(val)) ddl.SelectedValue = val;
                    }
                }
            }
            else
            {
                if (string.IsNullOrEmpty(xID) || xID.Equals("ddlOpNo"))
                {
                    for (int i = 0; i < gvRouter.Rows.Count; i++)
                    {
                        GridViewRow Rw = gvRouter.Rows[i];
                        if (Rw.RowState.ToString().Contains("Edit"))
                        {
                            DropDownList ddl = Rw.FindControl("ddlOpNo1") as DropDownList;
                            //string val = ddl.SelectedIndex > -1 ? ddl.SelectedValue : string.Empty;
                            string val = ((HiddenField)Rw.FindControl("hfOpNo")).Value;
                            //<asp:HiddenField ID="hfOpNo" runat="server" Value='<%# Bind("OpNo") %>' />
                            ddl.DataSource = x.getOpList(UID, RFQID, val); ddl.DataBind();
                            if (!string.IsNullOrEmpty(val)) ddl.SelectedValue = val;
                            i = gvRouter.Rows.Count;
                        }
                    }
                }
                if (string.IsNullOrEmpty(xID) || xID.Equals("ddlOpNo1"))
                {
                    DropDownList ddl = gvRouter.FooterRow.FindControl("ddlOpNo") as DropDownList;
                    string val = ddl.SelectedIndex > -1 ? ddl.SelectedValue : string.Empty;
                    ddl.DataSource = x.getOpList(UID, RFQID, val); ddl.DataBind();
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
            (gvRouter.Rows[gvRouter.EditIndex].FindControl("hfOpNo") as HiddenField).Value = ddl.SelectedValue;
        }
        protected void rblSN_Change(object sender, EventArgs e)
        {
            Control Rw = gvRouter.Controls[0].Controls[0];
            RadioButtonList StepName = (RadioButtonList)sender;
            string[] v = StepName.ID.Split('_'); string PL = string.Format("ddlProcessList_{0}", v[1]), selTxt = StepName.SelectedItem.Text;
            DropDownList ProcessList = ((DropDownList)Rw.FindControl(PL));
            ProcessList.DataSource = getProTbl(Convert.ToInt32(StepName.SelectedValue)); ProcessList.DataBind();
            Rw.FindControl(string.Format("litRIT_{0}", v[1])).Visible = selTxt.Equals("OPS");

            string[] sNm = { "RIM", "SAW" };
            if (sNm.Contains(selTxt)) ProcessList.SelectedIndex = 1;
            appDef(Rw, selTxt, string.Format("_{0}", v[1]));
        }
        protected void uRouter(object sender, GridViewUpdateEventArgs e)
        {
            bool EPT = e.NewValues["EPTime"] != null && !string.IsNullOrEmpty(e.NewValues["EPTime"].ToString());
            bool EPU = e.NewValues["EPUnit"] != null && !string.IsNullOrEmpty(e.NewValues["EPUnit"].ToString());
            bool EST = e.NewValues["ESTime"] != null && !string.IsNullOrEmpty(e.NewValues["ESTime"].ToString());
            bool ESU = e.NewValues["ESUnit"] != null && !string.IsNullOrEmpty(e.NewValues["ESUnit"].ToString());
            bool ECT = e.NewValues["ECTime"] != null && !string.IsNullOrEmpty(e.NewValues["ECTime"].ToString());
            bool ECU = e.NewValues["ECUnit"] != null && !string.IsNullOrEmpty(e.NewValues["ECUnit"].ToString());

            System.Text.StringBuilder x = new System.Text.StringBuilder();
            if (EPT && !EPU) x.Append("<li>The Unit (Program Time) is required.</li>");
            if (EST && !ESU) x.Append("<li>The Unit (Estimated Setup Time) is required.</li>");
            if (ECT && !ECU) x.Append("<li>The Unit (Estimated Cycle Time) is required.</li>");

            if (x.Length == 0)
            {
                GridViewRow Rw = (sender as GridView).Rows[e.RowIndex];
                odsRouter.UpdateParameters["MPID"].DefaultValue = (Rw.FindControl("ddlProcessList") as DropDownList).SelectedValue;
            }
            else
            {
                iMsg.ShowErr("Cannot update Router", x.ToString(), true);
                e.Cancel = true;
            }
        }
        protected void rblStepName_Change(object sender, EventArgs e)
        {
            GridViewRow Rw = gvRouter.EditIndex > -1 ? gvRouter.Rows[gvRouter.EditIndex] : gvRouter.FooterRow;
            DropDownList ProcessList = ((DropDownList)Rw.FindControl("ddlProcessList"));
            RadioButtonList StepName = (RadioButtonList)sender;

            ProcessList.Visible = StepName.SelectedIndex > -1;
            if (ProcessList.Visible)
            {
                ProcessList.DataSource = getProTbl(Convert.ToInt32(StepName.SelectedValue)); ProcessList.DataBind();
                if (gvRouter.EditIndex > -1)
                {
                    hfCurSNm.Value = StepName.SelectedItem.Text;
                    try { ProcessList.SelectedValue = (Rw.FindControl("hfMPID") as HiddenField).Value; }
                    catch { ProcessList.SelectedIndex = -1; }
                }
            }

            if (gvRouter.EditIndex < 0) appDef(Rw, StepName.SelectedItem.Text, string.Empty);
        }
        private void appDef(Control Rw, string selVal, string subScript)
        {
            DataTable Tb = (new myBiz.DAL.clsDefaultValues()).Select(selVal, "RFQ");
            if (Tb != null && Tb.Rows.Count > 0)
            {
                DataRow R = Tb.Rows[0]; bool YN = !selVal.Equals("RIM");

                var txt = Rw.FindControl(string.Format("txtEPTime{0}", subScript)) as TextBox;
                txt.Text = gVal(selVal, "RIM", R["xT00"]); txt.Enabled = YN;
                var ddl = Rw.FindControl(string.Format("ddlEPUnit{0}", subScript)) as DropDownList;
                ddl.SelectedValue = gVal(selVal, "RIM", R["xU00"]); ddl.Enabled = YN;

                txt = Rw.FindControl(string.Format("txtESTime{0}", subScript)) as TextBox;
                txt.Text = gVal(selVal, "RIM", R["xT01"]); txt.Enabled = YN;
                ddl = Rw.FindControl(string.Format("ddlESUnit{0}", subScript)) as DropDownList;
                ddl.SelectedValue = gVal(selVal, "RIM", R["xU01"]); ddl.Enabled = YN;

                txt = Rw.FindControl(string.Format("txtECTime{0}", subScript)) as TextBox;
                txt.Text = gVal(selVal, "RIM", R["xT02"]); txt.Enabled = YN;
                ddl = Rw.FindControl(string.Format("ddlECUnit{0}", subScript)) as DropDownList;
                ddl.SelectedValue = gVal(selVal, "RIM", R["xU02"]); ddl.Enabled = YN;

                txt = Rw.FindControl(string.Format("txtEFTime{0}", subScript)) as TextBox;
                txt.Text = gVal(selVal, "RIM:OPS", R["xT03"]); txt.Enabled = YN;
                ddl = Rw.FindControl(string.Format("ddlEFUnit{0}", subScript)) as DropDownList;
                ddl.SelectedValue = gVal(selVal, "RIM:OPS", R["xU03"]); ddl.Enabled = YN;

                txt = Rw.FindControl(string.Format("txtFixMatl{0}", subScript)) as TextBox;
                txt.Text = gVal(selVal, "RIM:OPS", R["xA01"]); txt.Enabled = YN;
            }
        }
        private string gVal(string selVal, string exVal, object val)
        {
            string[] v = exVal.Split(':');
            return v.Contains(selVal) ? string.Empty : Convert.ToString(val);
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

                ProcessList.Visible = StepName.SelectedIndex > -1;

                if (ProcessList.Visible)
                {
                    ProcessList.DataSource = getProTbl(Convert.ToInt32(StepName.SelectedValue)); ProcessList.DataBind();
                    if (e.Row.RowState.ToString().Contains("Edit"))
                    {
                        try { ProcessList.SelectedValue = (e.Row.FindControl("hfMPID") as HiddenField).Value; }
                        catch { ProcessList.SelectedIndex = -1; }

                        HyperLink lnkTool = e.Row.FindControl("lnkTool") as HyperLink; lnkTool.ToolTip = "What information to display here?";
                        HyperLink lnkGage = e.Row.FindControl("lnkGage") as HyperLink; lnkGage.ToolTip = "What information to display here?";

                        string RterID = gvRouter.DataKeys[e.Row.RowIndex].Values["HID"].ToString();
                        string sNo = gvRouter.DataKeys[e.Row.RowIndex].Values["StepNo"].ToString();
                        hfCurSNm.Value = StepName.SelectedItem.Text;

                        lnkTool.NavigateUrl = string.Format("javascript:loadGT({0},{1},'Tool');", RterID, sNo);
                        lnkGage.NavigateUrl = string.Format("javascript:loadGT({0},{1},'Gage');", RterID, sNo);
                    }
                }
            }
        }
        protected void gvBound(object sender, EventArgs e)
        {
            pnlMoveSwap.Visible = !Util.isEmpty(gvRouter);
            //myCmp.Visible = !Util.isEmpty(gvRouter); pnlMoveSwap.Visible = myCmp.Visible;
            if (!pnlMoveSwap.Visible)
            {
                Control Rw = gvRouter.Controls[0].Controls[0];
                for (int i = 1; i < 10; i++)
                {
                    LinkButton lBtn = (LinkButton)Rw.FindControl(string.Format("lCmd_{0}", i));
                    TextBox Instr = (TextBox)Rw.FindControl(string.Format("txtInstruction_{0}", i));
                    lBtn.Attributes.Add("onclick", string.Format("gInstr('{0}','{1}');return false;", lBtn.ClientID, Instr.ClientID));
                }
            }
            loadOpList(string.Empty, string.Empty);
        }
        protected void MarkDone(object sender, EventArgs e)
        {
            var btn = sender as Button;
            var isDone = btn.Text.Equals("Done");
            (new clsTaskList()).MarkDone(Convert.ToInt32(IDs[3]), isDone, AppCode);
            btn.Text = isDone ? "Undone" : "Done";

            iMsg.ShowMsg(string.Format("Thank you! You have successfully {0} this task", isDone ? "done" : "undone"), true);
        }
        protected void btnCmp_Click(object sender, EventArgs e)
        {
            iMsg.ShowMsg("If the current rfq is a component, should we create component?", true);
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
                clsRouter Tv = new clsRouter(); bool isSwap = ddlSwap.SelectedValue.Equals("Yes") ? true : false;
                errMsg = Tv.MoveSwap(this.IDs[0], Convert.ToInt32(txtoSN.Text.Trim()), Convert.ToInt32(txtnSN.Text.Trim()), isSwap);
            }
            if (!string.IsNullOrEmpty(errMsg)) iMsg.ShowErr(string.Format("Sorry! <font color=red><ul>{0}</ul></font>", errMsg), true);
            else
            {
                gvRouter.DataBind(); txtnSN.Text = string.Empty; txtoSN.Text = string.Empty;
                iMsg.ShowMsg("Thank You! Your StepNos have been moved/swapped.", true);
            }
        }
        protected void Instr_Click(object sender, EventArgs e)
        {
            LinkButton lID = (LinkButton)sender;
            if (lID.ID.Equals("lEdit"))
            {
                lID.Text = ((TextBox)gvRouter.Rows[gvRouter.EditIndex].FindControl("txtInstruction")).Text.Substring(0, 50);
            }
        }
        protected string gInstr()
        {
            string mInstr = Eval("Instruction").ToString(); if (string.IsNullOrEmpty(mInstr)) mInstr = "&#5897;";
            int i = mInstr.Length > 50 ? 50 : mInstr.Length; return mInstr.Substring(0, i);
        }
        protected string GTLnk(string GT)
        {
            string lnk = "<a href=\"javascript:loadGT1({0},{1},'{2}','{3}','Checked');\" title=\"What information to display here?\" style=\"color:{4};\">&diams;</a>";
            return string.Format(lnk, Eval("HID"), Eval("StepNo"), Eval("StepName"), GT, Convert.ToInt32(Eval(string.Format("{0}Cnt", GT))) > 0 ? "Red" : "Blue");
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
            TaskSec.Add("t06", "Done");
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
            btnDone.Visible = !isPDA && isYN("t06");
            if (!IsPostBack) btnDone.Text = myMode.isDone ? "Undone" : "Done";
        }
    }
}