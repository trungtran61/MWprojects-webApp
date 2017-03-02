<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.chkInventory" Codebehind="chkInventory.ascx.cs" %>

<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>AVAILABLE: <asp:Literal ID="litAvailable" runat="server" /> = Quantity Available for Use</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvAvailable" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="PartInvID" DataSourceID="odsAvailable">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /></ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="From WO#" DataField="WorkOrder" SortExpression="WorkOrder" />
     <asp:BoundField HeaderText="Qty" DataField="Available" SortExpression="Available" />
     <asp:BoundField HeaderText="Location" DataField="LocDesc" SortExpression="LocDesc" />
    </Columns>
   </asp:GridView>
  </td>
 </tr>
 <tr id="trUsePart" style="background-color:#CCFFCC" runat="server" visible="false">
  <td align="right">
   <asp:Panel ID="pnlUsePart" runat="server">
    <br /><b>Quantity Need:</b> <asp:Literal ID="litNeed" runat="server"></asp:Literal>
    <br /><b>Result:</b> <asp:Literal ID="litResult" runat="server"></asp:Literal>
    <br /><asp:Button ID="btnUsePart" runat="server" Text="Yes, I want to use part" OnClick="usePart" CssClass="NavBtn" />
   </asp:Panel>
   <br /><MW:Message ID="iMsg" runat="server" />
  </td>
 </tr>
</table>
<br /><br />
<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>ON HAND: <asp:Literal ID="litOnHand" runat="server" /> = AVAILABLE + ALLOCATED</b></td>
 </tr>
</table>
<br /><br />
<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>ALLOCATED: <asp:Literal ID="litAllocated" runat="server" /> = Quantity Reserved for Work Orders & Waiting to Ship</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvAllocated" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="WorkOrder" DataSourceID="odsAllocated">
    <Columns>
     <asp:BoundField HeaderText="For WO#" DataField="WorkOrder" SortExpression="WorkOrder" />
     <asp:BoundField HeaderText="Qty" DataField="Qty" SortExpression="Qty" />
     <asp:BoundField HeaderText="Due Date" DataField="DueDate" SortExpression="DueDate" />
     <asp:BoundField HeaderText="From WO#" DataField="fWorkOrder" SortExpression="fWorkOrder" />
     <asp:BoundField HeaderText="From Location" DataField="fLocDesc" SortExpression="fLocDesc" />
    </Columns>
   </asp:GridView>
  </td>
 </tr>
</table>
<br /><br />
<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>COMMITTED: <asp:Literal ID="litCommitted" runat="server" /> = Quantity Ready to Deliver</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvCommitted" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="WorkOrder" DataSourceID="odsCommitted">
    <Columns>
     <asp:BoundField HeaderText="For WO#" DataField="WorkOrder" SortExpression="WorkOrder" />
     <asp:BoundField HeaderText="Qty" DataField="CommitQty" SortExpression="CommitQty" />
     <asp:BoundField HeaderText="Current Location" DataField="LocDesc" SortExpression="LocDesc" />
     <asp:BoundField HeaderText="Due Date" DataField="DueDate" SortExpression="DueDate" />
     <asp:BoundField HeaderText="From WO#" DataField="fWorkOrder" SortExpression="fWorkOrder" />
     <asp:BoundField HeaderText="From Location" DataField="fLocDesc" SortExpression="fLocDesc" />
    </Columns>
   </asp:GridView>
  </td>
 </tr>
</table>
<br /><br />
<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White; font-weight:bold;">
  <td>
   <asp:DropDownList ID="ddlSoldDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
    <asp:ListItem Text="5" Value="5"></asp:ListItem>
    <asp:ListItem Text="10" Value="10"></asp:ListItem>
    <asp:ListItem Text="20" Value="20"></asp:ListItem>
    <asp:ListItem Text="40" Value="40"></asp:ListItem>
    <asp:ListItem Text="All" Value="*"></asp:ListItem>
   </asp:DropDownList>
   HISTORY
  </td>
  <td align="right"><asp:Literal ID="litTotalSoldMade" runat="server" /></td>
 </tr>
 <tr>
  <td colspan="2">
   <asp:GridView ID="gvSold" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="WorkOrder" DataSourceID="odsSold" PageSize="5">
    <Columns>
     <asp:BoundField HeaderText="For WO#" DataField="WorkOrder" SortExpression="WorkOrder" />
     <asp:BoundField HeaderText="Qty" DataField="CommitQty" SortExpression="CommitQty" />
     <asp:BoundField HeaderText="Delivered By" DataField="LocDesc" SortExpression="LocDesc" />
     <asp:BoundField HeaderText="Due Date" DataField="DueDate" SortExpression="DueDate" />
     <asp:BoundField HeaderText="From WO#" DataField="fWorkOrder" SortExpression="fWorkOrder" />
     <asp:BoundField HeaderText="From Location" DataField="fLocDesc" SortExpression="fLocDesc" />
    </Columns>
   </asp:GridView>
  </td>
 </tr>
