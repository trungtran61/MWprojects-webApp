<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload_DeburrPic" Codebehind="Upload_DeburrPic.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload Picture of Deburr Tools</h3>
You will be able to upload, edit, view, and print Picture of Deburr Tools documents from here.<br /><br />
Please click on one of the buttons below to continue ...
<br />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />