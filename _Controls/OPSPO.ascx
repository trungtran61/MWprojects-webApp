<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.OPSPO" Codebehind="OPSPO.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>PO FOR OPS</h3>
Please use this search form to find the specific quote with received data; then select the necessary item(s) to generate PO.<br /><br />
Please note that the system will automatically separate POs based on vendor(s).<br /><br />
<asp:Panel ID="pnlTask" runat="server" Enabled="false">
 <table class="SearchForm" cellspacing="5">
  <tr>
   <td><b>RFQ Number:</b><br /><asp:TextBox ID="txtRFQNumber" runat="server"></asp:TextBox></td>
   <td><b>Item Number:</b><br /><asp:TextBox ID="txtItemNo" runat="server"></asp:TextBox></td>
   <td><b>Vendor Name:</b><br /><asp:TextBox ID="txtVendorName" runat="server"></asp:TextBox></td>
   <td><b>Price:</b><br /><asp:TextBox ID="txtUnitPrice" runat="server"></asp:TextBox></td>
   <td><b>Lead Time:</b><br /><asp:TextBox ID="txtLeadTime" runat="server"></asp:TextBox></td>
   <td style="vertical-align:bottom"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="NavBtn" /></td>
  </tr>
 </table>
 <br />

 <asp:GridView ID="gvQuote" runat="server" AutoGenerateColumns="False" DataSourceID="odsQuote" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="None" DataKeyNames="HID,VendorID" AllowSorting="true">
  <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
  <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
  <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
  <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
  <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
  <Columns>
   <asp:TemplateField>
    <ItemTemplate>
     <asp:CheckBox ID="chkQuote" runat="server" Visible='<%# Convert.ToInt32(Eval("sCnt")) < 1 %>'/>
     <asp:Literal ID="litCnt" runat="server" Text='<%# Eval("sCnt") %>' Visible='<%# Convert.ToInt32(Eval("sCnt")) > 0 %>'></asp:Literal>
    </ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="RFQ Number" DataField="RFQNumber" SortExpression="RFQNumber" InsertVisible="false" />
   <asp:BoundField HeaderText="Item#" DataField="ItemNo" SortExpression="ItemNo" InsertVisible="false" />
   <asp:BoundField HeaderText="Description" DataField="Description" SortExpression="Description" InsertVisible="false" />
   <asp:BoundField HeaderText="Quantity" DataField="Qty" SortExpression="Qty" InsertVisible="false" />
   <asp:BoundField HeaderText="Unit" DataField="Unit" SortExpression="Unit" InsertVisible="false" />
   <asp:BoundField HeaderText="Unit Price" DataField="UnitPrice" SortExpression="UnitPrice" InsertVisible="false" />
   <asp:BoundField HeaderText="Amount" DataField="Amount" SortExpression="Amount" InsertVisible="false" />
   <asp:BoundField HeaderText="Lead Time" DataField="LeadTime" SortExpression="LeadTime" InsertVisible="false" />
   <asp:BoundField HeaderText="Vendor" DataField="VendorName" SortExpression="VendorName" InsertVisible="false" />
   <asp:BoundField HeaderText="Comment" DataField="Comment" SortExpression="Comment" InsertVisible="false" />
  </Columns>
  <EmptyDataTemplate>No quote is available to create PO for this work order</EmptyDataTemplate>
 </asp:GridView><br />
 <h3 style="color:red;">Balance: <asp:Literal ID="litBalance" runat="server"></asp:Literal></h3>
 <asp:Button ID="btnSubmit" runat="server" Text="Generate PO" OnClick="btnSubmit_Click" CssClass="NavBtn" />
 <br /><br />
 <asp:DropDownList ID="ddlPO" runat="server" DataSourceID="odsPO" DataTextField="PONumber" DataValueField="HID" AutoPostBack="true" OnDataBound="poBound" OnSelectedIndexChanged="poSelected" />
 <asp:Button ID="btnPreview" runat="server" Text="Preview" CssClass="NavBtn" Enabled="false" />
 <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="pEdit" CssClass="NavBtn" />
 <MW:Message ID="iMsg" runat="server" />
 <asp:HiddenField ID="hfEnforcedBalance" runat="server" />
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />

  <table id="tblPO" runat="server" class="mdlPopup">
   <tr><td><b>RFQ/PO:</b> <asp:Literal ID="litRFQPO" runat="server"></asp:Literal><br /></td></tr>
   <tr><td><b>Part Number:</b> <asp:Literal ID="litPartNumber" runat="server"></asp:Literal></td></tr>
   <tr>
    <td>
     <table cellpadding="0" cellspacing="0" class="Tb2" width="100%">
      <tr class="BlueBar"><td><b>DESCRIPTION</b></td></tr>
      <tr>
       <td>
        Type: <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="true" DataSourceID="odsTypeList" DataValueField="HID" DataTextField="OPSType" OnSelectedIndexChanged="pbKeepOpen" /><br />
        Spec#: <asp:DropDownList ID="ddlSpec" runat="server" AutoPostBack="true" DataSourceID="odsSpecList" DataValueField="HID" DataTextField="OPSSpec" OnSelectedIndexChanged="pbKeepOpen" /><br />
        Spec Desc: <asp:DropDownList ID="ddlDesc" runat="server" DataSourceID="odsDescList" DataValueField="HID" DataTextField="OPSDesc" /><br />
        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Width="450px" Height="100px" />
       </td>
      </tr>
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
       <td class="Td2"><asp:TextBox ID="txtUPrice" runat="server" Width="75px" /></td>
       <td class="Td2">
        <asp:Label ID="lblAmount" runat="server"></asp:Label>
        <asp:Label ID="lblTotal" runat="server"></asp:Label>
        <asp:LinkButton ID="lnkNumbers" runat="server" Text="&diams;" />
       </td>
       <td class="Td2"><asp:TextBox ID="txtLTime" runat="server" Width="50px" /></td>
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
       <td align="left"><asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="deletePO" OnClientClick="return confirm('Are you sure you want to delete?');" CssClass="NavBtn" /></td>
       <td align="right">
        <asp:Button ID="btnSave" runat="server" Text="Save Data" OnClick="sData" CssClass="NavBtn" />
        <asp:Button ID="btnClose" runat="server" Text="Close Window" CssClass="NavBtn" />
        <asp:HiddenField ID="hfHID" runat="server" Value="0" />
       </td>
      </tr>
     </table>
    </td>
   </tr>
  </table>
  <ajax:ModalPopupExtender ID="mpePO" runat="server" TargetControlID="hfHID" PopupControlID="tblPO" BackgroundCssClass="modalBackground"
   OkControlID="btnClose" DropShadow="false" RepositionMode="RepositionOnWindowResize" />

  <table id="tblNumbers" runat="server" class="modalPopup">
   <tr class="GrayBar"><td align="right"><b>Amount:</b></td><td><asp:TextBox ID="txtAmount" runat="server" Width="75px" /></td></tr>
   <tr class="GrayBar"><td align="right"><b>Freight:</b></td><td><asp:TextBox ID="txtFrieght" runat="server" Width="75px" /></td></tr>
   <tr class="GrayBar"><td align="right"><b>Misc:</b></td><td><asp:TextBox ID="txtMisc" runat="server" Width="75px" /></td></tr>
   <tr class="GrayBar"><td align="right"><b>Tax:</b></td><td><asp:TextBox ID="txtTax" runat="server" Width="75px" /></td></tr>
   <tr class="GrayBar"><td align="right"><b>Total:</b></td><td><asp:TextBox ID="txtTotal" runat="server" Width="75px" ReadOnly="true" /></td></tr>
   <tr>
    <td colspan="2" align="right"><asp:Button ID="btnNmOK" runat="server" Text="Close" CssClass="NavBtn" /></td>
   </tr>
  </table>
  <ajax:ModalPopupExtender ID="mpeNumbers" runat="server" TargetControlID="lnkNumbers" PopupControlID="tblNumbers" BackgroundCssClass="modalBackground"
   OkControlID="btnNmOK" DropShadow="false" RepositionMode="RepositionOnWindowResize" OnOkScript="doOK()" />

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
   window.radopen("File/Preview.aspx?FID=PO&Code=OPSPO&HID=" + id, "preview").maximize();
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
<asp:ObjectDataSource ID="odsQuote" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="Select_Quotes" InsertMethod="Insert_PO">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:ControlParameter Name="RFQNumber" Type="String" ControlID="txtRFQNumber" PropertyName="Text" />
  <asp:ControlParameter Name="ItemNo" Type="String" ControlID="txtItemNo" PropertyName="Text" />
  <asp:ControlParameter Name="VendorName" Type="String" ControlID="txtVendorName" PropertyName="Text" />
  <asp:ControlParameter Name="UnitPrice" Type="String" ControlID="txtUnitPrice" PropertyName="Text" />
  <asp:ControlParameter Name="LeadTime" Type="String" ControlID="txtLeadTime" PropertyName="Text" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </SelectParameters>
 <InsertParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:Parameter Name="QuoteID" Type="String" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </InsertParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsPO" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="Distinct_PO">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </SelectParameters>
