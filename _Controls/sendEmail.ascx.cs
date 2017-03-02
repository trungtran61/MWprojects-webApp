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
using System.Linq;
using myBiz.DAL;

namespace webApp._Controls
{
    public partial class sendEmail : System.Web.UI.UserControl
    {
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnSave.Visible = trVendor.Visible && (this.Code.Equals("Material") || this.Code.Equals("OPS") || this.Code.Equals("Gage") || this.Code.Equals("Tools"));
        }
        protected override void OnInit(EventArgs e)
        {
            if (!Page.ClientScript.IsStartupScriptRegistered("chkAllScript"))
            {
                System.Text.StringBuilder js = new System.Text.StringBuilder("function chkAll(chk, isAll){\n");
                js.Append(string.Format(" var myBoxes = document.getElementById('{0}').value.split(':');\n", hfChkBox.ClientID));
                js.Append(" var len = myBoxes.length;\n var Cnt = 1;\n");
                js.Append(" for (var i = 0; i < len; i++) {\n");
                js.Append("  if (isAll) document.getElementById(myBoxes[i]).checked = chk.checked;\n");
                js.Append("  else if (document.getElementById(myBoxes[i]).checked && i > 0) Cnt++;\n");
                js.Append(" }\n");
                js.Append(" if (!isAll) document.getElementById('chkAlls').checked = Cnt == len;\n");
                js.Append("}\n");

                Page.ClientScript.RegisterStartupScript(typeof(Page), "chkAllScript", js.ToString(), true);
            }
        }
        protected void Bound(object sender, EventArgs e)
        {
            for (int i = 0; i < lbxVendor.Items.Count; i++)
            {
                ListItem item = lbxVendor.Items[i]; item.Enabled = item.Text.EndsWith("</span>)");
                if (item.Enabled)
                {
                    string cID = string.Format("{0}_{1}", lbxVendor.ClientID, i);
                    item.Attributes.Add("onclick", "javascript:chkAll(this,false);");
                    hfChkBox.Value += string.IsNullOrEmpty(hfChkBox.Value) ? cID : string.Format(":{0}", cID);
                }
                else if (!item.Text.Contains("Expired"))
                {
                    item.Text = string.Format("<span style=\"background-color:#000000; color:#FFFFFF;\">{0}</span>", item.Text);
                }
            }
            trVendor.Visible = lbxVendor.Items.Count > 0;
        }
        protected void doSave(object sender, EventArgs e)
        {
            var q = from i in lbxVendor.Items.Cast<ListItem>()
                    where i.Selected
                    let j = i.Value.Split(':')
                    select new { SID = j[0], VID = j[1] };

            if (q.Count() > 0)
            {
                string SID = string.Join(":", (q.Select(r => r.SID)).ToArray());
                string VID = string.Join(":", (q.Select(r => r.VID)).ToArray());

                if (this.Code.Equals("Material"))
                {
                    clsMaterial objMaterial = new clsMaterial();
                    DataSet Ds = objMaterial.RFQ_Addresses(this.HID, this.Code, SID, Common.clsUser.AppCode);
                    objMaterial.Insert_Quotes(Ds.Tables[0].Rows[0][0].ToString(), this.HID, SID, VID, Common.clsUser.AppCode);
                }
                else if (this.Code.Equals("OPS"))
                {
                    clsOPS objOPS = new clsOPS();
                    DataSet Ds = objOPS.RFQ_Addresses(this.HID, this.Code, SID, Common.clsUser.AppCode);
                    objOPS.Insert_Quotes(Ds.Tables[0].Rows[0][0].ToString(), this.HID, SID, VID, Common.clsUser.AppCode);
                }
                else if (this.Code.Equals("Gage"))
                {
                    clsGage objGage = new clsGage();
                    DataSet Ds = objGage.RFQ_Addresses(this.HID, this.Code, SID, Common.clsUser.AppCode);
                    objGage.Insert_Quotes(Ds.Tables[0].Rows[0][0].ToString(), this.HID, SID, VID, Common.clsUser.AppCode);
                }
                else if (this.Code.Equals("Tools"))
                {
                    clsTools objTools = new clsTools();
                    DataSet Ds = objTools.RFQ_Addresses(this.HID, this.Code, SID, Common.clsUser.AppCode);
                    objTools.Insert_Quotes(Ds.Tables[0].Rows[0][0].ToString(), this.HID, SID, VID, Common.clsUser.AppCode);
                }

                iMsg.ShowMsg("Thank You! Quotes have been created for selected vendor.", true);
            }
            else iMsg.ShowErr("Please select at least one vendor to create quote only.", true);
        }
        protected void doSend(object sender, EventArgs e)
        {
            if (this.Code.Equals("Survey")) SendSurvey();
            else if (this.Code.Equals("ToolGroup")) SendToolGroup();
            else doSendMOGT(sender, e);
        }
        protected void SendToolGroup()
        {
            var toolInv = new clsToolInventory();
            var rw = toolInv.ToolGroupRFQ(this.HID);
            var bDy = txtBody.Text.Trim().Replace("\r", "<br>").Replace("\n", "<br>")
                .Replace("[[ToolGroupNum]]", rw["ToolGroupNum"].ToString())
                .Replace("[[Description]]", rw["Desc"].ToString());

            var x = sendSingleMessage(bDy);

            if (trVendor.Visible)
            {
                var q = from i in lbxVendor.Items.Cast<ListItem>()
                        where i.Selected
                        let j = i.Value.Split(':')
                        where j.Length > 1
                        select new { VID = j[0], Email = j[1] };

                if (q.Count() > 0)
                {
                    Hashtable h = new Hashtable();

                    h.Add("From", txtFrom.Text.Trim()); h.Add("To", string.Empty);
                    h.Add("Subject", txtSubject.Text.Trim()); h.Add("Body", bDy);

                    foreach (var i in q)
                    {
                        h["To"] = i.Email;
                        Common.clsUser.Util.sendEmail(h);
                    }
                }
            }

            if (string.IsNullOrEmpty(x))
            {
                toolInv.ToolGroupRFQSent(this.HID);
                iMsg.ShowMsg("Your message has been sent.", true);
            }
            else if (x.StartsWith("You can enter TO")) iMsg.ShowMsg(x, true);
            else iMsg.ShowErr(x, true);
        }
        protected void SendSurvey()
        {
            string x = sendSingleSurvey();

            if (trVendor.Visible)
            {
                var q = from i in lbxVendor.Items.Cast<ListItem>()
                        where i.Selected
                        let j = i.Value.Split(':')
                        where j.Length > 1
                        select new { VID = j[0], Email = j[1] };

                if (q.Count() > 0)
                {
                    var obj = new clsSurvey();

                    string eURL = Common.clsUser.Util.AppSetting("ExternalURL"), bDy = txtBody.Text.Trim().Replace("\r", "<br>").Replace("\n", "<br>"), lnkPhl = "[[VendorSurveyLink]]";
                    bool hasVendorLink = bDy.Contains(lnkPhl);
                    Hashtable h = new Hashtable();

                    h.Add("From", txtFrom.Text.Trim()); h.Add("To", string.Empty);
                    h.Add("Subject", txtSubject.Text.Trim()); h.Add("Body", hasVendorLink ? string.Empty : bDy);
                    var PID = Common.clsUser.AppCode;

                    foreach (var i in q)
                    {
                        if (hasVendorLink) h["Body"] = bDy.Replace(lnkPhl, string.Format(eURL, obj.getURL(i.VID, PID)));
                        h["To"] = i.Email;
                        Common.clsUser.Util.sendEmail(h);
                    }
                }
            }

            if (string.IsNullOrEmpty(x)) iMsg.ShowMsg("Your message has been sent.", true);
            else if (x.StartsWith("You can enter TO")) iMsg.ShowMsg(x, true);
            else iMsg.ShowErr(x, true);
        }
        protected void doSendMOGT(object sender, EventArgs e)
        {
            myBiz.Tools.clsPDF mPDF = new myBiz.Tools.clsPDF(Common.clsUser.Util.AppSetting("FormPath"), string.Format("{0}{1}", this.FormID, this.GT));
            mPDF.ImagePath = Common.clsUser.Util.AppSetting("ImagePath"); mPDF.DF = this.DF;
            string x = sendSingle(mPDF);

            if (trVendor.Visible && (this.Code.Equals("Material") || this.Code.Equals("OPS") || this.Code.Equals("Gage") || this.Code.Equals("Tools")))
            {
                var q = from i in lbxVendor.Items.Cast<ListItem>()
                        where i.Selected
                        let j = i.Value.Split(':')
                        select new { SID = j[0], VID = j[1] };

                if (q.Count() > 0)
                {
                    string SID = string.Join(":", (q.Select(r => r.SID)).ToArray());
                    string VID = string.Join(":", (q.Select(r => r.VID)).ToArray());

                    if (this.Code.Equals("Material"))
                    {
                        clsMaterial objMaterial = new clsMaterial();
                        DataSet Ds = objMaterial.RFQ_Addresses(this.HID, this.Code, SID, Common.clsUser.AppCode);
                        objMaterial.Insert_Quotes(Ds.Tables[0].Rows[0][0].ToString(), this.HID, SID, VID, Common.clsUser.AppCode);
                        sendMultiple(mPDF, Ds.Tables[1], objMaterial.RFQ_Data(this.HID, Common.clsUser.AppCode), Common.clsUser.AppCode, this.Code);
                    }
                    else if (this.Code.Equals("OPS"))
                    {
                        clsOPS objOPS = new clsOPS();
                        DataSet Ds = objOPS.RFQ_Addresses(this.HID, this.Code, SID, Common.clsUser.AppCode);
                        objOPS.Insert_Quotes(Ds.Tables[0].Rows[0][0].ToString(), this.HID, SID, VID, Common.clsUser.AppCode);
                        sendMultiple(mPDF, Ds.Tables[1], objOPS.RFQ_Data(this.HID, Common.clsUser.AppCode), Common.clsUser.AppCode, this.Code);
                    }
                    else if (this.Code.Equals("Gage"))
                    {
                        clsGage objGage = new clsGage();
                        DataSet Ds = objGage.RFQ_Addresses(this.HID, this.Code, SID, Common.clsUser.AppCode);
                        objGage.Insert_Quotes(Ds.Tables[0].Rows[0][0].ToString(), this.HID, SID, VID, Common.clsUser.AppCode);
                        sendMultiple(mPDF, Ds.Tables[1], objGage.RFQ_Data(this.HID, Common.clsUser.AppCode), Common.clsUser.AppCode, this.Code);
                    }
                    else if (this.Code.Equals("Tools"))
                    {
                        clsTools objTools = new clsTools();
                        DataSet Ds = objTools.RFQ_Addresses(this.HID, this.Code, SID, Common.clsUser.AppCode);
                        objTools.Insert_Quotes(Ds.Tables[0].Rows[0][0].ToString(), this.HID, SID, VID, Common.clsUser.AppCode);
                        sendMultiple(mPDF, Ds.Tables[1], objTools.RFQ_Data(this.HID, Common.clsUser.AppCode), Common.clsUser.AppCode, this.Code);
                    }
                }
            }

            if (string.IsNullOrEmpty(x)) iMsg.ShowMsg("Your message has been sent.", true);
            else if (x.StartsWith("You can enter TO")) iMsg.ShowMsg(x, true);
            else iMsg.ShowErr(x, true);
        }
        private string sendSingle(myBiz.Tools.clsPDF mPDF)
        {
            string xTo = txtTo.Text.Trim(), x = string.Empty;
            if (!string.IsNullOrEmpty(xTo))
            {
                Hashtable h = new Hashtable(); h.Add("From", txtFrom.Text.Trim()); h.Add("To", xTo);
                if (!string.IsNullOrEmpty(txtCC.Text.Trim())) h.Add("CC", txtCC.Text.Trim());
                if (!string.IsNullOrEmpty(txtBcc.Text.Trim())) h.Add("Bcc", txtBcc.Text.Trim());
                h.Add("Subject", txtSubject.Text.Trim()); h.Add("Body", txtBody.Text.Trim().Replace("\r", "<br>").Replace("\n", "<br>"));
                x = _sendEmail(h, getStream(mPDF));
            }
            else x = "You can enter TO email address if you would like to send CC and Bcc as well.";
            return x;
        }
        private string sendSingleSurvey()
        {
            string xTo = txtTo.Text.Trim(), x = string.Empty;
            if (!string.IsNullOrEmpty(xTo))
            {
                Hashtable h = new Hashtable(); h.Add("From", txtFrom.Text.Trim()); h.Add("To", xTo);
                if (!string.IsNullOrEmpty(txtCC.Text.Trim())) h.Add("CC", txtCC.Text.Trim());
                if (!string.IsNullOrEmpty(txtBcc.Text.Trim())) h.Add("Bcc", txtBcc.Text.Trim());
                h.Add("Subject", txtSubject.Text.Trim()); h.Add("Body", txtBody.Text.Trim().Replace("\r", "<br>").Replace("\n", "<br>"));
                x = Common.clsUser.Util.sendEmail(h);
            }
            else x = "You can enter TO email address if you would like to send CC and Bcc as well.";
            return x;
        }
        private string sendSingleMessage(string bDy)
        {
            string xTo = txtTo.Text.Trim(), x = string.Empty;
            if (!string.IsNullOrEmpty(xTo))
            {
                Hashtable h = new Hashtable(); h.Add("From", txtFrom.Text.Trim()); h.Add("To", xTo);
                if (!string.IsNullOrEmpty(txtCC.Text.Trim())) h.Add("CC", txtCC.Text.Trim());
                if (!string.IsNullOrEmpty(txtBcc.Text.Trim())) h.Add("Bcc", txtBcc.Text.Trim());
                h.Add("Subject", txtSubject.Text.Trim()); h.Add("Body", bDy);
                x = Common.clsUser.Util.sendEmail(h);
            }
            else x = "You can enter TO email address if you would like to send CC and Bcc as well.";
            return x;
        }
        private void sendMultiple(myBiz.Tools.clsPDF mPDF, DataTable Tb, Hashtable RFQ, string aCode, string aName)
        {
            var eFill = new myBiz.DAL.clsExternalFill();
            string eURL = Common.clsUser.Util.AppSetting("ExternalURL"), bDy = txtBody.Text.Trim().Replace("\r", "<br>").Replace("\n", "<br>"), lnkPhl = "[[VendorLink]]";
            bool hasVendorLink = bDy.Contains(lnkPhl) && !string.IsNullOrEmpty(aCode) && !string.IsNullOrEmpty(aName);

            Hashtable h = new Hashtable(), hashForm = RFQ["hashForm"] as Hashtable;
            hashForm.Add("toCompanyName", string.Empty); hashForm.Add("toAddress1", string.Empty);
            hashForm.Add("toCity", string.Empty); hashForm.Add("toState", string.Empty);
            hashForm.Add("toZip", string.Empty); hashForm.Add("Contact", string.Empty);
            hashForm.Add("Phone", string.Empty); hashForm.Add("Fax", string.Empty);

            h.Add("From", txtFrom.Text.Trim()); h.Add("To", string.Empty);
            h.Add("Subject", txtSubject.Text.Trim()); h.Add("Body", hasVendorLink ? string.Empty : bDy);

            var q = Tb.Rows.Cast<DataRow>().Where(r => r["Email"] != null && !string.IsNullOrEmpty(r["Email"].ToString()));
            foreach (var Rw in q)
            {
                if(hasVendorLink) h["Body"] = bDy.Replace(lnkPhl, string.Format(eURL, eFill.getURL(Rw["CpyID"].ToString(), this.HID, aCode, aName)));
                h["To"] = Rw["Email"];
                hashForm["toCompanyName"] = Rw["CompanyName"];
                hashForm["toAddress1"] = Rw["Address1"];
                hashForm["toCity"] = Rw["City"];
                hashForm["toState"] = Rw["State"];
                hashForm["toZip"] = Rw["Zip"];
                hashForm["Contact"] = Rw["Contact"];
                hashForm["Phone"] = Rw["Phone"];
                hashForm["Fax"] = Rw["Fax"];
                _sendEmail(h, mPDF.getPdf(RFQ));
            }
        }
        private string _sendEmail(Hashtable h, System.IO.MemoryStream ms)
        {
            System.Collections.Generic.List<Hashtable> Att = new System.Collections.Generic.List<Hashtable>();
            Hashtable i = new Hashtable(); i.Add("Att", ms); i.Add("Nm", string.Format("{0}.pdf", gNum)); Att.Add(i);
            Att.AddRange(myFile.gFiles());
            if (h.ContainsKey("Attachments")) h["Attachments"] = Att; else h.Add("Attachments", Att);

            return Common.clsUser.Util.sendEmail(h);
        }
        protected void doSend1(object sender, EventArgs e)
        {
            myBiz.Tools.clsPDF mPDF = new myBiz.Tools.clsPDF(Common.clsUser.Util.AppSetting("FormPath"), string.Format("{0}{1}", this.FormID, this.GT));
            mPDF.ImagePath = Common.clsUser.Util.AppSetting("ImagePath"); mPDF.DF = this.DF;
            Response.ClearHeaders(); Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", string.Format("attachment;filename={0}.pdf", FormID));
            System.IO.MemoryStream os = getStream(mPDF);
            Response.BinaryWrite(os.GetBuffer());
            os.Close();
            Response.End();
        }
        private System.IO.MemoryStream getStream(myBiz.Tools.clsPDF mPDF)
        {
            System.IO.MemoryStream ms = new System.IO.MemoryStream();
            switch (this.Code)
            {
                case "Invoice": ms = mPDF.getPdf((new clsPackingList()).getInvoiceData(this.HID)); break;
                case "Tool": ms = mPDF.getPdf((new clsTool()).getFormData(this.FormID, this.HID)); break;
                case "GeneralPO": ms = mPDF.getPdf((new clsPO()).getFormData(this.FormID, this.HID)); break;
                case "OPSPO": ms = mPDF.getPdf((new clsOPS()).PO_Data(HID)); break;
                case "OPS": ms = mPDF.getPdf((new clsOPS()).RFQ_Data(HID, Common.clsUser.AppCode)); break;
                case "MaterialPO": ms = mPDF.getPdf((new clsMaterial()).PO_Data(HID, Common.clsUser.AppCode)); break;
                case "Material": ms = mPDF.getPdf((new clsMaterial()).RFQ_Data(this.HID, Common.clsUser.AppCode)); break;
                case "Gage": ms = mPDF.getPdf((new clsGage()).RFQ_Data(this.HID, Common.clsUser.AppCode)); break;
                case "Tools": ms = mPDF.getPdf((new clsTools()).RFQ_Data(this.HID, Common.clsUser.AppCode)); break;
                case "FinQte": ms = mPDF.getPdf((new clsFinQte()).QTE_Data(this.HID, Common.clsUser.AppCode)); break;
            }

            return ms;
        }
        public string GT { set { hfGT.Value = value; } get { return hfGT.Value; } }
        public string FormID { set { hfFormID.Value = value; } get { return hfFormID.Value; } }
        public string HID { set { hfHID.Value = value; } get { return hfHID.Value; } }
        public string Code { set { hfCode.Value = value; } get { return hfCode.Value; } }
        public string DF { set { hfDF.Value = value; } get { return string.IsNullOrEmpty(hfDF.Value) ? Common.clsUser.Util.AppSetting("FormDefDate") : hfDF.Value; } }
        public void loadData()
        {
            if (!IsPostBack)
            {
                this.Visible = isVisible;
                if (this.Visible)
                {
                    switch (FormID)
                    {
                        case "RFQ":
                        case "QTE":
                        case "PO":
                        case "Invoice":
                        case "Survey":
                        case "ToolGroup":
                        case "CustFU":
                        case "PoCustFU":
                            callEmailDetail(); break;
                    }
                }
            }
        }
        private void callEmailDetail()
        {
            string xCode = Code, xHID = this.HID;
            if (Code.Equals("GeneralPO")) { string[] v = HID.Split('_'); xHID = v[0]; xCode = v[1]; }
            else if (Code.Equals("MaterialPO")) xCode = "Material";
            else if (Code.Equals("OPSPO")) xCode = "OPS";
            else if (Code.Equals("Survey")) xHID = Common.clsUser.AppCode;

            DataSet Ds = (new clsMisc()).getEmailDetail(Common.clsUser.uID, xCode, FormID, !FormID.Equals("RFQ") || Code.Equals("Tool") ? Convert.ToInt32(xHID) : -1);
            litEmail.Text = generateAddress(Ds.Tables[0]);

            DataRow Rw = Ds.Tables[1].Rows[0];
            if (Rw["frEmail"] != null && !string.IsNullOrEmpty(Rw["frEmail"].ToString())) txtFrom.Text = Rw["frEmail"].ToString();
            if (Rw["toEmail"] != null && !string.IsNullOrEmpty(Rw["toEmail"].ToString())) txtTo.Text = Rw["toEmail"].ToString();

            if (FormID.Equals("RFQ") && !Code.Equals("Tool")) gNum = HID;
            else if (Rw["Num"] != null && !string.IsNullOrEmpty(Rw["Num"].ToString())) gNum = Rw["Num"].ToString();

            if (xCode.Equals("Survey") && !string.IsNullOrEmpty(gNum)) txtSubject.Text = string.Format("Survey from {0}", gNum);
            else if (xCode.Equals("ToolGroup") && !string.IsNullOrEmpty(gNum)) txtSubject.Text = string.Format("RFQ for TG# {0}", gNum);
            else if (xCode.Equals("CustFU") || xCode.Equals("PoCustFU")) txtSubject.Text = "Follow Up from Machine Works.";
            else if (!string.IsNullOrEmpty(gNum)) txtSubject.Text = string.Format("{0}# {1} from Machine Works, LLC. ({2})", FormID, gNum, Common.clsUser.isWIP ? "WO" : "QTE");

            if (Rw["Body"] != null && !string.IsNullOrEmpty(Rw["Body"].ToString())) txtBody.Text = Rw["Body"].ToString();
        }
        private string generateAddress(DataTable Tb)
        {
            if (Tb != null && Tb.Rows.Count > 0)
            {
                System.Text.StringBuilder s = new System.Text.StringBuilder("<table>");
                string tr = "<tr><td><input type=\"checkbox\" id=\"xAddress_{0}\" name=\"xAddress_{0}\" value=\"{1}\" /> {2}</td></tr>\n";
                int Cnt = Tb.Rows.Count;
                for (int i = 0; i < Cnt; i++)
                {
                    DataRow r = Tb.Rows[i];
                    s.Append(string.Format(tr, i, r["Email"], r["xEmail"]));
                }
                s.Append("</table>"); hfCnt.Value = Cnt.ToString();
                return s.ToString();
            }
            else return "Company does not have contact list.";
        }
        private string gNum
        {
            set { ViewState["gNum"] = value; }
            get { return ViewState["gNum"] == null ? string.Empty : ViewState["gNum"].ToString(); }
        }
        public bool isVisible { get { return !string.IsNullOrEmpty(this.FormID) && !string.IsNullOrEmpty(this.HID) && !string.IsNullOrEmpty(this.Code); } }
    }
}