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

namespace webApp.AdminPanel
{
    public partial class CommMgmnt : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (loadSec("AdminPanel/Communication Management"))
            {
                ucClass.myEvent += new Common.myDelegate(classEvent);
                ucCompany.myEvent += new Common.myDelegate(companyEvent);
                ucType.myEvent += new Common.myDelegate(typeEvent);
                ucContact.myEvent += new Common.myDelegate(contactEvent);
                ucAddress.myEvent += new Common.myDelegate(addressEvent);
                ucItem.myEvent += new Common.myDelegate(itemEvent);
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            ucType.isInAct = isYN("k16");
            ucCompany.Visible = ucCompany.isVisible;
            ucType.Visible = ucType.isVisible;
            ucContact.Visible = ucContact.isVisible;
            ucAddress.Visible = ucAddress.isVisible;
            ucItem.Visible = ucItem.isVisible;

            btnSave.Visible = isYN("k01");
            btnRemove.Visible = isYN("k02");
        }

        protected void classEvent(Hashtable h)
        {
            if (h.ContainsKey("loadSec"))
            {
                loadSec("AdminPanel/Communication Management"); h.Clear();
                foreach (string k in PageSec.Keys) h.Add(k, PageSec[k]);
            }
            else
            {
                ucCompany.ClassID = ucType.ClassID = ucContact.ClassID = ucAddress.ClassID = ucItem.ClassID = h["ClassID"].ToString();
            }
        }
        protected void companyEvent(Hashtable h)
        {
            if (h.ContainsKey("loadSec"))
            {
                loadSec("AdminPanel/Communication Management"); h.Clear();
                foreach (string k in PageSec.Keys) h.Add(k, PageSec[k]);
            }
            else
            {
                ucType.CompanyID = ucContact.CompanyID = ucAddress.CompanyID = ucItem.CompanyID = h["CompanyID"].ToString();
                ucContact.isMore = ucAddress.isMore = true;
            }
        }
        protected void typeEvent(Hashtable h)
        {
            if (h.ContainsKey("loadSec"))
            {
                loadSec("AdminPanel/Communication Management"); h.Clear();
                foreach (string k in PageSec.Keys) h.Add(k, PageSec[k]);
            }
            else
            {
                ucContact.TypeID = ucAddress.TypeID = ucItem.TypeID = h["TypeID"].ToString();
                ucContact.isMore = false;
            }
        }
        protected void contactEvent(Hashtable h)
        {
            if (h.ContainsKey("loadSec"))
            {
                loadSec("AdminPanel/Communication Management"); h.Clear();
                foreach (string k in PageSec.Keys) h.Add(k, PageSec[k]);
            }
            else
            {
                ucAddress.ContactID = ucItem.ContactID = h["ContactID"].ToString();
                ucAddress.isMore = false;
            }
        }
        protected void addressEvent(Hashtable h)
        {
            if (h.ContainsKey("loadSec"))
            {
                loadSec("AdminPanel/Communication Management"); h.Clear();
                foreach (string k in PageSec.Keys) h.Add(k, PageSec[k]);
            }
            else
            {
                ucItem.AddressID = h["AddressID"].ToString();
            }
        }
        protected void itemEvent(Hashtable h)
        {
            if (h.ContainsKey("loadSec"))
            {
                loadSec("AdminPanel/Communication Management"); h.Clear();
                foreach (string k in PageSec.Keys) h.Add(k, PageSec[k]);
            }
        }
        protected void dCmd(object sender, EventArgs e)
        {
            var btn = sender as Button;
            (new myBiz.DAL.clsCommunication()).Save(btn.ID.Equals("btnSave"), ucClass.ClassID,
                ucCompany.CompanyID, ucType.TypeID, ucContact.ContactID, ucAddress.AddressID, ucItem.ItemID);
            iMsg.ShowMsg("Thank you! you have sucessfully save/remove the communication contact.", true);
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Save Button");
            PageSec.Add("k02", "Remove Button");
            PageSec.Add("k03", "Edit Class");
            PageSec.Add("k04", "Add New Class");
            PageSec.Add("k05", "View Customer");
            PageSec.Add("k06", "View Supplier");
            PageSec.Add("k07", "View Owner");
            PageSec.Add("k08", "Edit Company");
            PageSec.Add("k09", "Add New Company");
            PageSec.Add("k10", "Edit Contact");
            PageSec.Add("k11", "Add New Contact");
            PageSec.Add("k12", "Edit Address");
            PageSec.Add("k13", "Add New Address");
            PageSec.Add("k14", "Edit Item");
            PageSec.Add("k15", "Add New Item");
            PageSec.Add("k16", "Activate/Inactivate Button");
            PageSec.Add("k17", "Allow CVT Box");
            PageSec.Add("k18", "Allow Blk Box");
        }
    }
}