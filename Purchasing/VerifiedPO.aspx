<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Purchasing.VerifiedPO" Title="Enter Bills" Codebehind="VerifiedPO.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" Runat="Server">
<aspx:UpdatePanel ID="uPnlPO" runat="server">
 <ContentTemplate>
  <asp:Panel ID="pnlBilledPO" runat="server" DefaultButton="btnBilledS">
   <table>
    <tr>
     <td><b>PO Number:</b></td>
     <td><b>Invoice#:</b></td>
     <td><b>Vendor:</b></td>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td>
      <asp:TextBox ID="txtBilledPO" runat="server"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="aceBilledPO" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtBilledPO" />
     </td>
     <td><asp:TextBox ID="txtBilledInvoice" runat="server" Width="75px"></asp:TextBox></td>
     <td><asp:TextBox ID="txtBilledSupplier" runat="server"></asp:TextBox></td>
     <td valign="bottom">
      <asp:Button ID="btnBilledS" runat="server" Text="Search" CssClass="NavBtn" />
      <asp:Button ID="btnBilledR" runat="server" Text="Reset" CssClass="NavBtn" OnClientClick="javascript:billReset(); return false;" />
     </td>
    </tr>
   </table>
  </asp:Panel>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">BILLS HAVE BEEN RECEIVED <asp:Literal ID="litBilledCnt" runat="server" /></td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvBilledPO" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsBilledPO" OnDataBound="dataBound" OnRowCommand="gvCmd" OnRowDataBound="rwBound" PageSize="10">
      <Columns>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
        <HeaderTemplate>
         <asp:DropDownList ID="ddlBilledDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
          <asp:ListItem Text="10" Value="10"></asp:ListItem>
          <asp:ListItem Text="20" Value="20"></asp:ListItem>
          <asp:ListItem Text="30" Value="30"></asp:ListItem>
          <asp:ListItem Text="All" Value="5000"></asp:ListItem>
         </asp:DropDownList>
        </HeaderTemplate>
        <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Approved By" DataField="AprvBy" SortExpression="AprvBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="AprvDate" SortExpression="AprvDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="PO #" SortExpression="PONumber" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkPONumber" runat="server" Text='<%# Eval("PONumber") %>' OnClientClick='<%# string.Format("javascript:loadPreview(\"{0}\");return false;", Eval("POLink")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Ordered Qty" SortExpression="Qty">
        <ItemTemplate><%# Eval("Qty") %> <%# Eval("Unit") %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Received Qty">
        <ItemTemplate><%# clsCnt() %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Price" DataField="UnitPrice" SortExpression="UnitPrice" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Total Amount" SortExpression="Total">
        <ItemTemplate>[<%# Eval("Amount") %>][<%# Eval("Total") %>]</ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Bill Amount($)" DataField="BillAmt" SortExpression="BillAmt" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Invoices #" SortExpression="InvoiceNo">
        <ItemTemplate>
         <asp:LinkButton ID="lnkDLInvoice" runat="server" Text="&diams;" CommandName="bInvoice" ToolTip="View Invoice" />
         <%# Eval("InvoiceNo") %>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Expenses Acct." DataField="ExpAcct" SortExpression="ExpAcct" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Pay Bill Due Date" SortExpression="PaidDD">
        <ItemTemplate><%# gDD("PaidDD") %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Supplier" SortExpression="VendorName">
        <ItemTemplate><%# gVdrName() %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate>
         <a onclick="javascript:xPopup('../Note/Note.aspx?lDB=PO&lID=<%# Eval("HID") %>');" class="Finger"><img src="../App_Themes/<%# Eval("NoteImg") %>" alt="Note" /></a>
        </ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No bills have been received!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  <br />
  <asp:Button ID="btnUndo" runat="server" Text="Undo" OnClick="doUndo" CssClass="NavBtn" />
  <br /><hr />
 
  <asp:Panel ID="pnlVerifiedPO" runat="server" DefaultButton="btnVerifiedS">
   <table>
    <tr>
     <td><b>PO Number:</b></td>
     <td><b>Invoice#:</b></td>
     <td><b>Vendor:</b></td>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td>
      <asp:TextBox ID="txtVerifiedPO" runat="server"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="aceVerifiedPO" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtVerifiedPO" />
     </td>
     <td><asp:TextBox ID="txtVerifiedInvoice" runat="server" Width="75px"></asp:TextBox></td>
     <td><asp:TextBox ID="txtVerifiedSupplier" runat="server"></asp:TextBox></td>
     <td valign="bottom">
      <asp:Button ID="btnVerifiedS" runat="server" Text="Search" CssClass="NavBtn" />
      <asp:Button ID="btnVerifiedR" runat="server" Text="Reset" CssClass="NavBtn" OnClientClick="javascript:veriReset(); return false;" />
     </td>
    </tr>
   </table>
  </asp:Panel>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">BILLS NEED TO BE RECEIVED <asp:Literal ID="litVerifiedCnt" runat="server" /></td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvVerifiedPO" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsVerifiedPO" OnRowDataBound="gvBound" OnRowCommand="gvCmd" OnDataBound="dataBound" PageSize="10">
      <Columns>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
        <HeaderTemplate>
         <asp:DropDownList ID="ddlVerifiedDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
          <asp:ListItem Text="10" Value="10"></asp:ListItem>
          <asp:ListItem Text="20" Value="20"></asp:ListItem>
          <asp:ListItem Text="30" Value="30"></asp:ListItem>
          <asp:ListItem Text="All" Value="5000"></asp:ListItem>
         </asp:DropDownList>
        </HeaderTemplate>
        <ItemTemplate>
         <asp:CheckBox ID="chkItem" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("isBilled").ToString()) %>' />
         <%# Eval("isBilled") %>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Verified By" DataField="VerifiedBy" SortExpression="VerifiedBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="VerifiedDate" SortExpression="VerifiedDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="PO #" SortExpression="PONumber" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkPONumber" runat="server" Text='<%# Eval("PONumber") %>' OnClientClick='<%# string.Format("javascript:loadPreview(\"{0}\");return false;", Eval("POLink")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Ordered Qty" SortExpression="Qty">
        <ItemTemplate><%# Eval("Qty") %> <%# Eval("Unit") %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Received Qty">
        <ItemTemplate><%# clsCnt() %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Price" DataField="UnitPrice" SortExpression="UnitPrice" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Total Amount" SortExpression="Total">
        <ItemTemplate>[<%# Eval("Amount") %>]<span style="color:Orange">[<%# Eval("Total") %>]</span></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Bill Amount($)" SortExpression="BillAmt">
        <ItemTemplate>
         <asp:LinkButton ID="lnkEdit" runat="server" Text="&diams;" CommandName="pEdit" />
         <asp:Literal ID="litBillAmt" runat="server" Text='<%# Eval("BillAmt") %>'></asp:Literal>
         <asp:HiddenField ID="hfDefAcct" runat="server" Value='<%# Eval("DefAcct") %>' />
         <asp:HiddenField ID="hfExpAcct" runat="server" Value='<%# Eval("ExpAcct") %>' />
        </ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Invoices #" SortExpression="InvoiceNo">
        <ItemTemplate>
         <asp:LinkButton ID="lnkULInvoice" runat="server" Text="&diams;" CommandName="uInvoice" ToolTip="Upload Invoice" />
         <asp:LinkButton ID="lnkDLInvoice" runat="server" Text="&diams;" CommandName="dInvoice" ToolTip="View Invoice" />
         <%# Eval("InvoiceNo") %>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Expenses Acct." DataField="tExpAcct" SortExpression="tExpAcct" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Enter Bill Due Date" SortExpression="AprvDD">
        <ItemTemplate><%# gDD("AprvDD") %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Supplier" SortExpression="VendorName">
        <ItemTemplate><%# gVdrName() %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate>
         <a onclick="javascript:xPopup('../Note/Note.aspx?lDB=PO&lID=<%# Eval("HID") %>');" class="Finger"><img src="../App_Themes/<%# Eval("NoteImg") %>" alt="Note" /></a>
        </ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No vendor invoices are waiting to be verified!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  <br />
  <asp:Button ID="btnApprove" runat="server" Text="Approve" OnClick="doApprove" CssClass="NavBtn" /><br />
  P: Unit Price is needed.<br />
  A: Bill Amount must equal to Total Amount (Organge).<br />
  Q: Ordered Qty must equal to Good Received Qty (Blue).<br />
  I: Invoice(s) need to be uploaded.<br />
  T: Term is needed.<br />
  C: Credit Card payment option is needed.<br />

  <MW:Message ID="iMsg" runat="server" />

  <table id="tblVerifiedPO" runat="server" class="mdlPopup">
   <tr>
    <td>
     <table cellpadding="0" cellspacing="0" class="Tb2" width="100%">
      <tr>
       <td class="BlueBar"><b>PO Number:</b></td>
       <td><asp:Literal ID="litPONumber" runat="server" /></td>
      </tr>
      <tr>
       <td class="BlueBar"><b>Bill Amount:</b></td>
       <td><asp:TextBox ID="txtBillAmt" runat="server" Width="75px"></asp:TextBox></td>
      </tr>
      <tr>
       <td class="BlueBar"><b>Invoices #:</b></td>
       <td><asp:TextBox ID="txtInvoiceNo" runat="server" Width="75px"></asp:TextBox></td>
      </tr>
      <tr>
       <td class="BlueBar"><b>Expense Account:</b></td>
       <td><asp:DropDownList ID="ddlExpAcct" runat="server" DataTextField="mText" DataValueField="mValue"></asp:DropDownList></td>
      </tr>
     </table>
    </td>
   </tr>
   <tr>
    <td>
     <asp:Button ID="btnAdd" runat="server" Text="Save Data" OnClick="sData" CssClass="NavBtn" />
     <asp:Button ID="btnClose" runat="server" Text="Close Window" CssClass="NavBtn" />
     <MW:Message ID="jMsg" runat="server" />
     <asp:HiddenField ID="hfHID" runat="server" Value="0" />
    </td>
   </tr>
  </table>
  <ajax:ModalPopupExtender ID="mpeVerifiedPO" runat="server" TargetControlID="hfHID" PopupControlID="tblVerifiedPO" BackgroundCssClass="mdlBackground"
   OkControlID="btnClose" DropShadow="false" RepositionMode="RepositionOnWindowResize" />
 </ContentTemplate>
</aspx:UpdatePanel>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadPreview(id)
  {
   window.radopen("../File/Preview.aspx?FID=PO&Code=GeneralPO&HID=" + id, "mPopup").maximize();
  }
  function billReset(){
   document.getElementById('<%= txtBilledPO.ClientID %>').value = '';
   document.getElementById('<%= txtBilledInvoice.ClientID %>').value = '';
   document.getElementById('<%= txtBilledSupplier.ClientID %>').value = '';   
  }
  function veriReset(){
   document.getElementById('<%= txtVerifiedPO.ClientID %>').value = '';
   document.getElementById('<%= txtVerifiedInvoice.ClientID %>').value = '';
   document.getElementById('<%= txtVerifiedSupplier.ClientID %>').value = '';
  }
 </script>
</telerik:RadCodeBlock>

<asp:HiddenField ID="hfUID" runat="server" />
<asp:HiddenField ID="hfValx" runat="server" />
<asp:ObjectDataSource ID="odsBilledPO" runat="server" TypeName="myBiz.DAL.clsPO" SelectMethod="Select" UpdateMethod="Billed_U">
 <SelectParameters>
  <asp:ControlParameter Name="xHID" Type="String" ControlID="hfValx" PropertyName="Value" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Billed" />
  <asp:Parameter Name="PN" Type="String" />
  <asp:ControlParameter Name="PO" Type="String" ControlID="txtBilledPO" PropertyName="Text" />
  <asp:ControlParameter Name="Supplier" Type="String" ControlID="txtBilledSupplier" PropertyName="Text" />
  <asp:ControlParameter Name="Invoice" Type="String" ControlID="txtBilledInvoice" PropertyName="Text" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:Parameter Name="lMode" Type="String" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="UN" Type="String" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Verified" />
 </UpdateParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsVerifiedPO" runat="server" TypeName="myBiz.DAL.clsPO" SelectMethod="Select" UpdateMethod="Billed_U" InsertMethod="Billed_Save">
 <SelectParameters>
  <asp:ControlParameter Name="xHID" Type="String" ControlID="hfValx" PropertyName="Value" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Verified" />
  <asp:Parameter Name="PN" Type="String" />
  <asp:ControlParameter Name="PO" Type="String" ControlID="txtVerifiedPO" PropertyName="Text" />
  <asp:ControlParameter Name="Supplier" Type="String" ControlID="txtVerifiedSupplier" PropertyName="Text" />
  <asp:ControlParameter Name="Invoice" Type="String" ControlID="txtVerifiedInvoice" PropertyName="Text" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
 </SelectParameters>
 <UpdateParameters>
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Billed" />
 </UpdateParameters>
 <InsertParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="BillAmt" Type="Decimal" />
  <asp:Parameter Name="InvoiceNo" Type="String" />
  <asp:Parameter Name="ExpAcct" Type="String" />
 </InsertParameters>
</asp:ObjectDataSource>
</asp:Content>