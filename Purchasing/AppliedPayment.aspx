<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Purchasing.AppliedPayment" Title="Apply Payments" Codebehind="AppliedPayment.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
<aspx:UpdatePanel ID="uPnlPO" runat="server">
 <ContentTemplate>  
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center"><b>RECEIVED PAYMENTS</b></td>
   </tr>
   <tr>
    <td>
   <asp:GridView ID="gvChecks" runat="server" SkinID="GrayHeader" DataKeyNames="FileID" DataSourceID="odsChecks" OnRowCommand="gvCmd">
    <Columns>
     <asp:TemplateField HeaderText="#" SortExpression="CheckID">
      <ItemTemplate>
       <asp:LinkButton ID="lnkSelect" runat="server" Text='<%# Eval("CheckID") %>' CommandName="Select" />
      </ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="File Name" SortExpression="FName">
      <ItemTemplate>
       <asp:LinkButton ID="lnkView" runat="server" Text='<%# Eval("FName") %>' CommandName="pView" CommandArgument='<%# Eval("CheckID") %>' />
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Received By" DataField="ModifiedBy" SortExpression="ModifiedBy" />
     <asp:BoundField HeaderText="Date" DataField="Modified" SortExpression="Modified" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" />
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Apply Payment Due Date" SortExpression="DueDate">
      <ItemTemplate><%# gDD("DueDate") %></ItemTemplate>
     </asp:TemplateField>
    </Columns>
   </asp:GridView>
   <asp:ObjectDataSource ID="odsChecks" runat="server" TypeName="myBiz.DAL.clsFile" SelectMethod="CheckImage_S">
    <SelectParameters><asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="xMode" /></SelectParameters>
   </asp:ObjectDataSource>
    </td>
   </tr>
  </table>
