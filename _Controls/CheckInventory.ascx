<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.CheckInventory" Codebehind="CheckInventory.ascx.cs" %>
<%@ Register Src="~/_Controls/chkInventory.ascx" TagName="chkInventory" TagPrefix="ucChkInv" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<asp:Panel ID="pnlTask" runat="server">
 <asp:Button ID="btnCheckInventory" runat="server" Text="Check Inventory" OnClick="doCheck" CssClass="NavBtn" OnPreRender="btnRender" />
 <br /><br />
 <table id="tblUndoCheck" runat="server" visible="false">
  <tr>
   <td>Please click on button above to undo-check inventory.</td>
  </tr>
 </table>
 <table id="tblCheck" runat="server" visible="false">
  <tr>
   <td><ucChkInv:chkInventory ID="chkInv" runat="server" /></td>
  </tr>
 </table>
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />
