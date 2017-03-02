<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.ChangePWD" Title="Change Password!" Codebehind="ChangePWD.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
<aspx:UpdatePanel ID="uPnlChange" runat="server">
 <ContentTemplate>
  <asp:Literal ID="litEpwd" runat="server" Text="Your password has expired! Please change your password.<br>" Visible="false"></asp:Literal><br />
  <fieldset>
   <legend>Please complete form below to change password</legend>
   <table>
    <tr valign="top">
     <td align="right"><b>Old Password:</b></td>
     <td><asp:TextBox ID="txtoPWD" runat="server" TextMode="Password"></asp:TextBox></td>
    </tr>
    <tr valign="top">
     <td align="right"><b>New Password:</b></td>
     <td>
      <asp:TextBox ID="txtnPWD" runat="server" TextMode="Password"></asp:TextBox>
      <asp:RequiredFieldValidator ID="rfvnPWD" runat="server" ControlToValidate="txtnPWD" ErrorMessage="New Password is required!" Text="*"></asp:RequiredFieldValidator>
      <asp:RegularExpressionValidator ID="revnPWD" runat="server" ControlToValidate="txtnPWD" ErrorMessage="New Password is invalid!" Text="*"
       ValidationExpression="(?=^.{6,20}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"></asp:RegularExpressionValidator>
     </td>
    </tr>
    <tr valign="top">
     <td align="right"><b>Confirm New Password:</b></td>
     <td>
      <asp:TextBox ID="txtcPWD" runat="server" TextMode="Password"></asp:TextBox>
      <asp:CompareValidator ID="cvcPWD" runat="server" ControlToValidate="txtcPWD" ControlToCompare="txtnPWD" Type="String" Operator="Equal" ErrorMessage="Passowrd does not match!" Text="*"></asp:CompareValidator>
     </td>
    </tr>
    <tr><td colspan="2" align="right"><asp:Button ID="btnChange" runat="server" Text="Change" OnClick="doChange" CssClass="NavBtn" /></td></tr>
   </table>
   <MW:Message ID="iMsg" runat="server" />
   <asp:ValidationSummary ID="vsChange" runat="server" />
  </fieldset>
 </ContentTemplate>
</aspx:UpdatePanel>
</asp:Content>