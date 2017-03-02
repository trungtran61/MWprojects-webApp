<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucCommContact" Codebehind="ucCommContact.ascx.cs" %>

<asp:LinkButton ID="lnkMoreContact" runat="server" Text="View All" OnClick="lMore"></asp:LinkButton> |
<asp:LinkButton ID="lnkNewContact" runat="server" Text="New Contact" OnClick="lNew"></asp:LinkButton>
<br />
<asp:GridView ID="gvContact" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsContact" OnRowCommand="gvCmd" OnRowDataBound="gvBound" OnSelectedIndexChanged="gvSelected">
 <Columns>
  <asp:TemplateField ItemStyle-Wrap="false">
   <ItemTemplate>
    <asp:Button ID="btnEdit" runat="server" CommandName="pEdit" Text="Edit" CssClass="NavBtn" />
   </ItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField ItemStyle-Wrap="false" HeaderText="First" SortExpression="FirstName">
   <ItemTemplate>
    <asp:CheckBox ID="chkSelected" runat="server" Checked='<%# Eval("isSelected") %>' Enabled="false" />
    <asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("FirstName") %>'></asp:LinkButton>
   </ItemTemplate>
  </asp:TemplateField>
  <asp:BoundField HeaderText="Last" DataField="LastName" SortExpression="LastName" ItemStyle-Wrap="false" />
  <asp:BoundField HeaderText="Middle" DataField="MiddleName" SortExpression="MiddleName" ItemStyle-Wrap="false" />
  <asp:BoundField HeaderText="Dept" DataField="Dept" SortExpression="Dept" ItemStyle-Wrap="false" />
  <asp:BoundField HeaderText="Phone" DataField="Phone" SortExpression="Phone" ItemStyle-Wrap="false" />
  <asp:BoundField HeaderText="Fax" DataField="Fax" SortExpression="Fax" ItemStyle-Wrap="false" />
  <asp:BoundField HeaderText="Cell" DataField="Cell" SortExpression="Cell" ItemStyle-Wrap="false" />
  <asp:BoundField HeaderText="TollFree" DataField="TollFree" SortExpression="TollFree" ItemStyle-Wrap="false" />
  <asp:BoundField HeaderText="Email" DataField="Email" SortExpression="Email" ItemStyle-Wrap="false" />
 </Columns>
</asp:GridView>

 <table id="tblContact" runat="server" class="mdlPopup">
  <tr>
   <td><b>First Name:</b><br /><asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox></td>
   <td><b>Last Name:</b><br /><asp:TextBox ID="txtLastName" runat="server"></asp:TextBox></td>
   <td><b>Middle Name:</b><br /><asp:TextBox ID="txtMiddleName" runat="server"></asp:TextBox></td>
  </tr>
  <tr>
   <td><b>Dept:</b><br /><asp:TextBox ID="txtDept" runat="server"></asp:TextBox></td>
   <td colspan="2"><b>Email:</b><br /><asp:TextBox ID="txtEmail" runat="server" Width="300px"></asp:TextBox></td>
  </tr>
  <tr>
   <td><b>Phone:</b><br /><asp:TextBox ID="txtPhone" runat="server"></asp:TextBox></td>
   <td colspan="2"><b>Fax:</b><br /><asp:TextBox ID="txtFax" runat="server"></asp:TextBox></td>
  </tr>
  <tr>
   <td><b>Cell:</b><br /><asp:TextBox ID="txtCell" runat="server"></asp:TextBox></td>
   <td colspan="2"><b>Toll Free:</b><br /><asp:TextBox ID="txtTollFree" runat="server"></asp:TextBox></td>
  </tr>
  <tr>
   <td colspan="3" align="right">
    <asp:Button ID="btnAdd" runat="server" Text="Save Contact" OnClick="sContact" CssClass="NavBtn" />
    <asp:Button ID="btnClose" runat="server" Text="Close Window" CssClass="NavBtn" />
    <asp:HiddenField ID="hfHID" runat="server" Value="0" />
   </td>
  </tr>
 </table>
 <ajax:ModalPopupExtender ID="mpeNewContact" runat="server" TargetControlID="hfHID" PopupControlID="tblContact" BackgroundCssClass="modalBackground"
  OkControlID="btnClose" DropShadow="false" RepositionMode="RepositionOnWindowResize" />

<asp:ObjectDataSource ID="odsContact" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="Contact_Select" UpdateMethod="Contact_Save">
 <SelectParameters>
  <asp:Parameter Name="CompanyID" Type="Int32" />
  <asp:Parameter Name="ClassID" Type="Int32" />
  <asp:Parameter Name="TypeID" Type="Int32" />
  <asp:Parameter Name="isMore" Type="Boolean" DefaultValue="false" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="CompanyID" Type="Int32" />
  <asp:Parameter Name="Dept" Type="String" />
  <asp:Parameter Name="FirstName" Type="String" />
  <asp:Parameter Name="LastName" Type="String" />
  <asp:Parameter Name="MiddleName" Type="String" />
  <asp:Parameter Name="Phone" Type="String" />
  <asp:Parameter Name="Fax" Type="String" />
  <asp:Parameter Name="Cell" Type="String" />
  <asp:Parameter Name="TollFree" Type="String" />
  <asp:Parameter Name="Email" Type="String" />
 </UpdateParameters>
</asp:ObjectDataSource>