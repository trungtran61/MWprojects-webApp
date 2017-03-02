<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.AdminPanel.CommMgmnt" Title="Communication Management" Codebehind="CommMgmnt.aspx.cs" %>
<%@ Register Src="~/_Controls/ucCommClass.ascx" TagName="ucCommClass" TagPrefix="ucClass" %>
<%@ Register Src="~/_Controls/ucCommCompany.ascx" TagName="ucCommCompany" TagPrefix="ucCompany" %>
<%@ Register Src="~/_Controls/ucCommType.ascx" TagName="ucCommType" TagPrefix="ucType" %>
<%@ Register Src="~/_Controls/ucCommContact.ascx" TagName="ucCommContact" TagPrefix="ucContact" %>
<%@ Register Src="~/_Controls/ucCommAddress.ascx" TagName="ucCommAddress" TagPrefix="ucAddress" %>
<%@ Register Src="~/_Controls/ucCommItem.ascx" TagName="ucCommItem" TagPrefix="ucItem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <aspx:UpdatePanel ID="uPnlCommunication" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="dCmd" CssClass="NavBtn" />
   <asp:Button ID="btnRemove" runat="server" Text="Remove" OnClick="dCmd" CssClass="NavBtn" OnClientClick="return confirm('Are you sure you want to remove?');" />
   <MW:Message ID="iMsg" runat="server"></MW:Message>
   <br /><br />
   <table>
    <tr>
     <td valign="top"><ucClass:ucCommClass ID="ucClass" runat="server" /></td>
     <td valign="top"><ucCompany:ucCommCompany ID="ucCompany" runat="server" /></td>
     <td valign="top"><ucType:ucCommType ID="ucType" runat="server" /></td>
     <td valign="top"><ucContact:ucCommContact ID="ucContact" runat="server" /></td>
    </tr>
   </table>
   <aspx:UpdatePanel ID="uPnl" runat="server">
    <ContentTemplate>
     <table>
      <tr>
       <td valign="top"><ucAddress:ucCommAddress ID="ucAddress" runat="server" /></td>
       <td valign="top"><ucItem:ucCommItem ID="ucItem" runat="server" /></td>
      </tr>
     </table>
    </ContentTemplate>
   </aspx:UpdatePanel>   
  </ContentTemplate>
 </aspx:UpdatePanel> 
</asp:Content>