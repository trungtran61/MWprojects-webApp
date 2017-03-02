<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Component" Codebehind="Component.ascx.cs" %>

<asp:Literal ID="litTitle" runat="server" Text="<b>Please add/remove component as necessary</b>"></asp:Literal>
<asp:GridView ID="gvComponent" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="HID" DataSourceID="odsComponent" ForeColor="#333333" GridLines="None" ShowFooter="true" OnRowUpdating="rwUpdate" OnRowDataBound="rwBound">
 <FooterStyle BackColor="#CCCC99" Font-Bold="True" ForeColor="White" />
 <RowStyle BackColor="#F7F7DE" />
 <Columns>
  <asp:TemplateField>
   <ItemTemplate>
    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
    <asp:LinkButton ID="lnkDelete" runat="server" Text="Remove" CommandName="Delete" OnClientClick="return confirm('Coming Soon');" />
   </ItemTemplate>
   <EditItemTemplate>
    <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
    <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
   </EditItemTemplate>
   <FooterTemplate><asp:Button ID="btnAdd" Text="Add New" runat="server" OnClick="btnAdd_Click" /></FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="WO#" InsertVisible="false">
   <ItemTemplate><%# Eval("WorkOrder") %></ItemTemplate>
   <EditItemTemplate><%# Eval("WorkOrder") %></EditItemTemplate>
   <FooterTemplate><%# Eval("WorkOrder") %></FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="P/N" SortExpression="PartNumber" InsertVisible="false">
   <ItemTemplate><%# Eval("PartNumber") %></ItemTemplate>
   <EditItemTemplate><asp:TextBox ID="txtPartNumber" runat="server" Text='<%# Bind("PartNumber") %>' /></EditItemTemplate>
   <FooterTemplate><asp:TextBox ID="txtPartNumber" runat="server" /></FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Rev" SortExpression="Revision" InsertVisible="false">
   <ItemTemplate><%# Eval("Revision")%></ItemTemplate>
   <EditItemTemplate><asp:TextBox ID="txtRevision" runat="server" Text='<%# Bind("Revision") %>' Width="100px" /></EditItemTemplate>
   <FooterTemplate><asp:TextBox ID="txtRevision" runat="server" Width="100px" /></FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Qty" InsertVisible="false">
   <ItemTemplate><%# Eval("oQty") %></ItemTemplate>
   <EditItemTemplate><asp:TextBox ID="txtoQty" runat="server" Text='<%# Bind("oQty") %>' Width="50px" /></EditItemTemplate>
   <FooterTemplate><asp:TextBox ID="txtoQty" runat="server" Width="25px" /></FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Due Date" SortExpression="DueDate" InsertVisible="false">
   <ItemTemplate><%# Eval("DueDate", "{0:MM/dd/yy}")%></ItemTemplate>
   <EditItemTemplate>
    <asp:TextBox ID="txtDueDate" runat="server" Text='<%# Bind("DueDate","{0:MM/dd/yy}") %>' Width="100px" />
    <ajax:CalendarExtender ID="calDueDate" runat="server" TargetControlID="txtDueDate" Format="MM/dd/yy" />
   </EditItemTemplate>
   <FooterTemplate>
    <asp:TextBox ID="txtDueDate" runat="server" Width="100px" />
    <ajax:CalendarExtender ID="calDueDate" runat="server" TargetControlID="txtDueDate" Format="MM/dd/yy" />
   </FooterTemplate>
  </asp:TemplateField>
 </Columns>
 <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Center" />
 <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
 <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
 <EditRowStyle BackColor="#9999CC" />
 <AlternatingRowStyle BackColor="White" />
 <EmptyDataRowStyle BackColor="#CCCC99" Font-Bold="True" ForeColor="White" />
 <EmptyDataTemplate>
  <table>
   <tr>
    <td valign="bottom"><asp:Button ID="btnAddN" runat="server" Text="Add New Component" OnClick="btnAdd_Click" /></td>
    <td><b>P/N</b><br /><asp:TextBox ID="txtPartNumber" runat="server" /></td>
    <td><b>Rev</b><br /><asp:TextBox ID="txtRevision" runat="server" Width="100px" /></td>
    <td><b>Qty Order</b><br /><asp:TextBox ID="txtoQty" runat="server" Width="50px" /></td>
    <td>
     <b>Due Date</b><br /><asp:TextBox ID="txtDueDate" runat="server" Width="100px" />
     <ajax:CalendarExtender ID="calDueDate" runat="server" TargetControlID="txtDueDate" Format="MM/dd/yy" />
    </td>
   </tr>
  </table>
 </EmptyDataTemplate>
</asp:GridView>
<asp:Literal ID="litMsg" runat="server"></asp:Literal>
<asp:ObjectDataSource ID="odsComponent" runat="server" TypeName="myBiz.DAL.clsComponent" SelectMethod="Select" InsertMethod="Insert" UpdateMethod="Update" DeleteMethod="Delete">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="PartNumber" Type="String" />
  <asp:Parameter Name="Revision" Type="String" />
  <asp:Parameter Name="oQty" Type="Int32" />
  <asp:Parameter Name="DueDate" Type="DateTime" />
 </UpdateParameters>
 <InsertParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="PartNumber" Type="String" />
  <asp:Parameter Name="Revision" Type="String" />
  <asp:Parameter Name="oQty" Type="Int32" />
  <asp:Parameter Name="DueDate" Type="DateTime" />
 </InsertParameters>
 <DeleteParameters>
  <asp:Parameter Name="HID" Type="Int32" />
 </DeleteParameters>
</asp:ObjectDataSource>