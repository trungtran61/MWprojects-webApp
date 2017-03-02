<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucLAT05" Codebehind="ucLAT05.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>SEND PROGRAM TO MACHINE</h3>
<asp:LinkButton ID="lnkMOT" runat="server" Text="View M.O.T." OnClick="doView" /><br />
<asp:LinkButton ID="lnkPro" runat="server" Text="View Program" OnClick="doView" /><br />

<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />
