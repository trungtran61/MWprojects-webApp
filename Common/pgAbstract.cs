using System;
using System.Collections.Generic;
using System.Web;
using System.Collections;
using myBiz.Tools;

namespace webApp.Common
{
    public abstract class pgAbstract : System.Web.UI.Page
    {
        protected bool loadSec(string PageName)
        {
            if (!clsUser.isValidated) { Response.Redirect(Util.AppSetting("LoginURL"), true); return false; }
            else
            {
                if (PageSec.Count < 1)
                {
                    PageSec.Add("k00", "Page Access"); enforceSecurity();
                    PageSec = clsUser.prepareSecurity(PageName, PageSec);
                }

                if (isYN("k00")) return true;
                else { Response.Redirect("~/Errors/Invalid.aspx", true); return false; }
            }
        }

        //hashtable object to retain all the security setups
        protected Hashtable PageSec
        {
            set { ViewState["PageSec"] = value; }
            get
            {
                if (ViewState["PageSec"] == null) ViewState["PageSec"] = new Hashtable();
                return ViewState["PageSec"] as Hashtable;
            }
        }

        //check if a person has access to the page or functions of a page
        protected bool isYN(string key) { return PageSec.ContainsKey(key) && Convert.ToBoolean(PageSec[key]); }
        protected string AppCode { get { return clsUser.AppCode; } }
        protected clsUtils Util { get { return clsUtils.myUtil; } }

        //abstract method is required for child class
        protected abstract void enforceSecurity();
    }
}