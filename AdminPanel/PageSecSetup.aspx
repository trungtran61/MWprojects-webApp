<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.AdminPanel.PageSecSetup" Title="Page Securities Setup" Codebehind="PageSecSetup.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <table>
  <tr>
   <td><b>Group:</b><br />
    <asp:DropDownList ID="ddlGroup" runat="server" DataSourceID="odsGroup" DataTextField="gName" DataValueField="HID"></asp:DropDownList>
   </td>
   <td><b>Page:</b><br />
    <asp:DropDownList ID="ddlPage" runat="server" DataSourceID="odsPage" DataTextField="PageName" DataValueField="HID"></asp:DropDownList>
   </td>
   <td valign="bottom"><asp:Button ID="btnLoad" runat="server" Text="Load" OnClick="doLoad" CssClass="NavBtn" /></td>
   <td valign="bottom">
    <aspx:UpdatePanel ID="uPnlSave" runat="server" UpdateMode="Conditional">
     <ContentTemplate><asp:Button ID="btnSave" runat="server" Text="Save" OnClick="doSave" CssClass="NavBtn" Enabled="false" /></ContentTemplate>
     <Triggers><aspx:AsyncPostBackTrigger ControlID="btnLoad" EventName="Click" /></Triggers>
    </aspx:UpdatePanel>
   </td>
  </tr>
 </table>
 <aspx:UpdatePanel ID="uPnlPageSec" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <MW:Message ID="iMsg" runat="server" />
   <MW:ChkBoxList ID="cblPageSec" runat="server" DataSourceID="odsPageSec" DataCheckedField="CodeVal" DataTextField="CodeName" DataValueField="HID" RepeatColumns="5" OnDataBound="cblBound"></MW:ChkBoxList>
  </ContentTemplate>
  <Triggers>
   <aspx:AsyncPostBackTrigger ControlID="btnLoad" EventName="Click" />
   <aspx:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
  </Triggers>
 </aspx:UpdatePanel>
 
 <asp:ObjectDataSource ID="odsGroup" runat="server" TypeName="myBiz.DAL.clsUserGroup" SelectMethod="GroupName_S"></asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsPage" runat="server" TypeName="myBiz.DAL.clsUserGroup" SelectMethod="Page_Info_S"></asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsPageSec" runat="server" TypeName="myBiz.DAL.clsUserGroup" SelectMethod="Page_Security_S1" UpdateMethod="Page_Security_U">
  <SelectParameters>
   <asp:ControlParameter Name="GroupID" Type="Int32" ControlID="ddlGroup" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="PageID" Type="Int32" ControlID="ddlPage" PropertyName="SelectedValue" />
  </SelectParameters>
  <UpdateParameters>
   <asp:Parameter Name="IDs" Type="String" />
   <asp:Parameter Name="Val" Type="String" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>