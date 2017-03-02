<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckList.aspx.cs" Inherits="webApp.Tools.CheckList" %>
<%@ Register Src="~/_Controls/ucCheckListItems.ascx" TagName="CheckListItems" TagPrefix="ucCheckList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>My Check List</title>
 <link href="../App_Themes/Default/mwStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
 <form id="form1" runat="server">
  <aspx:ScriptManager ID="myScriptManager" runat="server" EnablePartialRendering="true" EnablePageMethods="true" />
  <div>
   <asp:Repeater ID="rptCheckLists" runat="server" DataSourceID="odsCheckLists">
    <ItemTemplate>
     <asp:Label ID="lblHeader" runat="server" Text='<%# Eval("CheckListName") %>' BackColor="Silver" CssClass="Finger" Font-Size="Large"></asp:Label>
     <asp:Panel ID="pnlHeader" runat="server"><ucCheckList:CheckListItems ID="chkListItems" runat="server" UserName='<%# webApp.Common.clsUser.uID %>' CheckListID='<%# Eval("HID") %>' /></asp:Panel>
     <ajax:CollapsiblePanelExtender ID="cpeHeader" runat="server" TargetControlID="pnlHeader" ExpandControlID="lblHeader" CollapseControlID="lblHeader" Collapsed="false" />
    </ItemTemplate>
    <SeparatorTemplate><br /><br /></SeparatorTemplate>
   </asp:Repeater>

   <asp:ObjectDataSource ID="odsCheckLists" runat="server" TypeName="myBiz.DAL.clsCheckList" SelectMethod="GetCheckListsByUser">
    <SelectParameters>
     <asp:Parameter Name="UserName" Type="String" />
    </SelectParameters>
    <UpdateParameters>
     <asp:Parameter Name="UserName" Type="String" />
     <asp:Parameter Name="CheckListID" Type="Int32" />
     <asp:Parameter Name="Done" Type="Boolean" />
    </UpdateParameters>
   </asp:ObjectDataSource>
  </div>
 </form>
</body>
</html>
