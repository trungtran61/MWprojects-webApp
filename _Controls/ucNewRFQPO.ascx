<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucNewRFQPO" Codebehind="ucNewRFQPO.ascx.cs" %>

<script language="javascript" type="text/javascript">
 function ddlCheck(ddl) {
  var val = ddl.options[ddl.selectedIndex].value;
  if (val.indexOf(':N') > -1) ddl.selectedIndex = 0;
 }
 function ddlVendorCheck(ddl) {
  var txt = ddl.options[ddl.selectedIndex].text;
  if (txt.indexOf('(Expired)') > -1) ddl.selectedIndex = 0;
 }
</script>

<asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
 <table>
  <tr>
   <td><b>Part Number:</b></td>
   <td><b>Description:</b></td>
   <td><b>PO Number:</b></td>
   <td><b>RFQ Number:</b></td>
   <td><b>Vendor:</b></td>
   <td>&nbsp;</td>
  </tr>
  <tr>
   <td>
    <asp:TextBox ID="txtPartNumber" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="acePartNumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtPartNumber">
    </ajax:AutoCompleteExtender>
   </td>
   <td><asp:TextBox ID="txtDesc" runat="server"></asp:TextBox></td>
   <td>
    <asp:TextBox ID="txtPONumber" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="acePONumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtPONumber" />
   </td>
   <td>
    <asp:TextBox ID="txtRFQNumber" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="aceRFQNumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetRFQNumber" TargetControlID="txtRFQNumber" />
   </td>
   <td><asp:TextBox ID="txtVendorName" runat="server"></asp:TextBox></td>
   <td valign="bottom">
    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="NavBtn" />
    <asp:Button ID="btnNew" runat="server" Text="Add New" Enabled="false" OnClick="btnNew_Click" CssClass="NavBtn" />
    <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="doReset" CssClass="NavBtn" />
   </td>
  </tr>
 </table><br />
 <asp:GridView ID="gvSearch" runat="server" SkinID="Default" DataKeyNames="PartNumber,PONumber,RFQNumber" DataSourceID="odsRFQPO" OnRowCommand="gvCmd" OnRowDataBound="gvBound">
  <Columns>
   <asp:TemplateField HeaderText="Select">
    <ItemTemplate>
     <asp:LinkButton ID="lnkSelect" runat="server" CommandName="cNew" Text='&#9679;' Font-Size="XX-Large" ForeColor="Green" Font-Underline="false" />
     <asp:HiddenField ID="hfWorkOrderIDN" runat="server" Value='<%# Eval("WorkOrderID") %>' />
     <asp:HiddenField ID="hfProcessIDN" runat="server" Value='<%# Eval("ProcessID") %>' />
     <asp:HiddenField ID="hfVendorIDN" runat="server" Value='<%# Eval("VendorID") %>' />
    </ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Part Number" DataField="PartNumber" SortExpression="PartNumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Description" DataField="Description" SortExpression="Description" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="RFQ Number" DataField="RFQNumber" SortExpression="RFQNumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="PO Number" DataField="PONumber" SortExpression="PONumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Qty" DataField="Qty" SortExpression="Qty" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Unit" DataField="Unit" SortExpression="Unit" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Unit Price" DataField="UnitPrice" SortExpression="UnitPrice" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Amount" DataField="Amount" SortExpression="Amount" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Lead Time" DataField="LeadTime" SortExpression="LeadTime" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Vendor" DataField="CompanyName" SortExpression="CompanyName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
  </Columns>
 </asp:GridView>
