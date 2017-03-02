<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload_FirstArticle" Codebehind="Upload_FirstArticle.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload Completed 1st Article Inspection Report</h3>
You will be able to upload, edit, view, and print Completed 1st Article Inspection Report documents from here.<br /><br />
Please click on one of the buttons below to continue ...
<br />
<asp:LinkButton ID="lnkView" runat="server" Text="View 1st Article & Final Inspection Report" OnClick="doView" /><br />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />