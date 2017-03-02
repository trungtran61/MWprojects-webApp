<%@ Page Title="Tool Order List" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="ToolOrderList.aspx.cs" Inherits="webApp.Tools.ToolOrderList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlOrderList" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <table>
    <tr>
     <td><b>Exp. Acc</b><br /><asp:DropDownList ID="ddlExpAcct" runat="server" DataSourceID="odsExpAcct" DataTextField="tExpAcct" DataValueField="tExpAcct" AutoPostBack="false"></asp:DropDownList></td>
     <td><b>Item Number</b><br /><asp:TextBox ID="txtItemNum" runat="server" Width="100px"></asp:TextBox></td>
     <td><b>Name</b><br /><asp:TextBox ID="txtName" runat="server" Width="100px"></asp:TextBox></td>
     <td><b>Code</b><br /><asp:TextBox ID="txtCode" runat="server" Width="100px"></asp:TextBox></td>
     <td><b>MWID</b><br /><asp:TextBox ID="txtMWID" runat="server" Width="100px"></asp:TextBox></td>
     <td><b>Vendor</b><br /><asp:TextBox ID="txtVendorName" runat="server" Width="100px"></asp:TextBox></td>
     <td><br /><asp:Button ID="btnGo" runat="server" Text="Search" CssClass="NavBtn" /></td>
    </tr>
   </table>
   <br /><asp:Button ID="btnGen" runat="server" Text="Generate POs" OnClick="doGenerate" CssClass="NavBtn" /><br />
   <asp:GridView ID="gvOrderList" runat="server" SkinID="Default" DataSourceID="odsOrderList" DataKeyNames="HID" OnRowDataBound="rwBound" PageSize="2500" OnDataBound="gvBound" OnRowCommand="rwCmd">
    <Columns>
     <asp:TemplateField ItemStyle-HorizontalAlign="Center">
      <HeaderTemplate><asp:CheckBox ID="chkItem" runat="server" /></HeaderTemplate>
      <ItemTemplate>
       <asp:CheckBox ID="chkItem" runat="server" />
       <asp:Literal ID="litECode" runat="server" Text='<%# Eval("eCode") %>' />
       <asp:LinkButton ID="lnkNewApp" runat="server" CommandArgument='<%# Eval("HID") %>'></asp:LinkButton>
       <asp:LinkButton ID="lnkOrdApp" runat="server" CommandArgument='<%# Eval("HID") %>'></asp:LinkButton>
       <asp:HiddenField ID="hfEnforced" runat="server" Value='<%# Eval("Enforced") %>' />
       <asp:HiddenField ID="hfOrdApp" runat="server" Value='<%# Eval("ordApp") %>' />
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Expense Account" DataField="tExpAcct" SortExpression="tExpAcct" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Category" DataField="TypeName" SortExpression="TypeName" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Balance" DataField="Balance" SortExpression="Balance" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Item Number" DataField="ItemNumber" SortExpression="ItemNumber" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Name" DataField="Name" SortExpression="Name" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Code" DataField="Code" SortExpression="Code" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="MWID" DataField="MWID" SortExpression="MWID" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="On Hand" DataField="OnHand" SortExpression="OnHand" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="UnitPrice ($/pack)" DataField="UnitPrice" SortExpression="UnitPrice" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Order Qty (pack)" DataField="OrderQty" SortExpression="OrderQty" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Pack Size" DataField="PackSize" SortExpression="PackSize" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Amount ($)" DataField="Amount" SortExpression="Amount" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Vendor Name" DataField="VendorName" SortExpression="VendorName" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Phone" DataField="Phone" SortExpression="Phone" ItemStyle-HorizontalAlign="Center" InsertVisible="false" ItemStyle-Width="10px" />
     <asp:BoundField FooterStyle-Wrap="false" HeaderText="Description" DataField="Description" SortExpression="Description" InsertVisible="false" />
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Completion Date / Due Date" SortExpression="RecdDD" ItemStyle-Width="10px" HeaderStyle-Width="10px">
      <ItemTemplate><%# gDD("RecdDD") %></ItemTemplate>
     </asp:TemplateField>
    </Columns>
   </asp:GridView>
   <asp:Button ID="btnGenerate" runat="server" Text="Generate POs" OnClick="doGenerate" CssClass="NavBtn" />
   <asp:HiddenField ID="hfChkBox" runat="server" />
   <asp:HiddenField ID="hfIDs" runat="server" />
   <asp:GridView ID="gvReport" runat="server" SkinID="Default" Visible="false">
    <Columns>
     <asp:BoundField HeaderText="Expense Account" DataField="tExpAcct" SortExpression="tExpAcct" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="# of Item" DataField="NumItem" SortExpression="NumItem" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Total" DataField="Total" SortExpression="Total" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Balance" DataField="Balance" SortExpression="Balance" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:CheckBoxField HeaderText="Createable" DataField="Createable" SortExpression="Createable" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
    </Columns>
   </asp:GridView>
   <br />
   <asp:Button ID="btnOK" runat="server" Text="OK" OnClick="doOK" CssClass="NavBtn" Visible="false" />
   <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="doCancel" CssClass="NavBtn" Visible="false" />
   <MW:Message ID="iMsg" runat="server" />
   <asp:GridView ID="gvPOs" runat="server" SkinID="Default" Visible="false">
    <Columns>
     <asp:BoundField HeaderText="PONumber" DataField="PONumber" SortExpression="PONumber" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="ItemNumber" DataField="ItemNumber" SortExpression="ItemNumber" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Total" DataField="Total" SortExpression="Total" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
     <asp:BoundField HeaderText="Supplier" DataField="VendorName" SortExpression="VendorName" ItemStyle-HorizontalAlign="Center" InsertVisible="false" />
    </Columns>
   </asp:GridView>
   <asp:Button ID="btnReturn" runat="server" Text="Back to List" OnClientClick="javascript:location='ToolOrderList.aspx';" CssClass="NavBtn" Visible="false" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsOrderList" runat="server" TypeName="myBiz.DAL.clsToolInventory" SelectMethod="OrderList">
  <SelectParameters>
   <asp:Parameter Name="HIDs" Type="String" />
   <asp:ControlParameter Name="tExpAcct" Type="String" ControlID="ddlExpAcct" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="ItemNum" Type="String" ControlID="txtItemNum" PropertyName="Text" />
   <asp:ControlParameter Name="Name" Type="String" ControlID="txtName" PropertyName="Text" />
   <asp:ControlParameter Name="Code" Type="String" ControlID="txtCode" PropertyName="Text" />
   <asp:ControlParameter Name="MWID" Type="String" ControlID="txtMWID" PropertyName="Text" />
   <asp:ControlParameter Name="VendorName" Type="String" ControlID="txtVendorName" PropertyName="Text" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsExpAcct" runat="server" TypeName="myBiz.DAL.clsToolInventory" SelectMethod="ExpAcctList"></asp:ObjectDataSource>
</asp:Content>