using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webApp._Controls
{
    public partial class attFile : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Rw_Cmd(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Download")) downloadDoc(e.CommandArgument.ToString());
        }
        protected void downloadDoc(string FileID)
        {
            myBiz.DAL.clsFile mF = new myBiz.DAL.clsFile(); Hashtable h = mF.getDoc(FileID);
            if (h.Contains("errMsg")) litMsg.Text = h["errMsg"].ToString();
            else
            {
                Response.Clear(); Response.ContentType = h["Type"].ToString();
                Response.AddHeader("content-disposition", "attachment; filename=" + h["Name"].ToString());
                Response.BinaryWrite((byte[])h["FileData"]); Response.End();
            }
        }
        public List<Hashtable> gFiles()
        {
            var f = new List<Hashtable>();
            foreach (GridViewRow Rw in gvFileList.Rows)
            {
                if ((Rw.FindControl("chkItem") as CheckBox).Checked) f.Add(_xFile(Rw));
            }
            return f;
        }
        private Hashtable _xFile(GridViewRow Rw)
        {
            Hashtable h = new Hashtable();

            int LN = Convert.ToInt32((Rw.FindControl("hfLen") as HiddenField).Value); byte[] FileData = new byte[LN];
            LinkButton lnk = Rw.FindControl("LnkName") as LinkButton; h.Add("Nm", lnk.Text);

            string FN = string.Format("{0}File_{1}{2}", Common.clsUser.Util.AppSetting("FilePath"), lnk.CommandArgument, (Rw.FindControl("hfExt") as HiddenField).Value);
            
            try
            {
                System.IO.FileStream iFS = new System.IO.FileStream(FN, System.IO.FileMode.Open);
                iFS.Read(FileData, 0, LN); iFS.Close();
            }
            catch { }

            var v = new System.IO.MemoryStream(FileData);
            v.Position = 0; h.Add("Att", v); return h;
        }
    }
}