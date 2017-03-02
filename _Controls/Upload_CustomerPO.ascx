<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload_CustomerPO" Codebehind="Upload_CustomerPO.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload Customer <%= webApp.Common.clsUser.isWIP ? "PO" : "RFQ" %></h3>
You will be able to upload, edit, view, and print Customer <%= webApp.Common.clsUser.isWIP ? "Purchase Order" : "RFQ" %> documents from here.<br /><br />
Please click on one of the buttons below to continue ...
<br />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />