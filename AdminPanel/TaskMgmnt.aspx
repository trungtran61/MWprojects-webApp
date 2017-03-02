<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="TaskMgmnt.aspx.cs" Inherits="webApp.AdminPanel.TaskMgmnt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
<h3><%= this.Title %></h3>
Please select step name: <asp:DropDownList ID="ddlStepName" runat="server" OnDataBound="ddl_Bound" AutoPostBack="true" DataSourceID="odsStepNameList" DataValueField="HID" DataTextField="Name" /><br /><br />
Please check necessary boxes below; then click <b>Save</b><br /><br />
Sort By: <asp:DropDownList ID="ddlOrderBy" runat="server" AutoPostBack="true"><asp:ListItem Selected="true" Value="TaskID ASC" Text="TaskID ASC" /><asp:ListItem Value="TaskID DESC" Text="TaskID DESC" /><asp:ListItem Value="Name ASC" Text="Name ASC" /><asp:ListItem Value="Name DESC" Text="Name DESC" /></asp:DropDownList>
<aspx:UpdatePanel ID="uPnl1" runat="server">
 <ContentTemplate>
  <asp:Table ID="tblTaskMgmnt" runat="server" Visible="false" /><br />
  <asp:Literal ID="litNotFound" runat="server" Text="You have no task required for this step" Visible="false" />
 </ContentTemplate>
 <Triggers>
  <aspx:AsyncPostBackTrigger ControlID="ddlStepName" EventName="SelectedIndexChanged" />
  <aspx:AsyncPostBackTrigger ControlID="ddlOrderBy" EventName="SelectedIndexChanged" />
 </Triggers>
</aspx:UpdatePanel>
<aspx:UpdatePanel ID="uPnl2" runat="server">
 <ContentTemplate>
  <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btn_Save" Visible="false" /><br />
  <asp:Literal ID="litMsg" runat="server" Visible="false" />
 </ContentTemplate>
</aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsStepNameList" runat="server" TypeName="myBiz.DAL.clsStepName" SelectMethod="getStepNameList">
  <SelectParameters><asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" /></SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>
