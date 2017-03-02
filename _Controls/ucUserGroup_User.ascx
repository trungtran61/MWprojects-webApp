<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucUserGroup_User" Codebehind="ucUserGroup_User.ascx.cs" %>

<br />Please select user ...<br />
<asp:DropDownList ID="ddlUser" runat="server" DataSourceID="odsUser" DataTextField="UserName" DataValueField="UserName" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged"></asp:DropDownList>
<asp:DropDownList ID="ddlSelected" runat="server" AutoPostBack="true">
 <asp:ListItem Value="-1" Text=""></asp:ListItem>
 <asp:ListItem Value="1" Text="Selected"></asp:ListItem>
 <asp:ListItem Value="0" Text="Unselected"></asp:ListItem>
</asp:DropDownList>

<asp:Panel ID="pnlSave" runat="server" Visible="false">
 <br />... and check appropriate box(es)<br />
 <MW:ChkBoxList ID="cblGroup" runat="server" DataSourceID="odsGroup" DataCheckedField="isSelected" DataTextField="gName" DataValueField="HID" RepeatColumns="5"></MW:ChkBoxList>
 <br /><br />Then click save <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="doSave" CssClass="NavBtn" />
 <br /><MW:Message ID="iMsg" runat="server" />
</asp:Panel>
<asp:ObjectDataSource ID="odsUser" runat="server" TypeName="myBiz.DAL.clsUserGroup" SelectMethod="User_S"></asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsGroup" runat="server" TypeName="myBiz.DAL.clsUserGroup" SelectMethod="GroupName_S1">
 <SelectParameters>
  <asp:ControlParameter Name="UserName" Type="String" ControlID="ddlUser" PropertyName="SelectedValue" />
  <asp:ControlParameter Name="isSel" Type="Int32" ControlID="ddlSelected" PropertyName="SelectedValue" />
 </SelectParameters>
</asp:ObjectDataSource>