</table>
<br /><br />
<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>INCOMPLETE: <asp:Literal ID="litIncompleted" runat="server" /></b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvIncompleted" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="WorkOrder" DataSourceID="odsIncompleted">
    <Columns>
     <asp:BoundField HeaderText="From WO#" DataField="WorkOrder" SortExpression="WorkOrder" />
     <asp:BoundField HeaderText="Qty" DataField="Qty" SortExpression="Qty" />
     <asp:BoundField HeaderText="Completed Step" DataField="StepDesc" SortExpression="StepDesc" />
     <asp:BoundField HeaderText="Location" DataField="LocDesc" SortExpression="LocDesc" />
    </Columns>
   </asp:GridView>
  </td>
 </tr>
</table>

<asp:ObjectDataSource ID="odsAvailable" runat="server" TypeName="myBiz.DAL.clsPartInv" SelectMethod="Check_Available">
 <SelectParameters>
  <asp:ControlParameter Name="WO" Type="String" ControlID="hfWO" PropertyName="Value" />
  <asp:ControlParameter Name="WOID" Type="Int32" ControlID="hfWOID" PropertyName="Value" />
  <asp:ControlParameter Name="PN" Type="String" ControlID="hfPN" PropertyName="Value" />
  <asp:ControlParameter Name="RV" Type="String" ControlID="hfRV" PropertyName="Value" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsAllocated" runat="server" TypeName="myBiz.DAL.clsPartInv" SelectMethod="Check_Allocated">
 <SelectParameters>
  <asp:ControlParameter Name="WO" Type="String" ControlID="hfWO" PropertyName="Value" />
  <asp:ControlParameter Name="WOID" Type="Int32" ControlID="hfWOID" PropertyName="Value" />
  <asp:ControlParameter Name="PN" Type="String" ControlID="hfPN" PropertyName="Value" />
  <asp:ControlParameter Name="RV" Type="String" ControlID="hfRV" PropertyName="Value" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsCommitted" runat="server" TypeName="myBiz.DAL.clsPartInv" SelectMethod="Check_Committed">
 <SelectParameters>
  <asp:ControlParameter Name="WO" Type="String" ControlID="hfWO" PropertyName="Value" />
  <asp:ControlParameter Name="WOID" Type="Int32" ControlID="hfWOID" PropertyName="Value" />
  <asp:ControlParameter Name="PN" Type="String" ControlID="hfPN" PropertyName="Value" />
  <asp:ControlParameter Name="RV" Type="String" ControlID="hfRV" PropertyName="Value" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsSold" runat="server" TypeName="myBiz.DAL.clsPartInv" SelectMethod="Check_Sold">
 <SelectParameters>
  <asp:ControlParameter Name="WO" Type="String" ControlID="hfWO" PropertyName="Value" />
  <asp:ControlParameter Name="WOID" Type="Int32" ControlID="hfWOID" PropertyName="Value" />
  <asp:ControlParameter Name="PN" Type="String" ControlID="hfPN" PropertyName="Value" />
  <asp:ControlParameter Name="RV" Type="String" ControlID="hfRV" PropertyName="Value" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsIncompleted" runat="server" TypeName="myBiz.DAL.clsPartInv" SelectMethod="Check_Incompleted">
 <SelectParameters>
  <asp:ControlParameter Name="WO" Type="String" ControlID="hfWO" PropertyName="Value" />
  <asp:ControlParameter Name="WOID" Type="Int32" ControlID="hfWOID" PropertyName="Value" />
  <asp:ControlParameter Name="PN" Type="String" ControlID="hfPN" PropertyName="Value" />
  <asp:ControlParameter Name="RV" Type="String" ControlID="hfRV" PropertyName="Value" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:HiddenField ID="hfWOID" runat="server" Value="0" />
<asp:HiddenField ID="hfPN" runat="server" />
<asp:HiddenField ID="hfRV" runat="server" />
<asp:HiddenField ID="hfIsGood" runat="server" />
<asp:HiddenField ID="hfWO" runat="server" />