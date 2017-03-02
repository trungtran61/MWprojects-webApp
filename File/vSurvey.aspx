<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vSurvey.aspx.cs" Inherits="webApp.File.vSurvey" %>
<%@ Register Src="~/_Controls/ucSurvey.ascx" TagName="ucSurvey" TagPrefix="ucSurvey" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>Survey</title>
 <script language="javascript" type="text/javascript" src="../App_Themes/jquery-1.6.4.min.js"></script>
 <script language="javascript" type="text/javascript" src="../App_Themes/placeholders.min.js"></script>
 <telerik:RadScriptBlock runat="server" ID="scrBlock">
 <script language="javascript" type="text/javascript">
  function doCert(chk) {
   var a, b;

   if ($(chk).is(':checked')) {
    $('#dvCert').show();
    a = '_Cert';
    b = '_NoCert';
   }
   else {
    $('#dvCert').hide();
    a = '_NoCert';
    b = '_Cert';
   }

   $.each(Page_Validators, function (index, val) {
    var x = document.getElementById(val.id);
    if (val.id.indexOf(a) > -1) {
     x.validationGroup = 'vActive';
    } else if (val.id.indexOf(b) > -1) {
     x.validationGroup = 'vInActive';
    }
   });
  }
 </script>
 </telerik:RadScriptBlock>
</head>
<body>
 <form id="form1" runat="server">
  <div>
   <asp:ScriptManager ID="scrVendorFill" runat="server" EnablePartialRendering="true" />
   <asp:Literal ID="iMsg" runat="server"></asp:Literal>
   <asp:ValidationSummary ID="valSum" runat="server" HeaderText="Fields with red * are required!" ForeColor="Red" ValidationGroup="vActive" />
   <h3><asp:Literal ID="litVendorName" runat="server"></asp:Literal></h3>
   <b>Survey for: <asp:Literal ID="litSurvey" runat="server"></asp:Literal></b>
   <br />
   <ucSurvey:ucSurvey ID="mySurvey" runat="server" />
   <br /><br />
   <asp:Button ID="btnSubmit" runat="server" OnClick="doSubmit" Text="Submit" CssClass="NavBtn" ValidationGroup="vActive" />
  </div>
 </form>
</body>
</html>
