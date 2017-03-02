<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="IncPartList.aspx.cs" Inherits="webApp.Tools.IncPartList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlIncPartList" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <asp:GridView ID="gvIncompleted" Width="100%" runat="server" SkinID="Default" DataKeyNames="WorkOrderID,StepNo" DataSourceID="odsIncompleted" OnRowDataBound="rwBound">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit"></asp:LinkButton>
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update"></asp:LinkButton>
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel"></asp:LinkButton>
      </EditItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="From WO#" DataField="WorkOrder" SortExpression="WorkOrder" ReadOnly="true" />
     <asp:BoundField HeaderText="Qty" DataField="Qty" SortExpression="Qty" />
     <asp:BoundField HeaderText="Completed Step" DataField="StepDesc" SortExpression="StepDesc" ReadOnly="true" />
     <asp:TemplateField HeaderText="Location" SortExpression="LocDesc">
      <ItemTemplate><%# Eval("LocDesc") %></ItemTemplate>
      <EditItemTemplate>
       <asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID" SelectedValue='<%# Bind("LocID") %>'></asp:DropDownList>
      </EditItemTemplate>
     </asp:TemplateField>
    </Columns>
    <EmptyDataTemplate>No Record Found!</EmptyDataTemplate>
   </asp:GridView>
  </ContentTemplate>
 </aspx:UpdatePanel>

 <asp:ObjectDataSource ID="odsIncompleted" runat="server" TypeName="myBiz.DAL.clsPartInv" SelectMethod="IncPartList" UpdateMethod="IncPartList_U">
  <UpdateParameters>
   <asp:Parameter Name="WorkOrderID" Type="Int32" />
   <asp:Parameter Name="StepNo" Type="Int32" />
   <asp:Parameter Name="Qty" Type="Int32" />
   <asp:Parameter Name="LocID" Type="Int32" />
  </UpdateParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
  <SelectParameters>
   <asp:Parameter Name="Dept" Type="String" DefaultValue="Inventory" />
   <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
   <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>
