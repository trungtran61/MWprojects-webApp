<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Tools.CheckPartInventory" Title="Check Part Inventory" Codebehind="CheckPartInventory.aspx.cs" %>
<%@ Register Src="~/_Controls/chkInvByLoc.ascx" TagName="chkInvByLoc" TagPrefix="ucChkInvByLoc" %>
<%@ Register Src="~/_Controls/chkInventory.ascx" TagName="chkInventory" TagPrefix="ucChkInv" %>
<%@ Register Src="~/_Controls/InvUpdate.ascx" TagName="InvUpdate" TagPrefix="ucInvUpdate" %>
<%@ Register Src="~/_Controls/PartInfo.ascx" TagName="PartInfo" TagPrefix="ucPartInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <aspx:UpdatePanel ID="uPnlChkInv" runat="server">
  <ContentTemplate>
 <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnCheck">
  <table>
   <tr>
    <td valign="top">
  <table style="background-color:#CCCCCC;">
   <tr>
    <td><b>Part Number:</b><br /><asp:TextBox ID="txtPartNumber" runat="server"></asp:TextBox>
     <ajax:AutoCompleteExtender ID="acePartNumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtPartNumber">
     </ajax:AutoCompleteExtender>
    </td>
    <td><b>Work Order:</b><br /><asp:TextBox ID="txtWO" runat="server"></asp:TextBox>
     <ajax:AutoCompleteExtender ID="aceWorkOrder" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetWorkOrder" TargetControlID="txtWO" />
    </td>
    <td><b>Location:</b><br /><asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID"></asp:DropDownList>
     <asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
      <SelectParameters>
       <asp:Parameter Name="Dept" Type="String" DefaultValue="Inventory" />
       <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
       <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
      </SelectParameters>
     </asp:ObjectDataSource>
    </td>
   </tr>
   <tr>
    <td colspan="3" align="right">
     <asp:Button ID="btnPrintPreview" runat="server" Text="Print Preview" CssClass="NavBtn" Visible="false" />
     <asp:Button ID="btnInvUpdate" runat="server" Text="Update" OnClientClick="return false;" Visible="false" CssClass="NavBtn" />
     <asp:Button ID="btnCheck" runat="server" Text="Check" OnClick="doCheck" CssClass="NavBtn" />
     <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="doReset" CssClass="NavBtn" />
    </td>
   </tr>
  </table>
    </td>
    <td valign="top"><ucPartInfo:PartInfo ID="PrtInfo" runat="server" Visible="false" /></td>
   </tr>
  </table>
 </asp:Panel>
 <MW:Message ID="iMsg" runat="server" />
 <br /><br />
 <asp:Panel ID="pnlIU" runat="server" Visible="false">
  <asp:Panel ID="pnlInvUpdate" runat="server"><ucInvUpdate:InvUpdate ID="ucInvU" runat="server" /></asp:Panel>
  <ajax:CollapsiblePanelExtender ID="cpeInvUpdate" runat="server" TargetControlID="pnlInvUpdate" ExpandControlID="btnInvUpdate" CollapseControlID="btnInvUpdate" Collapsed="true" />
  <br /><br />
 </asp:Panel>
   <ucChkInv:chkInventory ID="chkInv" runat="server" WOID="0" />
   <ucChkInvByLoc:chkInvByLoc ID="chkInvByLoc" runat="server" LocID="-1" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadPreview(id)
  {
   window.radopen("../File/ShowImage.aspx?PrtImg=" + id, "mPopup");
  }
 </script>
</telerik:RadCodeBlock>
 
</asp:Content>