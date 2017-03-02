<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.AdminPanel.LocationMgmnt" Title="Location Management" Codebehind="LocationMgmnt.aspx.cs" %>
<%@ Register Src="~/_Controls/Progress.ascx" TagName="Progress" TagPrefix="ucProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <h3>Location Management</h3>
 <ucProgress:Progress ID="abc" runat="server" />
 <aspx:UpdatePanel ID="UpdatePanel1" runat="server">
  <ContentTemplate>
   Show Active? <asp:DropDownList ID="ddlAL" runat="server" AutoPostBack="true" DataSourceID="odsActiveList" DataValueField="mValue" DataTextField="mText" /><br /><br />
   Department: <asp:DropDownList ID="ddlDept" runat="server" AutoPostBack="true" DataSourceID="odsDept" DataValueField="Dept" DataTextField="Dept" /><br /><br />
   <asp:GridView ID="gvLocation" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsLocation" ShowFooter="true">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="vEdit" />
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
      </EditItemTemplate>
      <FooterTemplate><asp:Button ID="btnAdd" Text="Add New" runat="server" OnClick="btnAdd_Click" ValidationGroup="vAdd" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="ID" SortExpression="DescID" InsertVisible="false">
      <ItemTemplate><%# Eval("DescID") %></ItemTemplate>
      <EditItemTemplate><asp:Literal ID="litDescID" runat="server" Text='<%# Bind("DescID") %>' /></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtDescID" runat="server" Text='<%# Bind("DescID") %>' />
       <asp:RequiredFieldValidator ID="rfvDescID" runat="server" ErrorMessage="ID is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtDescID" ValidationGroup="vAdd" />
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Description" SortExpression="Description" InsertVisible="false">
      <ItemTemplate><%# Eval("Description") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' />
       <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Description is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtDescription" ValidationGroup="vEdit" />
      </EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' />
       <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Description is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtDescription" ValidationGroup="vAdd" />
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Dept" SortExpression="Dept" InsertVisible="false">
      <ItemTemplate><%# Eval("Dept") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtDept" runat="server" Text='<%# Bind("Dept") %>' /></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtDept" runat="server" Text='<%# Bind("Dept") %>' /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Active" InsertVisible="false">
      <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' Enabled="false" /></ItemTemplate>
      <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' /></EditItemTemplate>
      <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' /></FooterTemplate>
     </asp:TemplateField>
    </Columns>
    <EmptyDataTemplate>No Location Found!</EmptyDataTemplate>
   </asp:GridView>
   <br />
    <asp:ValidationSummary ID="vsEdit" runat="server" ValidationGroup="vEdit" />
    <asp:ValidationSummary ID="vsAdd" runat="server" ValidationGroup="vAdd" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsDept" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Distinct_Dept" />
 <asp:ObjectDataSource ID="odsActiveList" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="ActiveList" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="0" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select" UpdateMethod="Save" InsertMethod="Save">
  <SelectParameters>
   <asp:ControlParameter ControlID="ddlDept" PropertyName="SelectedValue" Name="Dept" Type="String" />
   <asp:ControlParameter ControlID="ddlAL" PropertyName="SelectedValue" Name="isActive" Type="Int32" />
   <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="False" />
  </SelectParameters>
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="DescID" Type="String" />
   <asp:Parameter Name="Description" Type="String" />
   <asp:Parameter Name="Dept" Type="String" />
   <asp:Parameter Name="isActive" Type="Boolean" />
  </UpdateParameters>
  <InsertParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="DescID" Type="String" />
   <asp:Parameter Name="Description" Type="String" />
   <asp:Parameter Name="Dept" Type="String" />
   <asp:Parameter Name="isActive" Type="Boolean" />
  </InsertParameters>
 </asp:ObjectDataSource>
</asp:Content>