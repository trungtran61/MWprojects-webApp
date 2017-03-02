using System;
using System.Collections.Generic;
using System.Web;
using System.Collections;
using System.Configuration;

namespace webApp.DAL
{
    public abstract class pgAbstract : System.Web.UI.Page
    {
        //call to enforceSecurity (on the first load) of a page to ensure the security is applied
        protected virtual void Page_Load(object sender, EventArgs e)
        {
            //if user is not logged in, send him/her to login page
            if (!clsUser.isValidated) Response.Redirect(ConfigurationManager.AppSettings["LoginURL"], true);
            else
            {
                if (iSec.Count < 1)
                {
                    iSec = new Hashtable(); iSec.Add("k00", "Page Access");
                    enforceSecurity(); iSec = clsUser.prepareSecurity(iSec);
                }
                //if user has no access to a page, send him/her to no access page telling user that he/she has no access
                if (!hasAccess("k00")) Response.Redirect(ConfigurationManager.AppSettings["NoAccessURL"], true);
            }
        }

        //hashtable object to retain all the security setups
        protected Hashtable iSec
        {
            set { ViewState["iSecurity"] = value; }
            get
            {
                if (ViewState["iSecurity"] == null) ViewState["iSecurity"] = new Hashtable();
                return ViewState["iSecurity"] as Hashtable;
            }
        }

        //check if a person has access to the page or functions of a page
        protected bool hasAccess(string Cde) { return iSec.ContainsKey(Cde) && Convert.ToBoolean(iSec[Cde]); }

        //abstract method is required for child class
        protected abstract void enforceSecurity();
    }
}