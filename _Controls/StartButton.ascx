<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StartButton.ascx.cs" Inherits="webApp._Controls.StartButton" %>

<asp:Menu ID="mnStart" runat="server" 
     Orientation="Horizontal" 
        StaticDisplayLevels="1"
        DynamicPopOutImageUrl="../Images/document-24.png" 
        StaticEnableDefaultPopOutImage="False"
        MaximumDynamicDisplayLevels="10" 
        EnableViewState="false"
        CssClass="nav navbar-fix-top" 
        StaticMenuStyle-CssClass="nav navbar-nav" 
        StaticSelectedStyle-CssClass="active"
        DynamicMenuStyle-CssClass="dropdown-menu" 
        IncludeStyleBlock="false" 
        SkipLinkText=""
        RenderingMode="List"
    >    
 <Items>
  <asp:MenuItem Text="START" ToolTip="Click here to start" Value="k01" Selectable="False">
   <asp:MenuItem Selectable="False" Text="Admin Panel" Value="k02">
    <asp:MenuItem NavigateUrl="~/AdminPanel/LocationMgmnt.aspx" Text="Location Management" Value="k03"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/CommMgmnt.aspx" Text="Communication Management" Value="k04"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/CommSetup.aspx" Text="Communication Setup" Value="k05"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/UserGroup.aspx" Text="Group User Management" Value="k06"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/PageSecSetup.aspx" Text="Page Securities Setup" Value="k07"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/TaskSecSetup.aspx?AppCode=WIP" Text="Task Securities Setup (WIP)" Value="k08"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/TaskSecSetup.aspx?AppCode=RFQ" Text="Task Securities Setup (RFQ)" Value="k09"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/StepName.aspx?AppCode=WIP" Text="Step Name Management (WIP)" Value="k10"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/StepName.aspx?AppCode=RFQ" Text="Step Name Management (RFQ)" Value="k11"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/TaskName.aspx" Text="Task Name Management" Value="k12"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/DeptMgmnt.aspx" Text="Department Management" Value="k13"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/DefVals.aspx?AppCode=RFQ" Text="Default Values Management (RFQ)" Value="k14"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/CustFUMgmnt.aspx" Text="Customer Follow Up Management" Value="k59"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/PoCustFUMgmnt.aspx" Text="P-Customer Follow Up Management" Value="k64"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/PoCustMgmnt.aspx" Text="P-Customer Management" Value="k67"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/FollowUpMgmnt.aspx" Text="RFQ Follow Up Management" Value="k15"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/TaskMgmnt.aspx?AppCode=WIP" Text="Task Management (WIP)" Value="k16"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/TaskMgmnt.aspx?AppCode=RFQ" Text="Task Management (RFQ)" Value="k17"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/CustTerm.aspx" Text="Customer Term Setup" Value="k18"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/GENSetup.aspx?AppCode=WIP" Text="Work Order Settings" Value="k19"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/GENSetup.aspx?AppCode=RFQ" Text="RFQ Settings" Value="k20"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/MachineProcess.aspx" Text="Machine & Process" Value="k21"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/OpHrs.aspx" Text="Operation Hours" Value="k22"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/VendorMgmnt.aspx" Text="Vendor Management" Value="k48"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/BudgetForcast.aspx" Text="Budget Forcast Setup" Value="k57"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/ReportalSetup.aspx" Text="Reportal Setup" Value="k75"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/CustPackSpec.aspx" Text="Customer - Packaging" Value="k86"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/CheckListMgmnt.aspx" Text="Check List Management" Value="k89"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/MacPmSetup.aspx" Text="Machine PM Setup" Value="k93"></asp:MenuItem>
