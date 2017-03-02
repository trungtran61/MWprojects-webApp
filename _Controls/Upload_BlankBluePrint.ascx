<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Upload_BlankBluePrint.ascx.cs" Inherits="webApp._Controls.Upload_BlankBluePrint" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload Blanked Out Blue Print</h3>
You will be able to upload, edit, view, and print Blanked Out Blue Print documents from here.<br /><br />
Please click on one of the buttons below to continue ...
<br />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />