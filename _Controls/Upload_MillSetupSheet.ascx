<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload_MillSetupSheet" Codebehind="Upload_MillSetupSheet.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload Setup Sheet For Mill</h3>
You will be able to upload, edit, view, and print Setup Sheet for Mill documents from here.<br /><br />
Please click on one of the buttons below to continue ...
<br />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />