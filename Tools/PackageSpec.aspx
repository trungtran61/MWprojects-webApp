<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="PackageSpec.aspx.cs" Inherits="webApp.Tools.PackageSpec" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlPackageSpec" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <asp:GridView ID="gvPackageSpec" runat="server" SkinID="Default" DataSourceID="odsPackageSpec" DataKeyNames="HID" ShowFooter="true" OnRowCommand="gvCmd">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" Visible='<%# isYN("k01") %>' />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
      </EditItemTemplate>
      <FooterTemplate>
       <asp:Button ID="btnAdd" Text="Add New" runat="server" CommandName="AddNew" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Name" SortExpression="PackgeName" InsertVisible="false">
      <ItemTemplate><%# Eval("PackageName") %></ItemTemplate>
      <EditItemTemplate>
       <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("PackageName") %>' /></EditItemTemplate>
      <FooterTemplate>
       <asp:TextBox ID="txtName" runat="server" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="File" SortExpression="PackgeName" InsertVisible="false">
      <ItemTemplate>
       <asp:LinkButton ID="lnkView" runat="server" Text="View" CommandName="viewFile" CommandArgument='<%# Eval("HID") %>' />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpload" runat="server" Text="Upload" CommandName="uploadFile" CommandArgument='<%# Eval("HID") %>' />
      </EditItemTemplate>
      <FooterTemplate>N/A</FooterTemplate>
     </asp:TemplateField>
    </Columns>
    <EmptyDataTemplate>
     You have nothing
    </EmptyDataTemplate>
   </asp:GridView>
   <asp:Panel ID="pnlPopup" runat="server"></asp:Panel>
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsPackageSpec" runat="server" TypeName="myBiz.DAL.clsFile" SelectMethod="PackageSpec_S" UpdateMethod="PackageSpec_Save">
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="PackageName" Type="String" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>