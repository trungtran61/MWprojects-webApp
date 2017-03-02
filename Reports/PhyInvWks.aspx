<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Reports.PhyInvWks" Title="Physical Inventory Worksheet" Codebehind="PhyInvWks.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" Runat="Server">
 <h3>Physical Inventory Worksheet</h3>
 <table>
  <tr valign="top">
   <td>
    <asp:DropDownList ID="ddlCustomer" runat="server" DataSourceID="odsCustomer" DataTextField="CompanyName" DataValueField="HID" OnPreRender="ddlPreRender"></asp:DropDownList><br />
    <b>Location:</b><br />
    <div style="width:250px; height:400px; overflow:auto;"> 
     <MW:ChkBoxList ID="cblLocation" runat="server" DataSourceID="odsLocation" DataTextField="Description" DataValueField="HID" RepeatColumns="1" OnPreRender="cblPreRender"></MW:ChkBoxList>
    </div><br />
    <asp:Button ID="btnGo" runat="server" Text="Preview" OnClick="doPreview" CssClass="NavBtn" />
    <asp:Button ID="btnReset" runat="server" Text="Reset" OnClientClick="javascript:document.forms[0].reset(); return false;" CssClass="NavBtn" /><br /><br />
    <asp:Button ID="btnDownload" runat="server" OnClick="doDownload" Text="View in PDF" CssClass="NavBtn" />
   </td>
   <td>
    <aspx:UpdatePanel ID="uPnlPhy" runat="server">
     <ContentTemplate>
      <%= ddlCustomer.SelectedItem.Text %><br />
      <asp:GridView ID="gvPhy" runat="server" SkinID="GrayHeader" DataSourceID="odsPhy" OnRowDataBound="rwBound" PageSize="20">
       <Columns>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-VerticalAlign="Middle">
         <HeaderTemplate>
          <asp:DropDownList ID="ddlDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
           <asp:ListItem Text="10" Value="10"></asp:ListItem>
           <asp:ListItem Text="20" Value="20"></asp:ListItem>
           <asp:ListItem Text="40" Value="40"></asp:ListItem>
           <asp:ListItem Text="All" Value="*"></asp:ListItem>
          </asp:DropDownList>
          <asp:LinkButton ID="lnkSortLoc" runat="server" CommandName="Sort" CommandArgument="LocDesc" ForeColor="Black" Text="Location" /><br />
         </HeaderTemplate>
         <ItemTemplate><%# Eval("LocDesc") %></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="WO#" DataField="WorkOrder" SortExpression="WorkOrder" InsertVisible="false" />
        <asp:BoundField HeaderText="P/N" DataField="PN" SortExpression="PN" InsertVisible="false" />
        <asp:BoundField HeaderText="On-Hand" DataField="OnHand" SortExpression="PN" ItemStyle-HorizontalAlign="Right" InsertVisible="false" />
       </Columns>
       <EmptyDataTemplate>No Record Found!</EmptyDataTemplate>
      </asp:GridView>
     </ContentTemplate>
     <Triggers>
      <aspx:AsyncPostBackTrigger ControlID="btnGo" EventName="Click" />
     </Triggers>
    </aspx:UpdatePanel>
   </td>
  </tr>
 </table>

 <asp:ObjectDataSource ID="odsPhy" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="PhyInvWks_S">
  <SelectParameters>
   <asp:ControlParameter Name="LocIDs" Type="String" ControlID="cblLocation" PropertyName="SelectedValues" />
   <asp:ControlParameter Name="CustID" Type="Int32" ControlID="ddlCustomer" PropertyName="SelectedValue" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
  <SelectParameters>
   <asp:Parameter Name="Dept" Type="String" DefaultValue="Inventory" />
   <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
   <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsCustomer" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="getCompanyList">
  <SelectParameters>
   <asp:Parameter Name="ClassName" Type="String" DefaultValue="Customer" />
   <asp:Parameter Name="TypeName" Type="String" DefaultValue="Customer" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>