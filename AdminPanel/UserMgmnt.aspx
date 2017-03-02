<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="UserMgmnt.aspx.cs" Inherits="webApp.AdminPanel.UserMgmnt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
Please select a user from the list below; then check whether or not a user is in the group on the bottom.
<br />Don't forget to click save.
<br /><br />
 <aspx:ScriptManager ID="ScriptManager1" runat="server">
 </aspx:ScriptManager>
 <aspx:UpdatePanel ID="UpdatePanel1" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvUser" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="mwUserName" DataSourceID="sdsUser" ForeColor="#333333" GridLines="None" ShowFooter="true"
    OnRowDataBound="gv_Bound" OnRowUpdating="gv_Update" OnRowDeleting="gv_Delete" OnSelectedIndexChanged="gv_Changed">
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <RowStyle BackColor="#EFF3FB" />
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" OnClick="lnk_Reset" />
       <asp:LinkButton ID="lnkDelete" runat="server" Text="Remove" CommandName="Delete" OnClick="lnk_Reset" OnClientClick="return confirm('Are you sure you want to remove?');" />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
      </EditItemTemplate>
      <FooterTemplate><asp:Button ID="btnAdd" Text="Add New" runat="server" OnClick="btnAdd_Click" ValidationGroup="grpNew" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Username">
      <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" Text='<%# Eval("mwUserName") %>' CommandName="Select" /></ItemTemplate>
      <EditItemTemplate><%# Eval("mwUserName") %></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtmwUserName" runat="server" Width="75px" Text='<%# Bind("mwUserName") %>'></asp:TextBox>
       <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Username is required!" Text="*" ControlToValidate="txtmwUserName" ValidationGroup="grpNew"></asp:RequiredFieldValidator>
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Password">
      <ItemTemplate>**********</ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtmwPassword" runat="server" Width="75px" TextMode="password" Text='<%# Bind("mwPassword") %>'></asp:TextBox></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtmwPassword" runat="server" Width="75px" TextMode="password" Text='<%# Bind("mwPassword") %>'></asp:TextBox></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Name">
      <ItemTemplate><%# Eval("mwName") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtmwName" runat="server" Text='<%# Bind("mwName") %>'></asp:TextBox></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtmwName" runat="server" Text='<%# Bind("mwName") %>'></asp:TextBox></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Email">
      <ItemTemplate><%# Eval("mwEmail") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtmwEmail" runat="server" Text='<%# Bind("mwEmail") %>'></asp:TextBox></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtmwEmail" runat="server" Text='<%# Bind("mwEmail") %>'></asp:TextBox></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Active">
      <ItemTemplate><asp:CheckBox ID="chkmwActive" runat="server" Enabled="false" Checked='<%# Eval("mwActive") %>' /></ItemTemplate>
      <EditItemTemplate>
       <asp:CheckBox ID="chkmwActive" runat="server" Checked='<%# Bind("mwActive") %>' />
      </EditItemTemplate>
      <FooterTemplate>
       <asp:CheckBox ID="chkmwActive" runat="server" Checked='<%# Bind("mwActive") %>' />
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Title">
      <ItemTemplate><asp:Literal ID="litTitle" runat="server"></asp:Literal></ItemTemplate>
      <EditItemTemplate><asp:Literal ID="litTitle" runat="server"></asp:Literal></EditItemTemplate>
      <FooterTemplate>N/A</FooterTemplate>
     </asp:TemplateField>
    </Columns>
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#9999CC" />
    <AlternatingRowStyle BackColor="White" />
   </asp:GridView>
   <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ValidationGroup="grpNew" />
   <br /><br />
   <asp:Panel ID="pnlCB" runat="server" Visible="false">
    <b>Check whether a selected user is in the group<br />Don't forget to click save.</b>
    <asp:CheckBoxList ID="cblGroup" runat="server" BackColor="#FFFFCC" RepeatColumns="3" DataSourceID="sdsGroup" DataTextField="mwGroup" DataValueField="mwGroup">
    </asp:CheckBoxList><br />
    <asp:LinkButton ID="lnkSave" runat="server" Text="Save" OnClick="lnk_Save" />
    <a href="mwGroup.aspx">Manage Group</a>
   </asp:Panel>
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:SqlDataSource ID="sdsGroup" runat="server" ConnectionString="<%$ ConnectionStrings:DefCS %>" SelectCommand="SELECT DISTINCT mwGroup FROM MWGroup WHERE mwGroup NOT IN ('Admin') ORDER BY mwGroup"></asp:SqlDataSource>
 <asp:SqlDataSource ID="sdsUser" runat="server" ConnectionString="<%$ ConnectionStrings:DefCS %>" SelectCommand="SELECT mwUserName,mwPassword,mwName,mwEmail,mwActive FROM MWUser ORDER BY mwName"
  UpdateCommand="UPDATE MWUser SET mwPassword=@mwPassword,mwName=@mwName,mwEmail=@mwEmail,mwPasswordDate=getdate(),mwActive=@mwActive WHERE mwUserName=@mwUserName"
  DeleteCommand="DELETE FROM MWUser WHERE mwUserName=@mwUserName"
  InsertCommand="IF EXISTS(SELECT mwUserName FROM MWUser WHERE mwUserName=@mwUserName) RAISERROR ('Username is already existed!',16,1) ELSE INSERT INTO MWUser (mwUserName,mwPassword,mwName,mwEmail,mwPasswordDate,mwActive) VALUES (@mwUserName,@mwPassword,@mwName,@mwEmail,getdate(),@mwActive)">
  <DeleteParameters>
   <asp:Parameter Name="mwUserName" Type="String" />
  </DeleteParameters>
  <UpdateParameters>
   <asp:Parameter Name="mwUserName" Type="String" />
   <asp:Parameter Name="mwPassword" Type="String" />
   <asp:Parameter Name="mwName" Type="String" />
   <asp:Parameter Name="mwEmail" Type="String" />
   <asp:Parameter Name="mwActive" Type="Byte" />
  </UpdateParameters>
  <InsertParameters>
   <asp:Parameter Name="mwUserName" Type="String" />
   <asp:Parameter Name="mwPassword" Type="String" />
   <asp:Parameter Name="mwName" Type="String" />
   <asp:Parameter Name="mwEmail" Type="String" />
   <asp:Parameter Name="mwActive" Type="Byte" />
  </InsertParameters>
 </asp:SqlDataSource>
</asp:Content>