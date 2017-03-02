<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Purchasing.OpenPO" Title="Receiving Orders" Codebehind="OpenPO.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" Runat="Server">
<aspx:UpdatePanel ID="uPnlPO" runat="server">
 <ContentTemplate>
  <asp:Panel ID="pnlRecdPO" runat="server" DefaultButton="btnRecdS">
   <table>
    <tr>
     <td><b>Supplier:</b></td>
     <td><b>Part Number:</b></td>
     <td><b>PO Number:</b></td>
     <td><b>Date From:</b></td>
     <td><b>Date To:</b></td>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td><asp:TextBox ID="txtRecdSupplier" runat="server"></asp:TextBox></td>
     <td>
      <asp:TextBox ID="txtRecdPN" runat="server"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="aceRecdPN" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtRecdPN">
      </ajax:AutoCompleteExtender>
     </td>
     <td>
      <asp:TextBox ID="txtRecdPO" runat="server"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="aceRecdPO" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtRecdPO" />
     </td>
     <td><asp:TextBox ID="txtRecdDDf" runat="server" Width="75px"></asp:TextBox>
      <ajax:CalendarExtender ID="calRecdDDf" runat="server" TargetControlID="txtRecdDDf" Format="MM/dd/yy" />
     </td>
     <td><asp:TextBox ID="txtRecdDDt" runat="server" Width="75px"></asp:TextBox>
      <ajax:CalendarExtender ID="calRecdDDt" runat="server" TargetControlID="txtRecdDDt" Format="MM/dd/yy" />
     </td>
     <td valign="bottom">
      <asp:Button ID="btnRecdS" runat="server" Text="Search" CssClass="NavBtn" />
      <asp:Button ID="btnRecdR" runat="server" Text="Reset" CssClass="NavBtn" OnClientClick="javascript:recdReset(); return false;" />
     </td>
    </tr>
   </table>
  </asp:Panel>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;"><span id="lblRecdCnt" style="float:left;">0</span>ORDERS HAD BEEN RECEIVED <asp:Literal ID="litRecdCnt" runat="server" /></td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvRecdPO" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsRecdPO" OnDataBound="recdBound" OnRowDataBound="rwBound" PageSize="10">
      <Columns>
       <asp:TemplateField>
        <HeaderTemplate>
         <asp:DropDownList ID="ddlRecdDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
          <asp:ListItem Text="10" Value="10"></asp:ListItem>
          <asp:ListItem Text="20" Value="20"></asp:ListItem>
          <asp:ListItem Text="30" Value="30"></asp:ListItem>
          <asp:ListItem Text="All" Value="5000"></asp:ListItem>
         </asp:DropDownList>
        </HeaderTemplate>
        <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /><asp:HiddenField ID="hfDollar" runat="server" Value='<%# Eval("Total") %>' /></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Received By" DataField="RecdBy" SortExpression="RecdBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="RecdDate" SortExpression="RecdDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="PO #" SortExpression="PONumber" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkPONumber" runat="server" Text='<%# Eval("PONumber") %>' OnClientClick='<%# string.Format("javascript:loadPreview(\"{0}\");return false;", Eval("POLink")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Total" DataField="Total" HtmlEncode="false" DataFormatString="{0:C2}" SortExpression="Total" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Part Number" DataField="PartNumber" SortExpression="PartNumber" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Due Date" SortExpression="RecdDD">
        <ItemTemplate><%# gDD("RecdDD") %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Supplier" SortExpression="VendorName">
        <ItemTemplate><%# gVdrName() %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Rec'd Loc" DataField="RecdLoc" SortExpression="RecdLoc" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate>
         <a onclick="javascript:xPopup('../Note/Note.aspx?lDB=PO&lID=<%# Eval("HID") %>');" class="Finger"><img src="../App_Themes/<%# Eval("NoteImg") %>" alt="Note" /></a>
        </ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No Purchase Order has been received!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>

  <br />
  <asp:Button ID="btnUndo" runat="server" Text="Undo" OnClick="doUndo" CssClass="NavBtn" />
  <br /><hr />

  <asp:Panel ID="pnlOpenPO" runat="server" DefaultButton="btnOpenS">
   <table>
    <tr>
     <td><b>Supplier:</b></td>
     <td><b>Part Number:</b></td>
     <td><b>PO Number:</b></td>
     <td><b>Date From:</b></td>
     <td><b>Date To:</b></td>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td><asp:TextBox ID="txtOpenSupplier" runat="server"></asp:TextBox></td>
     <td>
      <asp:TextBox ID="txtOpenPN" runat="server"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="aceOpenPN" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtOpenPN">
      </ajax:AutoCompleteExtender>
     </td>
     <td>
      <asp:TextBox ID="txtOpenPO" runat="server"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="aceOpenPO" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtOpenPO" />
     </td>
     <td><asp:TextBox ID="txtOpenDDf" runat="server" Width="75px"></asp:TextBox>
      <ajax:CalendarExtender ID="calOpenDDf" runat="server" TargetControlID="txtOpenDDf" Format="MM/dd/yy" />
     </td>
     <td><asp:TextBox ID="txtOpenDDt" runat="server" Width="75px"></asp:TextBox>
      <ajax:CalendarExtender ID="calOpenDDt" runat="server" TargetControlID="txtOpenDDt" Format="MM/dd/yy" />
     </td>
     <td valign="bottom">
      <asp:Button ID="btnOpenS" runat="server" Text="Search" CssClass="NavBtn" />
      <asp:Button ID="btnOpenR" runat="server" Text="Reset" CssClass="NavBtn" OnClientClick="javascript:openReset(); return false;" />
     </td>
    </tr>
   </table>
  </asp:Panel>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;"><span id="lblOpenCnt" style="float:left;">0</span>OPEN PURCHASE ORDER (P.O)
     <asp:Literal ID="litOpenCnt" runat="server"></asp:Literal>
     <asp:Label ID="showOpenTotal" runat="server" Text="$" onclick="javascript:toggleOpenTotal();" CssClass="Finger" Visible="false"></asp:Label>
     <span id="xOpenTotal" style="display:none"><asp:Literal ID="litOpenTotal" runat="server"></asp:Literal></span>
    </td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvOpenPO" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsOpenPO" OnDataBound="openBound" OnRowDataBound="rwBound" PageSize="10">
      <Columns>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
        <HeaderTemplate>
         <asp:DropDownList ID="ddlOpenDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
          <asp:ListItem Text="10" Value="10"></asp:ListItem>
          <asp:ListItem Text="20" Value="20"></asp:ListItem>
          <asp:ListItem Text="30" Value="30"></asp:ListItem>
          <asp:ListItem Text="All" Value="5000"></asp:ListItem>
         </asp:DropDownList>
        </HeaderTemplate>
        <ItemTemplate>
         <asp:CheckBox ID="chkItem" runat="server" Visible='<%# string.IsNullOrEmpty(Eval("isValid").ToString()) %>' />
         <%# Eval("isValid") %>
         <asp:HiddenField ID="hfDollar" runat="server" Value='<%# Eval("Total") %>' />
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Created By" DataField="CreatedBy" SortExpression="CreatedBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="CreatedDate" SortExpression="CreatedDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="PO #" SortExpression="PONumber" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkPONumber" runat="server" Text='<%# Eval("PONumber") %>' OnClientClick='<%# string.Format("javascript:loadPreview(\"{0}\");return false;", Eval("POLink")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Total" DataField="Total" HtmlEncode="false" DataFormatString="{0:C2}" SortExpression="Total" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Part Number" DataField="PartNumber" SortExpression="PartNumber" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Due Date" SortExpression="RecdDD">
        <ItemTemplate><%# gDD("RecdDD") %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Supplier" SortExpression="VendorName">
        <ItemTemplate><%# gVdrName() %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate>
         <a onclick="javascript:xPopup('../Note/Note.aspx?lDB=PO&lID=<%# Eval("HID") %>');" class="Finger"><img src="../App_Themes/<%# Eval("NoteImg") %>" alt="Note" /></a>
         <%# Eval("SoR") %>
        </ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No Purchase Order has been sent!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  <br />
  <asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID"></asp:DropDownList>
  <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="doSubmit" CssClass="NavBtn" /><br />
  D: Due date is needed.<br />
  S: Supplier's name is needed.<br />
  <MW:Message ID="iMsg" runat="server" />
 </ContentTemplate>
