<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="RanChkPrtInv.aspx.cs" Inherits="webApp.Tools.RanChkPrtInv" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlAvailable" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvAvailable" runat="server" SkinID="Default" DataSourceID="odsAvailable" DataKeyNames="WOID" AllowSorting="false">
    <Columns>
     <asp:BoundField HeaderText="WO#" DataField="WO" SortExpression="WO" InsertVisible="false" />
     <asp:BoundField HeaderText="PN" DataField="PN" SortExpression="PN" InsertVisible="false" />
     <asp:BoundField HeaderText="Rev" DataField="Rev" SortExpression="Rev" InsertVisible="false" />
     <asp:BoundField HeaderText="Order Qty" DataField="oQty" SortExpression="oQty" InsertVisible="false" />
     <asp:BoundField HeaderText="Due Date" DataField="DD" SortExpression="DD" InsertVisible="false" />
     <asp:BoundField HeaderText="From WO#" DataField="fWO" SortExpression="fWO" InsertVisible="false" />
     <asp:BoundField HeaderText="Available" DataField="aQty" SortExpression="aQty" InsertVisible="false" />
     <asp:TemplateField>
      <ItemTemplate><%# showImg() %></ItemTemplate>
     </asp:TemplateField>
    </Columns>
    <EmptyDataTemplate>There is no part to display!</EmptyDataTemplate>
   </asp:GridView>
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsAvailable" runat="server" TypeName="myBiz.DAL.clsPartInv" SelectMethod="Check_AvailableAll">
 </asp:ObjectDataSource>
</asp:Content>