<%--    <asp:MenuItem NavigateUrl="~/AdminPanel/UserMgmnt.aspx" Text="Manage User List" Value="k78"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/AdminPanel/EmployeeMgmnt.aspx" Text="Manage Employee" Value="k79"></asp:MenuItem>--%>
  </asp:MenuItem>
   <asp:MenuItem Selectable="False" Text="WIP" Value="k23">
    <asp:MenuItem NavigateUrl="~/WIP/DataEntry.aspx" Text="Work Order Entry" Value="k24"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/WIP/Status.aspx" Text="Status" Value="k25"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/WIP/CustomerReturnLog.aspx" Text="Customer Return Log" Value="k88"></asp:MenuItem>
   </asp:MenuItem>
   <asp:MenuItem Selectable="False" Text="RFQ" Value="k26">
    <asp:MenuItem NavigateUrl="~/RFQ/NewRFQEntry.aspx" Text="New RFQ Entry" Value="k27"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/RFQ/RFQEntryQueue.aspx" Text="New Customer RFQs" Value="k62"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/RFQ/FollowUp.aspx" Text="Quote Follow Up" Value="k28"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/RFQ/CustFU.aspx" Text="Customer Follow Up" Value="k61"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/RFQ/PoCustFU.aspx" Text="P-Customer Follow Up" Value="k63"></asp:MenuItem>
   </asp:MenuItem>
   <asp:MenuItem Selectable="False" Text="Tools" Value="k29">
    <asp:MenuItem NavigateUrl="~/Tools/MachineInfo.aspx" Text="Machine Info" Value="k30"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/OldWO.aspx" Text="Create Old Work Order" Value="k31"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/FixQty.aspx" Text="Fix Inventory Qty" Value="k32"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/CheckPartInventory.aspx" Text="Check Part Inventory" Value="k33"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/RFQPO.aspx" Text="Create RFQ/PO" Value="k34"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/Docs.aspx" Text="Documents" Value="k35"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/DmsLib.aspx" Text="Dimension Library" Value="k53"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/MatlTypeMgmnt.aspx" Text="Material Type Management" Value="k49"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/OPSTypeMgmnt.aspx" Text="OPS Type Management" Value="k54"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/GageTypeMgmnt.aspx" Text="Gage Type Management" Value="k52"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/ToolTypeMgmnt.aspx" Text="Tool Type Management" Value="k51"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Purchasing/ReceivePayments.aspx" Text="Receive Payments" Value="k36"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/ReceiveCustomerPO.aspx" Text="Receive CustomerPOs" Value="k65"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/ReviewCustomerPO.aspx" Text="Review New POs" Value="k68"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/QueueCustomerPO.aspx" Text="New CustomerPOs" Value="k66"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/PNChange.aspx" Text="PN-REV Change Approval" Value="k69"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/ProcessCategory.aspx" Text="Process-Category Mapping" Value="k70"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/ToolOrderList.aspx" Text="Tool Order List" Value="k71"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/ToolGroupList.aspx" Text="Find-Vendor for Tool" Value="k73"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/IncPartList.aspx" Text="Incompleted Part List" Value="k72"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/GageTrak.aspx" Text="GageTrak Management" Value="k77"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/PrepSetupList.aspx" Text="Setup Prep List" Value="k80"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/MOTLog.aspx" Text="Upload M.O.T Log" Value="k81"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/RanChkPrtInv.aspx" Text="Random Check Part Inventory" Value="k82"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/RecQteFrmVdr.aspx" Text="Receive Quotes from Vendors" Value="k83"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/MQTasks.aspx" Text="Material & OPS Task List" Value="k84"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/LMTasks.aspx" Text="Lathe & Mill Task List" Value="k90"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/PackageSpec.aspx" Text="Packaging Specification" Value="k85"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/ProTpeVdr.aspx" Text="Find Vendors for Process Type" Value="k87"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/MacPmSched.aspx" Text="Machine PM Schedule" Value="k94"></asp:MenuItem>
   </asp:MenuItem>
   <asp:MenuItem Selectable="False" Text="Reports" Value="k37">
    <asp:MenuItem NavigateUrl="~/Reports/OpenAR.aspx" Text="AR Open Report for Customer" Value="k38"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Reports/OpenPO.aspx" Text="Open PO Report for Customer" Value="k39"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Reports/PN4Cust.aspx" Text="P/N Make for Customer" Value="k40"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Reports/InvAvail.aspx" Text="Inventory Available" Value="k41"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Reports/InvVal.aspx" Text="Inventory Valuation" Value="k42"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Reports/PhyInvWks.aspx" Text="Physical Inventory Worksheet" Value="k43"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Reports/DeptOTD.aspx" Text="Department OTD" Value="k44"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Reports/OTDTrend.aspx" Text="Dept. OTD Trend" Value="k45"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Reports/CtrlVdrList.aspx" Text="Controled Vendor List" Value="k55"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Reports/ExpAcct.aspx" Text="Expense Account" Value="k56"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Reports/ExpLimRatio.aspx" Text="Expense Limit Ratio" Value="k58"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Purchasing/IncExp.aspx" Text="Income/Expense Report" Value="k74"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Reports/LateDept.aspx" Text="Late Department" Value="k76"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/ToolTrackDetails.aspx" Text="Tool Activity Detail Report" Value="k91"></asp:MenuItem>
    <asp:MenuItem NavigateUrl="~/Tools/ToolTrackPeriods.aspx" Text="Tool Activity Period Report" Value="k92"></asp:MenuItem>
   </asp:MenuItem>
   <asp:MenuItem NavigateUrl="~/ChangePWD.aspx" Text="Change Password" Value="k46"></asp:MenuItem>
   <asp:MenuItem NavigateUrl="~/Login.aspx?cmd=logout" Text="Logout" Value="k47"></asp:MenuItem>
  </asp:MenuItem>
 </Items>
 <StaticMenuItemStyle HorizontalPadding="1px" VerticalPadding="1px" Font-Size="Small" />
 <DynamicHoverStyle BackColor="#FEFAED" ForeColor="Red" Font-Size="Small" />
 <DynamicMenuStyle BackColor="#FEFAED" Font-Size="Small" />
 <StaticSelectedStyle BackColor="#FEFAED" Font-Size="Small" />
 <DynamicSelectedStyle BackColor="#FEFAED" Font-Size="Small" />
 <DynamicMenuItemStyle HorizontalPadding="1px" VerticalPadding="1px" Font-Size="Small" />
 <StaticHoverStyle BackColor="#FEFAED" ForeColor="Black" Font-Size="Small" />
</asp:Menu>

<%-- Next key to use: k95 --%>