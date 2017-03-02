<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload_OPSCert" Codebehind="Upload_OPSCert.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload OPS Certification</h3>
You will be able to upload, edit, view, and print OPS Certification documents from here.<br /><br />
Please click on one of the buttons below to continue ...
<br />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />