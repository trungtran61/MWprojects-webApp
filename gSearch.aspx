<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.gSearch" Codebehind="gSearch.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" Runat="Server">
 <asp:DataList ID="dlSearch" runat="server" DataSourceID="odsSearch" RepeatColumns="1">
  <ItemTemplate><%# getLinkData() %><br><%# Eval("Description").ToString().Replace("\n", "<br>") %><br><br></ItemTemplate>
  <FooterTemplate><asp:Literal ID="litEmpty" runat="server" Text="No Record Found!" Visible='<%# dlSearch.Items.Count < 1 %>'></asp:Literal></FooterTemplate>
 </asp:DataList>

 <asp:HiddenField ID="hfSearch" runat="server" />
 <asp:ObjectDataSource ID="odsSearch" runat="server" TypeName="myBiz.DAL.clsSearch" SelectMethod="Search">
  <SelectParameters><asp:FormParameter Name="Val" Type="String" FormField="hfVal" /></SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>