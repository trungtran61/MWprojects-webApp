using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using myBiz.Tools;

namespace webApp.Common
{
    public abstract class ucAbstract : System.Web.UI.UserControl
    {
        protected event myDelegate myEvent;

        protected void gCmd(string cmd)
        {
            if (TaskSec.Count < 1)
            {
                enforceSecurity();
                TaskSec = clsUser.getTaskSec(Convert.ToInt32(IDs[3]), TaskSec);
            }
            switch (cmd)
            {
                case "Task": dTask(); break;
                case "Edit": dEdit(); break;
                case "View": dView(); break;
            }
        }
        protected void mEvent(System.Collections.Hashtable h) { gCmd(h["cMode"].ToString()); }
        protected string[] IDs { get { return Request.QueryString["IDs"].Split(':'); } }
        protected int xID(string key) { return (new myBiz.DAL.clsFile()).getID(IDs[3], key, AppCode); }
        protected Hashtable TaskSec
        {
            set { ViewState["TaskSec"] = value; }
            get
            {
                if (ViewState["TaskSec"] == null) ViewState["TaskSec"] = new Hashtable();
                return ViewState["TaskSec"] as Hashtable;
            }
        }

        //check if a person has access to the page or functions of a page
        protected bool isYN(string key) { return TaskSec.ContainsKey(key) && Convert.ToBoolean(TaskSec[key]); }
        protected string AppCode { get { return clsUser.AppCode; } }
        protected clsUtils Util { get { return clsUtils.myUtil; } }

        //abstract methods are required for child class
        protected abstract void dTask();
        protected abstract void dEdit();
        protected abstract void dView();
        protected abstract void enforceSecurity();
    }
}