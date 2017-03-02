<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="CtrlVdrList.aspx.cs" Inherits="webApp.Reports.CtrlVdrList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <b>Process Type:</b> <asp:DropDownList ID="ddlProType" runat="server" DataSourceID="odsType" DataTextField="TypeName" DataValueField="HID" AutoPostBack="true"></asp:DropDownList>
 <br /><br />
 <aspx:UpdatePanel ID="uPnlVdrList" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <asp:GridView ID="gvVdrList" runat="server" SkinID="Default" DataSourceID="odsVdrList" DataKeyNames="CompanyName">
    <Columns>
     <asp:BoundField HeaderText="Vendor" ReadOnly="true" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" />
     <asp:BoundField HeaderText="Type" DataField="TypeName" SortExpression="TypeName" InsertVisible="false" />
    </Columns>
   </asp:GridView>
   <asp:ObjectDataSource ID="odsVdrList" runat="server" TypeName="myBiz.DAL.clsVendor" SelectMethod="RptVdrCtrl_S">
    <SelectParameters>
     <asp:ControlParameter Name="PID" Type="Int32" ControlID="ddlProType" PropertyName="SelectedValue" />
    </SelectParameters>
   </asp:ObjectDataSource>
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="ddlProType" EventName="SelectedIndexChanged" /></Triggers>
 </aspx:UpdatePanel>

 <asp:ObjectDataSource ID="odsType" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="Type_S1">
  <SelectParameters><asp:Parameter Name="mTxt" Type="String" DefaultValue="All" /></SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>
