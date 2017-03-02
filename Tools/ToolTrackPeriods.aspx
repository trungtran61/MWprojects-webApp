<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="ToolTrackPeriods.aspx.cs" Inherits="webApp.Tools.ToolTrackPeriods" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
 <script type="text/javascript">
  function doChange() {
   var x = $('#<%= ddlRange.ClientID %> option:selected').val();
   var txt = $('#<%= ddlRange.ClientID %> option:selected').text();

   if (x.indexOf(':') > 0) {
    var df = '';
    var dt = '';

    if (txt == 'Last 3 Months') {
     var d1 = new Date();
     var d2 = new Date();
     d1.setMonth(d1.getMonth() - 3); d1.setDate(1);
     d2.setDate(0);

     df = d1.format("MM/dd/yyyy");
     dt = d2.format("MM/dd/yyyy");
    } else {
     var dNow = new Date();
     var y = x.split(':');
     var z = dNow.getFullYear();
     var df = y[0] + z;
     var dt = y[1] + z;
    }

    $('#<%= txtDf.ClientID %>').val(df);
    $('#<%= txtDt.ClientID %>').val(dt + ' 23:59:59');
   } else {
    $('#<%= txtDf.ClientID %>').val('');
    $('#<%= txtDt.ClientID %>').val('');
   }
  }

  function getTotal() {
   var itemNum = $('#<%= txtItemNum.ClientID %>').val();
   var toolName = $('#<%= txtToolName.ClientID %>').val();
   var manufacturer = $('#<%= txtManufacturer.ClientID %>').val();
   var toolStatus = $('#<%= txtToolStatus.ClientID %>').val();

   var req = new Object();
   req.Token = $('#<%= hfToken.ClientID %>').val();
   req.Channel = $('#<%= hfChannel.ClientID %>').val();
   req.TGN = $('#<%= txtTGN.ClientID %>').val();

   if (itemNum !== '') req.ItemNum = '%' + itemNum + '%'; else req.ItemNum = '';
   if (toolName !== '') req.ToolName = '%' + toolName + '%'; else req.ToolName = '';
   if (manufacturer !== '') req.Manufacturer = '%' + manufacturer + '%'; else req.Manufacturer = '';
   if (toolStatus !== '') req.ToolStatus = '%' + toolStatus + '%'; else req.ToolStatus = '';

   req.DateFrom = $('#<%= txtDf.ClientID %>').val();
   req.DateTo = $('#<%= txtDt.ClientID %>').val();

   $.support.cors = true;

   $.ajax({
    url: $('#<%= hfApiUrl.ClientID %>').val(),
    type: 'POST',
    dataType: 'json',
    data: req,
    success: function (data) {

     $('#ChkOutTotalNew').text(data.CheckOutTotalNew);
     $('#ChkOutTotalNonNew').text(data.CheckOutTotalNonNew);
     $('#ChkOutTotal').text(data.CheckOutTotal);

     $('#RecTotalNew').text(data.RecTotalNew);
     $('#RecTotalNonNew').text(data.RecTotalNonNew);
     $('#RecTotal').text(data.RecTotal);

     $('#ChkInTotalNew').text(data.CheckInTotalNew);
     $('#ChkInTotalNonNew').text(data.CheckInTotalNonNew);
     $('#ChkInTotal').text(data.CheckInTotal);

     $('#UohTotalNew').text(data.UohTotalNew);
     $('#UohTotalNonNew').text(data.UohTotalNonNew);
     $('#UohTotal').text(data.UohTotal);

     __doPostBack('<%= btnSearch.UniqueID %>', '');
    },
    error: function (xhr, textStatus, errorThrown) {
     alert(xhr.responseJSON.ErrorMessage);
    }
   });

   return false;
  }
 </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <h3>Tool Activity Period Report</h3>
 <table style="background-color:#CCCCCC;">
  <tr>
   <td><b>TG#:</b><br /><asp:TextBox ID="txtTGN" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>Item#:</b><br /><asp:TextBox ID="txtItemNum" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>Name:</b><br /><asp:TextBox ID="txtToolName" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>Manufacture:</b><br /><asp:TextBox ID="txtManufacturer" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>Status:</b><br /><asp:TextBox ID="txtToolStatus" runat="server" Width="75px"></asp:TextBox></td>
   <td>
    <b>Date Range:</b><br />
    <asp:DropDownList ID="ddlRange" runat="server" onchange="javascript:doChange();">
     <asp:ListItem Text="" Value=""></asp:ListItem>
     <asp:ListItem Text="January" Value="01/01/:01/31/"></asp:ListItem>
     <asp:ListItem Text="February" Value="02/01/:02/28/"></asp:ListItem>
     <asp:ListItem Text="March" Value="03/01/:03/31/"></asp:ListItem>
     <asp:ListItem Text="April" Value="04/01/:04/30/"></asp:ListItem>
     <asp:ListItem Text="May" Value="05/01/:05/31/"></asp:ListItem>
     <asp:ListItem Text="June" Value="06/01/:06/30/"></asp:ListItem>
     <asp:ListItem Text="July" Value="07/01/:07/31/"></asp:ListItem>
     <asp:ListItem Text="August" Value="08/01/:08/31/"></asp:ListItem>
     <asp:ListItem Text="September" Value="09/01/:09/30/"></asp:ListItem>
     <asp:ListItem Text="October" Value="10/01/:10/31/"></asp:ListItem>
     <asp:ListItem Text="November" Value="11/01/:11/30/"></asp:ListItem>
     <asp:ListItem Text="December" Value="12/01/:12/31/"></asp:ListItem>
     <asp:ListItem Text="Last 3 Months" Value="12/01/:12/31/"></asp:ListItem>
     <asp:ListItem Text="1st Quarter" Value="01/01/:03/31/"></asp:ListItem>
     <asp:ListItem Text="2nd Quarter" Value="04/01/:06/30/"></asp:ListItem>
     <asp:ListItem Text="3rd Quarter" Value="07/01/:09/30/"></asp:ListItem>
     <asp:ListItem Text="4th Quarter" Value="10/01/:12/31/"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td>
    <b>Date From:</b><br />
    <asp:TextBox ID="txtDf" runat="server" Width="80px" />
    <ajax:CalendarExtender ID="calDf" runat="server" TargetControlID="txtDf" Format="MM/dd/yyyy" />
   </td>
   <td>
    <b>Date To:</b><br />
    <asp:TextBox ID="txtDt" runat="server" Width="80px" />
    <ajax:CalendarExtender ID="calDt" runat="server" TargetControlID="txtDt" Format="MM/dd/yyyy" />
   </td>
   <td valign="bottom"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="NavBtn" OnClientClick="javascript:return getTotal();" OnClick="clickSearch" /></td>
   <td valign="bottom">
    <input type="button" name="mainArea_btnReset" value="Reset" id="mainArea_btnReset" class="NavBtn" onclick="javascript: location.href = 'ToolTrackPeriods.aspx';" />
   </td>
  </tr>
 </table>
 <table style="border: 1px solid black;">
  <tr style="background-color:#507CD1">
   <td>&nbsp;</td>
   <td><b>New ($)</b></td>
   <td><b>Non-New ($)</b></td>
   <td><b>Total ($)</b></td>
  </tr>
  <tr>
   <td>Check Out</td>
   <td><span id="ChkOutTotalNew"></span></td>
   <td><span id="ChkOutTotalNonNew"></span></td>
   <td><span id="ChkOutTotal"></span></td>
  </tr>
  <tr>
   <td>Receive</td>
   <td><span id="RecTotalNew"></span></td>
   <td><span id="RecTotalNonNew"></span></td>
   <td><span id="RecTotal"></span></td>
  </tr>
  <tr>
   <td>Check In</td>
   <td><span id="ChkInTotalNew"></span></td>
   <td><span id="ChkInTotalNonNew"></span></td>
   <td><span id="ChkInTotal"></span></td>
  </tr>
  <tr>
   <td>On-Hand</td>
   <td><span id="UohTotalNew"></span></td>
   <td><span id="UohTotalNonNew"></span></td>
   <td><span id="UohTotal"></span></td>
  </tr>
 </table>
 <aspx:UpdatePanel ID="uPnlPeriods" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvPeriods" runat="server" SkinID="Default" DataSourceID="odsPeriods" DataKeyNames="TGN,ItemNum" AllowSorting="false" OnDataBound="gvBound">
    <Columns>
     <asp:BoundField HeaderText="TG#" DataField="TGN" SortExpression="TGN" InsertVisible="false" />
     <asp:BoundField HeaderText="Item#" DataField="ItemNum" SortExpression="ItemNum" InsertVisible="false" />
     <asp:BoundField HeaderText="Name" DataField="ToolName" SortExpression="ToolName" InsertVisible="false" />
     <asp:BoundField HeaderText="Manufacture" DataField="Manufacturer" SortExpression="Manufacturer" InsertVisible="false" />
     <asp:BoundField HeaderText="Status" DataField="ToolStatus" SortExpression="ToolStatus" InsertVisible="false" />
     <asp:BoundField HeaderText="Uoh (Net)" DataField="Uoh" SortExpression="Uoh" InsertVisible="false" />
     <asp:BoundField HeaderText="In (Net)" DataField="ChkIn" SortExpression="ChkIn" InsertVisible="false" />
     <asp:BoundField HeaderText="Rec (Net)" DataField="Rec" SortExpression="Rec" InsertVisible="false" />
     <asp:BoundField HeaderText="Out (Net)" DataField="ChkOut" SortExpression="ChkOut" InsertVisible="false" />
     <asp:BoundField HeaderText="Price Each" DataField="PriceEach" SortExpression="PriceEach" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" InsertVisible="false" />
     <asp:BoundField HeaderText="Uoh ($)" DataField="UohAmt" SortExpression="UohAmt" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" InsertVisible="false" />
     <asp:BoundField HeaderText="In ($)" DataField="ChkInAmt" SortExpression="ChkInAmt" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" InsertVisible="false" />
     <asp:BoundField HeaderText="Rec ($)" DataField="RecAmt" SortExpression="RecAmt" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" InsertVisible="false" />
     <asp:BoundField HeaderText="Out ($)" DataField="ChkOutAmt" SortExpression="ChkOutAmt" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" InsertVisible="false" />
    </Columns>
   </asp:GridView>
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" /></Triggers>
 </aspx:UpdatePanel>
 <asp:HiddenField ID="hfToken" runat="server" />
 <asp:HiddenField ID="hfChannel" runat="server" />
 <asp:HiddenField ID="hfApiUrl" runat="server" />
 <asp:ObjectDataSource ID="odsPeriods" runat="server" TypeName="myBiz.DAL.clsToolTracking" SelectMethod="GetToolTrackingReport">
  <SelectParameters>
   <asp:Parameter Name="isSearch" Type="Boolean" DefaultValue="False" />
   <asp:ControlParameter Name="TGN" Type="String" ControlID="txtTGN" PropertyName="Text" />
   <asp:ControlParameter Name="ItemNum" Type="String" ControlID="txtItemNum" PropertyName="Text" />
   <asp:ControlParameter Name="ToolName" Type="String" ControlID="txtToolName" PropertyName="Text" />
   <asp:ControlParameter Name="Manufacturer" Type="String" ControlID="txtManufacturer" PropertyName="Text" />
   <asp:ControlParameter Name="ToolStatus" Type="String" ControlID="txtToolStatus" PropertyName="Text" />
   <asp:ControlParameter Name="Df" Type="DateTime" ControlID="txtDf" PropertyName="Text" />
   <asp:ControlParameter Name="Dt" Type="DateTime" ControlID="txtDt" PropertyName="Text" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsRange" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="DateRange" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>
