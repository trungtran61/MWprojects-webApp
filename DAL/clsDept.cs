using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using myBiz.Tools;

namespace webApp.DAL
{
    public class clsDept
    {
        private DBAccess myDB = DBAccess.myDB;
        private const string AdminCS = "AdminCS";

        public DataTable DeptMgmnt_S()
        {
            myDB.prepData("spDeptMgmnt_S"); return myDB.getTb(AdminCS);
        }
        public void DeptMgmnt_U(int DeptID, bool isWIP, bool isRFQ)
        {
            myDB.prepData("spDeptMgmnt_U"); myDB.addValue("DeptID", DeptID);
            myDB.addValue("isWIP", isWIP); myDB.addValue("isRFQ", isRFQ);
            myDB.exeCMD(AdminCS);
        }
    }
}