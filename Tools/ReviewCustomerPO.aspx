<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="ReviewCustomerPO.aspx.cs" Inherits="webApp.Tools.ReviewCustomerPO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlCustomerPO" runat="server">
  <ContentTemplate>
   <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
    <tr style="background-color:#330099; color:White">
     <td align="center" style="font-weight:bold;">NEW CUSTOMER POs. NEED TO BE REVIEWED</td>
    </tr>
    <tr>
     <td>
      <asp:GridView ID="gvNew" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID,Code" DataSourceID="odsNew" OnRowDataBound="rwBound" OnRowCommand="rwCmd" PageSize="10">
       <Columns>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
         <HeaderTemplate>
          <asp:DropDownList ID="ddlNewDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
           <asp:ListItem Text="10" Value="10"></asp:ListItem>
           <asp:ListItem Text="20" Value="20"></asp:ListItem>
           <asp:ListItem Text="30" Value="30"></asp:ListItem>
           <asp:ListItem Text="All" Value="5000"></asp:ListItem>
          </asp:DropDownList>
         </HeaderTemplate>
         <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="#" DataField="HID" SortExpression="HID" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer PO#" DataField="CustomerPO" SortExpression="CustomerPO" />
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="File Name" SortExpression="FName">
         <ItemTemplate>
          <asp:LinkButton ID="lnkFName" runat="server" Text='<%# Eval("FName") %>' CommandName="viewCustomerPO" CommandArgument='<%# string.Format("{0}:{1}", Eval("HID"), Eval("Code")) %>'></asp:LinkButton>
         </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Received By" DataField="ModifiedBy" SortExpression="ModifiedBy" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Received Date" DataField="Modified" SortExpression="Modified" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" />
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Order Review Due Date" SortExpression="ReviewDueDate">
         <ItemTemplate><%# gDD("ReviewDueDate") %></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer" DataField="CompanyName" SortExpression="CompanyName" />
       </Columns>
       <EmptyDataTemplate>No Customer PO is available!</EmptyDataTemplate>
      </asp:GridView>
     </td>
    </tr>
   </table>

   <br />
   <asp:Button ID="btnReview" runat="server" Text="Complete" OnClick="doReviewing" CssClass="NavBtn" />
   <hr /><br />

   <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
    <tr style="background-color:#330099; color:White">
     <td align="center" style="font-weight:bold;">CUSTOMER POs. HAD BEEN REVIEWED</td>
    </tr>
    <tr>
     <td>
      <asp:GridView ID="gvReviewed" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID,Code" DataSourceID="odsReviewed" OnRowDataBound="rwBound" OnRowCommand="rwCmd" PageSize="10">
       <Columns>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
         <HeaderTemplate>
          <asp:DropDownList ID="ddlReviewedDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
           <asp:ListItem Text="10" Value="10"></asp:ListItem>
           <asp:ListItem Text="20" Value="20"></asp:ListItem>
           <asp:ListItem Text="30" Value="30"></asp:ListItem>
           <asp:ListItem Text="All" Value="5000"></asp:ListItem>
          </asp:DropDownList>
         </HeaderTemplate>
         <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="#" DataField="HID" SortExpression="HID" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer PO#" DataField="CustomerPO" SortExpression="CustomerPO" />
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="File Name" SortExpression="FName">
         <ItemTemplate>
          <asp:LinkButton ID="lnkFName" runat="server" Text='<%# Eval("FName") %>' CommandName="viewCustomerPO" CommandArgument='<%# string.Format("{0}:{1}", Eval("HID"), Eval("Code")) %>'></asp:LinkButton>
         </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Reviewed By" DataField="ReviewedBy" SortExpression="ReviewedBy" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Reviewed Date" DataField="ReviewedDate" SortExpression="ReviewedDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" />
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Order Entry Due Date" SortExpression="DueDate">
         <ItemTemplate><%# gDD("DueDate") %></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer" DataField="CompanyName" SortExpression="CompanyName" />
       </Columns>
       <EmptyDataTemplate>No Customer PO has been reviewed!</EmptyDataTemplate>
      </asp:GridView>
     </td>
    </tr>
   </table>
   <br />
   <asp:Button ID="btnUndoReview" runat="server" Text="Undo Complete" OnClick="doReviewing" CssClass="NavBtn" />
   <asp:Panel ID="pnlPopup" runat="server" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsNew" runat="server" TypeName="myBiz.DAL.clsFile" SelectMethod="CustomerPO_S">
  <SelectParameters>
   <asp:Parameter Name="Status" Type="String" DefaultValue="New" />
   <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsReviewed" runat="server" TypeName="myBiz.DAL.clsFile" SelectMethod="CustomerPO_S">
  <SelectParameters>
   <asp:Parameter Name="Status" Type="String" DefaultValue="Reviewed" />
   <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>