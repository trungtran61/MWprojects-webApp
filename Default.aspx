<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="webApp.Default" %>
<%@ Register Src="~/_Controls/QueueActivity.ascx" TagName="QueueActivity" TagPrefix="ucQA" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnl" runat="server">
  <ContentTemplate>
      <div style="margin-left: 10px;">
  <ucQA:QueueActivity ID="myQueue" runat="server" /></td>
  </div>
      <div id="dvChgPwd" style="margin: 15px 0 0 10px;" runat="server" visible="false">
       Friendly Reminder: Your password has expired!<br />
       Please <a href="ChangePWD.aspx">Change Password</a> now.
      </div>     
  </ContentTemplate>
 </aspx:UpdatePanel>
</asp:Content>
