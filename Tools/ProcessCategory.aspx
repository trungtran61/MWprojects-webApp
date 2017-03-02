<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="ProcessCategory.aspx.cs" Inherits="webApp.Tools.ProcessCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlCommand" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="doSave" CssClass="NavBtn" />
   <MW:Message ID="iMsg" runat="server" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <aspx:UpdatePanel ID="uPnlProcess" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <MW:ChkBoxList ID="cblProcessType" runat="server" DataSourceID="odsProcessType" DataEnabledField="isEnabled" DataCheckedField="isSelected" DataTextField="Name" DataValueField="HID" RepeatColumns="5"></MW:ChkBoxList>
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsProcessType" runat="server" TypeName="myBiz.DAL.clsToolInventory" SelectMethod="ProcessType_S1" UpdateMethod="ProcessType_Save">
  <UpdateParameters>
   <asp:ControlParameter Name="HIDs" Type="String" ControlID="cblProcessType" PropertyName="SelectedValues" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>
