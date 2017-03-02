<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucSurvey.ascx.cs" Inherits="webApp._Controls.ucSurvey" %>
<%@ Register Src="~/_Controls/ucSurvey_Question.ascx" TagName="ucSurvey_Question" TagPrefix="ucQuestion" %>

<center>
 <table border="1px" cellpadding="" cellspacing="0" style="border-color:Gray; width:90%">
  <tr align="left">
   <td width="50%">
    <table>
     <tr>
      <td valign="top">From:</td>
      <td valign="bottom"><br /><br /><asp:Literal ID="litMWAddress" runat="server"></asp:Literal></td>
     </tr>
    </table>
   </td>
   <td width="50%">
    <table>
     <tr>
      <td valign="top">Contact Us:</td>
      <td valign="bottom"><br /><br /><asp:Literal ID="litMWContact" runat="server"></asp:Literal></td>
     </tr>
    </table>
   </td>
  </tr>
  <tr align="left">
   <td>
    To: <b><asp:Literal ID="litVdrAddress" runat="server"></asp:Literal></b><br />
    Attention: <b><u>Quality Manager</u></b>
   </td>
   <td style="border:1px solid black;">
    Please complete this survey,<br />
    and hit Submit button below when done.<br /><br />
    Thank You!
   </td>
  </tr>
  <tr>
   <td colspan="2">
    <center><b>SUPPLIER SURVEY</b></center>
    <asp:RadioButtonList ID="rdoStatus" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" CellPadding="15">
     <asp:ListItem Value="New" Text="NEW SUPPLIER"></asp:ListItem>
     <asp:ListItem Value="Existed" Text="ANNUAL SURVEY UPDATE"></asp:ListItem>
    </asp:RadioButtonList>
    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" Text="* - Supplier Survey is required!" ControlToValidate="rdoStatus" ValidationGroup="vActive" />
   </td>
  </tr>
  <tr>
   <td colspan="2">
    As part of our obligations to our customers in the Aerosspace industry we are required to periodically suvey our subcontractors or parts and services.
    We appreciate you taking your time to fill out this survey form.
   </td>
  </tr>
 </table>

 <br /><br />

 <h1>YOUR ORGANIZATION</h1>
 <table border="1" cellpadding="0" cellspacing="0" style="border-color:Gray; width:90%">
  <tr align="left">
   <td width="50%">
    <b>Quality Control Manager:</b> <asp:TextBox ID="txtQltyCtrlMgr" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvQltyCtrlMgr" runat="server" Text="*" ControlToValidate="txtQltyCtrlMgr" ValidationGroup="vActive" />
   </td>
   <td width="50%">
    <b>Manufacturing Manager:</b> <asp:TextBox ID="txtMfgMgr" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvMfgMgr" runat="server" Text="*" ControlToValidate="txtMfgMgr" ValidationGroup="vActive" />
   </td>
  </tr>
  <tr align="left">
   <td><b>TYPE OF PRODUCT OR SERVICE PROVIDED</b></td>
   <td><asp:TextBox ID="txtProductType" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvProductType" runat="server" Text="*" ControlToValidate="txtProductType" ValidationGroup="vActive" />
   </td>
  </tr>
  <tr align="left">
   <td colspan="2">
    Distributor <asp:CheckBox ID="chkIsDistributor" runat="server" /><br />
    (Distributors resell product as received from a manufacturer. The product material is not processed, modified, or sorted).
   </td>
  </tr>
  <tr align="left">
   <td colspan="2">
    Certified? <asp:CheckBox ID="chkIsCertified" runat="server" /><br />
    <b>++IF YOU ARE CERTIFIED ISO 9000/AS9100/NADCAP OR EQUIVALENT, SKIP TO SECTION 14. CERTIFICATION AND SEND A COPY OF YOUR CERTIFICATION++</b>
   </td>
  </tr>
 </table>

 <ucQuestion:ucSurvey_Question ID="myQuestion" runat="server" />

 <div id="dvCert">
 <br /><br />
 <table border="1" cellpadding="0" cellspacing="0" style="border-color:Gray; width:90%">
  <tr align="left">
   <td>
    <b>14. CERTIFICATION</b><br />
    Certification Number/Name: <asp:TextBox ID="txtCertNo" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvCertNo_Cert" runat="server" Text="*" ControlToValidate="txtCertNo" ValidationGroup="vInActive" />
    <br /><br />
    Certification Expiration Date: <asp:TextBox ID="txtExpDate" runat="server" placeholder="mm/dd/yyyy"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvExpDate_Cert" runat="server" Text="*" ControlToValidate="txtExpDate" ValidationGroup="vInActive" />
    <asp:RangeValidator ID="rvExpDate_Cert" runat="server" ControlToValidate="txtExpDate" Type="Date" Text="Invalid Date!" ForeColor="Red" OnLoad="lDate" ValidationGroup="vInActive"></asp:RangeValidator>
    <br /><br />
    Upload Certification:<br /><asp:FileUpload ID="fuCert" runat="server" />
    <asp:RequiredFieldValidator ID="rfvCert_Cert" runat="server" Text="*" ControlToValidate="fuCert" ValidationGroup="vInActive" />
   </td>
  </tr>
 </table>
 </div>

 <br /><br />
 <table border="1" cellpadding="0" cellspacing="0" style="border-color:Gray; width:90%">
  <tr style="text-align:left">
   <td>
    The information supplied above is certified to be true and accurate to the best of my knowledge.<br />
    <table>
     <tr>
      <td><b>Name:</b><br /><asp:TextBox ID="txtName" runat="server"></asp:TextBox>
       <asp:RequiredFieldValidator ID="rfvName" runat="server" Text="*" ControlToValidate="txtName" ValidationGroup="vActive" />
      </td>
      <td><b>Title:</b><br /><asp:TextBox ID="txtTitle" runat="server"></asp:TextBox>
       <asp:RequiredFieldValidator ID="rfvTitle" runat="server" Text="*" ControlToValidate="txtTitle" ValidationGroup="vActive" />
      </td>
      <td><b>Date:</b><br /><asp:TextBox ID="txtDate" runat="server" placeholder="mm/dd/yyyy"></asp:TextBox>
       <asp:RequiredFieldValidator ID="rfvDate" runat="server" Text="*" ControlToValidate="txtDate" ValidationGroup="vActive" />
      </td>
     </tr>
    </table>
    <br />
    Signature: <asp:TextBox ID="txtSignature" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvSignature" runat="server" Text="*" ControlToValidate="txtSignature" ValidationGroup="vActive" />
   </td>
  </tr>
 </table>

 <asp:HiddenField ID="hfVendorID" runat="server" />
 <asp:HiddenField ID="hfProcessID" runat="server" />
 <asp:HiddenField ID="hfTemplateID" runat="server" />
 <asp:HiddenField ID="hfCertID" runat="server" />
 <asp:HiddenField ID="hfCertInfoID" runat="server" />
</center>