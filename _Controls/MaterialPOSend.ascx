<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MaterialPOSend.ascx.cs" Inherits="webApp._Controls.MaterialPOSend" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>PO FOR MATERIAL TO VENDOR(S)</h3>
Please select the PO preview button to view/send the PO to vendor(s).<br /><br />

<asp:Panel ID="pnlTask" runat="server" Enabled="false">
 <asp:DropDownList ID="ddlPO" runat="server" DataSourceID="odsPO" DataTextField="PONumber" DataValueField="HID" AutoPostBack="true" OnDataBound="poBound" OnSelectedIndexChanged="poSelected" />
 <asp:Button ID="btnPreview" runat="server" Text="Preview" CssClass="NavBtn" Enabled="false" />
 <MW:Message ID="iMsg" runat="server" />
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />

<asp:ObjectDataSource ID="odsPO" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Distinct_PO">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </SelectParameters>
</asp:ObjectDataSource>
