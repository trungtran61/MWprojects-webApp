<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ToolRFQSend.ascx.cs" Inherits="webApp._Controls.ToolRFQSend" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>RFQ FOR TOOL TO VENDOR(S)</h3>
Please select the RFQ preview button to view/send the RFQ to vendor(s).<br /><br />

<asp:Panel ID="pnlTask" runat="server" Enabled="false">
 <b>RFQ Number:</b> <asp:DropDownList ID="ddlRFQ" runat="server" DataSourceID="odsRFQ" DataTextField="RFQNumber" DataValueField="RFQNumber" AutoPostBack="true" OnDataBound="rfqBound" OnSelectedIndexChanged="rfqSelected" />
 <asp:Button ID="btnPreview" runat="server" Text="Preview" CssClass="NavBtn" Enabled="false" />
 <MW:Message ID="iMsg" runat="server" />
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />

<asp:ObjectDataSource ID="odsRFQ" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Distinct_RFQ">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </SelectParameters>
</asp:ObjectDataSource>