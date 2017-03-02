<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Reports.InvVal" Title="Inventory Avaluation" Codebehind="InvVal.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
 <script language="javascript" type="text/javascript" src="../App_Themes/jquery-1.6.4.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <h3>Inventory Valuation</h3>
 <table>
  <tr>
   <td><b>Customer Name</b></td>
   <td><b>Part Number</b></td>
   <td><b>Work Order</b></td>
   <td><b>Location</b></td>
  </tr>
  <tr>
   <td>
    <asp:DropDownList ID="ddlCustomerName" runat="server" DataSourceID="odsCustomerName" DataValueField="HID" DataTextField="CompanyName"></asp:DropDownList>
    <asp:ObjectDataSource ID="odsCustomerName" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="CompanyList">
     <SelectParameters>
      <asp:Parameter Name="ClassName" Type="String" DefaultValue="Customer" />
      <asp:Parameter Name="isAll" Type="Boolean" DefaultValue="True" />
      </SelectParameters>
    </asp:ObjectDataSource>
   </td>
   <td>
    <asp:TextBox ID="txtPartNumber" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="acePartNumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtPartNumber" />
   </td>
   <td>
    <asp:TextBox ID="txtWO" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="aceWorkOrder" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetWorkOrder" TargetControlID="txtWO" />
   </td>
   <td>
    <asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="Description" DataValueField="HID"></asp:DropDownList>
    <asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
     <SelectParameters>
      <asp:Parameter Name="Dept" Type="String" DefaultValue="Inventory" />
      <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
      <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
     </SelectParameters>
    </asp:ObjectDataSource>
   </td>
   <td><asp:Button ID="btnGo" runat="server" Text="Run Report" CssClass="NavBtn" /></td>
  </tr>
 </table>
 <table>
  <tr valign="top">
   <td>
 <aspx:UpdatePanel ID="uPnlInvVal" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <asp:Button ID="btnEmail" runat="server" Text="Email" OnClientClick="javascript:$('#dvEmail').show();return false;" CssClass="NavBtn" Visible="false" /><br />
   <asp:Literal ID="litGrandTotal" runat="server" OnLoad="lGrandTotal"></asp:Literal>
   <table cellspacing="3">
    <tr valign="top" style="background-color:#330099; color:White; text-align:center;" runat="server" id="trHeader">
     <td><b>Cust. ID</b></td>
     <td><b>P/N</b></td>
     <td><b>WO#</b></td>
     <td><b>Location</b></td>
     <td><b>Unit Price ($)</b></td>
     <td><b>OnHand</b></td>
     <td><b>Avail.</b></td>
     <td><b>OnHand ($)</b></td>
     <td><b>Avail. ($)</b></td>
    </tr>
   <asp:Repeater ID="rptInvVal" runat="server" DataSourceID="odsInvVal">
    <ItemTemplate>
     <tr valign="top" style="background:#EFF3FB">
      <td colspan="7"><%# Eval("CompanyID") %></td>
      <td align="right"><%# Eval("OnHandTotal", "{0:N}")%></td>
      <td align="right"><%# Eval("AvailTotal", "{0:N}")%></td>
     </tr>
     <asp:Repeater ID="rptInvVal1" runat="server" DataSourceID="odsInvVal1">
      <ItemTemplate>
       <tr valign="top" style="background:#fefaed">
        <td>&nbsp;</td>
        <td><%# Eval("PartNumber") %></td>
        <td><%# Eval("WorkOrder") %></td>
        <td><%# Eval("LocDesc") %></td>
        <td align="right"><%# Eval("UnitPrice", "{0:0.00}")%></td>
        <td align="right"><%# Eval("OnHandQty") %></td>
        <td align="right"><%# Eval("Available") %></td>
        <td align="right"><%# Eval("OnHandTotal", "{0:N}")%></td>
        <td align="right"><%# Eval("AvailTotal", "{0:N}")%></td>
       </tr>
      </ItemTemplate>
     </asp:Repeater>
     <asp:HiddenField ID="hfCustID" runat="server" Value='<%# Eval("CustomerID") %>' />
     <asp:ObjectDataSource ID="odsInvVal1" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="InvVal_S1">
      <SelectParameters>
       <asp:ControlParameter Name="CustID" Type="String" ControlID="hfCustID" PropertyName="Value"  />
       <asp:ControlParameter Name="PartNumber" Type="String" ControlID="txtPartNumber" PropertyName="Text" />
       <asp:ControlParameter Name="WorkOrder" Type="String" ControlID="txtWO" PropertyName="Text" />
       <asp:ControlParameter Name="LocID" Type="String" ControlID="ddlLocation" PropertyName="SelectedValue" />
      </SelectParameters>
     </asp:ObjectDataSource>
    </ItemTemplate>
   </asp:Repeater>
   </table>
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="btnGo" EventName="Click" /></Triggers>
 </aspx:UpdatePanel>
   </td>
   <td>
   <div id="dvEmail" style="display:none;">
   <aspx:UpdatePanel ID="uPnlInvVal1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
    <table style="background:#CCFFCC;">
     <tr><td><b>From:</b></td><td><asp:TextBox ID="txtFrom" runat="server" Width="300px"></asp:TextBox></td></tr>
     <tr><td><b>To:</b></td><td><asp:TextBox ID="txtTo" runat="server" Width="300px"></asp:TextBox></td></tr>
     <tr><td><b>Subject:</b></td><td><asp:TextBox ID="txtSubject" runat="server" Width="300px"></asp:TextBox></td></tr>
     <tr><td colspan="2"><asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine" Width="365px" Height="150px"></asp:TextBox></td></tr>
     <tr>
      <td align="right" colspan="2">
       <asp:Button ID="btnSend" runat="server" Text="Send" OnClick="doSend" CssClass="NavBtn" />
       <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick="javascript:$('#dvEmail').hide(); return false;" CssClass="NavBtn" /><br />
      </td>
     </tr>
    </table>
    <br /><MW:Message ID="iMsg" runat="server" />
    </ContentTemplate>
    <Triggers><aspx:AsyncPostBackTrigger ControlID="btnGo" EventName="Click" /></Triggers>
   </aspx:UpdatePanel>
   </div>
   </td>  
  </tr>
 </table>

 <asp:ObjectDataSource ID="odsInvVal" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="InvVal_S">
  <SelectParameters>
   <asp:ControlParameter Name="CustID" Type="String" ControlID="ddlCustomerName" PropertyName="SelectedValue"  />
   <asp:ControlParameter Name="PartNumber" Type="String" ControlID="txtPartNumber" PropertyName="Text" />
   <asp:ControlParameter Name="WorkOrder" Type="String" ControlID="txtWO" PropertyName="Text" />
   <asp:ControlParameter Name="LocID" Type="String" ControlID="ddlLocation" PropertyName="SelectedValue" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>