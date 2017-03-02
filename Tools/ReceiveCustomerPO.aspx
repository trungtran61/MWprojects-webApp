<%@ Page Title="Receive CustomerPO" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="ReceiveCustomerPO.aspx.cs" Inherits="webApp.Tools.ReceiveCustomerPO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlCustomerPOs" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvCustomerPOs" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsCustomerPOs" OnRowCommand="gvCmd" OnRowDataBound="rwBound">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:Button ID="btnUpload" runat="server" Text="Edit" CommandName="pUpload" CommandArgument='<%# Eval("HID") %>' CssClass="NavBtn" />
       <asp:Button ID="btnView" runat="server" Text="View" CommandName="pView" CommandArgument='<%# Eval("HID") %>' CssClass="NavBtn" />
       <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# Eval("HID") %>' CssClass="NavBtn" OnClientClick="return confirm('Are you sure you want to delete?');" />
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="#" DataField="HID" SortExpression="HID" />
     <asp:BoundField HeaderText="Customer PO#" DataField="CustomerPO" SortExpression="CustomerPO" />
     <asp:BoundField HeaderText="File Name" DataField="FName" SortExpression="FName" />
     <asp:BoundField HeaderText="Received By" DataField="ModifiedBy" SortExpression="ModifiedBy" />
     <asp:BoundField HeaderText="Received Date" DataField="Modified" SortExpression="Modified" />
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Order Review Due Date" SortExpression="ReviewDueDate">
      <ItemTemplate><%# gDD("ReviewDueDate") %></ItemTemplate>
     </asp:TemplateField>
    </Columns>
   </asp:GridView>
   <asp:LinkButton ID="lnkRefresh" runat="server" OnClick="lRefresh" />
   <br /><br />
   <asp:Literal ID="litMsg" runat="server"></asp:Literal>
   <b>Customer PO#:</b> <asp:TextBox ID="txtCustomerPO" runat="server"></asp:TextBox>
   <asp:Button ID="btnUpload" runat="server" Text="Upload New File" OnClick="doUpload" CssClass="NavBtn" ValidationGroup="nPO" />
   <asp:RequiredFieldValidator ID="rfvCustomerPO" runat="server" ControlToValidate="txtCustomerPO" ErrorMessage="Customer PO is required!" ValidationGroup="nPO"></asp:RequiredFieldValidator>
   <asp:Panel ID="pnlPopup" runat="server" />
   <asp:ObjectDataSource ID="odsCustomerPOs" runat="server" TypeName="myBiz.DAL.clsFile" SelectMethod="CustomerPO_S" DeleteMethod="CustomerPO_Delete">
    <SelectParameters>
     <asp:Parameter Name="Status" Type="String" DefaultValue="New" />
     <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="xMode" />
    </SelectParameters>
    <DeleteParameters>
     <asp:Parameter Name="HID" Type="Int32" />
    </DeleteParameters>
   </asp:ObjectDataSource>
  </ContentTemplate>
 </aspx:UpdatePanel>
</asp:Content>