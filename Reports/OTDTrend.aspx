<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Reports.OTDTrend" Title="Department OTD Trend" Codebehind="OTDTrend.aspx.cs" %>

<asp:Content ID="cntHead" runat="server" ContentPlaceHolderID="cphHead">
 <script language="javascript" type="text/javascript" src="../App_Themes/jquery-1.6.4.min.js"></script>
 <script language="javascript" type="text/javascript">
  function doChange(){
   var x = $('#<%= ddlRange.ClientID %> option:selected').val();
   var txt = $('#<%= ddlRange.ClientID %> option:selected').text();
   
   if (x.indexOf(':') > 0){
    var y = x.split(':');
    var z = (new Date()).getFullYear();

    if (txt == 'Last Year') z = z - 1;
    var Ab = y[1] + z;
    
    if (txt == 'This Year') {
     var tDay = new Date();
     Ab = tDay.format("MM/dd/yyyy"); 
    }
    
    $('#<%= txtDf.ClientID %>').val(y[0] + z);
    $('#<%= txtDt.ClientID %>').val(Ab + ' 23:59:59');
   } else {
    $('#<%= txtDf.ClientID %>').val('');
    $('#<%= txtDt.ClientID %>').val('');
   }
  }
  function chkAll(chk,isAll,hf){
   var myBoxes = $(hf).val().split(':');
   var len = myBoxes.length;
   var Cnt = 1;
   for (var i = 0; i < len; i++) {
    if (isAll) document.getElementById(myBoxes[i]).checked = chk.checked;
    else if (document.getElementById(myBoxes[i]).checked && i > 0) Cnt++;
   }
   if (!isAll) document.getElementById(myBoxes[0]).checked = Cnt == len;
  }
  function doOpen(x){
   $('#<%= hfUseField.ClientID %>').val(x);
   $find('<%= mpeAddress.ClientID %>').show();
  }
  function doOK(){
   var x = ''; var y;
   var cID = 'xAddress_';
   var Cnt = $('#<%= hfCnt.ClientID %>').val();
   
   for (var i = 0; i < Cnt; i++){
    y = document.getElementById(cID+i);
    if (y.checked) {
     if (x.length>0) x = x + ', ' + y.value;
     else x = y.value;
     y.checked = false;
    }
   }
   
   $('#' + $('#<%= hfUseField.ClientID %>').val()).val(x);
  }
 </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" Runat="Server">
 <table>
  <tr valign="top">
   <td>
    <fieldset>
     <legend>Report On</legend>
     <table>
      <tr valign="top">
       <td><b>Dept.</b></td>
       <td><b>Step</b></td>
       <td><b>PO/INV</b></td>
      </tr>
      <tr valign="top">
       <td>
        <MW:ChkBoxList ID="cblDeptList" runat="server" DataSourceID="odsDeptList" AppendDataBoundItems="true" DataTextField="Txt" DataValueField="HID" OnDataBound="cblBound">
         <asp:ListItem Text="All" Value="-1"></asp:ListItem>
         <asp:ListItem Text="C-OTD" Value="0"></asp:ListItem>
         <asp:ListItem Text="RC-OTD" Value="99"></asp:ListItem>
        </MW:ChkBoxList>
       </td>
       <td>
        <MW:ChkBoxList ID="cblStepList" runat="server" DataSourceID="odsStepList" AppendDataBoundItems="true" DataTextField="Name" DataValueField="HID" OnDataBound="cblBound">
         <asp:ListItem Text="All" Value="-1"></asp:ListItem>
        </MW:ChkBoxList>
       </td>
       <td>
        <MW:ChkBoxList ID="cblQueue" runat="server" DataSourceID="odsQueue" AppendDataBoundItems="true" DataTextField="mText" DataValueField="mValue" OnDataBound="cblBound">
         <asp:ListItem Text="All" Value="-1"></asp:ListItem>
        </MW:ChkBoxList>
       </td>
      </tr>
     </table>
     <asp:HiddenField ID="hfDept" runat="server" />
     <asp:HiddenField ID="hfStep" runat="server" />
     <asp:HiddenField ID="hfQueue" runat="server" />
    </fieldset>   
   </td>
   <td>
    <fieldset>
     <legend>Date Range</legend>
     <table>
      <tr>
       <td><b>Range:</b></td>
       <td><b>Date From:</b></td>
       <td><b>Date To:</b></td>
      </tr>
      <tr>
       <td><asp:DropDownList ID="ddlRange" runat="server" DataSourceID="odsRange" DataTextField="mText" DataValueField="mValue" onchange="javascript:doChange();" /></td>
       <td>
        <asp:TextBox ID="txtDf" runat="server" Width="80px" />
        <ajax:CalendarExtender ID="calDf" runat="server" TargetControlID="txtDf" Format="MM/dd/yyyy" />
       </td>
       <td>
        <asp:TextBox ID="txtDt" runat="server" Width="80px" />
        <ajax:CalendarExtender ID="calDt" runat="server" TargetControlID="txtDt" Format="MM/dd/yyyy" />   
       </td>
      </tr>
     </table>
    </fieldset>
    <br />
    <asp:Button ID="btnGo" runat="server" Text="Calculate OTD Trend" OnClick="doCalculate" CssClass="NavBtn" />   
    <asp:Button ID="btnTable" runat="server" Text="Show Table" CssClass="NavBtn" />
   </td>
  </tr>
 </table>
 <br /><br />
 <table>
  <tr valign="top">
   <td>
    <aspx:UpdatePanel ID="uPnlOTD" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
      <asp:Button ID="btnEmail" runat="server" Text="Email" OnClientClick="javascript:$('#dvEmail').show();return false;" CssClass="NavBtn" Visible="false" /><br /><br />
      <telerik:RadChart ID="rChart" runat="server" DefaultType="Line" AutoLayout="true" Height="500px" Width="800px">
       <ChartTitle><TextBlock Text="Department OTD Trend"></TextBlock></ChartTitle>
       <PlotArea>
        <EmptySeriesMessage TextBlock-Text="No records to display!"></EmptySeriesMessage>
        <Appearance FillStyle-FillType="Solid" FillStyle-MainColor="White"></Appearance>
        <YAxis Appearance-MajorGridLines-Visible="false" Appearance-MinorGridLines-Visible="false" Appearance-TextAppearance-TextProperties-Color="Black"></YAxis>
        <XAxis Appearance-MajorGridLines-Visible="false" Appearance-MinorGridLines-Visible="false" Appearance-TextAppearance-TextProperties-Color="Black" DataLabelsColumn="dName" Appearance-LabelAppearance-RotationAngle="300"></XAxis>
       </PlotArea>
      </telerik:RadChart>
     </ContentTemplate>
     <Triggers>
      <aspx:AsyncPostBackTrigger ControlID="btnGo" EventName="Click" />
     </Triggers>
    </aspx:UpdatePanel>
   </td>
   <td><br /><br />
    <div id="dvEmail" style="display:none;">
     <aspx:UpdatePanel ID="uPnlEmail" runat="server" UpdateMode="Conditional">
      <ContentTemplate>
       <table style="background:#CCFFCC;">
        <tr><td><b>From:</b></td><td><asp:TextBox ID="txtFrom" runat="server" Width="300px"></asp:TextBox></td></tr>
        <tr><td><b><a onclick="javascript:doOpen('<%= txtTo.ClientID %>');" class="Pointer">To:</a></b></td><td><asp:TextBox ID="txtTo" runat="server" Width="300px"></asp:TextBox></td></tr>
        <tr><td><b>Subject:</b></td><td><asp:TextBox ID="txtSubject" runat="server" Width="300px" Text="Department OTD Trend Graph!"></asp:TextBox></td></tr>
        <tr><td colspan="2"><asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine" Width="365px" Height="150px"></asp:TextBox></td></tr>
        <tr>
         <td align="right" colspan="2">
          <asp:Button ID="btnSend" runat="server" Text="Send" OnClick="doSend" CssClass="NavBtn" />
          <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick="javascript:$('#dvEmail').hide(); return false;" CssClass="NavBtn" />
         </td>
        </tr>
       </table><br />
       <MW:Message ID="iMsg" runat="server" />
       <table id="tblAddress" runat="server" class="mdlPopup">
        <tr><td><asp:Literal ID="litEmail" runat="server"></asp:Literal></td></tr>
        <tr><td><asp:Button ID="btnAddOK" runat="server" Text="OK" CssClass="NavBtn" /></td></tr>
       </table>
       <ajax:ModalPopupExtender ID="mpeAddress" runat="server" TargetControlID="hfUseField" PopupControlID="tblAddress" BackgroundCssClass="mdlBackground"
        OkControlID="btnAddOK" DropShadow="false" RepositionMode="RepositionOnWindowResize" OnOkScript="doOK()" />

       <asp:HiddenField ID="hfCnt" runat="server" />
       <asp:HiddenField ID="hfUseField" runat="server" />
      </ContentTemplate>
      <Triggers><aspx:AsyncPostBackTrigger ControlID="btnGo" EventName="Click" /></Triggers>
     </aspx:UpdatePanel>
    </div>  
   </td>
  </tr>
 </table>

 <aspx:UpdatePanel ID="uPnlTable" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
      <asp:GridView ID="gvTable" runat="server" SkinID="Default" DataSourceID="odsTable" DataKeyNames="dName">
       <Columns>
        <asp:BoundField HeaderText="Month" DataField="dName" SortExpression="dName" InsertVisible="false" />
        <asp:BoundField HeaderText="Value" DataField="RC_OTD" SortExpression="RC_OTD" InsertVisible="false" />
       </Columns>
      </asp:GridView>
      <asp:ObjectDataSource ID="odsTable" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="Dept_OTD_S">
       <SelectParameters>
        <asp:Parameter Name="spName" Type="String" DefaultValue="spReport_OTDTrend_S" />
        <asp:ControlParameter Name="Df" Type="DateTime" ControlID="txtDf" PropertyName="Text" />
        <asp:ControlParameter Name="Dt" Type="DateTime" ControlID="txtDt" PropertyName="Text" />
        <asp:Parameter Name="DeptIDs" Type="String" DefaultValue="99" />
        <asp:Parameter Name="StepIDs" Type="String" DefaultValue="" />
        <asp:Parameter Name="xQueue" Type="String" DefaultValue="" />
       </SelectParameters>
      </asp:ObjectDataSource>
  </ContentTemplate>
     <Triggers>
      <aspx:AsyncPostBackTrigger ControlID="btnTable" EventName="Click" />
     </Triggers>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsDeptList" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="DeptList"></asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsStepList" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="StepList"></asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsRange" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="DateRange" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
  </SelectParameters>
 </asp:ObjectDataSource>

 <asp:ObjectDataSource ID="odsQueue" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="QueueList" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="0" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>