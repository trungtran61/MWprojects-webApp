﻿<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Reports.InvAvail" Title="Inventory Available" Codebehind="InvAvail.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
 <script language="javascript" type="text/javascript" src="../App_Themes/jquery-1.6.4.min.js"></script>
 <script language="javascript" type="text/javascript">
  function doOpen(x){
   $('#<%= hfUseField.ClientID %>').val(x);
   $find('<%= mpeAddress.ClientID %>').show();
  }
  function doOK(){
   var x = ''; var y;
   var cID = 'xAddress_';
   var Cnt = $('#<%= hfCnt.ClientID %>').val();
   
   for (var i = 0; i < Cnt; i++){
    y = document.getElementById(cID+i);
    if (y.checked) {
     if (x.length>0) x = x + ', ' + y.value;
     else x = y.value;
     y.checked = false;
    }
   }
   
   $('#' + $('#<%= hfUseField.ClientID %>').val()).val(x);
  }
 </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <h3>Inventory Available</h3>
 <table>
  <tr>
   <td><b>Customer Name:</b></td>
   <td><asp:DropDownList ID="ddlCustomerName" runat="server" AutoPostBack="true" DataSourceID="odsCustomerName" DataValueField="HID" DataTextField="CompanyName"></asp:DropDownList></td>
  </tr>
 </table>
 <table>
  <tr valign="top">
   <td>
    <aspx:UpdatePanel ID="uPnlInvAvail" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
      <asp:Button ID="btnEmail" runat="server" Text="Email" OnClientClick="javascript:$('#dvEmail').show();return false;" CssClass="NavBtn" Visible="false" /><br />
      <asp:Literal ID="litInvAvail" runat="server"></asp:Literal>
      <asp:GridView ID="gvInvAvail" runat="server" SkinID="Default" DataSourceID="odsInvAvail" OnDataBound="gvBound" OnRowDataBound="rwBound" PageSize="20">
       <Columns>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle">
         <HeaderTemplate>
          <asp:DropDownList ID="ddlDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
           <asp:ListItem Text="10" Value="10"></asp:ListItem>
           <asp:ListItem Text="20" Value="20"></asp:ListItem>
           <asp:ListItem Text="40" Value="40"></asp:ListItem>
           <asp:ListItem Text="All" Value="*"></asp:ListItem>
          </asp:DropDownList>
          <asp:LinkButton ID="lnkSortPN" runat="server" CommandName="Sort" CommandArgument="PN" ForeColor="White" Text="Part Number" /><br />
         </HeaderTemplate>
         <ItemTemplate><%# Eval("PN") %></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="Avail." DataField="Qty" SortExpression="Qty" InsertVisible="false" ItemStyle-HorizontalAlign="Right" />
        <asp:BoundField HeaderText="Unit Price ($)" DataField="UnitPrice" SortExpression="UnitPrice" InsertVisible="false" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
        <asp:BoundField HeaderText="Total ($)" DataField="Total" SortExpression="Total" InsertVisible="false" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
       </Columns>
      </asp:GridView>
     </ContentTemplate>
     <Triggers><aspx:AsyncPostBackTrigger ControlID="ddlCustomerName" EventName="SelectedIndexChanged" /></Triggers>
    </aspx:UpdatePanel>
   </td>
   <td>
    <div id="dvEmail" style="display:none;">
     <aspx:UpdatePanel ID="uPnlInvAvail1" runat="server" UpdateMode="Conditional">
      <ContentTemplate>
       <table style="background:#CCFFCC;">
        <tr><td><b>From:</b></td><td><asp:TextBox ID="txtFrom" runat="server" Width="300px"></asp:TextBox></td></tr>
        <tr><td><b><a onclick="javascript:doOpen('<%= txtTo.ClientID %>');" class="Pointer">To:</a></b></td><td><asp:TextBox ID="txtTo" runat="server" Width="300px"></asp:TextBox></td></tr>
        <tr><td><b>Subject:</b></td><td><asp:TextBox ID="txtSubject" runat="server" Width="300px" Text="Inventory Availability Report"></asp:TextBox></td></tr>
        <tr><td colspan="2"><asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine" Width="365px" Height="150px"></asp:TextBox></td></tr>
        <tr>
         <td align="right" colspan="2">
          <asp:Button ID="btnSend" runat="server" Text="Send" OnClick="doSend" CssClass="NavBtn" />
          <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick="javascript:$('#dvEmail').hide(); return false;" CssClass="NavBtn" />
         </td>
        </tr>
       </table><br />
       <MW:Message ID="iMsg" runat="server" />
       <table id="tblAddress" runat="server" class="mdlPopup">
        <tr><td><asp:Literal ID="litEmail" runat="server"></asp:Literal></td></tr>
        <tr><td><asp:Button ID="btnAddOK" runat="server" Text="OK" CssClass="NavBtn" /></td></tr>
       </table>
       <ajax:ModalPopupExtender ID="mpeAddress" runat="server" TargetControlID="hfUseField" PopupControlID="tblAddress" BackgroundCssClass="mdlBackground"
        OkControlID="btnAddOK" DropShadow="false" RepositionMode="RepositionOnWindowResize" OnOkScript="doOK()" />

       <asp:HiddenField ID="hfCnt" runat="server" />
       <asp:HiddenField ID="hfUseField" runat="server" />
      </ContentTemplate>
      <Triggers><aspx:AsyncPostBackTrigger ControlID="ddlCustomerName" EventName="SelectedIndexChanged" /></Triggers>
     </aspx:UpdatePanel>
    </div>
   </td>
  </tr>
 </table>
 
 <asp:ObjectDataSource ID="odsCustomerName" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="CompanyList">
  <SelectParameters>
   <asp:Parameter Name="ClassName" Type="String" DefaultValue="Customer" />
   <asp:Parameter Name="isAll" Type="Boolean" DefaultValue="False" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsInvAvail" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="InvAvail">
  <SelectParameters>
   <asp:ControlParameter Name="CustID" Type="Int32" ControlID="ddlCustomerName" PropertyName="SelectedValue"  />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>