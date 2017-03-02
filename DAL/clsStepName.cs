using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using myBiz.Tools;

namespace webApp.DAL
{
    public class clsStepName
    {
        private DBAccess myDB = DBAccess.myDB;
        private const string AdminCS = "AdminCS";

        public DataTable Select(int isActive)
        {
            myDB.prepData("spStepName_S");
            if (isActive != 2) myDB.addValue("isActive", isActive);
            return myDB.getTb(AdminCS);
        }
        public void Update(string Name, string Description, string TopNote, string BottomNote, int HID, bool isActive)
        {
            myDB.prepData("spStepName_U");
            myDB.addValue("Name", Name); myDB.addValue("Description", Description); myDB.addValue("isActive", isActive);
            myDB.addValue("TopNote", TopNote); myDB.addValue("BottomNote", BottomNote);
            myDB.addValue("HID", HID); myDB.exeCMD(AdminCS);
        }
        public void Insert(string Name, string Description, string TopNote, string BottomNote, bool isActive)
        {
            myDB.prepData("spStepName_I");
            myDB.addValue("Name", Name); myDB.addValue("Description", Description); myDB.addValue("isActive", isActive);
            myDB.addValue("TopNote", TopNote); myDB.addValue("BottomNote", BottomNote); myDB.exeCMD(AdminCS);
        }
        public void Delete(int HID)
        {
            myDB.prepData("spStepName_D");
            myDB.addValue("HID", HID); myDB.exeCMD(AdminCS);
        }
        public DataSet spStepName_ProcessList_S(string StepID)
        {
            myDB.prepData("spStepName_ProcessList_S");
            myDB.addValue("StepID", StepID);
            return myDB.getDs(AdminCS);
        }
        public void spStepName_ProcessList_I(string StepID, string valueID)
        {
            myDB.prepData("spStepName_ProcessList_I");

            string[] v = valueID.Split(':');
            myDB.addValue("StepID", StepID);
            myDB.addValue("MID", v[0]);
            myDB.addValue("PID", v[1]);
            myDB.exeCMD(AdminCS);
        }
        public void spStepName_ProcessList_D(string StepID)
        {
            myDB.prepData("spStepName_ProcessList_D");
            myDB.addValue("HID", StepID);
            myDB.exeCMD(AdminCS);
        }
        public DataSet spStepTask_S(string StepID)
        {
            myDB.prepData("spStepTask_S"); myDB.addValue("StepID", StepID); return myDB.getDs(AdminCS);
        }
        public void spStepTask_I(string StepID, string TaskID)
        {
            myDB.prepData("spStepTask_I"); myDB.addValue("StepID", StepID);
            myDB.addValue("TaskID", TaskID); myDB.exeCMD(AdminCS);
        }
        public void spStepTask_D(string StepID)
        {
            myDB.prepData("spStepTask_D"); myDB.addValue("HID", StepID); myDB.exeCMD(AdminCS);
        }
        public DataTable getStepNameList()
        {
            myDB.prepData("SELECT 0 HID, 'Work Order' Name UNION ALL SELECT HID,Name FROM dbo.StepName ORDER BY Name", CommandType.Text);
            return myDB.getTb(AdminCS);
        }
    }
}