<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="GENSetup.aspx.cs" Inherits="webApp.AdminPanel.GENSetup" %>
<%@ Register Src="~/_Controls/Progress.ascx" TagName="Progress" TagPrefix="ucProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <h3><%= this.Title %></h3>
 Please select the tasks that are required for work orders.<br /><br />
 <ucProgress:Progress ID="abc" runat="server" />
 <aspx:UpdatePanel ID="uPnl1" runat="server">
  <ContentTemplate>
    <ajax:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
     <ajax:TabPanel ID="tabTask" runat="server" HeaderText="Required Tasks">
      <ContentTemplate>
       <asp:Table ID="tblTask" runat="server" BackColor="BurlyWood">
        <asp:TableRow>
         <asp:TableCell Font-Bold="true">Available Tasks ...</asp:TableCell>
         <asp:TableCell>&nbsp;</asp:TableCell>
         <asp:TableCell Font-Bold="true">Currently Required Tasks ...</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
         <asp:TableCell><asp:ListBox ID="lbxRemT" runat="server" Height="350px" Width="350px" DataTextField="mText" DataValueField="HID" SelectionMode="Multiple" /></asp:TableCell>
         <asp:TableCell HorizontalAlign="center">
          <asp:Button ID="btnAddTask" runat="server" Text=">>> Add >>>" OnClick="btnAddTask_Click" /><br />
          <asp:Button ID="btnDelTask" runat="server" Text="< Remove <<" OnClick="btnDelTask_Click" />
         </asp:TableCell>
         <asp:TableCell><asp:ListBox ID="lbxAddT" runat="server" Height="350px" Width="350px" DataTextField="mText" DataValueField="HID" SelectionMode="Multiple" /></asp:TableCell>
        </asp:TableRow>
       </asp:Table>
      </ContentTemplate>
     </ajax:TabPanel>
     <ajax:TabPanel ID="tabTimeUsage" runat="server" HeaderText="Dept. Time Usage">
      <ContentTemplate>
       <asp:GridView ID="gvDeptTime" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsDeptTime">
        <Columns>
         <asp:CommandField ShowEditButton="true" />
         <asp:BoundField HeaderText="Department" ReadOnly="True" DataField="Dept" InsertVisible="false" />
         <asp:BoundField HeaderText="Time" ControlStyle-Width="50px" DataField="Time" InsertVisible="false" />
         <asp:BoundField HeaderText="Unit" ReadOnly="True" DataField="Unit" InsertVisible="false" />
        </Columns>
       </asp:GridView>
      </ContentTemplate>
     </ajax:TabPanel>
     <ajax:TabPanel ID="tabNote" runat="server" HeaderText="Job/PO Notes and Margin">
      <ContentTemplate>
       Please edit job note and/or margin as necessary; then click <b>Save</b> button to save.<br />
       <asp:TextBox ID="txtJobNote" runat="server" TextMode="multiLine" Width="650px" Height="75px" /><br /><br />
       PO Note<br /><asp:TextBox ID="txtPONote" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       Customer Follow Up Note<br /><asp:TextBox ID="txtCustFUNote" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       P-Customer Follow Up Note<br /><asp:TextBox ID="txtPCustFUNote" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       RFQ Note<br /><asp:TextBox ID="txtRFQNote" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       C of C Note<br /><asp:TextBox ID="txtCoCNote" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       Vendor Link Instructions<br /><asp:TextBox ID="txtVdrLnk" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       Vendor Survey Link Instructions<br /><asp:TextBox ID="txtVdrSrvLnk" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       Invoice Email<br /><asp:TextBox ID="txtInvoiceEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       PO Email<br /><asp:TextBox ID="txtPOEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       RFQ Email<br /><asp:TextBox ID="txtRFQEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       Customer Follow Up Email<br /><asp:TextBox ID="txtCustFUEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       P-Customer Follow Up Email<br /><asp:TextBox ID="txtPoCustFUEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       Tool Group Email<br /><asp:TextBox ID="txtToolGroupEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       Survey Email<br /><asp:TextBox ID="txtSurveyEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       Quote Email<br /><asp:TextBox ID="txtQTEEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       Inventory Available Email<br /><asp:TextBox ID="txtInvAvailEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       P/N Make for Customer Email<br /><asp:TextBox ID="txtPN4CustEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       Open PO Report for Customer Email<br /><asp:TextBox ID="txtOpenPOEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       AR Open Report for Customer Email<br /><asp:TextBox ID="txtOpenAREmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       OTD Graph Email<br /><asp:TextBox ID="txtOTDGraphEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       OTD Graph Trend Email<br /><asp:TextBox ID="txtOTDGraphTrendEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       Expense Limit Ratio Email<br /><asp:TextBox ID="txtExpLimRtoEmail" runat="server" TextMode="MultiLine" Width="650px" Height="75px" /><br /><br />
       <span title="Links for vendor will be expired in number of days after it has been created">Vendor Link Expired:</span>
       <asp:TextBox ID="txtVdrLnkExp" runat="server" Width="50px"></asp:TextBox> days<br />
       <span title="Time window for a task that has due date before the current date">Margin:</span>
       <asp:TextBox ID="txtMargin" runat="server" Width="50px"></asp:TextBox> hours<br />
       <span title="Default time for the customer due date">Due Time:</span>
       <asp:TextBox ID="txtDueTime" runat="server" Width="100px"></asp:TextBox> hh:mm<br />
       <span title="Max qty that a location can hold">Location Capacity:</span>
       <asp:TextBox ID="txtLocCap" runat="server" Width="100px"></asp:TextBox> qty counts<br />
       <span title="Time clock to refresh the machine status & schedule">Machine Auto Refresh:</span>
       <asp:TextBox ID="txtAutoRefresh" runat="server" Width="100px"></asp:TextBox> seconds<br />
       <span title="Time clock to auto-suggest an operation to a machine">Wakeup Timer:</span>
       <asp:TextBox ID="txtWKPTimer" runat="server" Width="100px"></asp:TextBox> seconds<br />
       <span title="Remaining time (to ECD) to auto-suggest an operation to a machine">ERT Remaining:</span>
       <asp:TextBox ID="txtARTRemain" runat="server" Width="100px"></asp:TextBox> seconds<br />
       <span title="Time to log out if page is not used">Auto Logout:</span>
       <asp:TextBox ID="txtAutoLogout" runat="server" Width="100px"></asp:TextBox> minutes<br />
       <span title="Time left before log out">Auto Logout Alert:</span>
       <asp:TextBox ID="txtAutoLogoutAlert" runat="server" Width="100px"></asp:TextBox> minutes<br />
       <span title="Average Wage">Average Wage:</span>
       <asp:TextBox ID="txtAvgWage" runat="server" Width="100px"></asp:TextBox> dollars<br />
       <span title="Auto receive order">Auto Receive Order:</span>
       <asp:DropDownList ID="ddlAutoRecd" runat="server"><asp:ListItem Text="" Value="" /><asp:ListItem Text="Yes" Value="Yes" /><asp:ListItem Text="No" Value="No" /></asp:DropDownList><br />
       <span title="Days to have order review">Days of Order Review:</span>
       <asp:TextBox ID="txtOrderReview" runat="server" Width="100px"></asp:TextBox> days<br />
       <span title="Days to have order entry">Days of Order Entry:</span>
       <asp:TextBox ID="txtOrderEntry" runat="server" Width="100px"></asp:TextBox> days<br />
       <span title="Minimum Lead Time">Minimum Lead Time:</span>
       <asp:TextBox ID="txtMinLeadTime" runat="server" Width="100px"></asp:TextBox> days<br />
       <span title="Vendor Expired Grace Period">Days of Vendor Expired Grace Period:</span>
       <asp:TextBox ID="txtVdrExpGraPeriod" runat="server" Width="100px"></asp:TextBox> days<br />
       <span title="Block Expired Vendor Approved Dates">Enforced Approved Date:</span>
       <asp:DropDownList ID="ddlEnfExpCert" runat="server"><asp:ListItem Text="" Value="" /><asp:ListItem Text="Yes" Value="Yes" /><asp:ListItem Text="No" Value="No" /></asp:DropDownList><br />
       <span title="Enforcing Matched Part Numbers">Enforced Matched PNs:</span>
       <asp:DropDownList ID="ddlEnfMatPN" runat="server"><asp:ListItem Text="" Value="" /><asp:ListItem Text="Yes" Value="Yes" /><asp:ListItem Text="No" Value="No" /></asp:DropDownList><br />
       <span title="Minimum-Median-Maxinum Selector">Min-Max:</span>
       <asp:DropDownList ID="ddlMinMedMax" runat="server"><asp:ListItem Text="Minimum" Value="Minimum" /><asp:ListItem Text="Median" Value="Median" /><asp:ListItem Text="Maximum" Value="Maximum" /></asp:DropDownList><br />
       <span title="Enforcing RFQ Quantity Edit">Enforced RFQ Qty Edit:</span>
       <asp:DropDownList ID="ddlEnfQty" runat="server"><asp:ListItem Text="" Value="" /><asp:ListItem Text="Yes" Value="Yes" /><asp:ListItem Text="No" Value="No" /></asp:DropDownList><br />
       <span title="Tool Group Record Set Point for Find-Vendor for Tool list">TGR Set Point:</span>
       <asp:TextBox ID="txtTGR" runat="server" Width="100px"></asp:TextBox> points<br />
       <span title="Operating Hour Efficiency">OHE:</span>
       <asp:TextBox ID="txtOHE" runat="server" Width="100px"></asp:TextBox> percent<br />
       <span title="Enforcing Tool Order List Approval">Enforced Tool Order List Approval:</span>
       <asp:DropDownList ID="ddlEnfTola" runat="server"><asp:ListItem Text="" Value="" /><asp:ListItem Text="Yes" Value="Yes" /><asp:ListItem Text="No" Value="No" /></asp:DropDownList><br />
       <asp:Button ID="btnSaveNote" runat="server" Text="Save" OnClick="btnSaveNote_Click" />
      </ContentTemplate>
     </ajax:TabPanel>
     <ajax:TabPanel ID="tabDDL" runat="server" HeaderText="Dropdown Lists">
      <ContentTemplate>
      <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true">
       <asp:ListItem Text="Unit" Value="Unit"></asp:ListItem>
       <asp:ListItem Text="Expenses Account" Value="ExpAcct"></asp:ListItem>
       <asp:ListItem Text="Document Type" Value="DocType"></asp:ListItem>
       <asp:ListItem Text="Document Type" Value="DocType"></asp:ListItem>
       <asp:ListItem Text="Process Category" Value="ProCate"></asp:ListItem>
       <asp:ListItem Text="Cutting Method" Value="CuttingMethod"></asp:ListItem>
       <asp:ListItem Text="User Titles" Value="UserTitle"></asp:ListItem>
       <asp:ListItem Text="Approve Reason" Value="ApproveReason"></asp:ListItem>
      </asp:DropDownList><br /><br />

      <asp:GridView ID="gvDDL" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsDDL" ShowFooter="true" OnRowCommand="gvCmd">
       <Columns>
        <asp:TemplateField>
         <ItemTemplate>
          <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
         </ItemTemplate>
         <EditItemTemplate>
          <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
          <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
         </EditItemTemplate>
         <FooterTemplate><asp:Button ID="btnAdd" Text="Add New" runat="server" CommandName="AddNew" /></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="ID" SortExpression="mValue" InsertVisible="false">
         <ItemTemplate><%# Eval("mValue") %></ItemTemplate>
         <EditItemTemplate><asp:TextBox ID="txtmValue" runat="server" Text='<%# Bind("mValue") %>' /></EditItemTemplate>
         <FooterTemplate><asp:TextBox ID="txtmValue" runat="server" /></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Name" SortExpression="mText" InsertVisible="false">
         <ItemTemplate><%# Eval("mText") %></ItemTemplate>
         <EditItemTemplate><asp:TextBox ID="txtmText" runat="server" Text='<%# Bind("mText") %>' /></EditItemTemplate>
         <FooterTemplate><asp:TextBox ID="txtmText" runat="server" /></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="SortOrder" SortExpression="SortOrder" InsertVisible="false">
         <ItemTemplate><%# Eval("SortOrder") %></ItemTemplate>
         <EditItemTemplate><asp:TextBox ID="txtSortOrder" runat="server" Text='<%# Bind("SortOrder") %>' Width="50px" /></EditItemTemplate>
         <FooterTemplate><asp:TextBox ID="txtSortOrder" runat="server" Width="50px" /></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Active">
         <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("isActive") %>' Enabled="false" /></ItemTemplate>
         <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' /></EditItemTemplate>
         <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" /></FooterTemplate>
        </asp:TemplateField>
       </Columns>
      </asp:GridView>


 <asp:ObjectDataSource ID="odsDDL" runat="server" TypeName="myBiz.DAL.clsDDL" SelectMethod="Select" UpdateMethod="Save">
  <SelectParameters><asp:ControlParameter ControlID="ddlCategory" Name="Category" Type="String" PropertyName="SelectedValue" /></SelectParameters>
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:ControlParameter ControlID="ddlCategory" Name="Category" Type="String" PropertyName="SelectedValue" />
   <asp:Parameter Name="mText" Type="String" />
   <asp:Parameter Name="mValue" Type="String" />
   <asp:Parameter Name="isActive" Type="Boolean" />
   <asp:Parameter Name="SortOrder" Type="Int32" />
  </UpdateParameters>
 </asp:ObjectDataSource>
      </ContentTemplate>
     </ajax:TabPanel>
     <ajax:TabPanel ID="tabBeLate" runat="server" HeaderText="Be-Late Setup">
      <ContentTemplate>
       <asp:GridView ID="gvBeLate" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsBeLate">
        <Columns>
         <asp:CommandField ShowEditButton="true" />
         <asp:BoundField HeaderText="Dept/Step" ReadOnly="True" DataField="Name" InsertVisible="false" />
         <asp:BoundField HeaderText="Days" ControlStyle-Width="50px" DataField="NumVal" InsertVisible="false" />
        </Columns>
       </asp:GridView>
      </ContentTemplate>
     </ajax:TabPanel>
     <ajax:TabPanel ID="tabUploadLimit" runat="server" HeaderText="Upload Limit">
      <ContentTemplate>
       <asp:GridView ID="gvUploadLimit" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsUploadLimit">
        <Columns>
         <asp:CommandField ShowEditButton="true" />
         <asp:BoundField HeaderText="Description" ReadOnly="True" DataField="TaskDesc" InsertVisible="false" />
         <asp:BoundField HeaderText="Limit (KB)" ControlStyle-Width="50px" DataField="mxLN" InsertVisible="false" />
        </Columns>
       </asp:GridView>
      </ContentTemplate>
     </ajax:TabPanel>
    </ajax:TabContainer>
    <MW:Message ID="iMsg" runat="server" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsDeptTime" runat="server" TypeName="myBiz.DAL.clsDept" SelectMethod="DeptTime_Select" UpdateMethod="DeptTime_Update" OnUpdated="odsUpdated">
  <SelectParameters><asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" /></SelectParameters>
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
   <asp:Parameter Name="Time" Type="Decimal" />
  </UpdateParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsBeLate" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="DeptStepNum_S" UpdateMethod="DeptStepNum_U">
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="NumVal" Type="Int32" />
  </UpdateParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsUploadLimit" runat="server" TypeName="myBiz.DAL.clsTaskName" SelectMethod="TaskName_UploadLimit_S" UpdateMethod="TaskName_UploadLimit_U">
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="mxLN" Type="String" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>