<br />
  <asp:Panel ID="pnlUnpaid" runat="server" DefaultButton="btnUnpaidS">
   <table>
    <tr>
     <td><b>Customer Name:</b></td>
     <td><b>Invoice#:</b></td>
     <td><b>Customer PO#:</b></td>
     <td><b>Date From:</b></td>
     <td><b>Date To:</b></td>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td><asp:TextBox ID="txtUnpaidCustomer" runat="server"></asp:TextBox></td>
     <td><asp:TextBox ID="txtUnpaidInvoice" runat="server" Width="75px"></asp:TextBox></td>
     <td><asp:TextBox ID="txtUnpaidCustomerPO" runat="server" Width="100px"></asp:TextBox></td>
     <td><asp:TextBox ID="txtDDf" runat="server" Width="75px"></asp:TextBox>
      <ajax:CalendarExtender ID="calDDf" runat="server" TargetControlID="txtDDf" Format="MM/dd/yy" />
     </td>
     <td><asp:TextBox ID="txtDDt" runat="server" Width="75px"></asp:TextBox>
      <ajax:CalendarExtender ID="calDDt" runat="server" TargetControlID="txtDDt" Format="MM/dd/yy" />
     </td>
     <td valign="bottom">
      <asp:Button ID="btnUnpaidS" runat="server" Text="Search" CssClass="NavBtn" />
      <asp:Button ID="btnUnpaidR" runat="server" Text="Reset" CssClass="NavBtn" OnClientClick="javascript:unpaidReset(); return false;" />
      <asp:HyperLink ID="lnkIncExp" runat="server" Text="Income/Expense Report" NavigateUrl="~/Purchasing/IncExp.aspx"></asp:HyperLink>
      <asp:HyperLink ID="lnkExpAcct" runat="server" Text="Expense Account Report" NavigateUrl="~/Reports/ExpAcct.aspx"></asp:HyperLink>
     </td>
    </tr>
   </table>
  </asp:Panel>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;"><span id="lblUnpaidCnt" style="float:left;">0</span>UNPAID INVOICES
     <asp:Literal ID="litCount" runat="server"></asp:Literal>
     <asp:Label ID="showTotal" runat="server" Text="$" onclick="javascript:toggleTotal();" CssClass="Finger" Visible="false"></asp:Label>
     <span id="xTotal" style="display:none"><asp:Literal ID="litTotal" runat="server"></asp:Literal></span>
     <asp:Label ID="showAPTotal" runat="server" Text="$" onclick="javascript:toggleAPTotal();" CssClass="Finger" Visible="false"></asp:Label>
     <span id="xAPTotal" style="display:none"><asp:Literal ID="litAPTotal" runat="server"></asp:Literal></span>
     <asp:Label ID="showOATotal" runat="server" Text="$" onclick="javascript:toggleOATotal();" CssClass="Finger" Visible="false"></asp:Label>
     <span id="xOATotal" style="display:none"><asp:Literal ID="litOATotal" runat="server"></asp:Literal></span>
    </td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvUnpaid" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsUnpaid" OnRowDataBound="rwBound" PageSize="5" AllowSorting="false">
      <Columns>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
        <HeaderTemplate>
         <asp:DropDownList ID="ddlUnpaidDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
          <asp:ListItem Text="5" Value="5"></asp:ListItem>
          <asp:ListItem Text="10" Value="10"></asp:ListItem>
          <asp:ListItem Text="25" Value="25"></asp:ListItem>
          <asp:ListItem Text="50" Value="50"></asp:ListItem>
          <asp:ListItem Text="All" Value="5000"></asp:ListItem>
         </asp:DropDownList>
        </HeaderTemplate>
        <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /><asp:HiddenField ID="hfDollar" runat="server" Value='<%# Eval("Amount") %>' /></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Sent By" DataField="BillBy" SortExpression="BillBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="BillDate" SortExpression="BillDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Invoice #" SortExpression="PackNum" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkPackNum" runat="server" Text='<%# Eval("PackNum") %>' OnClientClick='<%# string.Format("javascript:loadPreview({0});return false;", Eval("HID")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Amount ($)" SortExpression="Amount">
        <ItemTemplate><%# gAmt() %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer PO#" DataField="CustomerPO" SortExpression="CustomerPO" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Invoice Due Date" SortExpression="InvoiceDD">
        <ItemTemplate><%# gDD("InvoiceDD") %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate>
         <a onclick="javascript:xPopup('../Note/Note.aspx?lDB=WorkOrder&lID=<%# Eval("WorkOrderID") %>');" class="Finger"><img src="../App_Themes/<%# Eval("NoteImg") %>" alt="Note" /></a>
        </ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No Invoice has been billed!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  <br />
  <br />
  <b>Check #:</b> <asp:TextBox ID="txtCheckNo" runat="server"></asp:TextBox><span style="color:Red">*</span>
  <asp:Button ID="btnApplyPay" runat="server" Text="Apply Payment" OnClick="doApply" CssClass="NavBtn" />

  <hr />

  <asp:Panel ID="pnlPaid" runat="server" DefaultButton="btnPaidS">
   <table>
    <tr>
     <td><b>Customer Name:</b></td>
     <td><b>Invoice #:</b></td>
     <td><b>Customer PO#:</b></td>
     <td><b>Check #:</b></td>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td><asp:TextBox ID="txtPaidCustomer" runat="server"></asp:TextBox></td>
     <td><asp:TextBox ID="txtPaidInvoice" runat="server" Width="75px"></asp:TextBox></td>
     <td><asp:TextBox ID="txtPaidCustomerPO" runat="server" Width="100px"></asp:TextBox></td>
     <td><asp:TextBox ID="txtPaidCheckNo" runat="server" Width="75px"></asp:TextBox></td>
     <td valign="bottom">
      <asp:Button ID="btnPaidS" runat="server" Text="Search" CssClass="NavBtn" />
      <asp:Button ID="btnPaidR" runat="server" Text="Reset" CssClass="NavBtn" OnClientClick="javascript:paidReset(); return false;" />
      <asp:Button ID="btnExportS" runat="server" Text="Export" CssClass="NavBtn" OnClick="doExport" />
     </td>
    </tr>
   </table>
  </asp:Panel>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;"><span id="lblPaidCnt" style="float:left;">0</span>UNRECONCILED PAID INVOICES
     <asp:Literal ID="litPaidCnt" runat="server"></asp:Literal>
     <asp:Label ID="showPaidTotal" runat="server" Text="$" onclick="javascript:togglePaidTotal();" CssClass="Finger" Visible="false"></asp:Label>
     <span id="xPaidTotal" style="display:none"><asp:Literal ID="litPaidTotal" runat="server"></asp:Literal></span>
    </td>
    <td align="right" style="font-weight:bold;">[<asp:Literal ID="litChkCnt" runat="server"></asp:Literal>]</td>
   </tr>
   <tr>
    <td colspan="2">
     <asp:GridView ID="gvPaid" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsPaid" OnRowDataBound="rwBound" PageSize="5" AllowSorting="false">
      <Columns>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
        <HeaderTemplate>
         <asp:DropDownList ID="ddlPaidDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
          <asp:ListItem Text="5" Value="5"></asp:ListItem>
          <asp:ListItem Text="10" Value="10"></asp:ListItem>
          <asp:ListItem Text="25" Value="25"></asp:ListItem>
          <asp:ListItem Text="50" Value="50"></asp:ListItem>
          <asp:ListItem Text="All" Value="5000"></asp:ListItem>
         </asp:DropDownList>
        </HeaderTemplate>
        <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /><asp:HiddenField ID="hfDollar" runat="server" Value='<%# Eval("Amount") %>' /></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Applied By" DataField="AppliedBy" SortExpression="AppliedBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="AppliedDate" SortExpression="AppliedDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Invoice #" SortExpression="PackNum" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkPackNum" runat="server" Text='<%# Eval("PackNum") %>' OnClientClick='<%# string.Format("javascript:loadPreview({0});return false;", Eval("HID")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Amount ($)" SortExpression="Amount">
        <ItemTemplate><%# gAmt() %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer PO#" DataField="CustomerPO" SortExpression="CustomerPO" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Check #" SortExpression="CheckNo" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkCheck" runat="server" Text='<%# Eval("CheckNo") %>' OnClientClick='<%# string.Format("javascript:loadFile({0});return false;", Eval("FileID")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate>
         <a onclick="javascript:xPopup('../Note/Note.aspx?lDB=WorkOrder&lID=<%# Eval("WorkOrderID") %>');" class="Finger"><img src="../App_Themes/<%# Eval("NoteImg") %>" alt="Note" /></a>
        </ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No invoice has been paid!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  <br />
  <asp:Button ID="btnUndo" runat="server" Text="Undo Payment" OnClick="doUndo" CssClass="NavBtn" />
  <asp:Button ID="btnRecon" runat="server" Text="Reconcile &darr;" OnClick="doRecon" CssClass="NavBtn" />

  <hr />

  <asp:Panel ID="pnlRPaid" runat="server" DefaultButton="btnRPaidS">
   <table>
    <tr>
     <td><b>Customer Name:</b></td>
     <td><b>Invoice #:</b></td>
     <td><b>Customer PO#:</b></td>
     <td><b>Check #:</b></td>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td><asp:TextBox ID="txtRPaidCustomer" runat="server"></asp:TextBox></td>
     <td><asp:TextBox ID="txtRPaidInvoice" runat="server" Width="75px"></asp:TextBox></td>
     <td><asp:TextBox ID="txtRPaidCustomerPO" runat="server" Width="100px"></asp:TextBox></td>
     <td><asp:TextBox ID="txtRPaidCheckNo" runat="server" Width="75px"></asp:TextBox></td>
     <td valign="bottom">
      <asp:Button ID="btnRPaidS" runat="server" Text="Search" CssClass="NavBtn" />
      <asp:Button ID="btnRPaidR" runat="server" Text="Reset" CssClass="NavBtn" OnClientClick="javascript:RpaidReset(); return false;" />
     </td>
    </tr>
   </table>
  </asp:Panel>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">RECONCILED PAID INVOICES
     <asp:Literal ID="litRPaidCnt" runat="server"></asp:Literal>
     <asp:Label ID="showRPaidTotal" runat="server" Text="$" onclick="javascript:toggleRPaidTotal();" CssClass="Finger" Visible="false"></asp:Label>
     <span id="xRPaidTotal" style="display:none"><asp:Literal ID="litRPaidTotal" runat="server"></asp:Literal></span>
    </td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvRPaid" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsRPaid" OnRowDataBound="rwRBound" PageSize="5" AllowSorting="false">
      <Columns>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
        <HeaderTemplate>
         <asp:DropDownList ID="ddlRPaidDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
          <asp:ListItem Text="5" Value="5"></asp:ListItem>
          <asp:ListItem Text="10" Value="10"></asp:ListItem>
          <asp:ListItem Text="25" Value="25"></asp:ListItem>
          <asp:ListItem Text="50" Value="50"></asp:ListItem>
          <asp:ListItem Text="All" Value="5000"></asp:ListItem>
         </asp:DropDownList>
        </HeaderTemplate>
        <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Applied By" DataField="AppliedBy" SortExpression="AppliedBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="AppliedDate" SortExpression="AppliedDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Invoice #" SortExpression="PackNum" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkPackNum" runat="server" Text='<%# Eval("PackNum") %>' OnClientClick='<%# string.Format("javascript:loadPreview({0});return false;", Eval("HID")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Amount ($)" SortExpression="Amount">
        <ItemTemplate><%# gAmt() %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer PO#" DataField="CustomerPO" SortExpression="CustomerPO" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Check #" SortExpression="CheckNo" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkCheck" runat="server" Text='<%# Eval("CheckNo") %>' OnClientClick='<%# string.Format("javascript:loadFile({0});return false;", Eval("FileID")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate>
         <a onclick="javascript:xPopup('../Note/Note.aspx?lDB=WorkOrder&lID=<%# Eval("WorkOrderID") %>');" class="Finger"><img src="../App_Themes/<%# Eval("NoteImg") %>" alt="Note" /></a>
        </ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>Please enter something to search!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  <br />
  <asp:Button ID="btnUnRecon" runat="server" Text="UnReconcile &uarr;" OnClick="doUnRecon" CssClass="NavBtn" />

  <asp:Panel ID="pnlPopup" runat="server" />
  <MW:Message ID="iMsg" runat="server" />
 </ContentTemplate>
 <Triggers>
  <aspx:PostBackTrigger ControlID="btnExportS" />
 </Triggers>
