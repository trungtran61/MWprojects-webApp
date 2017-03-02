<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucFileCnt" Codebehind="ucFileCnt.ascx.cs" %>

<asp:GridView ID="gvFileCnt" runat="server" SkinID="GrayHeader" PageSize="500" DataKeyNames="HID" DataSourceID="odsFileCnt" OnRowCommand="gvCmd" OnRowDataBound="rwBound">
 <Columns>
  <asp:BoundField HeaderText="Dept" DataField="Dept" SortExpression="Dept" InsertVisible="false" />
  <asp:BoundField HeaderText="ID" DataField="TaskID" SortExpression="TaskID" InsertVisible="false" />
  <asp:BoundField HeaderText="M.O.T. OP#" DataField="OpNo" SortExpression="OpNo" InsertVisible="false" />
  <asp:TemplateField HeaderText="Name" SortExpression="TaskDesc">
   <ItemTemplate>
    <asp:LinkButton ID="lnkUpload" runat="server" Text='<%# Eval("TaskDesc") %>' CommandName="doUpload" />
    <asp:PlaceHolder ID="phlLinks" runat="server"></asp:PlaceHolder>
    <asp:HiddenField ID="hfGrpID" runat="server" Value='<%# Eval("GrpID") %>' />
    <asp:HiddenField ID="hfLnkID" runat="server" Value='<%# Eval("LnkID") %>' />
    <asp:HiddenField ID="hflIDs" runat="server" Value='<%# Eval("lIDs") %>' />
   </ItemTemplate>
  </asp:TemplateField>
 </Columns>
 <EmptyDataTemplate>No report available</EmptyDataTemplate>
</asp:GridView>
<br />

<table id="tblShip" runat="server" cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>Shipping Paperwork</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvShip" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsShip" OnRowDataBound="shipBound">
    <Columns>
     <asp:TemplateField HeaderText="Packing #" ItemStyle-VerticalAlign="Top">
      <ItemTemplate>
       <asp:LinkButton ID="lnkPackNum" runat="server" Text='<%# Eval("PackNum") %>' OnClientClick='<%# string.Format("javascript:loadPreview({0});return false;", Eval("HID")) %>'></asp:LinkButton>
      </ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Reports to Print">
      <ItemTemplate>
       <asp:Label ID="lblShipRpt" runat="server" CssClass="Pointer"></asp:Label>
       <asp:Panel ID="pnlShipRpt" runat="server">
        <asp:Literal ID="litShip" runat="server"></asp:Literal>
        <asp:LinkButton ID="lnkMtlCert" runat="server" OnClick="doPrint" CommandArgument='<%# Eval("xWOID") %>'></asp:LinkButton>
        <asp:LinkButton ID="lnkOPSCert" runat="server" OnClick="doPrint" CommandArgument='<%# Eval("xWOID") %>'></asp:LinkButton>
        <asp:LinkButton ID="lnk1stArt" runat="server" OnClick="doPrint" CommandArgument='<%# Eval("xWOID") %>'></asp:LinkButton>
        <asp:LinkButton ID="lnkFinal" runat="server" OnClick="doPrint" CommandArgument='<%# Eval("xWOID") %>'></asp:LinkButton>
       </asp:Panel>
       <ajax:CollapsiblePanelExtender ID="cpeShipRpt" runat="server" TargetControlID="pnlShipRpt" ExpandControlID="lblShipRpt" CollapseControlID="lblShipRpt" Collapsed="false" ExpandedText="Collapse" CollapsedText="Print" TextLabelID="lblShipRpt" />
      </ItemTemplate>
     </asp:TemplateField>
    </Columns>
    <EmptyDataTemplate>You have no shipping report to print</EmptyDataTemplate>
   </asp:GridView>
   <asp:ObjectDataSource ID="odsShip" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="Select2">
    <SelectParameters>
     <asp:ControlParameter Name="IDs" Type="String" ControlID="hfWOID" PropertyName="Value" />
     <asp:Parameter Name="Dept" Type="String" DefaultValue="Ship" />
    </SelectParameters>
   </asp:ObjectDataSource>
  </td>
 </tr>
</table>

<asp:Panel ID="pnlPopup" runat="server" />
<asp:HiddenField ID="hfWOID" runat="server" />

<asp:ObjectDataSource ID="odsFileCnt" runat="server" TypeName="myBiz.DAL.clsWorkOrder" SelectMethod="FileCnt" FilterExpression="TaskID NOT IN ({0})" OnFiltering="odsFiltering">
 <SelectParameters><asp:ControlParameter Name="WOID" Type="String" ControlID="hfWOID" PropertyName="Value" /></SelectParameters>
 <FilterParameters><asp:Parameter Name="TaskID" Type="String" /></FilterParameters>
</asp:ObjectDataSource>

<telerik:RadWindowManager ID="radWindow" runat="server" Skin="Vista" Title="Form Preview">
 <Windows>
  <telerik:RadWindow ID="preview" runat="server" Title="Form Preview" Height="500px" 
  Width="500px" Left="150px" ReloadOnShow="true" VisibleStatusbar="false" ShowContentDuringLoad="false" Modal="true" Skin="Vista" VisibleTitlebar="true" />
 </Windows>
</telerik:RadWindowManager>