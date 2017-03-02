<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.OPSRFQRecd" Codebehind="OPSRFQRecd.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>QUOTE FOR OPS FROM VENDOR(S)</h3>
Please use this search form to find the specific RFQ; then enter the received data for that particular quote.<br /><br />
Please Re-Send RFQ to suppliers those have not responsed until you got at least 3 bids.<br /><br />
<asp:Panel ID="pnlTask" runat="server" Enabled="false">
 <table class="SearchForm" cellspacing="5">
  <tr>
   <td><b>RFQ Number:</b><br /><asp:TextBox ID="txtRFQNumber" runat="server"></asp:TextBox></td>
   <td><b>Item Number:</b><br /><asp:TextBox ID="txtItemNo" runat="server"></asp:TextBox></td>
   <td><b>Vendor Name:</b><br /><asp:TextBox ID="txtVendorName" runat="server"></asp:TextBox></td>
   <td><b>Price:</b><br /><asp:TextBox ID="txtUnitPrice" runat="server"></asp:TextBox></td>
   <td><b>Lead Time:</b><br /><asp:TextBox ID="txtLeadTime" runat="server"></asp:TextBox></td>
   <td style="vertical-align:bottom;"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="NavBtn" /></td>
  </tr>
 </table>
 <br />

 <asp:LinkButton ID="lnkMOT" runat="server" OnClick="lMOT" Text="View MOT"></asp:LinkButton>

 <asp:GridView ID="gvQuote" runat="server" AutoGenerateColumns="False" DataSourceID="odsQuote" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="None" DataKeyNames="HID" AllowSorting="true" OnRowCommand="rwCmd">
  <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
  <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
  <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
  <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
  <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
  <Columns>
   <asp:TemplateField>
    <ItemTemplate>
     <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit"  CommandName="Edit" Visible='<%# Convert.ToInt32(Eval("sCnt")) < 1 %>'></asp:LinkButton>
     <asp:Literal ID="litCnt" runat="server" Text='<%# Eval("sCnt") %>' Visible='<%# Convert.ToInt32(Eval("sCnt")) > 0 %>'></asp:Literal>
    </ItemTemplate>
    <EditItemTemplate>
     <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update"  CommandName="Update" ValidationGroup="vUpdate"></asp:LinkButton>
     <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel"  CommandName="Cancel"></asp:LinkButton>
    </EditItemTemplate>
   </asp:TemplateField>
   <asp:BoundField ReadOnly="true" HeaderText="RFQ#" DataField="RFQNumber" SortExpression="RFQNumber" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Item#" DataField="ItemNo" SortExpression="ItemNo" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Description" DataField="Description" SortExpression="Description" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Qty" DataField="Qty" SortExpression="Qty" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Unit" DataField="Unit" SortExpression="Unit" InsertVisible="false" />
   <asp:TemplateField HeaderText="Unit Price ($)" SortExpression="UnitPrice" ControlStyle-Width="50px" InsertVisible="false" >
    <ItemTemplate><%# Eval("UnitPrice","{0:C}") %></ItemTemplate>
    <EditItemTemplate>
     <asp:TextBox ID="txtUnitPrice" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:TextBox>
     <asp:RequiredFieldValidator ID="rfvUnitPrice" runat="server" ControlToValidate="txtUnitPrice" ErrorMessage="Required!" ValidationGroup="vUpdate"></asp:RequiredFieldValidator>
    </EditItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Amount ($)" DataField="Amount" SortExpression="Amount" ControlStyle-Width="75px" InsertVisible="false" />
   <asp:TemplateField HeaderText="Lead Time (d)" SortExpression="LeadTime" ControlStyle-Width="50px" InsertVisible="false" >
    <ItemTemplate><%# Eval("LeadTime") %></ItemTemplate>
    <EditItemTemplate>
     <asp:TextBox ID="txtLeadTime" runat="server" Text='<%# Bind("LeadTime") %>'></asp:TextBox>
     <asp:RequiredFieldValidator ID="rfvLeadTime" runat="server" ControlToValidate="txtLeadTime" ErrorMessage="Required!" ValidationGroup="vUpdate"></asp:RequiredFieldValidator>
    </EditItemTemplate>
   </asp:TemplateField>
   <asp:BoundField ReadOnly="true" HeaderText="Vendor" DataField="VendorName" SortExpression="VendorName" InsertVisible="false" />
   <asp:BoundField HeaderText="Vendor Quote#" DataField="VendorQuote" SortExpression="VendorQuote" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Estimator" DataField="Estimator" SortExpression="Estimator" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Estimate Date" DataField="EstDate" SortExpression="EstDate" InsertVisible="false" />
   <asp:BoundField HeaderText="Comment" DataField="Comment" SortExpression="Comment" InsertVisible="false" />
   <asp:TemplateField>
    <ItemTemplate>
     <asp:LinkButton ID="lnkFile" runat="server" Text="File" CommandName="viewFile" CommandArgument='<%# Eval("HID") %>'></asp:LinkButton>
    </ItemTemplate>
    <EditItemTemplate>
     <asp:LinkButton ID="lnkFile" runat="server" Text="File" CommandName="uploadFile" CommandArgument='<%# Eval("HID") %>'></asp:LinkButton>
    </EditItemTemplate>
   </asp:TemplateField>
  </Columns>
  <EmptyDataTemplate>No RFQ is available for this work order</EmptyDataTemplate>
 </asp:GridView>
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />

<asp:ObjectDataSource ID="odsQuote" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="Select_Quotes" UpdateMethod="Update_Quotes">
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