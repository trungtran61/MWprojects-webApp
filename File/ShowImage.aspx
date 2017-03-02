<%@ Page Language="C#" AutoEventWireup="true" Inherits="webApp.File.ShowImage" Codebehind="ShowImage.aspx.cs" %>
<%@ Register Src="~/_Controls/PartLabel.ascx" TagName="PartLabel" TagPrefix="ucPrtLbl" %>
<%@ Register Src="~/_Controls/ShippingLabel.ascx" TagName="ShippingLabel" TagPrefix="ucShipLbl" %>
<%@ Register Src="~/_Controls/TransferImage.ascx" TagName="TransferImage" TagPrefix="ucTrImg" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <ucTrImg:TransferImage ID="trImage" runat="server" Visible="false" />
    <ucShipLbl:ShippingLabel ID="shipLabel" runat="server" Visible="false" />
    <ucPrtLbl:PartLabel ID="PrtLbl" runat="server" Visible="false" /><br />
    <asp:Button ID="prtForm" runat="server" OnClientClick="javascript:self.print();return false;" Text="Print" />
    <asp:Literal ID="litMsg" runat="server"></asp:Literal>
    </div>
    </form>
</body>
</html>
