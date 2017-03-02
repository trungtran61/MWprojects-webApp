<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="attFile.ascx.cs" Inherits="webApp._Controls.attFile" %>

<asp:Literal ID="litMsg" runat="server"></asp:Literal>
 <asp:GridView ID="gvFileList" runat="server" AllowPaging="False" AllowSorting="True" AutoGenerateColumns="False"
  CellPadding="4" ForeColor="#333333" GridLines="None" DataSourceID="odsFileList" OnRowCommand="Rw_Cmd">
  <Columns>
   <asp:TemplateField HeaderText="Name" SortExpression="Name">
    <ItemTemplate>
     <asp:CheckBox ID="chkItem" runat="server" />
     <asp:LinkButton ID="lnkName" runat="server" CommandName="Download" CommandArgument='<%# Eval("HID") %>' Text='<%# Eval("Name") %>' />
     <asp:HiddenField ID="hfLen" runat="server" Value='<%# Eval("Len") %>' />
     <asp:HiddenField ID="hfExt" runat="server" Value='<%# Eval("Ext") %>' />
    </ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Date Modified" DataField="Modified" SortExpression="Modified" DataFormatString="{0:d}" />
   <asp:BoundField HeaderText="Modified By" DataField="ModifiedBy" SortExpression="ModifiedBy" />
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

 <asp:ObjectDataSource ID="odsFileList" runat="server" TypeName="myBiz.DAL.clsFile" SelectMethod="Select">
 <SelectParameters>
  <asp:QueryStringParameter Name="GrpID" Type="Int32" QueryStringField="gID" DefaultValue="1" />
  <asp:QueryStringParameter Name="LnkID" Type="Int32" QueryStringField="lID" />
 </SelectParameters>
</asp:ObjectDataSource>