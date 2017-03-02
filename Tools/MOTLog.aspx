<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="MOTLog.aspx.cs" Inherits="webApp.Tools.MOTLog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlMOTLog" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvMOTLog" runat="server" SkinID="Default" DataSourceID="odsMOTLog" DataKeyNames="FileID" AllowSorting="false" OnRowDataBound="rwBound">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:Button ID="btnDelete" runat="server" CommandName="Delete" CssClass="NavBtn" Text="D" OnClientClick="return confirm('Are you sure you want to delete?');" />
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="WO#" DataField="WorkOrder" SortExpression="WorkOrder" InsertVisible="false" />
     <asp:BoundField HeaderText="PN" DataField="PartNumber" SortExpression="PartNumber" InsertVisible="false" />
     <asp:BoundField HeaderText="Rev" DataField="Revision" SortExpression="Revision" InsertVisible="false" />
     <asp:BoundField HeaderText="St/Op" DataField="St_Op" SortExpression="St_Op" InsertVisible="false" />
     <asp:BoundField HeaderText="Op. Name" DataField="OpName" SortExpression="OpName" InsertVisible="false" />
     <asp:BoundField HeaderText="Uploaded Date" DataField="Modified" SortExpression="Modified" InsertVisible="false" />
     <asp:BoundField HeaderText="Uploaded By" DataField="ModifiedBy" SortExpression="ModifiedBy" InsertVisible="false" />
     <asp:BoundField HeaderText="Uploaded File" DataField="FileName" SortExpression="FileName" InsertVisible="false" />
    </Columns>
    <EmptyDataTemplate>There is no log to display!</EmptyDataTemplate>
   </asp:GridView>
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsMOTLog" runat="server" TypeName="myBiz.DAL.clsMOTLog" SelectMethod="GetLogs" DeleteMethod="DeleteLog">
  <DeleteParameters>
   <asp:Parameter Name="FileID" Type="Int32" />
  </DeleteParameters>
 </asp:ObjectDataSource>
</asp:Content>
