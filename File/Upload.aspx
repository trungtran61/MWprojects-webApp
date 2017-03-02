<%@ Page Language="C#" AutoEventWireup="true" Inherits="webApp.File.Upload" Codebehind="Upload.aspx.cs" %>
<%@ Register Src="../_Controls/Upload.ascx" TagName="Upload" TagPrefix="uc1" %>
<%@ Register Src="../_Controls/Download.ascx" TagName="Download" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Upload File</title>
    <link href="~/App_Themes/mwStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <table>
      <tr>
       <td valign="top"><uc1:Upload ID="UL" runat="server" /></td>
       <td valign="top"><uc2:Download ID="DL" runat="server" /></td>
      </tr>
     </table>
    </div>
    </form>
</body>
</html>
