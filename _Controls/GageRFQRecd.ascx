<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.GageRFQRecd" Codebehind="GageRFQRecd.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>QUOTE FOR GAGE FROM VENDOR(S)</h3>
Please use this search form to find the specific RFQ;<br />
then enter the received data for that particular quote.<br /><br />
<asp:Panel ID="pnlTask" runat="server" Enabled="false">
 <table class="SearchForm">
  <tr>
   <td colspan="2"><b>RFQ Number:</b><br /><asp:TextBox ID="txtRFQNumber" runat="server"></asp:TextBox></td>
  </tr>
  <tr>
   <td><b>Item Number:</b><br /><asp:TextBox ID="txtItemNo" runat="server"></asp:TextBox></td>
   <td><b>Vendor Name:</b><br /><asp:TextBox ID="txtVendorName" runat="server"></asp:TextBox></td>
  </tr>
  <tr>
   <td><b>Price:</b><br /><asp:TextBox ID="txtUnitPrice" runat="server"></asp:TextBox></td>
   <td><b>Lead Time:</b><br /><asp:TextBox ID="txtLeadTime" runat="server"></asp:TextBox></td>
  </tr>
  <tr><td colspan="2" align="right"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="NavBtn" /></td></tr>
 </table>
 <br />

 <asp:GridView ID="gvQuote" runat="server" AutoGenerateColumns="False" DataSourceID="odsQuote" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="None" DataKeyNames="HID" AllowSorting="true">
  <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
  <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
  <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
  <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
  <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
  <Columns>
   <asp:CommandField ShowEditButton="true" />
   <asp:BoundField ReadOnly="true" HeaderText="RFQ#" DataField="RFQNumber" SortExpression="RFQNumber" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Item#" DataField="ItemNo" SortExpression="ItemNo" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Description" DataField="Description" SortExpression="Description" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Quantity" DataField="Quantity" SortExpression="Quantity" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Unit" DataField="Unit" SortExpression="Unit" InsertVisible="false" />
   <asp:BoundField HeaderText="Unit Price ($)" DataField="UnitPrice" SortExpression="UnitPrice" ControlStyle-Width="50px" InsertVisible="false" />
   <asp:BoundField HeaderText="Amount ($)" DataField="Amount" SortExpression="Amount" ControlStyle-Width="75px" InsertVisible="false" />
   <asp:BoundField HeaderText="Lead Time (d)" DataField="LeadTime" SortExpression="LeadTime" ControlStyle-Width="50px" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Vendor" DataField="VendorName" SortExpression="VendorName" InsertVisible="false" />
   <asp:BoundField HeaderText="Vendor Quote#" DataField="VendorQuote" SortExpression="VendorQuote" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Estimator" DataField="Estimator" SortExpression="Estimator" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Estimate Date" DataField="EstDate" SortExpression="EstDate" InsertVisible="false" />
   <asp:TemplateField HeaderText="No Bid">
    <ItemTemplate><%# gLnk() %></ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Comment" DataField="Comment" SortExpression="Comment" InsertVisible="false" />
  </Columns>
  <EmptyDataTemplate>No RFQ is available for this work order</EmptyDataTemplate>
 </asp:GridView>
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />

<asp:ObjectDataSource ID="odsQuote" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Select_Quotes" UpdateMethod="Update_Quotes">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:ControlParameter Name="RFQNumber" Type="String" ControlID="txtRFQNumber" PropertyName="Text" />
  <asp:ControlParameter Name="ItemNo" Type="String" ControlID="txtItemNo" PropertyName="Text" />
  <asp:ControlParameter Name="VendorName" Type="String" ControlID="txtVendorName" PropertyName="Text" />
  <asp:ControlParameter Name="UnitPrice" Type="String" ControlID="txtUnitPrice" PropertyName="Text" />
  <asp:ControlParameter Name="LeadTime" Type="String" ControlID="txtLeadTime" PropertyName="Text" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="UnitPrice" Type="Double" />
  <asp:Parameter Name="Amount" Type="Double" />
  <asp:Parameter Name="LeadTime" Type="Int32" />
  <asp:Parameter Name="VendorQuote" Type="String" />
  <asp:Parameter Name="Comment" Type="String" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </UpdateParameters>
</asp:ObjectDataSource>