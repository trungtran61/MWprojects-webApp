<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucCommClass" Codebehind="ucCommClass.ascx.cs" %>

<br />
<asp:GridView ID="gvClass" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsClass" ShowFooter="true" OnRowCommand="gvClassCmd" OnSelectedIndexChanged="gvSelected" OnRowDataBound="rwBound">
 <Columns>
  <asp:TemplateField>
   <ItemTemplate>
    <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="NavBtn" />
   </ItemTemplate>
   <EditItemTemplate>
    <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="Update" Text="Update" ValidationGroup="uDate"></asp:LinkButton>
    <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
   </EditItemTemplate>
   <FooterTemplate><asp:Button ID="btnAddNew" runat="server" CommandName="AddNew" Text="Add" CssClass="NavBtn" ValidationGroup="aNew" /></FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Class Name" SortExpression="ClassName">
   <ItemTemplate>
    <asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("ClassName") %>'></asp:LinkButton>
   </ItemTemplate>
   <EditItemTemplate>
    <asp:TextBox ID="txtClassName" runat="server" Text='<%# Bind("ClassName") %>' Width="100px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvClassName" runat="server" ControlToValidate="txtClassName" ErrorMessage="*" ValidationGroup="uDate"></asp:RequiredFieldValidator>
   </EditItemTemplate>
   <FooterTemplate>
    <asp:TextBox ID="txtClassName" runat="server" Width="100px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvClassName" runat="server" ControlToValidate="txtClassName" ErrorMessage="*" ValidationGroup="aNew"></asp:RequiredFieldValidator>
   </FooterTemplate>
  </asp:TemplateField>
 </Columns>
</asp:GridView>
<asp:Literal ID="litMsg" runat="server"></asp:Literal>
<asp:ObjectDataSource ID="odsClass" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="Class_Select" UpdateMethod="Class_Save">
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="ClassName" Type="String" />
 </UpdateParameters>
</asp:ObjectDataSource>