<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" Inherits="webApp.WIP.Status" Title="WIP Status" Codebehind="Status.aspx.cs" %>
<%@ Register Src="~/_Controls/Progress.ascx" TagName="Progress" TagPrefix="ucProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" Runat="Server">
 <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
  [<a href="../RFQ/Status.aspx">RFQ</a>]<br />
  <table style="background-color:#CCCCCC;">
   <tr>
    <td><b>Work Order#:</b><br /><asp:TextBox ID="txtWO" runat="server" Width="110px"></asp:TextBox>
     <ajax:AutoCompleteExtender ID="aceWorkOrder" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetWorkOrder" TargetControlID="txtWO" />
    </td>
    <td><b>Part Number:</b><br /><asp:TextBox ID="txtPN" runat="server" Width="110px"></asp:TextBox>
     <ajax:AutoCompleteExtender ID="acePartNumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtPN" />
    </td>
    <td><b>Customer PO#:</b><br /><asp:TextBox ID="txtCPO" runat="server" Width="110px"></asp:TextBox>
     <ajax:AutoCompleteExtender ID="aceCPO" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="CustomerPO" TargetControlID="txtCPO" />
    </td>
    <td><b>Customer Job#:</b><br /><asp:TextBox ID="txtCJ" runat="server" Width="110px"></asp:TextBox></td>
    <td><b>Customer Name:</b><br /><asp:TextBox ID="txtCNm" runat="server" Width="110px"></asp:TextBox></td>
    <td><b>Due Date (from):</b><br /><asp:TextBox ID="txtDDf" runat="server" Width="110px"></asp:TextBox>
     <ajax:CalendarExtender ID="calDDf" runat="server" TargetControlID="txtDDf" Format="MM/dd/yy" />
    </td>
    <td><b>Due Date (to):</b><br /><asp:TextBox ID="txtDDt" runat="server" Width="110px"></asp:TextBox>
     <ajax:CalendarExtender ID="calDDt" runat="server" TargetControlID="txtDDt" Format="MM/dd/yy" />
    </td>
   </tr>
   <tr>
    <td colspan="6">
     <asp:CheckBoxList ID="cblStatus" runat="server" RepeatColumns="5" RepeatDirection="Horizontal">
      <asp:ListItem Text="WIP" Value="Open,New:ReRun"></asp:ListItem>
      <asp:ListItem Text="OIP" Value="Open"></asp:ListItem>
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

  <aspx:UpdatePanel ID="uPnlAutoApprove" runat="server" UpdateMode="Conditional">
   <ContentTemplate>
    <br />
    <asp:Button ID="btnAutoApprov" runat="server" Text="Auto Approve" CssClass="NavBtn" OnClick="doAutoApprove" OnClientClick="return confirm('Are you sure you want to auto-approve?');" />
    <asp:Literal ID="litAutoApprove" runat="server"></asp:Literal><br /><br />
    <asp:GridView ID="gvError" runat="server" SkinID="GrayHeader" PageSize="500">
     <Columns>
      <asp:BoundField HeaderText="Work Order" DataField="WorkOrder" SortExpression="WorkOrder" InsertVisible="false" />
      <asp:BoundField HeaderText="Error Message" DataField="eMsg" SortExpression="eMsg" InsertVisible="false" />
     </Columns>
    </asp:GridView>
   </ContentTemplate>
  </aspx:UpdatePanel>
 </asp:Panel>
 <ucProgress:Progress ID="abc" runat="server" />
 <aspx:UpdatePanel ID="uPnlStatus" runat="server" UpdateMode="conditional">
  <ContentTemplate>
   <MW:Message ID="iMsg" runat="server" /><br />
   Next WO#: <%= (new clsWorkOrder()).NextWO %>
   <asp:Literal ID="litCount" runat="server"></asp:Literal>
   <asp:Label ID="showTotal" runat="server" Text="$" onclick="javascript:toggleTotal();" CssClass="Finger" Visible="false"></asp:Label>
   <span id="xTotal" style="display:none"><asp:Literal ID="litTotal" runat="server"></asp:Literal></span>
   <br />
   <asp:Table ID="tblStatus" runat="server" Visible="false" />
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
  function toggleTotal(){
   var tt = document.getElementById('xTotal');
   if (tt.style.display=='none') tt.style.display='inline';
   else tt.style.display='none';
  }
 </script>
</asp:Content>