<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="TaskName.aspx.cs" Inherits="webApp.AdminPanel.TaskName" %>
<%@ Register Src="~/_Controls/Progress.ascx" TagName="Progress" TagPrefix="ucProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <h3>Task Name Management</h3>
 <ucProgress:Progress ID="abc" runat="server" />
 <aspx:UpdatePanel ID="UpdatePanel1" runat="server">
  <ContentTemplate>
   Show Active? <asp:DropDownList ID="ddlAL" runat="server" AutoPostBack="true" DataSourceID="odsActiveList" DataValueField="mValue" DataTextField="mText" /> 
   App Code: <asp:DropDownList ID="ddlAppCde" runat="server" AutoPostBack="true" DataSourceID="odsAppCode" DataValueField="mValue" DataTextField="mText" /><br /><br />
   Category: <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true" DataSourceID="odsCategory" DataValueField="Category" DataTextField="Category" /><br /><br />
   <asp:GridView ID="gvTaskName" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="HID" DataSourceID="odsTaskName" ForeColor="#333333" GridLines="None" ShowFooter="true" OnRowDataBound="gv_Bound">
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <RowStyle BackColor="#EFF3FB" />
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
       <asp:LinkButton ID="lnkDelete" runat="server" Text="Remove" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to remove?');" />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="vEdit" />
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
      </EditItemTemplate>
      <FooterTemplate><asp:Button ID="btnAdd" Text="Add New" runat="server" OnClick="btnAdd_Click" ValidationGroup="vAdd" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Task ID" SortExpression="TaskID" InsertVisible="false">
      <ItemTemplate><%# Eval("TaskID") %></ItemTemplate>
      <EditItemTemplate><asp:Label ID="lblTaskID" runat="server" Text='<%# Bind("TaskID") %>' />
      </EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtTaskID" runat="server" Width="50px" Text='<%# Bind("TaskID") %>' />
       <asp:RequiredFieldValidator ID="rfvTaskID" runat="server" ErrorMessage="Task ID is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtTaskID" ValidationGroup="vAdd" />
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Action" SortExpression="ActionName" InsertVisible="false">
      <ItemTemplate><%# Eval("ActionName") %></ItemTemplate>
      <EditItemTemplate><asp:DropDownList ID="ddlActionName" runat="server" DataSourceID="odsActionName" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("ActionName") %>'></asp:DropDownList></EditItemTemplate>
      <FooterTemplate><asp:DropDownList ID="ddlActionName" runat="server" DataSourceID="odsActionName" DataTextField="mText" DataValueField="mValue"></asp:DropDownList></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Name" SortExpression="Name" InsertVisible="false">
      <ItemTemplate><%# Eval("Name") %></ItemTemplate>
      <EditItemTemplate><asp:Literal ID="litName" runat="server" Text='<%# Bind("Name") %>' /></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' />
       <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Task Name is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtName" ValidationGroup="vAdd" />
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="isEdit">
      <ItemTemplate><asp:CheckBox ID="chkEdit" runat="server" Checked='<%# Eval("isEdit") %>' Enabled="false" /></ItemTemplate>
      <EditItemTemplate><asp:CheckBox ID="chkEdit" runat="server" Checked='<%# Bind("isEdit") %>' /></EditItemTemplate>
      <FooterTemplate><asp:CheckBox ID="chkEdit" runat="server" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="isView">
      <ItemTemplate><asp:CheckBox ID="chkView" runat="server" Checked='<%# Eval("isView") %>' Enabled="false" /></ItemTemplate>
      <EditItemTemplate><asp:CheckBox ID="chkView" runat="server" Checked='<%# Bind("isView") %>' /></EditItemTemplate>
      <FooterTemplate><asp:CheckBox ID="chkView" runat="server" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="isPrint">
      <ItemTemplate><asp:CheckBox ID="chkPrint" runat="server" Checked='<%# Eval("isPrint") %>' Enabled="false" /></ItemTemplate>
      <EditItemTemplate><asp:CheckBox ID="chkPrint" runat="server" Checked='<%# Bind("isPrint") %>' /></EditItemTemplate>
      <FooterTemplate><asp:CheckBox ID="chkPrint" runat="server" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Required" SortExpression="reqTask1" InsertVisible="false">
      <ItemTemplate><%# Eval("reqTask1") %></ItemTemplate>
      <EditItemTemplate><asp:DropDownList ID="ddlreqTask" runat="server" DataSourceID="odsreqTask" DataTextField="TaskID" DataValueField="HID" SelectedValue='<%# Bind("reqTask") %>'></asp:DropDownList></EditItemTemplate>
      <FooterTemplate><asp:DropDownList ID="ddlreqTask" runat="server" DataSourceID="odsreqTask" DataTextField="TaskID" DataValueField="HID"></asp:DropDownList></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Category" SortExpression="Category" InsertVisible="false">
      <ItemTemplate><%# Eval("Category") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtCategory" runat="server" Text='<%# Bind("Category") %>' /></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtCategory" runat="server" Text='<%# Bind("Category") %>' /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Hrs" SortExpression="Hrs" InsertVisible="false">
      <ItemTemplate><%# Eval("Hrs") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtHrs" runat="server" Text='<%# Bind("Hrs") %>' Width="50px" /></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtHrs" runat="server" Text='<%# Bind("Hrs") %>' Width="50px" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Active" InsertVisible="false">
      <ItemTemplate>
       <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' Enabled="false" /></ItemTemplate>
      <EditItemTemplate>
       <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' /></EditItemTemplate>
      <FooterTemplate>
       <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="App" SortExpression="AppCode" InsertVisible="false">
      <ItemTemplate><%# Eval("AppCode") %></ItemTemplate>
      <EditItemTemplate><asp:DropDownList ID="ddlAppCode" runat="server" DataSourceID="odsAppCode" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("AppCode") %>'></asp:DropDownList></EditItemTemplate>
      <FooterTemplate><asp:DropDownList ID="ddlAppCode" runat="server" DataSourceID="odsAppCode" DataTextField="mText" DataValueField="mValue"></asp:DropDownList></FooterTemplate>
     </asp:TemplateField>     
    </Columns>
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#9999CC" />
    <AlternatingRowStyle BackColor="White" />
    <EmptyDataTemplate>No Task Name Found!</EmptyDataTemplate>
   </asp:GridView>
   <MW:Message ID="iMsg" runat="server" />
   <br />
    <asp:ValidationSummary ID="vsEdit" runat="server" ValidationGroup="vEdit" />
    <asp:ValidationSummary ID="vsAdd" runat="server" ValidationGroup="vAdd" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsCategory" runat="server" TypeName="myBiz.DAL.clsTaskName" SelectMethod="TaskName_Category" />
 <asp:ObjectDataSource ID="odsActiveList" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="ActiveList" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="0" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsreqTask" runat="server" TypeName="myBiz.DAL.clsTaskName" SelectMethod="reqTask"></asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsTaskName" runat="server" TypeName="myBiz.DAL.clsTaskName" SelectMethod="Select" UpdateMethod="Update" InsertMethod="Insert" DeleteMethod="Delete" OnInserted="odsInserted">
  <SelectParameters>
   <asp:ControlParameter ControlID="ddlAL" PropertyName="SelectedValue" Name="isActive" Type="Int32" />
   <asp:ControlParameter ControlID="ddlAppCde" PropertyName="SelectedValue" Name="AppCode" Type="String" />
   <asp:ControlParameter ControlID="ddlCategory" PropertyName="SelectedValue" Name="Category" Type="String" />
  </SelectParameters>
  <DeleteParameters>
   <asp:Parameter Name="HID" Type="Int32" />
  </DeleteParameters>
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="TaskID" Type="String" />
   <asp:Parameter Name="ActionName" Type="String" />
   <asp:Parameter Name="isEdit" Type="Boolean" />
   <asp:Parameter Name="isView" Type="Boolean" />
   <asp:Parameter Name="isPrint" Type="Boolean" />
   <asp:Parameter Name="reqTask" Type="Int32" />
   <asp:Parameter Name="Name" Type="String" />
   <asp:Parameter Name="Category" Type="String" />
   <asp:Parameter Name="Hrs" Type="Decimal" />
   <asp:Parameter Name="isActive" Type="Boolean" />
   <asp:Parameter Name="AppCode" Type="String" />
  </UpdateParameters>
  <InsertParameters>
   <asp:Parameter Name="TaskID" Type="String" />
   <asp:Parameter Name="ActionName" Type="String" />
   <asp:Parameter Name="isEdit" Type="Boolean" />
   <asp:Parameter Name="isView" Type="Boolean" />
   <asp:Parameter Name="isPrint" Type="Boolean" />
   <asp:Parameter Name="reqTask" Type="Int32" />
   <asp:Parameter Name="Name" Type="String" />
   <asp:Parameter Name="Category" Type="String" />
   <asp:Parameter Name="Hrs" Type="Decimal" />
   <asp:Parameter Name="isActive" Type="Boolean" />
   <asp:Parameter Name="AppCode" Type="String" />
  </InsertParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsActionName" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="TaskAction" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="0" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsAppCode" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="AppCode" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="0" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>