</aspx:UpdatePanel>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadPreview(id)
  {
   window.radopen("../File/Preview.aspx?FID=Invoice&Code=Invoice&HID=" + id, "mPopup").maximize();
  }
  function loadFile(id)
  {
   window.radopen("../File/ShowImage.aspx?FileID=" + id, "mPopup");
  }
  function toggleTotal() {
   var tt = document.getElementById('xTotal');
   if (tt.style.display=='none') tt.style.display='inline';
   else tt.style.display='none';
  }
  function toggleAPTotal() {
   var tt = document.getElementById('xAPTotal');
   if (tt.style.display=='none') tt.style.display='inline';
   else tt.style.display='none';
  }
  function toggleOATotal() {
   var tt = document.getElementById('xOATotal');
   if (tt.style.display=='none') tt.style.display='inline';
   else tt.style.display='none';
  }
  function togglePaidTotal() {
   var tt = document.getElementById('xPaidTotal');
   if (tt.style.display=='none') tt.style.display='inline';
   else tt.style.display='none';
  }
  function toggleRPaidTotal() {
   var tt = document.getElementById('xRPaidTotal');
   if (tt.style.display == 'none') tt.style.display = 'inline';
   else tt.style.display = 'none';
  }
  function unpaidReset() {
   document.getElementById('<%= txtUnpaidCustomer.ClientID %>').value = '';
   document.getElementById('<%= txtUnpaidInvoice.ClientID %>').value = '';
   document.getElementById('<%= txtUnpaidCustomerPO.ClientID %>').value = '';
   document.getElementById('<%= txtDDf.ClientID %>').value = '';
   document.getElementById('<%= txtDDt.ClientID %>').value = '';
  }
  function paidReset() {
   document.getElementById('<%= txtPaidCustomer.ClientID %>').value = '';
   document.getElementById('<%= txtPaidInvoice.ClientID %>').value = '';
   document.getElementById('<%= txtPaidCustomerPO.ClientID %>').value = '';
   document.getElementById('<%= txtPaidCheckNo.ClientID %>').value = '';
  }
  function RpaidReset() {
   document.getElementById('<%= txtRPaidCustomer.ClientID %>').value = '';
   document.getElementById('<%= txtRPaidInvoice.ClientID %>').value = '';
   document.getElementById('<%= txtRPaidCustomerPO.ClientID %>').value = '';
   document.getElementById('<%= txtRPaidCheckNo.ClientID %>').value = '';
  }
  function dCnt(chk, val, lbl) {
   var Cnt = document.getElementById(lbl);
   if (chk.checked) Cnt.innerHTML = (parseFloat(Cnt.innerHTML) + parseFloat(val)).toFixed(2);
   else Cnt.innerHTML = (parseFloat(Cnt.innerHTML) - parseFloat(val)).toFixed(2);
  }
 </script>
