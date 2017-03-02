<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucCommAddress" Codebehind="ucCommAddress.ascx.cs" %>

<asp:LinkButton ID="lnkMoreAddress" runat="server" Text="View All" OnClick="lMore"></asp:LinkButton> |
<asp:LinkButton ID="lnkNewAddress" runat="server" Text="New Address" OnClick="lNew"></asp:LinkButton>
<br />
<asp:GridView ID="gvAddress" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsAddress" OnRowCommand="gvCmd" OnRowDataBound="gvBound" OnSelectedIndexChanged="gvSelected" PageSize="10">
 <Columns>
  <asp:TemplateField ItemStyle-Wrap="false">
   <ItemTemplate>
    <asp:Button ID="btnEdit" runat="server" CommandName="pEdit" Text="Edit" CssClass="NavBtn" />
   </ItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField ItemStyle-Wrap="false" HeaderText="Address1" SortExpression="Address1">
   <ItemTemplate>
    <asp:CheckBox ID="chkSelected" runat="server" Checked='<%# Eval("isSelected") %>' Enabled="false" />
    <asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("Address1") %>'></asp:LinkButton>
   </ItemTemplate>
  </asp:TemplateField>
  <asp:BoundField HeaderText="Address 2" DataField="Address2" SortExpression="Address2" ItemStyle-Wrap="false" />
  <asp:BoundField HeaderText="City" DataField="City" SortExpression="City" ItemStyle-Wrap="false" />
  <asp:BoundField HeaderText="State" DataField="State" SortExpression="State" ItemStyle-Wrap="false" />
  <asp:BoundField HeaderText="Zip" DataField="Zip" SortExpression="Zip" ItemStyle-Wrap="false" />
  <asp:BoundField HeaderText="Country" DataField="Country" SortExpression="Country" ItemStyle-Wrap="false" />
  <asp:BoundField HeaderText="Website" DataField="Website" SortExpression="Website" ItemStyle-Wrap="false" />
 </Columns>
</asp:GridView>

<table id="tblAddress" runat="server" class="mdlPopup">
 <tr>
  <td align="right"><b>Address1:</b></td><td><asp:TextBox ID="txtAddress1" runat="server"></asp:TextBox></td>
  <td align="right"><b>Address2:</b></td><td><asp:TextBox ID="txtAddress2" runat="server"></asp:TextBox></td>
 </tr>
 <tr>
  <td align="right"><b>City:</b></td><td><asp:TextBox ID="txtCity" runat="server"></asp:TextBox></td>
  <td align="right"><b>State:</b></td><td><asp:TextBox ID="txtState" runat="server"></asp:TextBox></td>
 </tr>
 <tr>
  <td align="right"><b>Zip:</b></td><td><asp:TextBox ID="txtZip" runat="server"></asp:TextBox></td>
  <td align="right"><b>Country:</b></td><td><asp:TextBox ID="txtCountry" runat="server"></asp:TextBox></td>
 </tr>
 <tr>
  <td align="right"><b>Website:</b></td><td colspan="3"><asp:TextBox ID="txtWebsite" runat="server" Width="385px"></asp:TextBox></td>
 </tr>
 <tr>
  <td colspan="4" align="right">
   <asp:Button ID="btnAdd" runat="server" Text="Save Address" OnClick="sAddress" CssClass="NavBtn" />
   <asp:Button ID="btnClose" runat="server" Text="Close Window" CssClass="NavBtn" />
   <asp:HiddenField ID="hfHID" runat="server" Value="0" />
  </td>
 </tr>
</table>
<ajax:ModalPopupExtender ID="mpeNewAddress" runat="server" TargetControlID="hfHID" PopupControlID="tblAddress" BackgroundCssClass="modalBackground"
 OkControlID="btnClose" DropShadow="false" RepositionMode="RepositionOnWindowResize" />

<asp:Panel ID="pnlPopup" runat="server"></asp:Panel>
<asp:ObjectDataSource ID="odsAddress" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="Address_Select" UpdateMethod="Address_Save">
 <SelectParameters>
  <asp:Parameter Name="CompanyID" Type="Int32" />
  <asp:Parameter Name="ClassID" Type="Int32" />
  <asp:Parameter Name="TypeID" Type="Int32" />
  <asp:Parameter Name="ContactID" Type="Int32" />
  <asp:Parameter Name="isMore" Type="Boolean" DefaultValue="false" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="CompanyID" Type="Int32" />
  <asp:Parameter Name="Address1" Type="String" />
  <asp:Parameter Name="Address2" Type="String" />
  <asp:Parameter Name="City" Type="String" />
  <asp:Parameter Name="State" Type="String" />
  <asp:Parameter Name="Zip" Type="String" />
  <asp:Parameter Name="Country" Type="String" />
  <asp:Parameter Name="Website" Type="String" />
 </UpdateParameters>
</asp:ObjectDataSource>