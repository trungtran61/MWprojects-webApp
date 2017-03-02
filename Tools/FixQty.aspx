<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Tools.FixQty" Title="Fix Inventory Qty" Codebehind="FixQty.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <b>WorkOrder:</b> <asp:TextBox ID="txtWO" runat="server"></asp:TextBox> <asp:Button ID="btnGo" runat="server" Text="Go" />
 <br /><br />
 <aspx:UpdatePanel ID="uPnlFixQty" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvFixQty" runat="server" SkinID="GrayHeader" DataSourceID="odsFixQty" DataKeyNames="HID">
    <Columns>
     <asp:CommandField ShowEditButton="true" />
     <asp:BoundField HeaderText="On-Hand" DataField="Qty" SortExpression="Qty" InsertVisible="false" />
     <asp:BoundField HeaderText="Available" DataField="Available" SortExpression="Available" InsertVisible="false" />
     <asp:BoundField HeaderText="Entered" DataField="iQty" SortExpression="iQty" InsertVisible="false" />
     <asp:BoundField HeaderText="Location" DataField="LocDesc" SortExpression="LocDesc" InsertVisible="false" ReadOnly="true" />
    </Columns>
   </asp:GridView>
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="btnGo" EventName="Click" /></Triggers>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsFixQty" runat="server" TypeName="myBiz.DAL.clsPartInv" SelectMethod="FixQty_S" UpdateMethod="FixQty_U">
  <SelectParameters><asp:ControlParameter Name="WO" Type="String" ControlID="txtWO" PropertyName="Text" /></SelectParameters>
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="Qty" Type="Int32" />
   <asp:Parameter Name="Available" Type="Int32" />
   <asp:Parameter Name="iQty" Type="Int32" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>