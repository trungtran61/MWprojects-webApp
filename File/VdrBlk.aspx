<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VdrBlk.aspx.cs" Inherits="webApp.File.VdrBlk" %>
<%@ Register Src="~/_Controls/ucVdrBlkMatl.ascx" TagName="ucVdrBlkMatl" TagPrefix="ucBlkMatl" %>
<%@ Register Src="~/_Controls/ucVdrBlkGage.ascx" TagName="ucVdrBlkGage" TagPrefix="ucBlkGage" %>
<%@ Register Src="~/_Controls/ucVdrBlkTool.ascx" TagName="ucVdrBlkTool" TagPrefix="ucBlkTool" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <ucBlkMatl:ucVdrBlkMatl ID="ucMatl" runat="server" Visible="false" />
     <ucBlkGage:ucVdrBlkGage ID="ucGage" runat="server" Visible="false" />
     <ucBlkTool:ucVdrBlkTool ID="ucTool" runat="server" Visible="false" />
     <asp:Literal ID="litMsg" runat="server" Text="I am not sure what to do here" Visible="false"></asp:Literal>
    </div>
    </form>
</body>
</html>
