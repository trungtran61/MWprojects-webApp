using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using myBiz.DAL;
using Common.DTO;

namespace webApp._Controls
{
    public partial class ucSurvey : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) lData();
        }

        public string isCertClientID
        {
            get
            {
                return string.Format("javascript:doCert('#{0}');", chkIsCertified.ClientID);
            }
        }

        protected void lDate(object sender, EventArgs e)
        {
            rvExpDate_Cert.MinimumValue = DateTime.Today.ToShortDateString();
            rvExpDate_Cert.MaximumValue = DateTime.Today.AddYears(50).ToShortDateString();
        }
        private void lData()
        {
            var obj = new clsSurvey();
            DataRow MW = obj.getSurveyAddresses();
            DataRow Rw = obj.getHeader(VendorID, ProcessID);
            myQuestion.TemplateID = hfTemplateID.Value = Convert.ToString(Rw["TemplateID"]);
            myQuestion.CertInfoID = hfCertInfoID.Value = Convert.ToString(Rw["CertInfoID"]);

            rdoStatus.SelectedValue = Convert.ToString(Rw["SurveyStatus"]);
            txtQltyCtrlMgr.Text = Convert.ToString(Rw["QltyCtrlMgr"]);
            txtMfgMgr.Text = Convert.ToString(Rw["MfgMgr"]);
            txtProductType.Text = Convert.ToString(Rw["ProductType"]);
            chkIsDistributor.Checked = !Rw["isDistributor"].Equals(DBNull.Value) && Convert.ToBoolean(Rw["isDistributor"]);
            chkIsCertified.Checked = !Rw["isCertified"].Equals(DBNull.Value) && Convert.ToBoolean(Rw["isCertified"]);
            txtName.Text = Convert.ToString(Rw["SurveyName"]);
            txtTitle.Text = Convert.ToString(Rw["SurveyTitle"]);
            txtDate.Text = Convert.ToString(Rw["SurveyDate"]);
            txtCertNo.Text = Convert.ToString(Rw["CertNo"]);
            txtExpDate.Text = Convert.ToString(Rw["ExpDate"]);
            txtSignature.Text = Convert.ToString(Rw["Signature"]);

            litMWAddress.Text = string.Format("<b>{0}</b><br>{1}<br>{2}, {3} {4}", MW["CompanyName"], MW["Address1"], MW["City"], MW["State"], MW["Zip"]);
            litMWContact.Text = string.Format("Office: {0}<br>Fax: {1}<br>Web: {2}<br>Email: {3}", MW["Phone"], MW["Fax"], MW["Website"], MW["Email"]);

            chkIsCertified.Attributes.Add("onclick", isCertClientID);
        }

        private SurveyDTO Data
        {
            get
            {
                return new SurveyDTO
                {
                    CertID = Convert.ToInt32(this.CertID),
                    VendorID = Convert.ToInt32(this.VendorID),
                    ProcessID = Convert.ToInt32(this.ProcessID),
                    Status = rdoStatus.SelectedValue,
                    QltyCtrlMgr = txtQltyCtrlMgr.Text,
                    MfgMgr = txtMfgMgr.Text,
                    ProductType = txtProductType.Text,
                    IsDistributor = chkIsDistributor.Checked,
                    IsCertified = chkIsCertified.Checked,
                    Answers = myQuestion.Answers,
                    Name = txtName.Text,
                    Title = txtTitle.Text,
                    Date = !string.IsNullOrEmpty(txtDate.Text) ? Convert.ToDateTime(txtDate.Text) : DateTime.MinValue,
                    Signature = txtSignature.Text,
                    CertNo = txtCertNo.Text,
                    ExpDate = !string.IsNullOrEmpty(txtExpDate.Text) ? Convert.ToDateTime(txtExpDate.Text) : DateTime.MinValue,
                    CertFile = !fuCert.HasFile ? null : GetFile(fuCert.PostedFile)
                };
            }
        }
        private FileDTO GetFile(HttpPostedFile file)
        {
            byte[] output = new byte[file.ContentLength];
            file.InputStream.Read(output, 0, output.Length);

            return new FileDTO
            {
                FileName = file.FileName,
                ContentLength = file.ContentLength,
                ContentType = file.ContentType,
                FileContent = output
            };
        }
        private string doValidate()
        {
            string eMsg = string.Empty;
            if (!fuCert.HasFile) eMsg = "Certification is required!";
            return eMsg;
        }
        public string SaveData()
        {
            string rMsg = string.Empty; //doValidate();
            if (string.IsNullOrWhiteSpace(rMsg))
            {
                (new clsSurvey()).saveSurvey(Data);
                this.Visible = false;
            }
            return rMsg;
        }
        public string CertID
        {
            get { return hfCertID.Value; }
            set { hfCertID.Value = value; }
        }
        public string VendorID
        {
            get { return hfVendorID.Value; }
            set { hfVendorID.Value = value; }
        }
        public string ProcessID
        {
            get { return hfProcessID.Value; }
            set { hfProcessID.Value = value; }
        }
        public string VendorName { set { litVdrAddress.Text = value; } }
        public bool HasData
        {
            get
            {
                return !string.IsNullOrWhiteSpace(hfCertInfoID.Value) && Convert.ToInt32(hfCertInfoID.Value) > 0;
            }
        }
    }
}