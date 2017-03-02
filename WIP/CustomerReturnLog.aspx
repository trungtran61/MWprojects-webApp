<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="CustomerReturnLog.aspx.cs" Inherits="webApp.WIP.CustomerReturnLog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlCustomerReturnLog" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvCustomerReturnLog" runat="server" SkinID="GrayHeader" DataSourceID="odsCustomerReturnLog" DataKeyNames="HID" AllowSorting="false" ShowFooter="true" OnRowCommand="rwCmd">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" Visible='<%# Eval("IsEdit") %>' />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
      </EditItemTemplate>
      <FooterTemplate><asp:Button ID="btnAdd" runat="server" Text="Add" CommandName="AddNew" CssClass="NavBtn" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="CR#" SortExpression="HID" InsertVisible="false">
      <ItemTemplate><%# gLnk("HID") %></ItemTemplate>
      <EditItemTemplate><%# Eval("HID") %></EditItemTemplate>
      <FooterTemplate>N/A</FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Date" SortExpression="ReturnedDate" InsertVisible="false">
      <ItemTemplate><%# Eval("ReturnedDate","{0:MM/dd/yyyy}") %></ItemTemplate>
      <EditItemTemplate>
       <asp:TextBox ID="txtReturnedDate" runat="server" Text='<%# Bind("ReturnedDate") %>' Width="130px" Enabled='<%# Eval("IsBlankFields") %>' />
       <ajax:CalendarExtender ID="calReturnedDate" runat="server" TargetControlID="txtReturnedDate" Format="MM/dd/yyyy" />
      </EditItemTemplate>
      <FooterTemplate>
       <asp:TextBox ID="txtReturnedDate" runat="server" Width="130px" />
       <ajax:CalendarExtender ID="calReturnedDate" runat="server" TargetControlID="txtReturnedDate" Format="MM/dd/yyyy" />
      </FooterTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Customer" ReadOnly="true" DataField="CustomerName" SortExpression="CustomerName" InsertVisible="false" />
     <asp:TemplateField HeaderText="MW Shipment No." SortExpression="PackNum" InsertVisible="false">
      <ItemTemplate><%# Eval("PackNum") %></ItemTemplate>
      <EditItemTemplate><asp:DropDownList ID="ddlPackingList" runat="server" DataSourceID="odsPackingList" DataTextField="PackNum" DataValueField="HID" SelectedValue='<%# Bind("PackID") %>' Enabled='<%# Eval("IsBlankFields") %>'></asp:DropDownList></EditItemTemplate>
      <FooterTemplate><asp:DropDownList ID="ddlPackingList" runat="server" DataSourceID="odsPackingList" DataTextField="PackNum" DataValueField="HID"></asp:DropDownList></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Qty Returned" SortExpression="ReturnedQty" InsertVisible="false">
      <ItemTemplate><%# Eval("ReturnedQty") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtQty" runat="server" Text='<%# Bind("ReturnedQty") %>' Width="75px"></asp:TextBox></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtQty" runat="server" Width="75px"></asp:TextBox></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Scar#" SortExpression="ScarNum" InsertVisible="false">
      <ItemTemplate>
       <asp:LinkButton ID="lnkULScar" runat="server" Text="&diams;" CommandName="uScar" CommandArgument='<%# ((GridViewRow)Container).RowIndex %>' ToolTip="Upload Scar" />
       <asp:LinkButton ID="lnkDLScar" runat="server" Text="&diams;" CommandName="dScar" CommandArgument='<%# ((GridViewRow)Container).RowIndex %>' ToolTip="View Scar" />
       <%# Eval("ScarNum") %>
      </ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtScarNum" runat="server" Text='<%# Bind("ScarNum") %>' Width="75px" Enabled='<%# Eval("IsBlankFields") %>'></asp:TextBox></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtScarNum" runat="server" Width="75px"></asp:TextBox></FooterTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Status" ReadOnly="true" DataField="Status" SortExpression="Status" InsertVisible="false" />
     <asp:TemplateField HeaderText="MWCar#" SortExpression="CarNum" InsertVisible="false">
      <ItemTemplate><%# gLnk("CarNum") %></ItemTemplate>
      <EditItemTemplate><%# Eval("CarNum") %></EditItemTemplate>
      <FooterTemplate>N/A</FooterTemplate>
     </asp:TemplateField>
    </Columns>
    <EmptyDataTemplate>
     <table>
      <tr>
       <td><b>Date</b></td>
       <td><b>MW Shipment No.</b></td>
       <td><b>Qty Returned</b></td>
       <td><b>Scar#</b></td>
      </tr>
      <tr>
       <td>
        <asp:TextBox ID="txtReturnedDate" runat="server" Width="130px" />
        <ajax:CalendarExtender ID="calReturnedDate" runat="server" TargetControlID="txtReturnedDate" Format="MM/dd/yyyy" />
       </td>
       <td><asp:DropDownList ID="ddlPackingList" runat="server" DataSourceID="odsPackingList" DataTextField="PackNum" DataValueField="HID"></asp:DropDownList></td>
       <td><asp:TextBox ID="txtQty" runat="server" Text='<%# Bind("ReturnedQty") %>' Width="75px"></asp:TextBox></td>
       <td><asp:TextBox ID="txtScarNum" runat="server" Text='<%# Bind("ScarNum") %>' Width="75px"></asp:TextBox></td>
      </tr>
      <tr>
       <td><asp:Button ID="btnAdd" runat="server" Text="Add" CommandName="InsertNew" CssClass="NavBtn" /></td>
      </tr>
     </table>
    </EmptyDataTemplate>
   </asp:GridView>
   <MW:Message ID="iMsg" runat="server" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsCustomerReturnLog" runat="server" TypeName="myBiz.DAL.clsCustomerReturnLog" SelectMethod="GetLogs" UpdateMethod="SaveLog">
  <SelectParameters>
   <asp:Parameter Name="isSearch" Type="Boolean" DefaultValue="True" />
  </SelectParameters>
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="ReturnedDate" Type="DateTime" />
   <asp:Parameter Name="PackID" Type="Int32" />
   <asp:Parameter Name="ScarNum" Type="String" />
   <asp:Parameter Name="ReturnedQty" Type="Int32" />
  </UpdateParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsPackingList" runat="server" TypeName="myBiz.DAL.clsPackingList" SelectMethod="GetIDs"></asp:ObjectDataSource>
</asp:Content>