<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.DeliCount" Codebehind="DeliCount.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Update Count for Delivery</h3>

<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>PARTIAL SHIPMENT STATUS</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvPartialShip" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsPartialShip" OnDataBound="PartialStatusBound" OnRowDataBound="PartialShipRwBound">
    <Columns>
     <asp:BoundField HeaderText="Order Qty" DataField="oQty" InsertVisible="false" />
     <asp:BoundField HeaderText="Delivered Qty" DataField="cQty" InsertVisible="false" />
     <asp:BoundField HeaderText="Back Order" DataField="nQty" InsertVisible="false" />
     <asp:TemplateField HeaderText="Action" InsertVisible="false">
      <ItemTemplate>
       <asp:DropDownList ID="ddlPartialStatus" runat="server" SelectedValue='<%# Eval("pStatus") %>' AutoPostBack="true" OnSelectedIndexChanged="pStatusSelected">
        <asp:ListItem Value="Working" Text="Working"></asp:ListItem>
        <asp:ListItem Value="ClosedShort" Text="Closed Short"></asp:ListItem>
       </asp:DropDownList>
      </ItemTemplate>
     </asp:TemplateField>
    </Columns>
    <EmptyDataTemplate>All parts have been shipped!</EmptyDataTemplate>
   </asp:GridView>
  </td>
 </tr>
</table>
<br />
<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>PARTS HAVE BEEN DELIVERED</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvDeliA" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsDeliA" OnDataBound="DeliABound">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:CheckBox ID="chkItem" runat="server" Visible='<%# Convert.ToBoolean(Eval("isUndo")) %>' /></ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Delivered By" DataField="DeliBy" SortExpression="DeliBy" InsertVisible="false" />
     <asp:BoundField HeaderText="Date" DataField="DeliDate" SortExpression="DeliDate" InsertVisible="false" />
     <asp:BoundField HeaderText="Packing #" DataField="PackNum" SortExpression="PackNum" InsertVisible="false" />
     <asp:BoundField HeaderText="Qty" DataField="Qty" SortExpression="Qty" InsertVisible="false" />
     <asp:BoundField HeaderText="At Location" DataField="LocDesc" SortExpression="LocDesc" InsertVisible="false" />
     <asp:BoundField HeaderText="SPL" DataField="SPL" SortExpression="SPL" InsertVisible="false" />
    </Columns>
    <EmptyDataTemplate>No part has been delivered!</EmptyDataTemplate>
   </asp:GridView>
  </td>
 </tr>
</table>
<br />
<asp:Button ID="btnUndo" runat="server" Text="Undo" OnClick="bUndo" CssClass="NavBtn" />
<br /><br />

<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>PARTS AVAILABLE TO DELIVER</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvDeli" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsDeli" OnDataBound="DeliBound">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:CheckBox ID="chkItem" runat="server" />
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Shipped By" DataField="ShipBy" SortExpression="ShipBy" InsertVisible="false" />
     <asp:BoundField HeaderText="Date" DataField="ShipDate" SortExpression="ShipDate" InsertVisible="false" />
     <asp:BoundField HeaderText="Packing #" DataField="PackNum" SortExpression="PackNum" InsertVisible="false" />
     <asp:BoundField HeaderText="Qty" DataField="Qty" SortExpression="Qty" InsertVisible="false" />
     <asp:BoundField HeaderText="From Location" DataField="LocDesc" SortExpression="LocDesc" InsertVisible="false" />
    </Columns>
    <EmptyDataTemplate>There is no packing available for delivery!</EmptyDataTemplate>
   </asp:GridView>
  </td>
 </tr>
</table>
<br />
<asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID"></asp:DropDownList>
<asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="doSubmit" CssClass="NavBtn" />
<MW:Message ID="iMsg" runat="server" />

<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:HiddenField ID="hfUID" runat="server" />
<asp:ObjectDataSource ID="odsPartialShip" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="PartialShip_S" UpdateMethod="PartialShip_U">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </SelectParameters>
 <UpdateParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="pStatus" Type="String" />
 </UpdateParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsDeli" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="Select1" UpdateMethod="Save">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Deli" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="WOID" Type="String" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:ControlParameter Name="LocID" Type="Int32" ControlID="ddlLocation" PropertyName="SelectedValue" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Deli" />
 </UpdateParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsDeliA" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="Select2" UpdateMethod="Undo">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Deli" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="WOID" Type="String" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Deli" />
 </UpdateParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
 <SelectParameters>
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Delivery" />
  <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
  <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
 </SelectParameters>
</asp:ObjectDataSource>