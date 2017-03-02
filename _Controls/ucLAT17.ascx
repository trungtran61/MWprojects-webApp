<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucLAT17" Codebehind="ucLAT17.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload Proven Program</h3>
You will be able to upload, edit, view, and print Proven Program documents from here.<br /><br />
Please click on one of the buttons below to continue ...
<br />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />