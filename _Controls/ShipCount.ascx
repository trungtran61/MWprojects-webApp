<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ShipCount" Codebehind="ShipCount.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Update Count for Shipping</h3>

<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>PARTS HAVE BEEN SHIPPED</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvShipA" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsShipA" OnDataBound="ShipABound">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:CheckBox ID="chkItem" runat="server" Visible='<%# Convert.ToBoolean(Eval("isUndo")) %>' /></ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Ship By" DataField="ShipBy" SortExpression="ShipBy" InsertVisible="false" />
     <asp:BoundField HeaderText="Date" DataField="ShipDate" SortExpression="ShipDate" InsertVisible="false" />
     <asp:TemplateField HeaderText="Packing #" SortExpression="PackNum" InsertVisible="false">
      <ItemTemplate>
       <asp:LinkButton ID="lnkPackNum" runat="server" Text='<%# Eval("PackNum") %>' OnClientClick='<%# string.Format("javascript:loadPreview({0});return false;", Eval("HID")) %>'></asp:LinkButton>
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Qty" DataField="Qty" SortExpression="Qty" InsertVisible="false" />
     <asp:BoundField HeaderText="At Location" DataField="LocDesc" SortExpression="LocDesc" InsertVisible="false" />
     <asp:BoundField HeaderText="SPL" DataField="SPL" SortExpression="SPL" InsertVisible="false" />
    </Columns>
    <EmptyDataTemplate>None of the parts have been shipped</EmptyDataTemplate>
   </asp:GridView>
  </td>
 </tr>
</table>

<br />
<asp:Button ID="btnUndo" runat="server" Text="Undo" OnClick="bUndo" CssClass="NavBtn" />

<hr />

<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>PARTS AVAILABLE TO SHIP</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView Width="100%" ID="gvShip" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsShip" OnDataBound="ShipBound">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:CheckBox ID="chkItem" runat="server" />
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Inventory By" DataField="InvBy" SortExpression="InvBy" InsertVisible="false" />
     <asp:BoundField HeaderText="Date" DataField="InvDate" SortExpression="InvDate" InsertVisible="false" />
     <asp:BoundField HeaderText="From WO#" DataField="WorkOrder" SortExpression="WorkOrder" InsertVisible="false" />
     <asp:BoundField HeaderText="Qty" DataField="Qty" SortExpression="Qty" InsertVisible="false" />
     <asp:BoundField HeaderText="From Location" DataField="LocDesc" SortExpression="LocDesc" InsertVisible="false" />
    </Columns>
    <EmptyDataTemplate>No part available for shipping!</EmptyDataTemplate>
   </asp:GridView>
  </td>
 </tr>
</table>

<br />
<asp:Literal ID="litLoc" runat="server" Text="<b>To Location:</b>"></asp:Literal>
<asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID"></asp:DropDownList>
<asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="doSubmit" CssClass="NavBtn" />
<asp:Literal ID="litLnk" runat="server" OnLoad="gLnk"></asp:Literal>
<MW:Message ID="iMsg" runat="server" />

<ucMode:CurrentMode ID="myMode" runat="server" />


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
   window.radopen("File/Preview.aspx?FID=PackingList&Code=PackingList&HID=" + id, "preview").maximize();
  }
 </script>
</telerik:RadCodeBlock>

<asp:HiddenField ID="hfUID" runat="server" />
<asp:ObjectDataSource ID="odsShip" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="Select1" UpdateMethod="Save">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Ship" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="WOID" Type="String" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:ControlParameter Name="LocID" Type="Int32" ControlID="ddlLocation" PropertyName="SelectedValue" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Ship" />
 </UpdateParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsShipA" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="Select2" UpdateMethod="Undo">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Ship" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="WOID" Type="String" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Ship" />
 </UpdateParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
 <SelectParameters>
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Shipping" />
  <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
  <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
 </SelectParameters>
</asp:ObjectDataSource>