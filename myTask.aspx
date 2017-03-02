<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MiniMaster.master" AutoEventWireup="true" Inherits="webApp.myTask" Codebehind="myTask.aspx.cs" %>
<asp:Content ContentPlaceHolderID="cphHead" runat="server">
 <script language="javascript" type="text/javascript" src="App_Themes/jquery-1.6.4.min.js"></script>
 <script language="javascript" type="text/javascript">
  window.onbeforeunload = confirmExit;
  function confirmExit() {
   var x = document.getElementById('<%= hfCompBtn.ClientID %>').value;
   var y = document.getElementById(x);
   var z = document.getElementById('xCloseX').value;

   if (y && z == 'Yes' && !$('#' + x).is(':disabled')) return doMarkComplete();
  }
  function doMarkComplete() {
   if (confirm("Would you like to Mark Complete this task?")) {
    callTest();
    alert('COMPLETED!');
   }
  }
  function callTest() {
   $.ajax({
    type: "POST",
    url: 'Search.asmx/markComplete',
    data: "{'URL':'" + window.location.href + "'}",
    contentType: 'application/json; charset=utf-8',
    dataType: 'json',
    success: function () { },
    error: doError
   });
  }
  function doError(request, status, error) { alert(request.statusText); }
 </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" Runat="Server">
<aspx:UpdatePanel ID="uPnlTask" runat="server">
 <ContentTemplate>
  <asp:Panel ID="pnlTask" runat="server" />
  <asp:HiddenField ID="hfCompBtn" runat="server" />
  <input type="hidden" name="xCloseX" id="xCloseX" value="No" />
 </ContentTemplate>
</aspx:UpdatePanel>
</asp:Content>

