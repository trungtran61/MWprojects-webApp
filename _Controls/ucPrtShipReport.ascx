<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucPrtShipReport" Codebehind="ucPrtShipReport.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>
<%@ Register Src="~/_Controls/ShippingLabel.ascx" TagName="ShippingLabel" TagPrefix="ucShipLbl" %>

<h3>Print Shipping Report</h3>

<asp:LinkButton ID="lnkPartTag" runat="server" Text="Part Tags" /><br /><br />

<asp:Panel ID="pnlTask" runat="server"><asp:Literal ID="lisMsg" runat="server"></asp:Literal>
<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>PARTS HAVE BEEN SHIPPED</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvShip" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsShip" OnRowDataBound="rwBound">
    <Columns>
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
     <asp:BoundField HeaderText="Ship By" DataField="ShipBy" SortExpression="ShipBy" ItemStyle-VerticalAlign="Top" InsertVisible="false" />
     <asp:BoundField HeaderText="Date" DataField="ShipDate" SortExpression="ShipDate" ItemStyle-VerticalAlign="Top" InsertVisible="false" />
     <asp:TemplateField HeaderText="Packing #" SortExpression="PackNum" ItemStyle-VerticalAlign="Top" InsertVisible="false">
      <ItemTemplate>
       <asp:LinkButton ID="lnkPackNum" runat="server" Text='<%# Eval("PackNum") %>' OnClientClick='<%# string.Format("javascript:loadPreview({0});return false;", Eval("HID")) %>'></asp:LinkButton>
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Qty" DataField="Qty" SortExpression="Qty" ItemStyle-VerticalAlign="Top" InsertVisible="false" />
     <asp:BoundField HeaderText="At Location" DataField="LocDesc" SortExpression="LocDesc" ItemStyle-VerticalAlign="Top" InsertVisible="false" />
     <asp:BoundField HeaderText="SPL" DataField="SPL" SortExpression="SPL" ItemStyle-VerticalAlign="Top" InsertVisible="false" />
    </Columns>
    <EmptyDataTemplate>None of the parts have been shipped</EmptyDataTemplate>
   </asp:GridView>
  </td>
 </tr>
</table>
</asp:Panel>

<div id="dvBogus" style="display:none;">Please follow the links to print report</div>
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server"></asp:Panel>

<iframe name="frmPartTag" id="frmPartTag" frameborder="0" height="0" width="0"></iframe>

<telerik:RadWindowManager ID="radWindow" runat="server" Skin="Vista" Title="Form Preview"  >
 <Windows>
  <telerik:RadWindow ID="preview" runat="server" Title="Form Preview" Height="500px" 
  Width="500px" Left="150px" ReloadOnShow="true" VisibleStatusbar="false" ShowContentDuringLoad="false" Modal="true" Skin="Vista" VisibleTitlebar="true" />
 </Windows>
</telerik:RadWindowManager>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function lFrame(url) {
   document.getElementById('frmPartTag').src = url;
  }
  function loadPreview(id)
  {
   window.radopen("File/Preview.aspx?FID=PackingList&Code=PackingList&HID=" + id, "preview").maximize();
  }
  function loadC(frm,cd,id)
  {
   window.radopen("File/Preview.aspx?FID=" + frm + "&Code=" + cd + "&HID=" + id, "preview").maximize();
  }
  function loadPView(id)
  {
   window.radopen("File/ShowImage.aspx?PackID=" + id, "preview").maximize();
  }
  function loadUpload(cmd)
  {
   window.radopen("File/Upload.aspx?cmd=" + cmd, "preview").maximize();
  }
 </script>
</telerik:RadCodeBlock>

<asp:ObjectDataSource ID="odsShip" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="Select2">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Ship" />
 </SelectParameters>
</asp:ObjectDataSource>