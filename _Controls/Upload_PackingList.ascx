<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload_PackingList" Codebehind="Upload_PackingList.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload Signed Packing List</h3>

<asp:GridView ID="gvPackingList" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsPackingList" OnRowCommand="gvCmd">
 <Columns>
  <asp:TemplateField>
   <ItemTemplate>
    <asp:Button ID="btnUpload" runat="server" Text="View" CommandName="Upload" CommandArgument='<%# Eval("HID") %>' CssClass="NavBtn" />
   </ItemTemplate>
  </asp:TemplateField>
  <asp:BoundField HeaderText="Delivered By" DataField="DeliBy" SortExpression="DeliBy" InsertVisible="false" />
  <asp:BoundField HeaderText="Date" DataField="DeliDate" SortExpression="DeliDate" InsertVisible="false" />
  <asp:BoundField HeaderText="Qty" DataField="Qty" SortExpression="Qty" InsertVisible="false" />
  <asp:BoundField HeaderText="Packing #" DataField="PackNum" SortExpression="PackNum" InsertVisible="false" />
  <asp:BoundField HeaderText="Location" DataField="LocDesc" SortExpression="LocDesc" InsertVisible="false" />
 </Columns>
 <EmptyDataTemplate>You have no packing list waiting to be uploaded or viewed.</EmptyDataTemplate>
</asp:GridView>

<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />

<asp:ObjectDataSource ID="odsPackingList" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="Select2">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Deli" />
 </SelectParameters>
</asp:ObjectDataSource>
