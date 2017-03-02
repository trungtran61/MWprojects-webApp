using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.SessionState;
using System.Web.Script.Serialization;

namespace webApp
{
    /// <summary>
    /// Summary description for Search
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    //[System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class Search : System.Web.Services.WebService
    {
        private myBiz.DAL.clsSearch objSearch = new myBiz.DAL.clsSearch();

        [WebMethod(EnableSession = true)]
        public string[] PartNumber(string prefixText, int count)
        {
            return objSearch.PartNumber(prefixText, count);
        }

        [WebMethod(EnableSession = true)]
        public string[] CustomerPO(string prefixText, int count)
        {
            return objSearch.CustomerPO(prefixText, count);
        }

        [WebMethod(EnableSession = true)]
        public string[] getWorkOrder(string prefixText, int count)
        {
            return objSearch.getWorkOrder(prefixText, count);
        }

        [WebMethod(EnableSession = true)]
        public string[] getRFQ(string prefixText, int count)
        {
            return objSearch.getRFQ(prefixText, count);
        }

        [WebMethod(EnableSession = true)]
        public string[] GetPONumber(string prefixText, int count, string contextKey = "WIP")
        {
            return objSearch.GetPONumber(prefixText, count, contextKey);
        }

        [WebMethod(EnableSession = true)]
        public string[] GetRFQNumber(string prefixText, int count, string contextKey = "WIP")
        {
            return objSearch.GetRFQNumber(prefixText, count, contextKey);
        }

        [WebMethod(EnableSession = true)]
        public void markComplete(string URL)
        {
            var q = (URL.Split('?')[1]).Split('&');
            var AppCode = q.Where(r => r.StartsWith("AppCode=")).Select(r => r.Replace("AppCode=", string.Empty)).FirstOrDefault();
            string[] IDs = (q.Where(r => r.StartsWith("IDs=")).FirstOrDefault()).Split(':');

            (new myBiz.DAL.clsTaskList()).completeTask(Convert.ToInt32(IDs[IDs.Length - 1]), AppCode);
        }

        [WebMethod(EnableSession = true)]
        public string doLogout() { return Common.clsUser.Logout(); }

        [WebMethod(EnableSession = true)]
        public string loginDetail()
        {
            return new JavaScriptSerializer().Serialize(new { timeOut = Common.clsUser.AutoLogout, timeWarn = Common.clsUser.AutoLogoutAlert, isLoggedIn = Common.clsUser.isValidated });
        }
    }
}
