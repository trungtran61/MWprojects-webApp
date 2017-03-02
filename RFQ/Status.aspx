<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" Inherits="webApp.RFQ.Status" Title="RFQ Status" CodeBehind="Status.aspx.cs" %>
<%@ Register Src="~/_Controls/Progress.ascx" TagName="Progress" TagPrefix="ucProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
  [<a href="../WIP/Status.aspx">WIP</a>]<br />
  <table style="background-color:#CCCCCC;">
   <tr>
    <td><b>Quote#:</b><br /><asp:TextBox ID="txtRFQ" runat="server" Width="110px"></asp:TextBox>
     <ajax:AutoCompleteExtender ID="aceRFQ" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetRFQ" TargetControlID="txtRFQ" />
    </td>
    <td><b>Part Number:</b><br /><asp:TextBox ID="txtPN" runat="server" Width="110px"></asp:TextBox>
     <ajax:AutoCompleteExtender ID="acePartNumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtPN" />
    </td>
    <td><b>Customer RFQ#:</b><br /><asp:TextBox ID="txtCRFQ" runat="server" Width="110px"></asp:TextBox>
     <ajax:AutoCompleteExtender ID="aceCRFQ" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="CustomerPO" TargetControlID="txtCRFQ" />
    </td>
    <td><b>Customer Name:</b><br /><asp:TextBox ID="txtCNm" runat="server" Width="110px"></asp:TextBox></td>
    <td><b>Due Date (from):</b><br /><asp:TextBox ID="txtDDf" runat="server" Width="110px"></asp:TextBox>
     <ajax:CalendarExtender ID="calDDf" runat="server" TargetControlID="txtDDf" Format="MM/dd/yy" />
    </td>
    <td><b>Due Date (to):</b><br /><asp:TextBox ID="txtDDt" runat="server" Width="110px"></asp:TextBox>
     <ajax:CalendarExtender ID="calDDt" runat="server" TargetControlID="txtDDt" Format="MM/dd/yy" />
    </td>
   </tr>
   <tr>
    <td colspan="5">
     <asp:CheckBoxList ID="cblStatus" runat="server" RepeatColumns="4" RepeatDirection="Horizontal">
      <asp:ListItem Text="QIP" Value="Open"></asp:ListItem>
      <asp:ListItem Text="PDA" Value="PostAudit:PreCompleted"></asp:ListItem>
      <asp:ListItem Text="HIS" Value="Completed"></asp:ListItem>
      <asp:ListItem Text="CAN" Value="Cancel"></asp:ListItem>
     </asp:CheckBoxList>    
    </td>
    <td align="right">
     <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="NavBtn" />
     <asp:Button ID="btnReset" runat="server" Text="Reset" OnClientClick="javascript:document.forms[0].reset(); return false;" CssClass="NavBtn" />
    </td>
   </tr>
  </table>
 </asp:Panel>
 <ucProgress:Progress ID="abc" runat="server" />
 <aspx:UpdatePanel ID="uPnlStatus" runat="server" UpdateMode="conditional">
  <ContentTemplate>
   <MW:Message ID="iMsg" runat="server" /><br />
   Next RFQ#: <%= (new clsRFQ()).NextRFQ %>
   <asp:Literal ID="litCount" runat="server"></asp:Literal>
   <asp:Label ID="showTotal" runat="server" Text="$" onclick="javascript:toggleTotal();" CssClass="Finger" Visible="false"></asp:Label>
   <span id="xTotal" style="display:none"><asp:Literal ID="litTotal" runat="server"></asp:Literal></span>
   <br />
   <asp:Table ID="tblStatus" runat="server" Visible="false" />
   <asp:GridView ID="gvStatus" runat="server">
    <Columns>
     <asp:BoundField HeaderText="RFQ" DataField="RFQ" />
    </Columns>
   </asp:GridView>
   <asp:ObjectDataSource ID="odsStatus" runat="server" TypeName="myBiz.DAL.clsRFQ" SelectMethod="RFQ_S">
    
   </asp:ObjectDataSource>
  </ContentTemplate>
  <Triggers>
   <aspx:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
  </Triggers>
 </aspx:UpdatePanel>
 <aspx:UpdatePanel ID="uPnlTask" runat="server" UpdateMode="conditional">
  <ContentTemplate>
   <asp:LinkButton ID="lnkControl" runat="server" OnClick="lnkCmd" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:HiddenField ID="hfValx" runat="server" />
 <script language="javascript" type="text/javascript">
  function toggleTotal() {
   var tt = document.getElementById('xTotal');
   if (tt.style.display == 'none') tt.style.display = 'inline';
   else tt.style.display = 'none';
  }
 </script>
</asp:Content>
