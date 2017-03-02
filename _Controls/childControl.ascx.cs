using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class childControl : System.Web.UI.UserControl
    {
        public event Common.myDelegate myEvent;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(hfChildID.Value)) loadChild();
        }
        private void loadChild()
        {
            string[] v = hfChildID.Value.Split(':'); if (myCtrl.Controls.Count > 0) myCtrl.Controls.Clear();
            UserControl x = (UserControl)LoadControl(string.Format("{0}.ascx", v[1])); x.ID = string.Format("uc{0}", v[1]);
            Delegate D = Delegate.CreateDelegate(x.GetType().GetEvent("myEvent").EventHandlerType, this, "mEvent");
            x.GetType().GetEvent("myEvent").AddEventHandler(x, D); myCtrl.Controls.Add(x); MPE.Show();
        }
        public string ChildID { set { hfChildID.Value = value; } }
        public bool btnClose { set { imgClose.Enabled = value; } }
        protected void mEvent(Hashtable h)
        {
            if (h.Contains("delChild") && hfChildID.Value.Equals(h["delChild"])) hideMe();
            this.myEvent(h);
        }
        protected void imgClose_Click(object sender, EventArgs e)
        {
            Hashtable h = new Hashtable(); h.Add("delChild", hfChildID.Value); hideMe(); this.myEvent(h);
        }
        private void hideMe() { myCtrl.Controls.Clear(); hfChildID.Value = string.Empty; MPE.Hide(); }
    }
}