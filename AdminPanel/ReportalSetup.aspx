<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="ReportalSetup.aspx.cs" Inherits="webApp.AdminPanel.ReportalSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <h3>Reportal Setup</h3>
 <aspx:UpdatePanel ID="uPnlReportal" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvReportal" runat="server" SkinID="Default" DataKeyNames="GraphName,isAcct" DataSourceID="odsReportal">
    <Columns>
     <asp:CommandField ShowEditButton="true" />
     <asp:BoundField HeaderText="Graph Name" ReadOnly="True" DataField="GraphName" InsertVisible="false" />
     <asp:BoundField HeaderText="Month" DataField="PreMonth" InsertVisible="false" />
     <asp:BoundField HeaderText="Goal" DataField="Goal" DataFormatString="{0:0.00}" InsertVisible="false" />
    </Columns>
   </asp:GridView>
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsReportal" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="Reportal_Admin_S" UpdateMethod="Reportal_Admin_U">
  <UpdateParameters>
   <asp:Parameter Name="GraphName" Type="String" />
   <asp:Parameter Name="PreMonth" Type="Int32" />
   <asp:Parameter Name="Goal" Type="Decimal" />
   <asp:Parameter Name="isAcct" Type="Boolean" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>
