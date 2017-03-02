<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucQTE02.ascx.cs" Inherits="webApp._Controls.ucQTE02" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3><%= myMode.ActionName %> Quote</h3>

Please select Final Quote below to start viewing and/or send to customer.<br />

<asp:Panel ID="pnlTask" runat="server" Enabled="false">
 <asp:DropDownList ID="ddlQTE" runat="server" DataSourceID="odsQTE" DataTextField="QTENumber" DataValueField="QTEID" AutoPostBack="true" OnDataBound="ddlChanged" OnSelectedIndexChanged="ddlChanged"></asp:DropDownList>
 <asp:Button ID="btnPreview" runat="server" Text="Preview" CssClass="NavBtn" />
 <MW:Message ID="iMsg" runat="server" />
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />

<asp:ObjectDataSource ID="odsQTE" runat="server" TypeName="myBiz.DAL.clsFollowUp" SelectMethod="RFQ_FollowUp">
 <SelectParameters><asp:Parameter Name="St" Type="String" DefaultValue="Open" /></SelectParameters>
</asp:ObjectDataSource>