</asp:ObjectDataSource>

 <asp:ObjectDataSource ID="odsRFQPO" runat="server" TypeName="myBiz.DAL.clsOPS" UpdateMethod="Quote_U1">
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="UnitPrice" Type="Decimal" />
   <asp:Parameter Name="Amount" Type="Decimal" />
   <asp:Parameter Name="Frieght" Type="Decimal" />
   <asp:Parameter Name="Misc" Type="Decimal" />
   <asp:Parameter Name="Tax" Type="Decimal" />
   <asp:Parameter Name="LeadTime" Type="Int32" />
   <asp:Parameter Name="OPSDescID" Type="Int32" />
   <asp:Parameter Name="Comment" Type="String" />
   <asp:Parameter Name="Description" Type="String" />
   <asp:Parameter Name="Qty" Type="Int32" />
   <asp:Parameter Name="Unit" Type="String" />
   <asp:Parameter Name="VendorID" Type="Int32" />
   <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
  </UpdateParameters>
 </asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsTypeList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Type_S">
 <SelectParameters><asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" /></SelectParameters>
</asp:ObjectDataSource>
       <asp:ObjectDataSource ID="odsSpecList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Spec_S">
        <SelectParameters>
         <asp:ControlParameter Name="OPSTypeID" Type="Int32" ControlID="ddlType" PropertyName="SelectedValue" />
         <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
        </SelectParameters>
       </asp:ObjectDataSource>
       <asp:ObjectDataSource ID="odsDescList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Desc_S">
        <SelectParameters>
         <asp:ControlParameter Name="OPSSpecID" Type="Int32" ControlID="ddlSpec" PropertyName="SelectedValue" />
         <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
        </SelectParameters>
       </asp:ObjectDataSource>
