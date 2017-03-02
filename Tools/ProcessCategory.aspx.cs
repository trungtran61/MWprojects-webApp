using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp.Tools
{
    public partial class ProcessCategory : Common.pgAbstract
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadSec("Tools/Process_Category Mapping");
        }
        protected void doSave(object sender, EventArgs e)
        {
            odsProcessType.Update();
            iMsg.ShowMsg("Data has been saved, thank you!", true);
        }
        protected override void enforceSecurity()
        {
            PageSec.Add("k01", "Save Data");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            btnSave.Visible = isYN("k01");
        }
    }
}