using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using myBiz.Tools;

namespace webApp.Common
{
    public delegate void myDelegate(Hashtable h);
    public delegate void mDelegate(object sender, EventArgs e);

    public static class clsUser
    {
        private static myBiz.DAL.clsUser objUser = new myBiz.DAL.clsUser();

        public static bool chkLogin(string UserName, string Password)
        {
            DataRow Rw = objUser.getUserInfo(UserName, Password);
            return Rw != null;
        }
        public static bool Login(string UserName, string Password)
        {
            DataRow Rw = objUser.getUserInfo(UserName, Password);
            if (Rw != null)
            {
                setupLogoutInteral();
                Session.Add("UserInfo", Rw);
                Session.Timeout = AutoLogout;
                HttpContext.Current.Response.Cache.SetExpires(DateTime.Now.AddMinutes(Session.Timeout));
                return true;
            }
            else return false;
        }
        public static string Logout()
        {
            Session.Clear(); Session.Abandon();
            return "You have successfully logged out.";
        }
        private static void setupLogoutInteral()
        {
            int tOut = 0, tWarn = 0;
            var Tb = myBiz.DAL.clsDB.spAdmin_Variables_S("AutoLogout:AutoLogoutAlert");
            foreach (System.Data.DataRow Rw in Tb.Rows)
            {
                switch (Rw["nKey"].ToString())
                {
                    case "AutoLogout": tOut = Convert.ToInt32(Rw["iValue"]); break;
                    case "AutoLogoutAlert": tWarn = Convert.ToInt32(Rw["iValue"]); break;
                }
            }
            Session["AutoLogout"] = tOut > 0 ? tOut : 20;
            Session["AutoLogoutAlert"] = tWarn > 0 ? tWarn : 5;
        }

        public static int AutoLogout { get { return Session["AutoLogout"] != null ? Convert.ToInt32(Session["AutoLogout"]) : 20; } }
        public static int AutoLogoutAlert { get { return Session["AutoLogoutAlert"] != null ? Convert.ToInt32(Session["AutoLogoutAlert"]) : 5; } }
        public static bool isValidated { get { return Session["UserInfo"] != null; } }
        public static string fontSize
        {
            get { return Convert.ToString(getValue("fontSize")); }
            set { setValue("fontSize", value); }
        }
        public static string uID { get { return Convert.ToString(getValue("uID")); } }
        public static string dName { get { return Convert.ToString(getValue("dName")); } }
        public static DateTime lDate
        {
            get { return Convert.ToDateTime(getValue("lDate")); }
            set { setValue("lDate", value); }
        }
        public static bool isExpired { get { return Convert.ToBoolean(getValue("isExpired")); } }
        public static bool isSuperUser { get { return Convert.ToBoolean(getValue("isSuperUser")); } }
        public static bool isWIP { get { return AppCode.Equals("WIP"); } }
        public static clsUtils Util { get { return clsUtils.myUtil; } }

        public static string TimeOutScript(string Message, int MinutesBeforeExpire)
        {
            string jvScript = "<script type=\"text/javascript\" language=\"javascript\">\n";
            jvScript += "var timer = null;\n";
            jvScript += "var reset = function()\n{\n";
            jvScript += " if (timer) clearTimeout(timer);\n";
            jvScript += string.Format(" timer = setTimeout(\"doExpire('{0}')\", {1});\n", Message, (Session.Timeout - MinutesBeforeExpire) * 60000);
            jvScript += "};\nreset();\n</script>";
            return jvScript;
        }

        ////prepare the security object of a person for a page
        public static Hashtable prepareSecurity(string pageName, Hashtable iSec)
        {
            string pageURL = HttpContext.Current.Request.ServerVariables["URL"].ToLower();

            if (pageName.Equals("StartButton/Navigation"))
            {
                string[] pi = HttpContext.Current.Request.ServerVariables["PATH_INFO"].Split('/');
                pageURL = string.Format("/{0}/{1}.aspx", pi[1], pageName).ToLower();
            }

            if (EnforcePWD.Equals("ePwd") && !pageURL.EndsWith("changepwd.aspx"))
            {
                HttpContext.Current.Response.Redirect("~/ChangePWD.aspx", true);
                return new Hashtable();
            }
            else
            {
                Hashtable r = new Hashtable(); bool isSuper = isSuperUser;
                if (isValidated && !isSuper) r = objUser.getPageSec(uID, pageName, pageURL, iSec);
                else foreach (string k in iSec.Keys) r.Add(k, isSuper);
                return r;
            }
        }

        public static Hashtable getTaskSec(int TID, Hashtable tSec)
        {
            Hashtable r = new Hashtable(); bool isSuper = isSuperUser;
            if (isValidated && !isSuper) r = objUser.getTaskSec(uID, TID, tSec, AppCode);
            else
            {
                for (int i = 1; i < 11; i++)
                {
                    string k = i < 10 ? string.Format("t0{0}", i) : string.Format("t{0}", i);
                    r.Add(k, isSuper);
                }
            }
            return r;
        }

        public static string EnforcePWD
        {
            get
            {
                Hashtable PageSec;

                if (Session["EnforcePWD"] == null)
                {
                    if (isExpired)
                    {
                        PageSec = new Hashtable();
                        PageSec.Add("k00", "Page Access");
                        PageSec.Add("k01", "External Login");
                        PageSec.Add("k02", "Enforce Password Change");
                        Hashtable rh = objUser.getPageSec(uID, "Login", clsUtils.myUtil.AppSetting("LoginURL"), PageSec);

                        PageSec = new Hashtable();
                        PageSec.Add("ePwd", clsUtils.myUtil.isYN(rh, "k02"));
                        PageSec.Add("iExp", true);
                    }
                    else
                    {
                        PageSec = new Hashtable();
                        PageSec.Add("ePwd", false);
                        PageSec.Add("iExp", false);
                    }

                    Session["EnforcePWD"] = PageSec;
                }
                else PageSec = Session["EnforcePWD"] as Hashtable;

                bool ePwd = clsUtils.myUtil.isYN(PageSec, "ePwd"), iExp = clsUtils.myUtil.isYN(PageSec, "iExp");
                return iExp && ePwd ? "ePwd" : iExp ? "iExp" : string.Empty;
            }
        }
        public static bool ChangePWD(string oPWD, string nPWD) { return objUser.ChangePWD(uID, oPWD, nPWD); }
        public static string AppCode { get { return HttpContext.Current.Request.QueryString["AppCode"] ?? "WIP"; } }
        public static int xID(string TaskID, string key) { return (new myBiz.DAL.clsFile()).getID(TaskID, key, AppCode); }

        private static object getValue(string key)
        {
            try { return ((DataRow)Session["UserInfo"])[key]; }
            catch { return null; }
        }
        private static void setValue(string key, object value)
        {
            if (Session["UserInfo"] != null)
            {
                DataRow Rw = (DataRow)Session["UserInfo"];
                Rw[key] = value; Session["UserInfo"] = Rw;
            }
        }
        private static System.Web.SessionState.HttpSessionState Session { get { return HttpContext.Current.Session; } }
    }
}