</telerik:RadCodeBlock>

<asp:HiddenField ID="hfUID" runat="server" />
<asp:HiddenField ID="hfValx" runat="server" />
<asp:ObjectDataSource ID="odsUnpaid" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="Select3" UpdateMethod="SaveInvoice">
<%-- EnablePaging="true" EnableCaching="true" StartRowIndexParameterName="startIndex" MaximumRowsParameterName="pageSize" SortParameterName="sortBy" SelectCountMethod="CountUnpaidInvoice" >--%>
 <SelectParameters>
  <asp:ControlParameter Name="xHID" Type="String" ControlID="hfValx" PropertyName="Value" />
  <asp:ControlParameter Name="CName" Type="String" ControlID="txtUnpaidCustomer" PropertyName="Text" />
  <asp:ControlParameter Name="CustomerPO" Type="String" ControlID="txtUnpaidCustomerPO" PropertyName="Text" />
  <asp:ControlParameter Name="Invoice" Type="String" ControlID="txtUnpaidInvoice" PropertyName="Text" />
  <asp:Parameter Name="CheckNo" Type="String" />
  <asp:ControlParameter Name="DDf" Type="DateTime" ControlID="txtDDf" PropertyName="Text" />
  <asp:ControlParameter Name="DDt" Type="DateTime" ControlID="txtDDt" PropertyName="Text" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="UnpaidInvoice" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
 </SelectParameters>
 <UpdateParameters>
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:ControlParameter Name="CheckNo" Type="String" ControlID="txtCheckNo" PropertyName="Text" />
  <asp:Parameter Name="CheckID" Type="Int32" />
  <asp:ControlParameter Name="FileID" Type="Int32" ControlID="gvChecks" PropertyName="SelectedValue" />
 </UpdateParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsPaid" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="Select3" UpdateMethod="SaveInvoice">
