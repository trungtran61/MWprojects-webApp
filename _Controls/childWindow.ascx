<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.childWindow" Codebehind="childWindow.ascx.cs" %>

<asp:Table ID="tblPopup" CellPadding="0" CellSpacing="0" CssClass="modalPopup" runat="server" style="display:none;">
 <asp:TableRow ID="trTitle" BackColor="#CCFFCC" runat="server">
  <asp:TableCell Height="20px" Font-Bold="true"><asp:Literal ID="litTitle" runat="server" /></asp:TableCell>
  <asp:TableCell Height="20px" HorizontalAlign="Right"><asp:ImageButton ID="imgClose" runat="server" ImageUrl="~/App_Themes/close.jpg" AlternateText="Close" /></asp:TableCell>
 </asp:TableRow>
 <asp:TableRow><asp:TableCell ColumnSpan="2" Height="1px" BackColor="#85226C"></asp:TableCell></asp:TableRow>
 <asp:TableRow><asp:TableCell Height="100%" ColumnSpan="2"><asp:Literal ID="litURL" runat="server" /></asp:TableCell></asp:TableRow>
</asp:Table>
<asp:HiddenField ID="hfChildID" runat="server" />
<ajax:ModalPopupExtender ID="MPE" runat="server" TargetControlID="hfChildID" PopupControlID="tblPopup" X="550" Y="10"
 OkControlID="imgClose" BackgroundCssClass="modalBackground" DropShadow="true" RepositionMode="RepositionOnWindowResize" Drag="true" />
