<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.AdminPanel.UserGroup" Title="Group User Management" Codebehind="UserGroup.aspx.cs" %>
<%@ Register Src="~/_Controls/ucUserGroup_User.ascx" TagName="ucUserGroup_User" TagPrefix="ucUser" %>
<%@ Register Src="~/_Controls/ucUserGroup_Group.ascx" TagName="ucUserGroup_Group" TagPrefix="ucGroup" %>
<%@ Register Src="~/_Controls/ucUserGroup_ChatGroup.ascx" TagName="ucUserGroup_ChatGrp" TagPrefix="ucChatGrp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
<aspx:UpdatePanel ID="uPnlUG" runat="server">
 <ContentTemplate>
 <ajax:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" AutoPostBack="true" OnActiveTabChanged="tabChanged">
  <ajax:TabPanel ID="tabUser" runat="server" HeaderText="Manage By User">
   <ContentTemplate>
    <aspx:UpdatePanel ID="uPnlUser" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
      <ucUser:ucUserGroup_User ID="xUser" runat="server" /><br />
     </ContentTemplate>
    </aspx:UpdatePanel>
   </ContentTemplate>
  </ajax:TabPanel>
  <ajax:TabPanel ID="tabGroup" runat="server" HeaderText="Manage By Group">
   <ContentTemplate>
    <aspx:UpdatePanel ID="uPnlGroup" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
      <ucGroup:ucUserGroup_Group ID="xGroup" runat="server" />
     </ContentTemplate>
    </aspx:UpdatePanel>
   </ContentTemplate>
  </ajax:TabPanel>
  <ajax:TabPanel ID="tabChatGrp" runat="server" HeaderText="Group For Note">
   <ContentTemplate>
    <aspx:UpdatePanel ID="uPnlChatGrp" runat="server" UpdateMode="Conditional">
     <ContentTemplate> 
      <ucChatGrp:ucUserGroup_ChatGrp ID="yGroup" runat="server" />
     </ContentTemplate>
    </aspx:UpdatePanel>
   </ContentTemplate>
  </ajax:TabPanel>
 </ajax:TabContainer>
 </ContentTemplate>
</aspx:UpdatePanel>

</asp:Content>