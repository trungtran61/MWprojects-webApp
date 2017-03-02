<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucCheckListItems.ascx.cs" Inherits="webApp._Controls.ucCheckListItems" %>

<aspx:UpdatePanel ID="uPnlCheckListItems" runat="server" UpdateMode="Conditional">
 <ContentTemplate>
  <asp:GridView ID="gvCheckListItems" runat="server" DataKeyNames="HID" DataSourceID="odsCheckListItems" SkinID="Default" Font-Size="Medium">
   <Columns>
    <asp:BoundField HeaderText="Priority" DataField="Priority" InsertVisible="false" />
    <asp:BoundField HeaderText="Time" DataField="ItemTime" InsertVisible="false" />
    <asp:BoundField HeaderText="Name" DataField="ItemName" InsertVisible="false" />
    <asp:BoundField HeaderText="Description" DataField="Description" InsertVisible="false" />
    <asp:TemplateField HeaderText="Done?" InsertVisible="false">
     <ItemTemplate>
      <asp:CheckBox ID="chkDone" runat="server" Checked='<%# Eval("Done") %>' OnCheckedChanged="chkChanged" AutoPostBack="true" /></ItemTemplate>
    </asp:TemplateField>
   </Columns>
  </asp:GridView>
  <asp:HiddenField ID="hfUserName" runat="server" />
  <asp:HiddenField ID="hfCheckListID" runat="server" />
 </ContentTemplate>
</aspx:UpdatePanel>

<asp:ObjectDataSource ID="odsCheckListItems" runat="server" TypeName="myBiz.DAL.clsCheckList" SelectMethod="GetCheckListItemsByUser" UpdateMethod="SaveCheckListUserItem">
 <SelectParameters>
  <asp:ControlParameter Name="UserName" Type="String" ControlID="hfUserName" PropertyName="Value" />
  <asp:ControlParameter Name="CheckListID" Type="Int32" ControlID="hfCheckListID" PropertyName="Value" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:ControlParameter Name="UserName" Type="String" ControlID="hfUserName" PropertyName="Value" />
  <asp:ControlParameter Name="CheckListID" Type="Int32" ControlID="hfCheckListID" PropertyName="Value" />
  <asp:Parameter Name="Done" Type="Boolean" />
 </UpdateParameters>
</asp:ObjectDataSource>
