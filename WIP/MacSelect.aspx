<%@ Page Language="C#" AutoEventWireup="true" Inherits="webApp.WIP.MacSelect" Codebehind="MacSelect.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>Untitled Page</title>
 <link href="../App_Themes/mwStyle.css" rel="stylesheet" type="text/css" />
 <telerik:RadScriptBlock runat="server" ID="scrBlock">
  <script type="text/javascript" language="javascript">
   function GetRadWindow()
   {
    var oWindow = null;
    if (window.radWindow) oWindow = window.radWindow;
    else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
    return oWindow;
   }
   function doClose(isOK)
   {
    var obj = GetRadWindow();
    obj.BrowserWindow.callMe(document.getElementById('<%= hfMIDs.ClientID %>').value,document.getElementById('<%= hfcID.ClientID %>').value,isOK);
    obj.close();
   }
  </script>
 </telerik:RadScriptBlock>
</head>
<body>
 <form id="form1" runat="server">
  <div>
   <aspx:ScriptManager ID="scrMacSel" runat="server" EnablePartialRendering="true" />
   <aspx:UpdatePanel ID="uPnlMalSel" runat="server">
    <ContentTemplate>
     <asp:Table ID="tblMacSel" runat="server" BackColor="Aquamarine">
      <asp:TableRow>
       <asp:TableCell Font-Bold="true">Selected Machine(s)</asp:TableCell>
       <asp:TableCell>&nbsp;</asp:TableCell>
       <asp:TableCell Font-Bold="true">Available Machine(s)</asp:TableCell>
      </asp:TableRow>
      <asp:TableRow>
       <asp:TableCell><asp:ListBox ID="lbxSelMac" runat="server" Height="350px" Width="350px" DataTextField="mName" DataValueField="MID" SelectionMode="Multiple" /></asp:TableCell>
       <asp:TableCell HorizontalAlign="center">
        <asp:Button ID="btnAdd" runat="server" Text="&larr; Add" OnClick="btnClick" CssClass="NavBtn" /><br />
        <asp:Button ID="btnRemove" runat="server" Text="Remove &rarr;" OnClick="btnClick" CssClass="NavBtn" /><br /><br />
        <asp:Button ID="btnMoveUp" runat="server" Text="&uarr; Up &uarr;" OnClick="btnClick" CssClass="NavBtn" /><br />
        <asp:Button ID="btnMoveDown" runat="server" Text="&darr; Down &darr;" OnClick="btnClick" CssClass="NavBtn" />
       </asp:TableCell>
       <asp:TableCell><asp:ListBox ID="lbxUnselMac" runat="server" Height="350px" Width="350px" DataTextField="mName" DataValueField="MID" SelectionMode="Multiple" /></asp:TableCell>
      </asp:TableRow>
     </asp:Table>
     <br /><br />
     <asp:Button ID="btnOK" runat="server" Text="OK" OnClientClick="javascript:doClose(1);return false;" CssClass="NavBtn" />
     <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick="javascript:doClose(0);return false;" CssClass="NavBtn" />
     <br /><MW:Message ID="iMsg" runat="server" />
     <asp:HiddenField ID="hfMIDs" runat="server" />
     <asp:HiddenField ID="hfcID" runat="server" />
    </ContentTemplate>
   </aspx:UpdatePanel>
   <asp:ObjectDataSource ID="odsMPID" runat="server" TypeName="myBiz.DAL.clsMachine" SelectMethod="MachineList">
    <SelectParameters>
     <asp:Parameter Name="StepID" Type="Int32" DefaultValue="3" />
    </SelectParameters>
   </asp:ObjectDataSource>
  </div>
 </form>
</body>
</html>
