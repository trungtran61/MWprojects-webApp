<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Upload_PackagingInst.ascx.cs" Inherits="webApp._Controls.Upload_PackagingInst" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload Packaging Instructions</h3>
<b>Customer PKG Spec:</b>
<asp:Literal ID="litPackage" runat="server" Text="None"></asp:Literal>
<asp:LinkButton ID="lnkPackage" runat="server" OnClick="doFile" OnLoad="LoadCustPackSpec"></asp:LinkButton><br />
<asp:LinkButton ID="lnkBlank" runat="server" Text="View Blank Packaging Instruction Sheet" /><br /><br />
You will be able to upload, edit, view, and print Packaging Instructions from here.<br /><br />
Please click on one of the buttons below to continue ...
<br />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />

<iframe name="frmBlank" id="frmBlank" frameborder="0" height="0" width="0"></iframe>
<script language="javascript" type="text/javascript">
 function lFrame(url) {
  document.getElementById('frmBlank').src = url;
 }
</script>
