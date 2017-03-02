<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Purchasing.ReceivePayments" Title="Receive Payments" Codebehind="ReceivePayments.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <aspx:UpdatePanel ID="uPnlChecks" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvChecks" runat="server" SkinID="Default" DataKeyNames="CheckID" DataSourceID="odsChecks" OnRowCommand="gvCmd" OnRowDataBound="rwBound">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:Button ID="btnUpload" runat="server" Text="Edit" CommandName="pUpload" CommandArgument='<%# Eval("CheckID") %>' CssClass="NavBtn" />
       <asp:Button ID="btnView" runat="server" Text="View" CommandName="pView" CommandArgument='<%# Eval("CheckID") %>' CssClass="NavBtn" />
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="#" DataField="CheckID" SortExpression="CheckID" />
     <asp:BoundField HeaderText="File Name" DataField="FName" SortExpression="FName" />
     <asp:BoundField HeaderText="Received By" DataField="ModifiedBy" SortExpression="ModifiedBy" />
     <asp:BoundField HeaderText="Date" DataField="Modified" SortExpression="Modified" />
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Apply Payment Due Date" SortExpression="DueDate">
      <ItemTemplate><%# gDD("DueDate") %></ItemTemplate>
     </asp:TemplateField>
    </Columns>
   </asp:GridView>
   <asp:LinkButton ID="lnkRefresh" runat="server" OnClick="lRefresh" />
   <br /><br />
   <asp:Literal ID="litMsg" runat="server"></asp:Literal>
   <asp:Button ID="btnUpload" runat="server" Text="Upload New File" OnClick="doUpload" CssClass="NavBtn" />
   <asp:Panel ID="pnlPopup" runat="server" />
   <asp:ObjectDataSource ID="odsChecks" runat="server" TypeName="myBiz.DAL.clsFile" SelectMethod="CheckImage_S">
    <SelectParameters><asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="xMode" /></SelectParameters>
   </asp:ObjectDataSource>
  </ContentTemplate>
 </aspx:UpdatePanel>
</asp:Content>