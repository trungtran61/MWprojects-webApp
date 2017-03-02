<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload_FAIRFIN" Codebehind="Upload_FAIRFIN.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload 1st Article & Finial Inspection Report</h3>
You will be able to upload, edit, view, and print 1st Article & Final Inspection Report documents from here.<br /><br />
Please click on one of the buttons below to continue ...
<br /><br />
<asp:LinkButton ID="lnkBlank" runat="server" Text="View Blank 1st Article & Final Inspection Report" />
<br />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />

<iframe name="frmBlank" id="frmBlank" frameborder="0" height="0" width="0"></iframe>
<script language="javascript" type="text/javascript">
 function lFrame(url) {
  document.getElementById('frmBlank').src = url;
 }
</script>