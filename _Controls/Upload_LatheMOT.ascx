<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload_LatheMOT" Codebehind="Upload_LatheMOT.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload M.O.T. For Lathe</h3>
You will be able to upload, edit, view, and print M.O.T. for Lathe documents from here.<br /><br />
Please click on one of the buttons below to continue ...
<br />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />