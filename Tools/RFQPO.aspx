<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Tools.RFQPO" Title="Create RFQ/PO" Codebehind="RFQPO.aspx.cs" %>
<%@ Register Src="~/_Controls/ucNewRFQPO.ascx" TagName="ucNewRFQPO" TagPrefix="ucRFQPO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <h3>Create General RFQ/PO</h3>

<aspx:UpdatePanel ID="uPnlRFQPO" runat="server">
 <ContentTemplate>
 <asp:Button ID="btnRFQPON" runat="server" Text="Create RFQ/PO" CssClass="NavBtn" />
 <MW:Message ID="iMsg" runat="server" />
 <asp:Panel ID="pnlRFQPON" runat="server"><ucRFQPO:ucNewRFQPO ID="ucRFQPO" runat="server" /></asp:Panel>
 <ajax:CollapsiblePanelExtender ID="cpeRFQPON" runat="server" TargetControlID="pnlRFQPON" ExpandControlID="btnRFQPON" CollapseControlID="btnRFQPON" Collapsed="true" />
 <br /><br />
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
    <asp:TextBox ID="txt1PartNumber" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="acePartNumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txt1PartNumber">
    </ajax:AutoCompleteExtender>
   </td>
   <td><asp:TextBox ID="txt1Desc" runat="server"></asp:TextBox></td>
   <td>
    <asp:TextBox ID="txt1PONumber" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="acePONumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txt1PONumber" />
   </td>
   <td>
    <asp:TextBox ID="txt1RFQNumber" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="aceRFQNumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetRFQNumber" TargetControlID="txt1RFQNumber" />
   </td>
   <td><asp:TextBox ID="txt1VendorName" runat="server"></asp:TextBox></td>
   <td valign="bottom">
    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="NavBtn" />
    <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="doReset" CssClass="NavBtn" />
   </td>
  </tr>
 </table>
 </asp:Panel>
 <asp:GridView ID="gvRFQPO" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsRFQPO" OnRowCommand="gvCmd" OnRowDataBound="gvBound" PageSize="10">
  <Columns>
   <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
    <HeaderTemplate>
     <asp:DropDownList ID="ddlDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
      <asp:ListItem Text="10" Value="10"></asp:ListItem>
      <asp:ListItem Text="25" Value="25"></asp:ListItem>
      <asp:ListItem Text="50" Value="50"></asp:ListItem>
     </asp:DropDownList>
    </HeaderTemplate>
    <ItemTemplate>
     <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="pEdit" />
     <asp:LinkButton ID="lnkCopy" runat="server" Text="Copy" CommandName="Copy" CommandArgument='<%# Eval("HID") %>' />
     <asp:HiddenField ID="hfStatus" runat="server" Value='<%# Eval("Status") %>' />
    </ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Work Order" DataField="WorkOrder" SortExpression="WorkOrder" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="RFQ Number" SortExpression="RFQNumber" InsertVisible="false">
    <ItemTemplate>
     <asp:LinkButton ID="lnkRFQ" runat="server" Text='<%# Eval("RFQNumber") %>' OnClientClick='<%# string.Format("javascript:loadPreview(\"RFQ\",{0});return false;", Eval("HID")) %>'></asp:LinkButton>
    </ItemTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="PO Number" SortExpression="PONumber" InsertVisible="false">
    <ItemTemplate>
    <asp:LinkButton ID="lnkPO" runat="server" Text='<%# Eval("PONumber") %>' OnClientClick='<%# string.Format("javascript:loadPreview(\"PO\",{0});return false;", Eval("HID")) %>'></asp:LinkButton>
    <asp:HiddenField ID="hfFrieght" runat="server" Value='<%# Eval("Frieght") %>' />
    <asp:HiddenField ID="hfMisc" runat="server" Value='<%# Eval("Misc") %>' />
    <asp:HiddenField ID="hfTax" runat="server" Value='<%# Eval("Tax") %>' />
    <asp:HiddenField ID="hfTotal" runat="server" Value='<%# Eval("Total") %>' />
    </ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Process ID" DataField="ProcessName" SortExpression="ProcessName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Part Number" DataField="PartNumber" SortExpression="PartNumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:TemplateField HeaderText="Description" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
    <ItemTemplate><%# strTrim("Description") %>
     <asp:HiddenField ID="hfDescription" runat="server" Value='<%# Eval("Description") %>' />
     <asp:HiddenField ID="hfProcessID" runat="server" Value='<%# Eval("ProcessID") %>' />
    </ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Qty" DataField="Qty" SortExpression="Qty" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Unit" DataField="Unit" SortExpression="Unit" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Unit Price" DataField="UnitPrice" SortExpression="UnitPrice" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Amount" DataField="Amount" SortExpression="Amount" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Lead Time" DataField="LeadTime" SortExpression="LeadTime" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Vendor" DataField="CompanyName" SortExpression="CompanyName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
    <ItemTemplate>
     <a onclick="javascript:xPopup('../Note/Note.aspx?lDB=PO&lID=<%# Eval("xHID") %>');" class="Finger"><img src="../App_Themes/<%# Eval("NoteImg") %>" alt="Note" /></a>
     <asp:HiddenField ID="hfVendorID" runat="server" Value='<%# Eval("VendorID") %>' />
     <asp:HiddenField ID="hfxHID" runat="server" Value='<%# Eval("xHID") %>' />
    </ItemTemplate>
   </asp:TemplateField>
  </Columns>
 </asp:GridView>

  <table id="tblRFQPO" runat="server" class="mdlPopup">
   <tr><td><b>RFQ/PO:</b> <asp:Literal ID="litRFQPO" runat="server"></asp:Literal><br /></td></tr>
   <tr><td><b>Part Number:</b> <asp:Literal ID="litPartNumber" runat="server"></asp:Literal></td></tr>
   <tr>
    <td>
     <table cellpadding="0" cellspacing="0" class="Tb2" width="100%">
      <tr class="BlueBar"><td><b>DESCRIPTION</b></td></tr>
      <tr><td><asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Width="450px" Height="100px" /></td></tr>
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
       <td class="Td2"><asp:TextBox ID="txtQty" runat="server" Width="50px" /></td>
       <td class="Td2">
        <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="odsUnit" DataValueField="mValue" DataTextField="mText"></asp:DropDownList>
        <asp:ObjectDataSource ID="odsUnit" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
         <SelectParameters>
          <asp:Parameter Name="Cate" Type="String" DefaultValue="Unit" />
          <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
         </SelectParameters>
        </asp:ObjectDataSource>
       </td>
       <td class="Td2"><asp:TextBox ID="txtUnitPrice" runat="server" Width="75px" /></td>
       <td class="Td2">
        <asp:Label ID="lblAmount" runat="server"></asp:Label>
        <asp:Label ID="lblTotal" runat="server"></asp:Label>
        <asp:LinkButton ID="lnkNumbers" runat="server" Text="&diams;" />
       </td>
       <td class="Td2"><asp:TextBox ID="txtLeadTime" runat="server" Width="50px" /></td>
      </tr>
     </table>
     <br />
     <table cellpadding="0" cellspacing="0" class="Tb2" width="100%">
      <tr>
       <td class="BlueBar"><b>VENDOR</b></td>
       <td>
        <asp:DropDownList ID="ddlVendor" runat="server" DataSourceID="odsVendor" DataValueField="HID" DataTextField="CompanyName"></asp:DropDownList>
        <asp:ObjectDataSource ID="odsVendor" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="getCompanyList">
         <SelectParameters>
          <asp:Parameter Name="ClassName" Type="String" DefaultValue="Supplier" />
          <asp:ControlParameter Name="TypeID" Type="Int32" ControlID="hfPID" PropertyName="Value" />
          <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
         </SelectParameters>
        </asp:ObjectDataSource>
        <asp:HiddenField ID="hfPID" runat="server" />
       </td>
      </tr>
     </table>
     <br />
     <table cellpadding="0" cellspacing="0" class="Tb2" width="100%">
      <tr class="BlueBar"><td><b>COMMENT</b></td></tr>
      <tr><td><asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Width="450px" Height="100px" /></td></tr>
     </table>
    </td>
   </tr>
   <tr>
    <td align="center">
     <table width="100%">
      <tr>
       <td align="left"><asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="delRFQPO" OnClientClick="return confirm('Are you sure you want to delete?');" CssClass="NavBtn" /></td>
       <td align="right">
        <asp:Button ID="btnAdd" runat="server" Text="Save Data" OnClick="sData" CssClass="NavBtn" />
        <asp:Button ID="btnClose" runat="server" Text="Close Window" CssClass="NavBtn" />
        <asp:HiddenField ID="hfHID" runat="server" Value="0" />
        <asp:HiddenField ID="hfxHID" runat="server" />
       </td>
      </tr>
     </table>
    </td>
   </tr>
  </table>
  <ajax:ModalPopupExtender ID="mpeRFQPO" runat="server" TargetControlID="hfHID" PopupControlID="tblRFQPO" BackgroundCssClass="mdlBackground"
   OkControlID="btnClose" DropShadow="false" RepositionMode="RepositionOnWindowResize" />

  <table id="tblNumbers" runat="server" class="mdlPopup">
   <tr class="GrayBar"><td align="right"><b>Amount:</b></td><td><asp:TextBox ID="txtAmount" runat="server" Width="75px" /></td></tr>
   <tr class="GrayBar"><td align="right"><b>Freight:</b></td><td><asp:TextBox ID="txtFrieght" runat="server" Width="75px" /></td></tr>
   <tr class="GrayBar"><td align="right"><b>Misc:</b></td><td><asp:TextBox ID="txtMisc" runat="server" Width="75px" /></td></tr>
   <tr class="GrayBar"><td align="right"><b>Tax:</b></td><td><asp:TextBox ID="txtTax" runat="server" Width="75px" /></td></tr>
   <tr class="GrayBar"><td align="right"><b>Total:</b></td><td><asp:TextBox ID="txtTotal" runat="server" Width="75px" ReadOnly="true" /></td></tr>
   <tr>
    <td colspan="2" align="right"><asp:Button ID="btnNmOK" runat="server" Text="Close" CssClass="NavBtn" /></td>
   </tr>
  </table>
  <ajax:ModalPopupExtender ID="mpeNumbers" runat="server" TargetControlID="lnkNumbers" PopupControlID="tblNumbers" BackgroundCssClass="mdlBackground"
   OkControlID="btnNmOK" DropShadow="false" RepositionMode="RepositionOnWindowResize" OnOkScript="doOK()" />
  <asp:HiddenField ID="hfNoClick" runat="server" />
 </ContentTemplate>
</aspx:UpdatePanel>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadPreview(fid,id)
  {
   window.radopen("../File/Preview.aspx?FID=" + fid + "&Code=Tool&HID=" + id, "mPopup").maximize();
  }
  function doOK()
  {
   var amt = Number(document.getElementById('<%= txtAmount.ClientID %>').value);
   var frieght = Number(document.getElementById('<%= txtFrieght.ClientID %>').value);
   var misc = Number(document.getElementById('<%= txtMisc.ClientID %>').value);
   var tax = Number(document.getElementById('<%= txtTax.ClientID %>').value);
   var tt = amt + frieght + misc + tax;
   
   document.getElementById('<%= txtTotal.ClientID %>').value = tt;
   document.getElementById('<%= lblAmount.ClientID %>').innerHTML = '[' + amt + ']';
   document.getElementById('<%= lblTotal.ClientID %>').innerHTML = '[' + tt + ']';
  }
 </script>
</telerik:RadCodeBlock>
<asp:HiddenField ID="hfUID" runat="server" />

 <asp:ObjectDataSource ID="odsRFQPO" runat="server" TypeName="myBiz.DAL.clsTool" SelectMethod="RFQPO_Select" UpdateMethod="RFQPO_Update">
  <SelectParameters>
   <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
   <asp:ControlParameter Name="PN" Type="String" ControlID="txt1PartNumber" PropertyName="Text" />
   <asp:ControlParameter Name="Desc" Type="String" ControlID="txt1Desc" PropertyName="Text" />
   <asp:ControlParameter Name="RN" Type="String" ControlID="txt1RFQNumber" PropertyName="Text" />
   <asp:ControlParameter Name="PO" Type="String" ControlID="txt1PONumber" PropertyName="Text" />
   <asp:ControlParameter Name="CN" Type="String" ControlID="txt1VendorName" PropertyName="Text" />
  </SelectParameters>
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="Description" Type="String" />
   <asp:Parameter Name="Qty" Type="Int32" />
   <asp:Parameter Name="Unit" Type="String" />
   <asp:Parameter Name="UnitPrice" Type="Decimal" />
   <asp:Parameter Name="Amount" Type="Decimal" />
   <asp:Parameter Name="Frieght" Type="Decimal" />
   <asp:Parameter Name="Misc" Type="Decimal" />
   <asp:Parameter Name="Tax" Type="Decimal" />
   <asp:Parameter Name="LeadTime" Type="Int32" />
   <asp:Parameter Name="VendorID" Type="Int32" />
  </UpdateParameters>
 </asp:ObjectDataSource>

 <asp:ObjectDataSource ID="odsChatLog" runat="server" TypeName="myBiz.DAL.clsChatLog" InsertMethod="ChatLog_Save">
  <InsertParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="GrpIDs" Type="String" />
   <asp:Parameter Name="LnkDB" Type="String" DefaultValue="PO" />
   <asp:Parameter Name="LnkID" Type="Int32" />
   <asp:ControlParameter Name="ChatBy" Type="String" ControlID="hfUID" PropertyName="Value" />
   <asp:Parameter Name="Note" Type="String" />
  </InsertParameters>
 </asp:ObjectDataSource>
</asp:Content>