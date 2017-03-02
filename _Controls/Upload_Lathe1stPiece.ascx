<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload_Lathe1stPiece" Codebehind="Upload_Lathe1stPiece.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload Completed 1st Piece Inspection Report For Lathe</h3>
You will be able to upload, edit, view, and print Completed 1st Piece Inspection for Lathe documents from here.<br /><br />
Please click on one of the buttons below to continue ...
<br /><br />
<asp:LinkButton ID="lnkView" runat="server" Text="View 1st Piece & In-Process Inspection Report for Lathe" OnClick="doView" /><br />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />