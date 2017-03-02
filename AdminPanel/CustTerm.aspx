<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.AdminPanel.CustTerm" Title="Customer Term Setup" Codebehind="CustTerm.aspx.cs" %>
<%@ Register Src="~/_Controls/Progress.ascx" TagName="Progress" TagPrefix="ucProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <h3>Customer Term Setup</h3>
 <ucProgress:Progress ID="abc" runat="server" />
 <aspx:UpdatePanel ID="UpdatePanel1" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvCustTerm" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="HID" DataSourceID="odsCustTerm" ForeColor="#333333" GridLines="None" OnRowDataBound="gv_Bound">
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <RowStyle BackColor="#EFF3FB" />
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
      </EditItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Customer" ReadOnly="true" DataField="CustomerName" SortExpression="CustomerName" InsertVisible="false" />
     <asp:BoundField HeaderText="Term" DataField="Term" SortExpression="Term" InsertVisible="false" />
     <asp:CheckBoxField HeaderText="Auto" DataField="isAuto" InsertVisible="false" />
     <asp:BoundField HeaderText="DADue" DataField="DayAfter" SortExpression="DayAfter" InsertVisible="false" />
     <asp:BoundField HeaderText="Freq" DataField="Frequency" SortExpression="Frequency" InsertVisible="false" />
     <asp:CheckBoxField HeaderText="CoC" DataField="CoC" InsertVisible="false" />
     <asp:CheckBoxField HeaderText="S.Label" DataField="sLabel" InsertVisible="false" />
     <asp:CheckBoxField HeaderText="Mat.Cert" DataField="MatCert" InsertVisible="false" />
     <asp:CheckBoxField HeaderText="OPS.Cert" DataField="OPSCert" InsertVisible="false" />
     <asp:CheckBoxField HeaderText="FAIR" DataField="FAIR" InsertVisible="false" />
     <asp:CheckBoxField HeaderText="FIN" DataField="FIN" InsertVisible="false" />
    </Columns>
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#9999CC" />
    <AlternatingRowStyle BackColor="White" />
   </asp:GridView>
   <br />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsCustTerm" runat="server" TypeName="myBiz.DAL.clsCustTerm" SelectMethod="Select" UpdateMethod="Update">
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="Term" Type="Int32" />
   <asp:Parameter Name="DayAfter" Type="Int32" />
   <asp:Parameter Name="Frequency" Type="Int32" />
   <asp:Parameter Name="isAuto" Type="Boolean" />
   <asp:Parameter Name="Coc" Type="Boolean" />
   <asp:Parameter Name="sLabel" Type="Boolean" />
   <asp:Parameter Name="MatCert" Type="Boolean" />
   <asp:Parameter Name="OPSCert" Type="Boolean" />
   <asp:Parameter Name="FAIR" Type="Boolean" />
   <asp:Parameter Name="FIN" Type="Boolean" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>