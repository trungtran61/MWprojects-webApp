<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.sendEmail" Codebehind="sendEmail.ascx.cs" %>
<%@ Register Src="~/_Controls/attFile.ascx" TagName="attFile" TagPrefix="ucFile" %>

<asp:Panel ID="pnlSend" runat="server" DefaultButton="btnSend">
<table>
 <tr id="trVendor" runat="server">
  <td colspan="2">
   <b>Please select vendor(s) you wish to send RFQ.</b> | <input id="chkAlls" type="checkbox" name="chkAlls" onclick="javascript:chkAll(this,true);" /> Select All<br />
   <asp:CheckBoxList ID="lbxVendor" runat="server" DataSourceID="odsVendor" DataTextField="Description" DataValueField="HID" RepeatColumns="3" RepeatDirection="horizontal" OnDataBound="Bound"></asp:CheckBoxList>
  </td>
 </tr>
 <tr><td><b>From:</b></td><td align="right"><asp:TextBox ID="txtFrom" runat="server" Width="600px"></asp:TextBox></td></tr>
 <tr><td><b><a onclick="javascript:doOpen('<%= txtTo.ClientID %>');" class="Pointer">To:</a></b></td><td align="right"><asp:TextBox ID="txtTo" runat="server" Width="600px"></asp:TextBox></td></tr>
 <tr><td><b><a onclick="javascript:doOpen('<%= txtCC.ClientID %>');" class="Pointer">CC:</a></b></td><td align="right"><asp:TextBox ID="txtCC" runat="server" Width="600px"></asp:TextBox></td></tr>
 <tr><td><b><a onclick="javascript:doOpen('<%= txtBcc.ClientID %>');" class="Pointer">Bcc:</a></b></td><td align="right"><asp:TextBox ID="txtBcc" runat="server" Width="600px"></asp:TextBox></td></tr>
 <tr><td><b>Subject:</b></td><td align="right"><asp:TextBox ID="txtSubject" runat="server" Width="600px"></asp:TextBox></td></tr>
 <tr>
  <td valign="top"><b>Attachment:</b></td>
  <td>
   <asp:Label ID="lblShowDoc" runat="server" Text="Documents" CssClass="Pointer"></asp:Label>
   <asp:Panel ID="pnlShowDoc" runat="server"><ucFile:attFile ID="myFile" runat="server" /></asp:Panel>
   <ajax:CollapsiblePanelExtender ID="cpeShowDoc" runat="server" TargetControlID="pnlShowDoc" ExpandControlID="lblShowDoc" CollapseControlID="lblShowDoc" Collapsed="true" />
  </td>
 </tr>
 <tr><td colspan="2"><asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine" Width="655px" Height="150px"></asp:TextBox></td></tr>
 <tr>
  <td align="right" colspan="2">
   <asp:Button ID="btnSave" runat="server" Text="No-Send" OnClick="doSave" OnClientClick="return confirm('Are you sure you want to create quote without sending email?');" CssClass="NavBtn" />
   <asp:Button ID="btnSend" runat="server" Text="Send" OnClick="doSend" OnClientClick="return confirm('Are you sure you want to send?');" CssClass="NavBtn" />
  </td>
 </tr>
 <tr><td colspan="2"><MW:Message ID="iMsg" runat="server" /></td></tr>
</table>
</asp:Panel>

<table id="tblAddress" runat="server" class="modalPopup">
 <tr><td><asp:Literal ID="litEmail" runat="server"></asp:Literal></td></tr>
 <tr><td><asp:Button ID="btnAddOK" runat="server" Text="OK" CssClass="NavBtn" /></td></tr>
</table>
<ajax:ModalPopupExtender ID="mpeAddress" runat="server" TargetControlID="hfUseField" PopupControlID="tblAddress" BackgroundCssClass="modalBackground"
 OkControlID="btnAddOK" DropShadow="false" RepositionMode="RepositionOnWindowResize" OnOkScript="doOK()" />

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function doOpen(x){
   document.getElementById('<%= hfUseField.ClientID %>').value = x;
   $find('<%= mpeAddress.ClientID %>').show();
  }
  function doOK(){
   var x = ''; var y;
   var cID = 'xAddress_';
   var Cnt = document.getElementById('<%= hfCnt.ClientID %>').value;
   
   for (var i = 0; i < Cnt; i++){
    y = document.getElementById(cID+i);
    if (y.checked) {
     if (x.length>0) x = x + ', ' + y.value;
     else x = y.value;
     y.checked = false;
    }
   }
   
   document.getElementById(document.getElementById('<%= hfUseField.ClientID %>').value).value = x;
  }
 </script>
</telerik:RadCodeBlock>

<asp:HiddenField ID="hfGT" runat="server" />
<asp:HiddenField ID="hfFormID" runat="server" />
<asp:HiddenField ID="hfHID" runat="server" />
<asp:HiddenField ID="hfCode" runat="server" />
<asp:HiddenField ID="hfDF" runat="server" />
<asp:HiddenField ID="hfCnt" runat="server" />
<asp:HiddenField ID="hfUseField" runat="server" />
<asp:HiddenField ID="hfChkBox" runat="server" />

<asp:ObjectDataSource ID="odsVendor" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="SendBy_Select2">
 <SelectParameters>
  <asp:Parameter Name="ClassName" Type="String" DefaultValue="Supplier" />
  <asp:QueryStringParameter Name="RFQNumber" Type="String" QueryStringField="HID" />
  <asp:QueryStringParameter Name="MO" Type="String" QueryStringField="Code" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </SelectParameters>
</asp:ObjectDataSource>