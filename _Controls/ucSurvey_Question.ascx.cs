using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common.DTO;

namespace webApp._Controls
{
    public partial class ucSurvey_Question : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void rptBound(object sender, RepeaterItemEventArgs e)
        {
            var AnswerType = (e.Item.FindControl("hfAnswerType") as HiddenField).Value;
            var rdoAnswer = e.Item.FindControl("rdoAnswer") as RadioButtonList;
            var txtAnswer = e.Item.FindControl("txtAnswer") as TextBox;
            var rfvAnswer = e.Item.FindControl("rfvAnswer_NoCert") as RequiredFieldValidator;

            rfvAnswer.Visible = rdoAnswer.Visible = AnswerType.Equals("YNA");
            txtAnswer.Visible = !rdoAnswer.Visible;
            if (rdoAnswer.Visible)
            {
                rdoAnswer.SelectedValue = txtAnswer.Text;
            }
        }
        public string TemplateID
        {
            get { return hfTemplateID.Value; }
            set { hfTemplateID.Value = value.ToString(); }
        }
        public string CertInfoID
        {
            get { return hfCertInfoID.Value; }
            set { hfCertInfoID.Value = value.ToString(); }
        }

        public List<QuestionDTO> Answers
        {
            get
            {
                var dto = new List<QuestionDTO>();
                var q = rptSection.Items.Cast<RepeaterItem>().Select(x => x.FindControl("rptQuestion") as Repeater);

                foreach (var i in q)
                {
                    var x = from a in i.Items.Cast<RepeaterItem>()
                            let isYN = (a.FindControl("hfAnswerType") as HiddenField).Value.Equals("YNA")
                            select new QuestionDTO
                            {
                                QuestionID = Convert.ToInt32((a.FindControl("hfQuestionID") as HiddenField).Value),
                                SurveyAnswer = isYN ? (a.FindControl("rdoAnswer") as RadioButtonList).SelectedValue : (a.FindControl("txtAnswer") as TextBox).Text
                            };

                    dto.AddRange(x.ToList());
                }

                return dto;
            }
        }
    }
}