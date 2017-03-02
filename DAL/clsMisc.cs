using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using myBiz.Tools;

namespace webApp.DAL
{
    public class clsMisc
    {
        private DBAccess myDB = DBAccess.myDB;
        private const string AdminCS = "AdminCS";

        public DataTable getDDL(string Cate, int iBlank)
        {
            myDB.prepData(string.Format("SELECT * FROM dbo.fnDropDownList('{0}',{1})", Cate, iBlank), CommandType.Text);
            return myDB.getTb(AdminCS);
        }
    }
}