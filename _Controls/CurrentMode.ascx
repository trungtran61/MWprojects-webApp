<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.CurrentMode" Codebehind="CurrentMode.ascx.cs" %>
<br /><br />
<asp:Button ID="btnTask" runat="server" Text="Task" OnCommand="Cmd_Click" CommandName="Task" CssClass="NavBtn" CausesValidation="false" />
<asp:Button ID="btnEdit" runat="server" Text="Edit" OnCommand="Cmd_Click" CommandName="Edit" CssClass="NavBtn" CausesValidation="false" />
<asp:Button ID="btnView" runat="server" Text="View" OnCommand="Cmd_Click" CommandName="View" CssClass="NavBtn" CausesValidation="false" />
<MW:Print ID="btnPrint" runat="server" CssClass="NavBtn"><asp:ListItem Value="dvBogus" Text="Form" ></asp:ListItem></MW:Print>
<asp:Button ID="btnComp" runat="server" Text="Mark Complete" OnCommand="Cmd_Click" CommandName="Complete" CssClass="NavBtn" CausesValidation="false" />
<asp:Literal ID="litMsg" runat="server"></asp:Literal>
<div id="dvBogus" style="display:none">What exactly do you want to print?</div>
<asp:HiddenField ID="hfpTask" runat="server" />