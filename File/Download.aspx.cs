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
using myBiz.DAL;

namespace webApp.File
{
    public partial class Download : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["TID"])) doDownload();
        }
        protected void doDownload()
        {
            DataRow Rw = (new clsWorkOrder()).getBlankField(Convert.ToInt32(Request.QueryString["TID"]));

            if (Rw != null)
            {
                string data = string.Empty, FN = Rw["fName"].ToString();
                if (!string.IsNullOrEmpty(Request.QueryString["HV"])) FN += Request.QueryString["HV"];

                string xmlFile = string.Format("{0}{1}.xml", ConfigurationManager.AppSettings["FormPath"], FN);
                using (System.IO.StreamReader sr = new System.IO.StreamReader(xmlFile)) data = sr.ReadToEnd();

                Response.Clear(); Response.ContentType = "application/octet-stream";
                Response.AddHeader("content-disposition", string.Format("attachment; filename={0}.xls", FN));

                switch (FN)
                {
                    case "FIPIP": Response.Write(string.Format(data, Rw["WorkOrder"], Rw["PartNumber"], Rw["Revision"], Rw["OpNo"], Rw["PartName"], Rw["oQty"])); break;
                    case "FAIRFIN": Response.Write(string.Format(data, Rw["WorkOrder"], Rw["PartNumber"], Rw["Revision"], Rw["PartName"], Rw["oQty"], Rw["CustomerPO"], Rw["Line"])); break;
                    default: Response.Write(string.Format(data, Rw["PartNumber"], Rw["Revision"], Rw["OpNo"])); break;
                }

                Response.End();
            }
        }
    }
}