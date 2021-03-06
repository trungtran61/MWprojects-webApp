<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucUserGroup_Group" Codebehind="ucUserGroup_Group.ascx.cs" %>

Show Active? <asp:DropDownList ID="ddlAL" runat="server" AutoPostBack="true" DataSourceID="odsActiveList" DataValueField="mValue" DataTextField="mText" /><br />
<table><tr><td valign="top">
<asp:GridView ID="gvGroup" runat="server" SkinID="default" DataKeyNames="HID" DataSourceID="odsGroup" OnRowCommand="gvCmd" ShowFooter="true" OnSelectedIndexChanged="gvChanged">
 <Columns>
  <asp:TemplateField FooterStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top">
   <ItemTemplate>
    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
    <%# getRptLnk() %>
   </ItemTemplate>
   <EditItemTemplate>
    <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="vEdit" />
    <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
   </EditItemTemplate>
   <FooterTemplate><asp:Button ID="btnAdd" Text="New" runat="server" CommandName="AddNew" CssClass="NavBtn" ValidationGroup="vAdd" /></FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField FooterStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" HeaderText="Group Name" SortExpression="gName" InsertVisible="false">
   <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" Text='<%# Eval("gName") %>' CommandName="Select" /></ItemTemplate>
   <EditItemTemplate><asp:TextBox ID="txtgName" runat="server" Text='<%# Bind("gName") %>' />
    <asp:RequiredFieldValidator ID="rfvgName" runat="server" ErrorMessage="Group Name is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtgName" ValidationGroup="vEdit" />
   </EditItemTemplate>
   <FooterTemplate><asp:TextBox ID="txtgName" runat="server" />
    <asp:RequiredFieldValidator ID="rfvgName" runat="server" ErrorMessage="Group Name is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtgName" ValidationGroup="vAdd" />
   </FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField FooterStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" HeaderText="Group Note" SortExpression="gNote" InsertVisible="false">
   <ItemTemplate><%# Eval("gNote") %></ItemTemplate>
   <EditItemTemplate><asp:TextBox ID="txtgNote" runat="server" TextMode="MultiLine" Text='<%# Bind("gNote") %>' /></EditItemTemplate>
   <FooterTemplate><asp:TextBox ID="txtgNote" TextMode="MultiLine" runat="server" /></FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField FooterStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" HeaderText="Active" InsertVisible="false">
   <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' Enabled="false" /></ItemTemplate>
   <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' /></EditItemTemplate>
   <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" /></FooterTemplate>
  </asp:TemplateField>
 </Columns>
</asp:GridView>
<br />
<asp:ValidationSummary ID="vsEdit" runat="server" ValidationGroup="vEdit" />
<asp:ValidationSummary ID="vsAdd" runat="server" ValidationGroup="vAdd" />
</td><td valign="top">
<asp:Panel ID="pnlSave" runat="server" Visible="false">
 Please select appropriate user(s) to add to selected group.<br />
 <MW:ChkBoxList ID="cblUser" runat="server" DataSourceID="odsUser" DataCheckedField="isSelected" DataTextField="UserName" DataValueField="UserName" RepeatColumns="5"></MW:ChkBoxList>
 <br /><br />Then click save <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="doSave" CssClass="NavBtn" />
 <br /><MW:Message ID="iMsg" runat="server" />
</asp:Panel>
</td></tr></table>

<asp:ObjectDataSource ID="odsActiveList" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
 <SelectParameters>
  <asp:Parameter Name="Cate" Type="String" DefaultValue="ActiveList" />
  <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="0" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsUser" runat="server" TypeName="myBiz.DAL.clsUserGroup" SelectMethod="GroupUser_S">
 <SelectParameters>
  <asp:ControlParameter Name="GroupID" Type="Int32" ControlID="gvGroup" PropertyName="SelectedValue" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsGroup" runat="server" TypeName="myBiz.DAL.clsUserGroup" SelectMethod="GroupName_S2" UpdateMethod="GroupName_Save">
 <SelectParameters><asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlAL" PropertyName="SelectedValue" /></SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="gName" Type="String" />
  <asp:Parameter Name="gNote" Type="String" />
  <asp:Parameter Name="isActive" Type="Boolean" />
 </UpdateParameters>
</asp:ObjectDataSource>