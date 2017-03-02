 <%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.BillCount" Codebehind="BillCount.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Update Count for Billing</h3>

<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>PARTIAL SHIPMENT STATUS</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvPartialShip" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsPartialShip" OnDataBound="PartialStatusBound">
    <Columns>
     <asp:BoundField HeaderText="Order Qty" DataField="oQty" InsertVisible="false" />
     <asp:BoundField HeaderText="Delivered Qty" DataField="cQty" InsertVisible="false" />
     <asp:BoundField HeaderText="Back Order" DataField="nQty" InsertVisible="false" />
     <asp:TemplateField HeaderText="Action" InsertVisible="false">
      <ItemTemplate>
       <asp:DropDownList ID="ddlPartialStatus" runat="server" SelectedValue='<%# Eval("pStatus") %>' Enabled="false">
        <asp:ListItem Value="Working" Text="Working"></asp:ListItem>
        <asp:ListItem Value="ClosedShort" Text="Closed Short"></asp:ListItem>
       </asp:DropDownList>
      </ItemTemplate>
     </asp:TemplateField>
    </Columns>
   </asp:GridView>
  </td>
 </tr>
</table>
<br />
<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>INVOICES HAVE BEEN SENT</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvBillA" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsBillA" OnDataBound="BillABound" OnRowCommand="gvCmd">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:CheckBox ID="chkItem" runat="server" Visible='<%# Convert.ToBoolean(Eval("isUndo")) %>' /></ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Sent By" DataField="BillBy" SortExpression="BillBy" InsertVisible="false" />
     <asp:BoundField HeaderText="Date" DataField="BillDate" SortExpression="BillDate" InsertVisible="false" />
     <asp:TemplateField HeaderText="Invoice #" SortExpression="PackNum" InsertVisible="false">
      <ItemTemplate>
       <asp:LinkButton ID="lnkPackNum" runat="server" Text='<%# Eval("PackNum") %>' OnClientClick='<%# string.Format("javascript:loadPreview({0});return false;", Eval("HID")) %>'></asp:LinkButton>
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Qty" DataField="Qty" SortExpression="Qty" InsertVisible="false" />
     <asp:BoundField HeaderText="Price ($)" DataField="UnitPrice" HtmlEncode="false" DataFormatString="{0:$0.00}" SortExpression="UnitPrice" InsertVisible="false" />
     <asp:BoundField HeaderText="Amount ($)" DataField="Amount" HtmlEncode="false" DataFormatString="{0:$0.00}" SortExpression="Amount" InsertVisible="false" />
     <asp:TemplateField HeaderText="SPL #" SortExpression="PackNum" InsertVisible="false">
      <ItemTemplate>
       <asp:LinkButton ID="lnkView" runat="server" Text='<%# Eval("PackNum") %>' CommandName="ViewSPL" CommandArgument='<%# Eval("HID") %>' />
      </ItemTemplate>
     </asp:TemplateField>
    </Columns>
    <EmptyDataTemplate>No Packing has been billed!</EmptyDataTemplate>
   </asp:GridView>
  </td>
 </tr>
</table>

<br />
<asp:Button ID="btnUndo" runat="server" Text="Undo" OnClick="bUndo" CssClass="NavBtn" />
<br /><br />

<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>INVOICES NEED TO BE SENT</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvBill" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsBill" OnDataBound="BillBound" OnRowCommand="gvCmd">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:CheckBox ID="chkItem" runat="server" Visible='<%# Convert.ToBoolean(Eval("isReady")) %>' />
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Delivered By" DataField="DeliBy" SortExpression="DeliBy" InsertVisible="false" />
     <asp:BoundField HeaderText="Date" DataField="DeliDate" SortExpression="DeliDate" InsertVisible="false" />
     <asp:TemplateField HeaderText="Invoice #" SortExpression="PackNum" InsertVisible="false">
      <ItemTemplate>
       <asp:LinkButton ID="lnkPackNum" runat="server" Text='<%# Eval("PackNum") %>' OnClientClick='<%# string.Format("javascript:loadPreview({0});return false;", Eval("HID")) %>'></asp:LinkButton>
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Qty" DataField="Qty" SortExpression="Qty" InsertVisible="false" />
     <asp:BoundField HeaderText="Price ($)" DataField="UnitPrice" HtmlEncode="false" DataFormatString="{0:$0.00}" SortExpression="UnitPrice" InsertVisible="false" />
     <asp:BoundField HeaderText="Amount ($)" DataField="Amount" HtmlEncode="false" DataFormatString="{0:$0.00}" SortExpression="Amount" InsertVisible="false" />
     <asp:TemplateField HeaderText="SPL #" SortExpression="PackNum" InsertVisible="false">
      <ItemTemplate>
       <asp:LinkButton ID="lnkView" runat="server" Text='<%# Eval("PackNum") %>' CommandName="ViewSPL" CommandArgument='<%# Eval("HID") %>' />
      </ItemTemplate>
     </asp:TemplateField>
    </Columns>
    <EmptyDataTemplate>There is no packing available for billing!</EmptyDataTemplate>
   </asp:GridView>
  </td>
 </tr>
</table>

<br />
<asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="doSubmit" CssClass="NavBtn" />

<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />

<telerik:RadWindowManager ID="radWindow" runat="server" Skin="Vista" Title="Form Preview"  >
 <Windows>
  <telerik:RadWindow ID="preview" runat="server" Title="Form Preview" Height="500px" 
  Width="500px" Left="150px" ReloadOnShow="true" VisibleStatusbar="false" ShowContentDuringLoad="false" Modal="true" Skin="Vista" VisibleTitlebar="true" />
 </Windows>
</telerik:RadWindowManager>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadPreview(id)
  {
   window.radopen("File/Preview.aspx?FID=Invoice&Code=Invoice&HID=" + id, "preview").maximize();
  }
 </script>
</telerik:RadCodeBlock>

<asp:HiddenField ID="hfUID" runat="server" />
<asp:ObjectDataSource ID="odsPartialShip" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="PartialShip_S">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsBill" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="Select1" UpdateMethod="Save">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Bill" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="WOID" Type="String" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:Parameter Name="LocID" Type="String" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Bill" />
 </UpdateParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsBillA" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="Select2" UpdateMethod="Undo">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Bill" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="WOID" Type="String" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Bill" />
 </UpdateParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
 <SelectParameters>
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Inventory" />
  <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
 </SelectParameters>
</asp:ObjectDataSource>