<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="ProTpeVdr.aspx.cs" Inherits="webApp.Tools.ProTpeVdr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlAvailable" runat="server">
  <ContentTemplate>
   <table>
    <tr valign="top">
     <td>
      <asp:DropDownList ID="ddlIsOPS" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
       <asp:ListItem Value="0" Text="All"></asp:ListItem>
       <asp:ListItem Value="1" Text="Outside Process" Selected="True"></asp:ListItem>
       <asp:ListItem Value="2" Text="Non Outside Process"></asp:ListItem>
      </asp:DropDownList><br />
      <asp:GridView ID="gvProTpeVdr" runat="server" SkinID="Default" DataSourceID="odsProTpeVdr" DataKeyNames="HID" AllowSorting="false" AllowPaging="false" OnRowCommand="rwCmd">
       <Columns>
        <asp:BoundField HeaderText="Process Name" DataField="ProcessName" SortExpression="ProcessName" InsertVisible="false" ItemStyle-Wrap="false" />
        <asp:TemplateField SortExpression="Tnv" InsertVisible="false" ItemStyle-Wrap="false">
         <HeaderTemplate><span title="Target # of Vendors">TNV</span></HeaderTemplate>
         <ItemTemplate><%# Eval("Tnv") %></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField SortExpression="Total" ItemStyle-Wrap="false">
         <HeaderTemplate><span title="Current # of Vendors">CNV</span></HeaderTemplate>
         <ItemTemplate>
          <asp:LinkButton ID="lnkTotal" runat="server" Text='<%# Eval("Total","[{0}]") %>' CommandName="Select" CommandArgument='<%# string.Format("{0}:All",Eval("HID")) %>' ForeColor='<%# System.Drawing.Color.FromName(Eval("ForeColor").ToString()) %>'></asp:LinkButton>
          <asp:LinkButton ID="lnkInState" runat="server" Text='<%# Eval("InState","[{0}]") %>' CommandName="Select" CommandArgument='<%# string.Format("{0}:In",Eval("HID")) %>' ForeColor="Blue"></asp:LinkButton>
          <asp:LinkButton ID="lnkOutState" runat="server" Text='<%# Eval("OutState","[{0}]") %>' CommandName="Select" CommandArgument='<%# string.Format("{0}:Out",Eval("HID")) %>' ForeColor="#ff9933"></asp:LinkButton>
         </ItemTemplate>
        </asp:TemplateField>
       </Columns>
      </asp:GridView>
     </td>
     <td>
      <asp:Literal ID="litTitle" runat="server"></asp:Literal><br />
      <asp:GridView ID="gvDetails" runat="server" SkinID="Default" DataSourceID="odsDetails" DataKeyNames="CompanyName" AllowSorting="false">
       <Columns>
        <asp:BoundField HeaderText="Vendor" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" />
        <asp:BoundField HeaderText="Address" DataField="Address1" SortExpression="Address1" InsertVisible="false" />
        <asp:BoundField HeaderText="City" DataField="City" SortExpression="City" InsertVisible="false" />
        <asp:BoundField HeaderText="State" DataField="State" SortExpression="State" InsertVisible="false" />
        <asp:BoundField HeaderText="Zip" DataField="Zip" SortExpression="Zip" InsertVisible="false" />
        <asp:BoundField HeaderText="Phone" DataField="Phone" SortExpression="Phone" InsertVisible="false" />
        <asp:BoundField HeaderText="Email" DataField="Email" SortExpression="Email" InsertVisible="false" />
        <asp:BoundField HeaderText="Website" DataField="Website" SortExpression="Website" InsertVisible="false" />
       </Columns>
       <EmptyDataTemplate>No Record found for sale person.</EmptyDataTemplate>
      </asp:GridView>
     </td>
    </tr>
   </table>
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsProTpeVdr" runat="server" TypeName="myBiz.DAL.clsProcessType" SelectMethod="FindVendors">
  <SelectParameters><asp:ControlParameter Name="isOPS" Type="Int32" ControlID="ddlIsOPS" PropertyName="SelectedValue" /></SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsDetails" runat="server" TypeName="myBiz.DAL.clsProcessType" SelectMethod="VendorDetails">
  <SelectParameters>
   <asp:Parameter Name="TypeID" Type="Int32" />
   <asp:Parameter Name="State" Type="String" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>