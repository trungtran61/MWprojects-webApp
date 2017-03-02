<%@ Page Language="C#" AutoEventWireup="true" Inherits="webApp.File.sendEmail" Codebehind="sendEmail.aspx.cs" %>
<%@ Register Src="~/_Controls/sendEmail.ascx" TagName="sendEmail" TagPrefix="ucEmail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Sending Email</title>
    <link href="../App_Themes/mwStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <aspx:ScriptManager ID="scrManager" runat="server"></aspx:ScriptManager>
    <div>
    <ucEmail:sendEmail ID="ucEmail" runat="server" />
    </div>
    </form>
</body>
</html>
