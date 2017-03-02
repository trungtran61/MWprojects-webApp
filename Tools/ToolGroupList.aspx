<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="ToolGroupList.aspx.cs" Inherits="webApp.Tools.ToolGroupList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlGroupList" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <table>
    <tr>
     <td><b>TG#</b><br /><asp:TextBox ID="txtTGN" runat="server" Width="100px"></asp:TextBox></td>
     <td><b>Item Number</b><br /><asp:TextBox ID="txtItemNum" runat="server" Width="100px"></asp:TextBox></td>
     <td><b>Vendor</b><br /><asp:TextBox ID="txtVendorName" runat="server" Width="100px"></asp:TextBox></td>
     <td><br /><asp:Button ID="btnGo" runat="server" Text="Search" OnClick="doSearch" CssClass="NavBtn" />
      <asp:Literal ID="litCount" runat="server"></asp:Literal>
     </td>
    </tr>
   </table>
   <br />
   <asp:GridView ID="gvGroupList" runat="server" SkinID="Default" DataSourceID="odsGroupList" DataKeyNames="HID">
    <Columns>
     <asp:TemplateField HeaderText="TG#" SortExpression="ToolGroupNum" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><%# gLnk() %></ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Item Number" DataField="ItemNumber" SortExpression="ItemNumber" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Status" DataField="Status" SortExpression="Status" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Price Each ($)" DataField="Price" SortExpression="Price" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Description" DataField="Description" SortExpression="Description" InsertVisible="false" />
     <asp:BoundField HeaderText="Price ($/pack)" DataField="UnitPrice" SortExpression="UnitPrice" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Pack Size" DataField="PackSize" SortExpression="PackSize" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Vendor Name" DataField="CompanyName" SortExpression="CompanyName" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Phone" DataField="Phone" SortExpression="Phone" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
    </Columns>
    <EmptyDataTemplate>No Record Found!</EmptyDataTemplate>
   </asp:GridView>
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsGroupList" runat="server" TypeName="myBiz.DAL.clsToolInventory" SelectMethod="ToolGroupList">
  <SelectParameters>
   <asp:ControlParameter Name="TGN" Type="Int32" ControlID="txtTGN" PropertyName="Text" />
   <asp:ControlParameter Name="ItemNum" Type="String" ControlID="txtItemNum" PropertyName="Text" />
   <asp:ControlParameter Name="VendorName" Type="String" ControlID="txtVendorName" PropertyName="Text" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>