</asp:Panel>

  <table id="tblRFQPON" runat="server" class="mdlPopup">
   <tr>
    <td colspan="2"><b>Work Order:</b>
     <asp:DropDownList ID="ddlWorkOrderN" runat="server" DataSourceID="odsWorkOrderN" DataValueField="HID" DataTextField="WorkOrder"></asp:DropDownList>
     <asp:ObjectDataSource ID="odsWorkOrderN" runat="server" TypeName="myBiz.DAL.clsWorkOrder" SelectMethod="Select1">
     </asp:ObjectDataSource>
    <b>RFQ/PO:</b> <asp:Literal ID="litRFQPON" runat="server"></asp:Literal></td>
   </tr>
   <tr>
    <td><b>Part Number:</b> <asp:TextBox ID="txtPartNumberN" runat="server"></asp:TextBox></td>
    <td><b>Process:</b>
     <asp:DropDownList ID="ddlProcessIDN" runat="server" DataSourceID="odsProcessIDN" DataValueField="HID" DataTextField="Name" AutoPostBack="true" OnSelectedIndexChanged="ddlSelected" onchange="javascript:ddlCheck(this);" OnPreRender="ddlPreRender"></asp:DropDownList>
     <asp:ObjectDataSource ID="odsProcessIDN" runat="server" TypeName="myBiz.DAL.clsProcessType" SelectMethod="Select3">
      <SelectParameters><asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" /></SelectParameters>
     </asp:ObjectDataSource>
    </td>
   </tr>
   <tr>
    <td colspan="2">Dynamically loads </td>
   </tr>
   <tr>
    <td colspan="2">
     <table cellpadding="0" cellspacing="0" class="Tb2" width="100%">
      <tr class="BlueBar"><td><b>DESCRIPTION</b></td></tr>
      <tr><td><asp:TextBox ID="txtDescriptionN" runat="server" TextMode="MultiLine" Width="450px" Height="100px" /></td></tr>
     </table>
     <br />
     <table cellpadding="0" cellspacing="0" class="Tb2" width="100%">
      <tr class="BlueBar">
       <td class="Td2"><b>QTY</b></td>
       <td class="Td2"><b>UNIT</b></td>
       <td class="Td2"><b>UNIT PRICE</b></td>
       <td class="Td2"><b>AMOUNT</b></td>
       <td class="Td2"><b>LEAD TIME</b></td>
      </tr>
      <tr>
       <td class="Td2"><asp:TextBox ID="txtQtyN" runat="server" Width="50px" /></td>
       <td class="Td2">
        <asp:DropDownList ID="ddlUnitN" runat="server" DataSourceID="odsUnitN" DataValueField="mValue" DataTextField="mText"></asp:DropDownList>
        <asp:ObjectDataSource ID="odsUnitN" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
         <SelectParameters>
          <asp:Parameter Name="Cate" Type="String" DefaultValue="Unit" />
          <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
         </SelectParameters>
        </asp:ObjectDataSource>
       </td>
       <td class="Td2"><asp:TextBox ID="txtUnitPriceN" runat="server" Width="75px" /></td>
       <td class="Td2"><asp:TextBox ID="txtAmountN" runat="server" Width="75px" /></td>
       <td class="Td2"><asp:TextBox ID="txtLeadTimeN" runat="server" Width="50px" /></td>
      </tr>
     </table>
     <br />
     <table cellpadding="0" cellspacing="0" class="Tb2" width="100%">
      <tr>
       <td class="BlueBar"><b>VENDOR</b></td>
       <td>
        <asp:DropDownList ID="ddlVendorN" runat="server" DataSourceID="odsVendorN" DataValueField="HID" DataTextField="CompanyName" onchange="javascript:ddlVendorCheck(this);" OnPreRender="ddlVendorPreRender"></asp:DropDownList>
        <asp:ObjectDataSource ID="odsVendorN" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="Company_Select1">
         <SelectParameters>
          <asp:ControlParameter Name="TypeID" Type="String" ControlID="ddlProcessIDN" PropertyName="SelectedValue" />
         </SelectParameters>
        </asp:ObjectDataSource>
       </td>
      </tr>
     </table>
     <br />
     <table cellpadding="0" cellspacing="0" class="Tb2" width="100%">
      <tr class="BlueBar"><td><b>COMMENT</b></td></tr>
      <tr><td><asp:TextBox ID="txtCommentN" runat="server" TextMode="MultiLine" Width="450px" Height="100px" /></td></tr>
     </table>
    </td>
   </tr>
   <tr>
    <td colspan="2">
     <asp:Button ID="btnAddN" runat="server" Text="Save Data" OnClick="nData" CssClass="NavBtn" />
     <asp:Button ID="btnCloseN" runat="server" Text="Close Window" CssClass="NavBtn" />
     <MW:Message ID="jMsg" runat="server" />
     <asp:HiddenField ID="hfRFQPON" runat="server" />
    </td>
   </tr>
  </table>
  <ajax:ModalPopupExtender ID="mpeRFQPON" runat="server" TargetControlID="hfRFQPON" PopupControlID="tblRFQPON" BackgroundCssClass="mdlBackground"
   OkControlID="btnCloseN" DropShadow="false" RepositionMode="RepositionOnWindowResize" />
   
 <asp:ObjectDataSource ID="odsRFQPO" runat="server" TypeName="myBiz.DAL.clsTool" SelectMethod="RFQPO_Search">
  <SelectParameters>
   <asp:ControlParameter Name="PN" Type="String" ControlID="txtPartNumber" PropertyName="Text" />
   <asp:ControlParameter Name="Desc" Type="String" ControlID="txtDesc" PropertyName="Text" />
   <asp:ControlParameter Name="PO" Type="String" ControlID="txtPONumber" PropertyName="Text" />
   <asp:ControlParameter Name="RFQ" Type="String" ControlID="txtRFQNumber" PropertyName="Text" />
   <asp:Parameter Name="POID" Type="Int32" DefaultValue="0" />
   <asp:ControlParameter Name="VendorName" Type="String" ControlID="txtVendorName" PropertyName="Text" />
  </SelectParameters>
 </asp:ObjectDataSource>