</aspx:UpdatePanel>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadPreview(id)
  {
   window.radopen("../File/Preview.aspx?FID=PO&Code=GeneralPO&HID=" + id, "mPopup").maximize();
  }
  function toggleOpenTotal(){
   var tt = document.getElementById('xOpenTotal');
   if (tt.style.display=='none') tt.style.display='inline';
   else tt.style.display='none';
  }
  function recdReset(){
   document.getElementById('<%= txtRecdSupplier.ClientID %>').value = '';
   document.getElementById('<%= txtRecdPN.ClientID %>').value = '';
   document.getElementById('<%= txtRecdPO.ClientID %>').value = '';
   document.getElementById('<%= txtRecdDDf.ClientID %>').value = '';
   document.getElementById('<%= txtRecdDDt.ClientID %>').value = '';
  }
  function openReset(){
   document.getElementById('<%= txtOpenSupplier.ClientID %>').value = '';
   document.getElementById('<%= txtOpenPN.ClientID %>').value = '';
   document.getElementById('<%= txtOpenPO.ClientID %>').value = '';
   document.getElementById('<%= txtOpenDDf.ClientID %>').value = '';
   document.getElementById('<%= txtOpenDDt.ClientID %>').value = '';
  }
  function dCnt(chk,val,lbl) {
   var Cnt = document.getElementById(lbl);
   if (chk.checked) Cnt.innerHTML = (Number(Cnt.innerHTML) + Number(val)).toFixed(2);
   else Cnt.innerHTML = (Number(Cnt.innerHTML) - Number(val)).toFixed(2);
  }
 </script>
