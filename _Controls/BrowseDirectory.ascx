<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.BrowseDirectory" Codebehind="BrowseDirectory.ascx.cs" %>

<asp:TextBox ID="txtFile" runat="server"></asp:TextBox><asp:Button ID="btnBrowse" runat="server" Text="Browse ..." OnClick="btnBrowse_Click" />
<asp:Panel ID="pnlList" runat="server" Visible="false">
 <asp:ListBox ID="lbxList" runat="server" Rows="10"></asp:ListBox><br />
 <asp:Button ID="btnUp" runat="server" Text="Up One Level" OnClick="btnUp_Click" />
 <asp:Button ID="btnOpen" runat="server" Text="Open" OnClick="btnOpen_Click" />
</asp:Panel>
<asp:HiddenField ID="hfCurrentDirectory" runat="server" />
