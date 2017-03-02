<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.InvCount" Codebehind="InvCount.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Update Count for Inventory</h3>

<b>Qty On Hand:</b> <asp:Literal ID="litOnHand" runat="server" /><br />
<b>Available:</b> <asp:Literal ID="litaQty" runat="server" />
<br /><br />
<asp:GridView ID="gvInvCnt" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsInvCnt" ShowFooter="true" OnRowCommand="gvCmd" OnDataBound="gvBound" OnRowUpdating="gvUpdating">
 <Columns>
  <asp:TemplateField>
   <ItemTemplate>
    <asp:Button ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" CssClass="NavBtn" Visible='<%# Eval("isEdit") %>' />
   </ItemTemplate>
   <EditItemTemplate>
    <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="vUpdate" />
    <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
   </EditItemTemplate>
   <FooterTemplate>
    <asp:Button ID="btnAddNew" Text="Add" runat="server" CommandName="AddNew" CommandArgument="Footer" CssClass="NavBtn" ValidationGroup="vNew" />
   </FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Entered By" SortExpression="EnteredBy" InsertVisible="false">
   <ItemTemplate><%# Eval("EnteredBy")%></ItemTemplate>
   <EditItemTemplate><asp:Literal ID="litEnteredBy" runat="server" Text='<%# Bind("EnteredBy")%>' /></EditItemTemplate>
   <FooterTemplate>&nbsp;</FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Date" SortExpression="InvDate" InsertVisible="false">
   <ItemTemplate><%# Eval("InvDate")%></ItemTemplate>
   <EditItemTemplate><%# Eval("InvDate")%></EditItemTemplate>
   <FooterTemplate>&nbsp;</FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="On-Hand" SortExpression="Qty" InsertVisible="false">
   <ItemTemplate><%# Eval("Qty")%></ItemTemplate>
   <EditItemTemplate><%# Eval("Qty")%></EditItemTemplate>
   <FooterTemplate>##</FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Available" SortExpression="Available" InsertVisible="false">
   <ItemTemplate><%# Eval("Available")%></ItemTemplate>
   <EditItemTemplate><%# Eval("Available")%></EditItemTemplate>
   <FooterTemplate>##</FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Entered" SortExpression="iQty" InsertVisible="false">
   <ItemTemplate><%# Eval("iQty")%></ItemTemplate>
   <EditItemTemplate>
    <asp:TextBox ID="txtQty" runat="server" Text='<%# Bind("Qty") %>' Width="50px" />
    <asp:RequiredFieldValidator ID="rfvQty" runat="server" ControlToValidate="txtQty" ErrorMessage="*" ValidationGroup="vUpdate"></asp:RequiredFieldValidator>
   </EditItemTemplate>
   <FooterTemplate>
    <asp:TextBox ID="txtQty" runat="server" Width="50px" />
    <asp:RequiredFieldValidator ID="rfvQty" runat="server" ControlToValidate="txtQty" ErrorMessage="*" ValidationGroup="vNew"></asp:RequiredFieldValidator>
   </FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Location" SortExpression="LocDesc" InsertVisible="false">
   <ItemTemplate><%# Eval("LocDesc")%></ItemTemplate>
   <EditItemTemplate><asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID" SelectedValue='<%# Bind("LocID") %>'></asp:DropDownList></EditItemTemplate>
   <FooterTemplate><asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID"></asp:DropDownList></FooterTemplate>
  </asp:TemplateField>
 </Columns>
 <EmptyDataTemplate>
  <table>
   <tr><td><b>Qty</b></td><td><asp:TextBox ID="txtQty" runat="server" Width="30px"></asp:TextBox></td></tr>
   <tr><td><b>Location:</b></td><td><asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID"></asp:DropDownList></td></tr>
   <tr><td colspan="2"><asp:Button ID="btnNew" runat="server" Text="Save" CssClass="NavBtn" CommandName="AddNew" CommandArgument="Empty" /></td></tr>
  </table>
 </EmptyDataTemplate>
</asp:GridView>

<MW:Message ID="iMsg" runat="server" />

<ucMode:CurrentMode ID="myMode" runat="server" />

<asp:ObjectDataSource ID="odsInvCnt" runat="server" TypeName="myBiz.DAL.clsPartInv" SelectMethod="Select" UpdateMethod="Save">
 <SelectParameters><asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" /></SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="EnteredBy" Type="String" />
  <asp:Parameter Name="Qty" Type="Int32" />
  <asp:Parameter Name="LocID" Type="Int32" />
 </UpdateParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
 <SelectParameters>
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Inventory" />
  <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
  <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
 </SelectParameters>
</asp:ObjectDataSource>
