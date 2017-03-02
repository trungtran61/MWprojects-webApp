<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload_Mill1stPiece" Codebehind="Upload_Mill1stPiece.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload Completed 1st Piece Inspection Report For Mill</h3>
You will be able to upload, edit, view, and print Completed 1st Piece Inspection for Mill documents from here.<br /><br />
Please click on one of the buttons below to continue ...
<br />
<asp:LinkButton ID="lnkView" runat="server" Text="View 1st Piece & In-Process Inspection Report for Mill" OnClick="doView" /><br />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />