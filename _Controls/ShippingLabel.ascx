<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ShippingLabel" Codebehind="ShippingLabel.ascx.cs" %>
<%@ Register Src="~/_Controls/PartLabel.ascx" TagName="PartLabel" TagPrefix="ucPrtLbl" %>

<asp:FormView ID="fvShippingLabel" runat="server" DataSourceID="odsShippingLabel">
 <ItemTemplate>
  <table style="font-size: 20px;" cellpadding="5">
   <tr>
    <td valign="top">From:</td>
    <td valign="top">
     <%# Eval("fromCompanyName") %><br />
     <%# Eval("fromAddress1")%><br />
     <%# Eval("fromCity")%>, <%# Eval("fromState")%> <%# Eval("fromZip")%>
    </td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td valign="top">To:</td>
    <td valign="top">
     <%# Eval("toCompanyName") %><br />
     <%# Eval("toAddress1") %><br />
     <%# Eval("toCity")%>, <%# Eval("toState")%> <%# Eval("toZip")%>
    </td>
   </tr>
   <tr><td colspan="5"><br /><br /><br /></td></tr>
   <tr>
    <td>&nbsp;</td>
    <td valign="top"><ucPrtLbl:PartLabel ID="PrtLabel" runat="server" PartID='<%# Eval("PartID") %>' /></td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td>&nbsp;</td>
    <td valign="top">
     QTY: <%# Eval("sQty")%> PCS<br />
     Shipper#: <%# Eval("PackNum")%><br />
     Customer P.O #: <%# Eval("CustomerPO")%> Line# <%# Eval("Line")%><br />
     Customer Job# <%# Eval("CustJob")%><br />
     Boxes:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OF
    </td>
   </tr>
  </table>
 </ItemTemplate>
</asp:FormView>

<asp:ObjectDataSource ID="odsShippingLabel" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="getShippingLabel">
 <SelectParameters><asp:Parameter Name="PackingID" Type="Int32" /></SelectParameters>
</asp:ObjectDataSource>