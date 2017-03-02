<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.msgWindow" Codebehind="msgWindow.ascx.cs" %>

<asp:Table ID="tblWindow" CellPadding="0" CellSpacing="0" CssClass="mdlPopup" Width="300px" Height="75px" runat="server" style="display:none;">
 <asp:TableRow>
  <asp:TableCell Height="20px" BackColor="#CCFFCC" HorizontalAlign="Left"><asp:Literal ID="litTitle" runat="server" /></asp:TableCell>
  <asp:TableCell Height="20px" BackColor="#CCFFCC" HorizontalAlign="Right"><asp:ImageButton ID="imgClose" runat="server" ImageUrl="~/App_Themes/close.jpg" AlternateText="Close" /></asp:TableCell>
 </asp:TableRow>
 <asp:TableRow><asp:TableCell ColumnSpan="2" Height="1px" BackColor="#85226C"></asp:TableCell></asp:TableRow>
 <asp:TableRow><asp:TableCell ColumnSpan="2" VerticalAlign="middle" HorizontalAlign="center" Height="100%" Font-Bold="true"><asp:Literal ID="litMsg" runat="server" /></asp:TableCell></asp:TableRow>
</asp:Table>
<asp:HiddenField ID="hfID" runat="server" />
<ajax:ModalPopupExtender ID="MPE" runat="server" TargetControlID="hfID" PopupControlID="tblWindow" OkControlID="imgClose" BackgroundCssClass="mdlBackground" DropShadow="true"
 RepositionMode="RepositionOnWindowResize" />