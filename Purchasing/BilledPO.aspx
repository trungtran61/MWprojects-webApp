<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Purchasing.BilledPO" Title="Pay Bills" Codebehind="BilledPO.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
<aspx:UpdatePanel ID="uPnlBilledPO" runat="server" UpdateMode="Conditional">
 <ContentTemplate>
  <asp:Panel ID="pnlBilleddPO" runat="server" DefaultButton="btnBilledS">
   <table>
    <tr>
     <td><b>Supplier:</b></td>
     <td><b>PO#:</b></td>
     <td><b>Invoice#:</b></td>
     <td><b>Date From:</b></td>
     <td><b>Date To:</b></td>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td><asp:TextBox ID="txtBilledSupplier" runat="server"></asp:TextBox></td>
     <td>
      <asp:TextBox ID="txtBilledPO" runat="server" Width="75px"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="aceBilledPO" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtBilledPO" />
     </td>
     <td><asp:TextBox ID="txtBilledInvoice" runat="server" Width="75px"></asp:TextBox></td>
     <td><asp:TextBox ID="txtBilledDDf" runat="server" Width="75px"></asp:TextBox>
      <ajax:CalendarExtender ID="calBilledDDf" runat="server" TargetControlID="txtBilledDDf" Format="MM/dd/yy" />
     </td>
     <td><asp:TextBox ID="txtBilledDDt" runat="server" Width="75px"></asp:TextBox>
      <ajax:CalendarExtender ID="calBilledDDt" runat="server" TargetControlID="txtBilledDDt" Format="MM/dd/yy" />
     </td>
     <td valign="bottom">
      <asp:Button ID="btnBilledS" runat="server" Text="Search" CssClass="NavBtn" />
      <asp:Button ID="btnBiledR" runat="server" Text="Reset" CssClass="NavBtn" OnClientClick="javascript:billReset(); return false;" />
      <asp:Button ID="btnExport" runat="server" Text="Export" CssClass="NavBtn" OnClick="doExport" />
     </td>
    </tr>
   </table>
  </asp:Panel>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;"><span id="lblBilledCnt" style="float:left;">0</span>UNPAID BILLS
     <asp:Literal ID="litBilledCnt" runat="server"></asp:Literal>
     <asp:Label ID="showBilledTotal" runat="server" Text="$" onclick="javascript:toggleBilledTotal();" CssClass="Finger" Visible="false"></asp:Label>
     <span id="xBilledTotal" style="display:none"><asp:Literal ID="litBilledTotal" runat="server"></asp:Literal></span>
    </td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvBilledPO" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsBilledPO"
      AllowSorting="false" OnRowDataBound="rwBound" OnRowCommand="gvCmd" PageSize="10">
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
        <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /><asp:HiddenField ID="hfDollar" runat="server" Value='<%# Eval("BillAmt") %>' /></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Approved By" DataField="AprvBy" SortExpression="AprvBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="AprvDate" SortExpression="AprvDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderImageUrl="~/App_Themes/thumbsUp.png" SortExpression="isThumbUp" InsertVisible="false">
        <ItemTemplate><asp:Image ID="imgThumbUp" runat="server" ImageUrl="~/App_Themes/thumbsUp.png" Visible='<%# Convert.ToBoolean(Eval("isThumbUp")) %>' /></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="PO #" SortExpression="PONumber" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkPONumber" runat="server" Text='<%# Eval("PONumber") %>' OnClientClick='<%# string.Format("javascript:loadPreview(\"{0}\");return false;", Eval("POLink")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Bill Amount ($)" DataField="BillAmt" HtmlEncode="false" SortExpression="BillAmt" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Invoices #" SortExpression="InvoiceNo">
        <ItemTemplate>
         <asp:LinkButton ID="lnkDLInvoice" runat="server" Text="&diams;" CommandName="bInvoice" ToolTip="View Invoice" />
         <%# Eval("InvoiceNo") %>
        </ItemTemplate>
       </asp:TemplateField>
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
      <EmptyDataTemplate>No Orders has been billed!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  
  <br /><br />
  <asp:Button ID="btnSched" runat="server" Text="Scheduled" OnClick="doScheduling" CssClass="NavBtn" />
  <hr />

  <asp:Panel ID="pnlSchedPO" runat="server" DefaultButton="btnSchedS">
   <table>
    <tr>
     <td><b>Supplier:</b></td>
     <td><b>PO#:</b></td>
     <td><b>Invoice#:</b></td>
     <td><b>Date From:</b></td>
     <td><b>Date To:</b></td>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td><asp:TextBox ID="txtSchedSupplier" runat="server"></asp:TextBox></td>
     <td>
      <asp:TextBox ID="txtSchedPO" runat="server" Width="75px"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="aceSchedPO" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtSchedPO" />
     </td>
     <td><asp:TextBox ID="txtSchedInvoice" runat="server" Width="75px"></asp:TextBox></td>
     <td><asp:TextBox ID="txtSchedDDf" runat="server" Width="75px"></asp:TextBox>
      <ajax:CalendarExtender ID="calSchedDDf" runat="server" TargetControlID="txtSchedDDf" Format="MM/dd/yy" />
     </td>
     <td><asp:TextBox ID="txtSchedDDt" runat="server" Width="75px"></asp:TextBox>
      <ajax:CalendarExtender ID="calSchedDDt" runat="server" TargetControlID="txtSchedDDt" Format="MM/dd/yy" />
     </td>
     <td valign="bottom">
      <asp:Button ID="btnSchedS" runat="server" Text="Search" CssClass="NavBtn" />
      <asp:Button ID="btnSchedR" runat="server" Text="Reset" CssClass="NavBtn" OnClientClick="javascript:schedReset(); return false;" />
     </td>
    </tr>
   </table>
  </asp:Panel>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;"><span id="lblSchedCnt" style="float:left;">0</span>SCHEDULED UNPAID BILLS
     <asp:Literal ID="litSchedCnt" runat="server"></asp:Literal>
     <asp:Label ID="showSchedTotal" runat="server" Text="$" onclick="javascript:toggleSchedTotal();" CssClass="Finger" Visible="false"></asp:Label>
     <span id="xSchedTotal" style="display:none"><asp:Literal ID="litSchedTotal" runat="server"></asp:Literal></span>
    </td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvSchedPO" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsSchedPO"
      AllowSorting="false" OnRowDataBound="rwSchedBound" OnRowCommand="gvCmd" PageSize="10">
      <Columns>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
        <HeaderTemplate>
         <asp:DropDownList ID="ddlSchedDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
          <asp:ListItem Text="10" Value="10"></asp:ListItem>
          <asp:ListItem Text="20" Value="20"></asp:ListItem>
          <asp:ListItem Text="30" Value="30"></asp:ListItem>
          <asp:ListItem Text="All" Value="5000"></asp:ListItem>
         </asp:DropDownList>
        </HeaderTemplate>
        <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /><asp:HiddenField ID="hfDollar" runat="server" Value='<%# Eval("BillAmt") %>' /></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Approved By" DataField="AprvBy" SortExpression="AprvBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="AprvDate" SortExpression="AprvDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="PO #" SortExpression="PONumber" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkPONumber" runat="server" Text='<%# Eval("PONumber") %>' OnClientClick='<%# string.Format("javascript:loadPreview(\"{0}\");return false;", Eval("POLink")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Bill Amount ($)" DataField="BillAmt" HtmlEncode="false" SortExpression="BillAmt" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Invoices #" SortExpression="InvoiceNo">
        <ItemTemplate>
         <asp:LinkButton ID="lnkDLInvoice" runat="server" Text="&diams;" CommandName="bInvoice" ToolTip="View Invoice" />
         <%# Eval("InvoiceNo") %>
        </ItemTemplate>
       </asp:TemplateField>
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
      <EmptyDataTemplate>No Orders has been Scheduled!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>

  <br /><br />
  <b>Check #:</b> <asp:TextBox ID="txtCheckNo" runat="server"></asp:TextBox>
  <asp:Button ID="btnPay" runat="server" Text="Pay Bill" OnClick="doPay" CssClass="NavBtn" />
  <asp:Button ID="btnUnSched" runat="server" Text="Undo Scheduled" OnClick="doScheduling" CssClass="NavBtn" />
  <hr />

  <asp:Panel ID="pnlPaidPO" runat="server" DefaultButton="btnPaidS">
   <table>
    <tr>
     <td><b>Supplier:</b></td>
     <td><b>PO#:</b></td>
     <td><b>Invoice#:</b></td>
     <td><b>Check#:</b></td>
     <td><b>Date From:</b></td>
     <td><b>Date To:</b></td>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td><asp:TextBox ID="txtPaidSupplier" runat="server"></asp:TextBox></td>
     <td>
      <asp:TextBox ID="txtPaidPO" runat="server" Width="75px"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="acePaidPO" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtPaidPO" />
     </td>
     <td><asp:TextBox ID="txtPaidInvoice" runat="server" Width="75px"></asp:TextBox></td>
     <td><asp:TextBox ID="txtPaidCheckNo" runat="server" Width="75px"></asp:TextBox></td>
     <td><asp:TextBox ID="txtPaidDDf" runat="server" Width="75px"></asp:TextBox>
      <ajax:CalendarExtender ID="calPaidDDf" runat="server" TargetControlID="txtPaidDDf" Format="MM/dd/yy" />
     </td>
     <td><asp:TextBox ID="txtPaidDDt" runat="server" Width="75px"></asp:TextBox>
      <ajax:CalendarExtender ID="calPaidDDt" runat="server" TargetControlID="txtPaidDDt" Format="MM/dd/yy" />
     </td>
     <td valign="bottom">
      <asp:Button ID="btnPaidS" runat="server" Text="Search" CssClass="NavBtn" />
      <asp:Button ID="btnPaidR" runat="server" Text="Reset" CssClass="NavBtn" OnClientClick="javascript:paidReset(); return false;" />
     </td>
    </tr>
   </table>
  </asp:Panel>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">PAID BILLS
     <asp:Literal ID="litPaidCnt" runat="server"></asp:Literal>
     <asp:Label ID="showPaidTotal" runat="server" Text="$" onclick="javascript:togglePaidTotal();" CssClass="Finger" Visible="false"></asp:Label>
     <span id="xPaidTotal" style="display:none"><asp:Literal ID="litPaidTotal" runat="server"></asp:Literal></span>
    </td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvPaidPO" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsPaidPO" OnRowDataBound="rwBound" OnRowCommand="gvCmd" PageSize="10">
      <Columns>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
        <HeaderTemplate>
         <asp:DropDownList ID="ddlPaidDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
          <asp:ListItem Text="10" Value="10"></asp:ListItem>
          <asp:ListItem Text="20" Value="20"></asp:ListItem>
          <asp:ListItem Text="30" Value="30"></asp:ListItem>
          <asp:ListItem Text="All" Value="5000"></asp:ListItem>
         </asp:DropDownList>
        </HeaderTemplate>
        <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Paid By" DataField="PaidBy" SortExpression="PaidBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="PaidDate" SortExpression="PaidDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="PO #" SortExpression="PONumber" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkPONumber" runat="server" Text='<%# Eval("PONumber") %>' OnClientClick='<%# string.Format("javascript:loadPreview(\"{0}\");return false;", Eval("POLink")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Bill Amount ($)" DataField="BillAmt" HtmlEncode="false" SortExpression="BillAmt" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Invoices #" SortExpression="InvoiceNo">
        <ItemTemplate>
         <asp:LinkButton ID="lnkDLInvoice" runat="server" Text="&diams;" CommandName="pInvoice" ToolTip="View Invoice" />
         <%# Eval("InvoiceNo") %>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Check #" DataField="CheckNo" SortExpression="CheckNo" InsertVisible="false" />
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
      <EmptyDataTemplate>Please enter something to search!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  <br />
  <asp:Button ID="btnUndo" runat="server" Text="Undo Payment" OnClick="doUndo" CssClass="NavBtn" />
  <MW:Message ID="iMsg" runat="server" />
  <asp:HiddenField ID="hfSUTotal" runat="server" />
 </ContentTemplate>
 <Triggers>
  <aspx:PostBackTrigger ControlID="btnExport" />
 </Triggers>
</aspx:UpdatePanel>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadPreview(id) {
   window.radopen("../File/Preview.aspx?FID=PO&Code=GeneralPO&HID=" + id, "mPopup").maximize();
  }
  function toggleBilledTotal() {
   var tt = document.getElementById('xBilledTotal');
   if (tt.style.display == 'none') tt.style.display = 'inline';
   else tt.style.display = 'none';
  }
  function billReset() {
   document.getElementById('<%= txtBilledSupplier.ClientID %>').value = '';
   document.getElementById('<%= txtBilledPO.ClientID %>').value = '';
   document.getElementById('<%= txtBilledInvoice.ClientID %>').value = '';
   document.getElementById('<%= txtBilledDDf.ClientID %>').value = '';
   document.getElementById('<%= txtBilledDDt.ClientID %>').value = '';
  }
  function toggleSchedTotal() {
   var tt = document.getElementById('xSchedTotal');
   if (tt.style.display == 'none') tt.style.display = 'inline';
   else tt.style.display = 'none';
  }
  function schedReset() {
   document.getElementById('<%= txtSchedSupplier.ClientID %>').value = '';
   document.getElementById('<%= txtSchedPO.ClientID %>').value = '';
   document.getElementById('<%= txtSchedInvoice.ClientID %>').value = '';
   document.getElementById('<%= txtSchedDDf.ClientID %>').value = '';
   document.getElementById('<%= txtSchedDDt.ClientID %>').value = '';
  }
  function togglePaidTotal() {
   var tt = document.getElementById('xPaidTotal');
   if (tt.style.display == 'none') tt.style.display = 'inline';
   else tt.style.display = 'none';
  }
  function paidReset() {
   document.getElementById('<%= txtPaidSupplier.ClientID %>').value = '';
   document.getElementById('<%= txtPaidPO.ClientID %>').value = '';
   document.getElementById('<%= txtPaidInvoice.ClientID %>').value = '';
   document.getElementById('<%= txtPaidCheckNo.ClientID %>').value = '';
   document.getElementById('<%= txtPaidDDf.ClientID %>').value = '';
   document.getElementById('<%= txtPaidDDt.ClientID %>').value = '';
  }
  function dCnt(chk, val, lbl) {
   var Cnt = document.getElementById(lbl);
   if (chk.checked) Cnt.innerHTML = (Number(Cnt.innerHTML) + Number(val)).toFixed(2);
   else Cnt.innerHTML = (Number(Cnt.innerHTML) - Number(val)).toFixed(2);
  }
 </script>
</telerik:RadCodeBlock>

<asp:HiddenField ID="hfUID" runat="server" />
<asp:HiddenField ID="hfValx" runat="server" />
<asp:ObjectDataSource ID="odsBilledPO" runat="server" TypeName="myBiz.DAL.clsPO" SelectMethod="Select1">
<%-- EnablePaging="true" EnableCaching="true" StartRowIndexParameterName="startIndex" MaximumRowsParameterName="pageSize" SortParameterName="sortBy" SelectCountMethod="CountBilledPO" >--%>
 <SelectParameters>
  <asp:ControlParameter Name="xHID" Type="String" ControlID="hfValx" PropertyName="Value" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Billed" />
  <asp:Parameter Name="PN" Type="String" />
  <asp:ControlParameter Name="PO" Type="String" ControlID="txtBilledPO" PropertyName="Text" />
  <asp:ControlParameter Name="Supplier" Type="String" ControlID="txtBilledSupplier" PropertyName="Text" />
  <asp:ControlParameter Name="Invoice" Type="String" ControlID="txtBilledInvoice" PropertyName="Text" />
  <asp:ControlParameter Name="PaidDD1" Type="DateTime" ControlID="txtBilledDDf" PropertyName="Text" />
  <asp:ControlParameter Name="PaidDD2" Type="DateTime" ControlID="txtBilledDDt" PropertyName="Text" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsSchedPO" runat="server" TypeName="myBiz.DAL.clsPO" SelectMethod="Select1" UpdateMethod="Paid_U">
 <%--EnablePaging="true" EnableCaching="true" StartRowIndexParameterName="startIndex" MaximumRowsParameterName="pageSize" SortParameterName="sortBy" SelectCountMethod="CountSchedPO" >--%>
 <SelectParameters>
  <asp:ControlParameter Name="xHID" Type="String" ControlID="hfValx" PropertyName="Value" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Billed_Sched" />
  <asp:Parameter Name="PN" Type="String" />
  <asp:ControlParameter Name="PO" Type="String" ControlID="txtSchedPO" PropertyName="Text" />
  <asp:ControlParameter Name="Supplier" Type="String" ControlID="txtSchedSupplier" PropertyName="Text" />
  <asp:ControlParameter Name="Invoice" Type="String" ControlID="txtSchedInvoice" PropertyName="Text" />
  <asp:ControlParameter Name="PaidDD1" Type="DateTime" ControlID="txtSchedDDf" PropertyName="Text" />
  <asp:ControlParameter Name="PaidDD2" Type="DateTime" ControlID="txtSchedDDt" PropertyName="Text" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
 </SelectParameters>
 <UpdateParameters>
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Paid" />
  <asp:ControlParameter Name="CheckNo" Type="String" ControlID="txtCheckNo" PropertyName="Text" />
 </UpdateParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsPaidPO" runat="server" TypeName="myBiz.DAL.clsPO" SelectMethod="Select2" UpdateMethod="Paid_U">
 <SelectParameters>
  <asp:ControlParameter Name="xHID" Type="String" ControlID="hfValx" PropertyName="Value" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Paid" />
  <asp:Parameter Name="PN" Type="String" />
  <asp:ControlParameter Name="PO" Type="String" ControlID="txtPaidPO" PropertyName="Text" />
  <asp:ControlParameter Name="Supplier" Type="String" ControlID="txtPaidSupplier" PropertyName="Text" />
  <asp:ControlParameter Name="Invoice" Type="String" ControlID="txtPaidInvoice" PropertyName="Text" />
  <asp:ControlParameter Name="CheckNo" Type="String" ControlID="txtPaidCheckNo" PropertyName="Text" />
  <asp:ControlParameter Name="PaidDD1" Type="DateTime" ControlID="txtPaidDDf" PropertyName="Text" />
  <asp:ControlParameter Name="PaidDD2" Type="DateTime" ControlID="txtPaidDDt" PropertyName="Text" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:Parameter Name="lMode" Type="String" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="UN" Type="String" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Billed_Sched" />
  <asp:Parameter Name="CheckNo" Type="String" />
 </UpdateParameters>
</asp:ObjectDataSource>
</asp:Content>