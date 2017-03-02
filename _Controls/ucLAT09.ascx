<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucLAT09" Codebehind="ucLAT09.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>In-Process INSPECTION REPORT</h3>

<ucMode:CurrentMode ID="myMode" runat="server" />
<br /><MW:Message ID="iMsg" runat="server" />

<div id="dvForm" style="display:none"><MW:Form ID="frmInspection" runat="server" /></div>