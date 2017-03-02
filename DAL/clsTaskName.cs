using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using myBiz.Tools;

namespace webApp.DAL
{
    public class clsTaskName
    {
        private  DBAccess myDB = DBAccess.myDB;
        private const string AdminCS = "AdminCS";

        public DataTable TaskName_Category()
        {
            myDB.prepData("spTaskName_Category_S");
            return myDB.getTb(AdminCS);
        }
        public DataTable Select(int isActive, string Category)
        {
            myDB.prepData("spTaskName_S");
            if (isActive != 2) myDB.addValue("isActive", isActive);
            if (!string.IsNullOrEmpty(Category)) myDB.addValue("Category", Category);
            return myDB.getTb(AdminCS);
        }
        public void Update(int HID, string TaskID, string ActionName, bool isEdit, bool isView, bool isPrint, int reqTask, string Name, string Category, decimal Hrs, bool isActive)
        {
            myDB.prepData("spTaskName_U"); myDB.addValue("HID", HID); myDB.addValue("TID", TaskID); myDB.addValue("An", ActionName);
            myDB.addValue("isE", isEdit); myDB.addValue("isV", isView); myDB.addValue("isP", isPrint); if (reqTask > 0) myDB.addValue("req", reqTask);
            myDB.addValue("Nm", Name); myDB.addValue("Cate", Category); if (Hrs > 0) myDB.addValue("Hrs", Hrs);
            myDB.addValue("isActive", isActive); myDB.exeCMD(AdminCS);
        }
        public void Insert(string TaskID, string ActionName, bool isEdit, bool isView, bool isPrint, int reqTask, string Name, string Category, decimal Hrs, bool isActive)
        {
            myDB.prepData("spTaskName_I"); myDB.addValue("isActive", isActive); myDB.addValue("ActionName", ActionName);
            myDB.addValue("isEdit", isEdit); myDB.addValue("isView", isView); myDB.addValue("isPrint", isPrint); if (reqTask > 0) myDB.addValue("req", reqTask);
            myDB.addValue("TaskID", TaskID); myDB.addValue("Name", Name); if (Hrs > 0) myDB.addValue("Hrs", Hrs);
            myDB.addValue("Category", Category); myDB.exeCMD(AdminCS);
        }
        public void Delete(int HID)
        {
            myDB.prepData("spTaskName_D");
            myDB.addValue("HID", HID); myDB.exeCMD(AdminCS);
        }
        public DataTable reqTask()
        {
            myDB.prepData("spTaskName_IDs");
            return myDB.getTb(AdminCS);
        }
    }
}