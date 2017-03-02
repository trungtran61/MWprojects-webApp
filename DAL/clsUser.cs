using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using myBiz.Tools;

namespace webApp.DAL
{
    public delegate void myDelegate(object sender, EventArgs e);

    public static class clsUser
    {
        private static DBAccess myDB = DBAccess.myDB;

        //public static string Register(string CompanyName, int CompTypeID, string CompDesc, string Email, string PWD)
        //{
        //    DataSet Ds = objUser.User_Register(CompanyName, CompTypeID, CompDesc, Email, PWD);
        //    string rMsg = Ds.Tables[0].Rows[0][0].ToString();
        //    if (string.IsNullOrEmpty(rMsg) && Ds.Tables.Count > 1)
        //    {
        //        Session.Add("UserInfo", Ds.Tables[1].Rows[0]);
        //        Session.Timeout = Convert.ToInt32(myBiz.Tools.clsUtils.myUtil.AppSetting("LogoutInterval"));
        //        HttpContext.Current.Response.Cache.SetExpires(DateTime.Now.AddMinutes(Session.Timeout));
        //        return string.Empty;
        //    }
        //    else return rMsg;
        //}
        //public static bool Login(string Email, string Password)
        //{
        //    DataRow Rw = objUser.getUserInfo(Email, Password);
        //    if (Rw != null)
        //    {
        //        Session.Add("UserInfo", Rw);
        //        Session.Timeout = Convert.ToInt32(myBiz.Tools.clsUtils.myUtil.AppSetting("LogoutInterval"));
        //        HttpContext.Current.Response.Cache.SetExpires(DateTime.Now.AddMinutes(Session.Timeout));
        //        return true;
        //    }
        //    else return false;
        //}
        //public static string Logout()
        //{
        //    Session.Clear(); Session.Abandon();
        //    return "You have successfully logged out of ServiceIT.";
        //}
        //public static bool isValidated { get { return Session["UserInfo"] != null; } }
        public static bool isValidated { get { return true; } }
        //public static int UserID { get { return Convert.ToInt32(getValue("UserID")); } }
        //public static string UserType { get { return Convert.ToString(getValue("UserType")); } }
        //public static int CompanyID { get { return UserType.Equals("Company") ? Convert.ToInt32(getValue("CompanyID")) : -1; } }
        //public static int ProvierID { get { return UserType.Equals("Provider") ? Convert.ToInt32(getValue("ProviderID")) : -1; } }
        //public static int ClientID { get { return UserType.Equals("Client") ? Convert.ToInt32(getValue("ClientID")) : -1; } }
        //public static bool isActive { get { return Convert.ToBoolean(getValue("isActive")); } }
        //public static string DisplayName { get { return Convert.ToString(getValue("DisplayName")); } }
        //public static string fontSize
        //{
        //    set { Session["fontSize"] = value; }
        //    get { return Session["fontSize"] == null ? "small" : Session["fontSize"].ToString(); }
        //}
        //public static string TimeOutScript(string Message, int MinutesBeforeExpire)
        //{
        //    string jvScript = "<script type=\"text/javascript\" language=\"javascript\">\n";
        //    jvScript += "var timer = null;\n";
        //    jvScript += "var reset = function()\n{\n";
        //    jvScript += " if (timer) clearTimeout(timer);\n";
        //    jvScript += string.Format(" timer = setTimeout(\"alert('{0}')\", {1});\n", Message, (Session.Timeout - MinutesBeforeExpire) * 60000);
        //    jvScript += "};\nreset();\n</script>";
        //    return jvScript;
        //}
        ////prepare the security object of a person for a page
        public static Hashtable prepareSecurity(Hashtable iSec)
        {
            //return objUser.getSecurity(UserID, HttpContext.Current.Request.ServerVariables["URL"], iSec);

            //TODO: access database to get security settings based on UserID (tblUser.HID)
            Hashtable h = new Hashtable();
            foreach (string k in iSec.Keys) h.Add(k, true); // temporary set everything to true for now
            return h;
        }

        private static object getValue(string key)
        {
            try { return ((DataRow)Session["UserInfo"])[key]; }
            catch { return null; }
        }
        private static System.Web.SessionState.HttpSessionState Session { get { return HttpContext.Current.Session; } }
    }
}