</telerik:RadCodeBlock>

<asp:HiddenField ID="hfUID" runat="server" />
<asp:HiddenField ID="hfValx" runat="server" />
<asp:ObjectDataSource ID="odsRecdPO" runat="server" TypeName="myBiz.DAL.clsPO" SelectMethod="Select" UpdateMethod="Recd_U">
 <SelectParameters>
  <asp:ControlParameter Name="xHID" Type="String" ControlID="hfValx" PropertyName="Value" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Received" />
  <asp:ControlParameter Name="PN" Type="String" ControlID="txtRecdPN" PropertyName="Text" />
  <asp:ControlParameter Name="PO" Type="String" ControlID="txtRecdPO" PropertyName="Text" />
  <asp:ControlParameter Name="Supplier" Type="String" ControlID="txtRecdSupplier" PropertyName="Text" />
  <asp:Parameter Name="Invoice" Type="String" />
  <asp:ControlParameter Name="CreatedDate1" Type="DateTime" ControlID="txtRecdDDf" PropertyName="Text" />
  <asp:ControlParameter Name="CreatedDate2" Type="DateTime" ControlID="txtRecdDDt" PropertyName="Text" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:Parameter Name="lMode" Type="String" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="UN" Type="String" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Open" />
  <asp:Parameter Name="LocID" Type="Int32" />
 </UpdateParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsOpenPO" runat="server" TypeName="myBiz.DAL.clsPO" SelectMethod="Select" UpdateMethod="Recd_U">
 <SelectParameters>
  <asp:ControlParameter Name="xHID" Type="String" ControlID="hfValx" PropertyName="Value" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Open" />
  <asp:ControlParameter Name="PN" Type="String" ControlID="txtOpenPN" PropertyName="Text" />
  <asp:ControlParameter Name="PO" Type="String" ControlID="txtOpenPO" PropertyName="Text" />
  <asp:ControlParameter Name="Supplier" Type="String" ControlID="txtOpenSupplier" PropertyName="Text" />
  <asp:Parameter Name="Invoice" Type="String" />
  <asp:ControlParameter Name="CreatedDate1" Type="DateTime" ControlID="txtOpenDDf" PropertyName="Text" />
  <asp:ControlParameter Name="CreatedDate2" Type="DateTime" ControlID="txtOpenDDt" PropertyName="Text" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
 </SelectParameters>
 <UpdateParameters>
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Received" />
  <asp:ControlParameter Name="LocID" Type="Int32" ControlID="ddlLocation" PropertyName="SelectedValue" />
 </UpdateParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
 <SelectParameters>
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Received" />
  <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
  <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
 </SelectParameters>
</asp:ObjectDataSource>
</asp:Content>