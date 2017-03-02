<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Errors.Invalid" Title="Error: Invalid Command!" Codebehind="Invalid.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" Runat="Server">
 <table width="100%">
  <tr><td align="center"><h1><asp:Literal ID="litMessage" runat="server"></asp:Literal></h1></td></tr>
  <tr><td align="center"><a href="../Default.aspx">Send me back home!</a></td></tr>
 </table>
</asp:Content>

