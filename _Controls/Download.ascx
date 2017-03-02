<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Download" Codebehind="Download.ascx.cs" %>
<asp:Panel ID="pnlDownload" runat="server">
<asp:Literal ID="litMsg" runat="server"></asp:Literal>
 <asp:GridView ID="gvDownload" runat="server" PageSize="10" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
  CellPadding="4" ForeColor="#333333" GridLines="None" DataKeyNames="HID,Ext" DataSourceID="odsDownload" OnRowCommand="Rw_Cmd" OnDataBound="gvBound">
  <Columns>
   <asp:TemplateField>
    <ItemTemplate><%# Eval("docType") %></ItemTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="Name" SortExpression="Name">
    <ItemTemplate>
     <asp:LinkButton ID="lnkName" runat="server" CommandName="Download" CommandArgument='<%# Eval("HID") %>' Text='<%# Eval("Name") %>' />
    </ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Date Modified" DataField="Modified" SortExpression="Modified" DataFormatString="{0:d}" />
   <asp:BoundField HeaderText="Modified By" DataField="ModifiedBy" SortExpression="ModifiedBy" />
   <asp:TemplateField>
    <ItemTemplate>
     <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandName="Delete" Enabled='<%# this.AllowDelete %>' OnClientClick="return confirm('Are you sure you want to delete?');"></asp:LinkButton>
    </ItemTemplate>
   </asp:TemplateField>
  </Columns>
  <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></FooterStyle>
  <RowStyle BackColor="#EFF3FB"></RowStyle>
  <EditRowStyle BackColor="#2461BF"></EditRowStyle>
  <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>
  <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"></PagerStyle>
  <HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"></HeaderStyle>
  <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
  <EmptyDataTemplate>No Document Found!</EmptyDataTemplate>
 </asp:GridView>
</asp:Panel>

<asp:ObjectDataSource ID="odsDownload" runat="server" TypeName="myBiz.DAL.clsFile" SelectMethod="Select" DeleteMethod="Delete">
 <SelectParameters>
  <asp:QueryStringParameter Name="GrpID" Type="Int32" QueryStringField="gID" DefaultValue="1" />
  <asp:QueryStringParameter Name="LnkID" Type="Int32" QueryStringField="lID" />
  <asp:QueryStringParameter Name="GrpIDs" Type="String" QueryStringField="gIDs" DefaultValue="0:" />
  <asp:QueryStringParameter Name="LnkIDs" Type="String" QueryStringField="lIDs" DefaultValue="0:" />
 </SelectParameters>
 <DeleteParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:QueryStringParameter Name="GrpID" Type="Int32" QueryStringField="gID" DefaultValue="-1" />
  <asp:Parameter Name="Ext" Type="String" />
 </DeleteParameters>
</asp:ObjectDataSource>