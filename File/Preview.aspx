<%@ Page Language="C#" AutoEventWireup="true" Inherits="webApp.File.Preview" Codebehind="Preview.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
 <title>Preview</title>
    <link href="../App_Themes/mwStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
<form id="form1" runat="server">
 <aspx:ScriptManager ID="myScript" runat="server"></aspx:ScriptManager>
 <div>
  <div id="dvForm"><MW:Form ID="frmView" runat="server" /></div>
  <br />
  <MW:Print ID="prtForm" runat="server" CssClass="NavBtn">
   <asp:ListItem Value="dvForm" Text="Form"></asp:ListItem>
  </MW:Print>
  <asp:Button ID="btnEmail" runat="server" Text="Email" CssClass="NavBtn" OnLoad="btnLoad" />
  <asp:Button ID="btnLive" runat="server" Text="Unload Data" CssClass="NavBtn" OnClick="ulData" Visible="false" />
  <asp:Button ID="btnFollowUp" runat="server" Text="Follow Up" CssClass="NavBtn" OnLoad="fuLoad" Visible="false" />

<telerik:RadWindowManager ID="radWindow" runat="server" Skin="Vista" Title="Form Preview">
 <Windows>
  <telerik:RadWindow ID="preview" runat="server" Title="Sending Email" Height="600px" 
  Width="900px" Left="150px" ReloadOnShow="true" VisibleStatusbar="false" ShowContentDuringLoad="false" Modal="true" Skin="Vista" VisibleTitlebar="true" />
 </Windows>
</telerik:RadWindowManager>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadEmail(xURL) { window.radopen(xURL, "preview"); }
  function loadEmail1(xURL) { window.open(xURL); }
 </script>
</telerik:RadCodeBlock>

</div>
</form>
</body>
</html>
