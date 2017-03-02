<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Tools.OldWO" Title="Create Old WO" Codebehind="OldWO.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 Please enter old work order information to create.<br />
 <aspx:UpdatePanel ID="uPnlOldWO" runat="server">
  <ContentTemplate>
   <asp:FormView ID="fvOldWO" runat="server" DefaultMode="Insert" DataSourceID="odsOldWO" OnItemInserted="fvInserted">
    <InsertItemTemplate>
     <table>
      <tr><td align="right"><b>WorkOrder#:</b></td><td><asp:TextBox ID="txtWorkOrder" runat="server" Text='<%# Bind("WorkOrder") %>'></asp:TextBox></td></tr>
      <tr><td align="right"><b>PartNumber:</b></td><td><asp:TextBox ID="txtPartNumber" runat="server" Text='<%# Bind("PartNumber") %>'></asp:TextBox></td></tr>
      <tr><td align="right"><b>Revision:</b></td><td><asp:TextBox ID="Revision" runat="server" Width="150px" Text='<%# Bind("Revision") %>'></asp:TextBox></td></tr>
      <tr><td colspan="2" align="right"><asp:Button ID="btnSave" runat="server" Text="Create" CommandName="Insert" CssClass="NavBtn" /></td></tr>
     </table><br />
    </InsertItemTemplate>
   </asp:FormView>
   <MW:Message ID="iMsg" runat="server" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsOldWO" runat="server" TypeName="myBiz.DAL.clsPartInv" InsertMethod="CreateOldWO">
  <InsertParameters>
   <asp:Parameter Name="WorkOrder" Type="String" />
   <asp:Parameter Name="PartNumber" Type="String" />
   <asp:Parameter Name="Revision" Type="String" />
  </InsertParameters>
 </asp:ObjectDataSource>
</asp:Content>