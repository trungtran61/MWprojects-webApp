<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.childControl" Codebehind="childControl.ascx.cs" %>

<asp:Table ID="tblWindow" CellPadding="1" CellSpacing="1" CssClass="mdlPopup" runat="server" style="display:none;">
 <asp:TableRow><asp:TableCell BackColor="#CCFFCC" HorizontalAlign="Right"><asp:ImageButton ID="imgClose" runat="server" ImageUrl="~/App_Themes/close.jpg" OnClick="imgClose_Click" AlternateText="Close" /></asp:TableCell></asp:TableRow>
 <asp:TableRow><asp:TableCell Height="1px" BackColor="#85226C"></asp:TableCell></asp:TableRow>
 <asp:TableRow><asp:TableCell ID="myCtrl" runat="server"></asp:TableCell></asp:TableRow>
</asp:Table>
<asp:HiddenField ID="hfChildID" runat="server" />
<ajax:ModalPopupExtender ID="MPE" runat="server" TargetControlID="hfChildID" PopupControlID="tblWindow"
 OkControlID="hfChildID" BackgroundCssClass="modalBackground" DropShadow="true" X="10" Y="10"
 RepositionMode="RepositionOnWindowResize" Drag="true" />