<%-- EnablePaging="true" EnableCaching="true" StartRowIndexParameterName="startIndex" MaximumRowsParameterName="pageSize" SortParameterName="sortBy" SelectCountMethod="CountPaidInvoice" >--%>
 <SelectParameters>
  <asp:ControlParameter Name="xHID" Type="String" ControlID="hfValx" PropertyName="Value" />
  <asp:ControlParameter Name="CName" Type="String" ControlID="txtPaidCustomer" PropertyName="Text" />
  <asp:ControlParameter Name="CustomerPO" Type="String" ControlID="txtPaidCustomerPO" PropertyName="Text" />
  <asp:ControlParameter Name="Invoice" Type="String" ControlID="txtPaidInvoice" PropertyName="Text" />
  <asp:ControlParameter Name="CheckNo" Type="String" ControlID="txtPaidCheckNo" PropertyName="Text" />
  <asp:Parameter Name="DDf" Type="DateTime" />
  <asp:Parameter Name="DDt" Type="DateTime" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="PaidInvoice" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:Parameter Name="lMode" Type="String" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="UN" Type="String" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:Parameter Name="CheckNo" Type="String" />
  <asp:Parameter Name="CheckID" Type="Int32" />
  <asp:Parameter Name="FileID" Type="Int32" />
 </UpdateParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsRPaid" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="Select3">
<%-- EnablePaging="true" EnableCaching="true" StartRowIndexParameterName="startIndex" MaximumRowsParameterName="pageSize" SortParameterName="sortBy" SelectCountMethod="CountRPaidInvoice" >--%>
 <SelectParameters>
  <asp:ControlParameter Name="xHID" Type="String" ControlID="hfValx" PropertyName="Value" />
  <asp:ControlParameter Name="CName" Type="String" ControlID="txtRPaidCustomer" PropertyName="Text" />
  <asp:ControlParameter Name="CustomerPO" Type="String" ControlID="txtRPaidCustomerPO" PropertyName="Text" />
  <asp:ControlParameter Name="Invoice" Type="String" ControlID="txtRPaidInvoice" PropertyName="Text" />
  <asp:ControlParameter Name="CheckNo" Type="String" ControlID="txtRPaidCheckNo" PropertyName="Text" />
  <asp:Parameter Name="DDf" Type="DateTime" />
  <asp:Parameter Name="DDt" Type="DateTime" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="RPaidInvoice" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:Parameter Name="lMode" Type="String" />
 </SelectParameters>
</asp:ObjectDataSource>
</asp:Content>