<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="BudgetForcast.aspx.cs" Inherits="webApp.AdminPanel.BudgetForcast" %>
<%@ Register Src="~/_Controls/Progress.ascx" TagName="Progress" TagPrefix="ucProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <h3>Budget Forcast Setup</h3>
 <ucProgress:Progress ID="abc" runat="server" />
 <aspx:UpdatePanel ID="uPnlUsage" UpdateMode="Conditional" runat="server">
  <ContentTemplate>
   <b>Percent Usage:</b><asp:TextBox ID="txtUsage" runat="server" Width="150"></asp:TextBox>
   <asp:Button ID="btnUsage" runat="server" Text="Update" CssClass="NavBtn" OnClick="saveUsage" />
   <MW:Message ID="jMsg" runat="server" />
   <asp:HiddenField id="hfDateID" runat="server" />
   <br /><br />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <aspx:UpdatePanel ID="uPnlBudget" UpdateMode="Conditional" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvBudget" runat="server" AllowPaging="False" PageSize="50" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="HID" DataSourceID="odsBudget" ForeColor="#333333" GridLines="None" OnRowDataBound="rwBound">
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <RowStyle BackColor="#EFF3FB" />
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
      </EditItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="ID" ReadOnly="true" DataField="ExpAcct" SortExpression="SortOrder,ExpAcct" InsertVisible="false" />
     <asp:BoundField HeaderText="Name" ReadOnly="true" DataField="tExpAcct" SortExpression="SortOrder,tExpAcct" InsertVisible="false" />
     <asp:TemplateField HeaderText="Budget ($)" SortExpression="SortOrder,BudgetAmt">
      <ItemTemplate><%# Eval("BudgetAmt") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtBudgetAmt" runat="server" Text='<%# Bind("BudgetAmt") %>'></asp:TextBox></EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Budget (%)" SortExpression="SortOrder,Budget">
      <ItemTemplate><%# Eval("Budget") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtBudget" runat="server" Text='<%# Bind("Budget") %>'></asp:TextBox></EditItemTemplate>
     </asp:TemplateField>
     <asp:CheckBoxField HeaderText="Enforced" DataField="Enforced" InsertVisible="false" />
     <asp:BoundField HeaderText="Note" DataField="Note" SortExpression="SortOrder,Note" InsertVisible="false" />
    </Columns>
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#9999CC" />
    <AlternatingRowStyle BackColor="White" />
   </asp:GridView>
   <br />
   <MW:Message ID="iMsg" runat="server" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsBudget" runat="server" TypeName="myBiz.DAL.clsBudget" SelectMethod="BudgetForcast_S" UpdateMethod="BudgetForcast_U" OnUpdated="odsUpdated">
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="BudgetAmt" Type="Decimal" />
   <asp:Parameter Name="Budget" Type="Decimal" />
   <asp:Parameter Name="Enforced" Type="Boolean" />
   <asp:Parameter Name="Note" Type="String" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>
