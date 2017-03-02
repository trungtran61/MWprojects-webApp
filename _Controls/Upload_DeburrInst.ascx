<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload_DeburrInst" Codebehind="Upload_DeburrInst.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload Deburr Instructions</h3>
<asp:LinkButton ID="lnkBlank" runat="server" Text="View Blank Hand Finish Instruction Sheet" /><br /><br />
You will be able to upload, edit, view, and print Deburr Instructions from here.<br /><br />
Please click on one of the buttons below to continue ...
<br />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />

<iframe name="frmBlank" id="frmBlank" frameborder="0" height="0" width="0"></iframe>
<script language="javascript" type="text/javascript">
 function lFrame(url){
  document.getElementById('frmBlank').src = url;
 }
</script>
