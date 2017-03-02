<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="OpenPOMix.aspx.cs" Inherits="webApp.Purchasing.OpenPOMix" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadPreview(id) {
   lPopup("../File/Preview.aspx?FID=PO&Code=GeneralPO&HID=" + id);
  }
  function openReset() {
   document.getElementById('<%= txtOpenSupplier.ClientID %>').value = '';
   document.getElementById('<%= txtOpenPN.ClientID %>').value = '';
   document.getElementById('<%= txtOpenPO.ClientID %>').value = '';
   document.getElementById('<%= txtOpenDDf.ClientID %>').value = '';
   document.getElementById('<%= txtOpenDDt.ClientID %>').value = '';
  }
 </script>
</telerik:RadCodeBlock>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
<aspx:UpdatePanel ID="uPnlPO" runat="server">
 <ContentTemplate>
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
    <td align="center" style="font-weight:bold;">OPEN PURCHASE ORDER (P.O)</td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvOpenPO" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsOpenPO" OnRowDataBound="rwBound" PageSize="10">
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
         <asp:Button ID="btnLnk" runat="server" Text="Edit" CssClass="NavBtn" />
         <asp:HiddenField ID="hfMixIDs" runat="server" Value='<%# Eval("MixIDs") %>' />
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
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Supplier" DataField="VendorName" SortExpression="VendorName" InsertVisible="false" />
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
  <MW:Message ID="iMsg" runat="server" />
 </ContentTemplate>
</aspx:UpdatePanel>

<asp:HiddenField ID="hfUID" runat="server" />
<asp:ObjectDataSource ID="odsOpenPO" runat="server" TypeName="myBiz.DAL.clsPO" SelectMethod="Select" UpdateMethod="Recd_U">
 <SelectParameters>
  <asp:Parameter Name="xHID" Type="String" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="OpenMix" />
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
</asp:Content>