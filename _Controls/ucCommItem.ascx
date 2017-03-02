<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucCommItem" Codebehind="ucCommItem.ascx.cs" %>

<asp:LinkButton ID="lnkMoreItem" runat="server" Text="View All" OnClick="lMore"></asp:LinkButton><br />
<asp:GridView ID="gvItem" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsItem" ShowFooter="true" OnRowCommand="gvItemCmd" OnRowDataBound="rwBound">
 <Columns>
  <asp:TemplateField>
   <ItemTemplate>
    <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="NavBtn" />
   </ItemTemplate>
   <EditItemTemplate>
    <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="Update" Text="Update"></asp:LinkButton>
    <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
   </EditItemTemplate>
   <FooterTemplate><asp:Button ID="btnAddNew" runat="server" CommandName="AddNew" Text="Add" CssClass="NavBtn" /></FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Item" SortExpression="Item">
   <ItemTemplate>
    <asp:CheckBox ID="chkSelected" runat="server" Checked='<%# Eval("isSelected") %>' Enabled="false" />
    <asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("Item") %>'></asp:LinkButton>
   </ItemTemplate>
   <EditItemTemplate>
    <asp:TextBox ID="txtItem" runat="server" Text='<%# Bind("Item") %>' Width="100px"></asp:TextBox>
   </EditItemTemplate>
   <FooterTemplate>
    <asp:TextBox ID="txtItem" runat="server" Width="100px"></asp:TextBox>
   </FooterTemplate>
  </asp:TemplateField>
 </Columns>
</asp:GridView>

<asp:ObjectDataSource ID="odsItem" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="Item_Select" UpdateMethod="Item_Save">
 <SelectParameters>
  <asp:Parameter Name="CompanyID" Type="Int32" />
  <asp:Parameter Name="ClassID" Type="Int32" />
  <asp:Parameter Name="TypeID" Type="Int32" />
  <asp:Parameter Name="ContactID" Type="Int32" />
  <asp:Parameter Name="AddressID" Type="Int32" />
  <asp:Parameter Name="isMore" Type="Boolean" DefaultValue="false" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="Item" Type="String" />
 </UpdateParameters>
</asp:ObjectDataSource>