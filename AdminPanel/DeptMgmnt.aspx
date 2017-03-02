<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="DeptMgmnt.aspx.cs" Inherits="webApp.AdminPanel.DeptMgmnt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <h3>Department Management</h3>
 <aspx:UpdatePanel ID="uPnlDeptMgmnt" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvDeptMgmnt" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsDeptMgmnt">
    <Columns>
     <asp:CommandField ShowEditButton="true" />
     <asp:BoundField HeaderText="Department" ReadOnly="True" DataField="Name" InsertVisible="false" />
     <asp:CheckBoxField HeaderText="WIP" DataField="isWIP" InsertVisible="false" />
     <asp:CheckBoxField HeaderText="RFQ" DataField="isRFQ" InsertVisible="false" />
    </Columns>
   </asp:GridView>
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsDeptMgmnt" runat="server" TypeName="myBiz.DAL.clsDept" SelectMethod="DeptMgmnt_S" UpdateMethod="DeptMgmnt_U">
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="isWIP" Type="Boolean" />
   <asp:Parameter Name="isRFQ" Type="Boolean" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>
