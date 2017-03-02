<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload_PartPicture" Codebehind="Upload_PartPicture.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload Picture of Part</h3>
You will be able to upload, edit, view, and print Picture of Part from here.<br /><br />
Please click on one of the buttons below to continue ...
<br />
<asp:Button ID="btnPrtPart" runat="server" Text="Print Part Label" CssClass="NavBtn" OnLoad="btnLoad" />
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />

<telerik:RadWindowManager ID="radWindow" runat="server" Skin="Vista" Title="Form Preview">
 <Windows>
  <telerik:RadWindow ID="preview" runat="server" Title="Form Preview" Height="500px" 
  Width="500px" Left="150px" ReloadOnShow="true" VisibleStatusbar="false" ShowContentDuringLoad="false" Modal="true" Skin="Vista" VisibleTitlebar="true" />
 </Windows>
</telerik:RadWindowManager>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadPreview(id)
  {
   window.radopen("File/ShowImage.aspx?PrtImg=" + id, "preview");
  }
 </script>
</telerik:RadCodeBlock>
