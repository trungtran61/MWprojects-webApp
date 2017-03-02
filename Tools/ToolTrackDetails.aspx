<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="ToolTrackDetails.aspx.cs" Inherits="webApp.Tools.ToolTrackDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
 <script type="text/javascript">
  function doChange() {
   var x = $('#<%= ddlRange.ClientID %> option:selected').val();
   var txt = $('#<%= ddlRange.ClientID %> option:selected').text();

   if (x.indexOf(':') > 0) {
    var y = x.split(':');
    var z = (new Date()).getFullYear();

    $('#<%= txtDf.ClientID %>').val(y[0] + z);
    $('#<%= txtDt.ClientID %>').val(y[1] + z + ' 23:59:59');
   } else {
    $('#<%= txtDf.ClientID %>').val('');
    $('#<%= txtDt.ClientID %>').val('');
   }
  }
 </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <h3>Tool Activity Detail Report</h3>
 <table style="background-color:#CCCCCC;">
  <tr>
   <td><b>TG#:</b><br /><asp:TextBox ID="txtTGN" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>Item#:</b><br /><asp:TextBox ID="txtItemNum" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>Name:</b><br /><asp:TextBox ID="txtToolName" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>Status:</b><br /><asp:TextBox ID="txtToolStatus" runat="server" Width="75px"></asp:TextBox></td>
   <td>
    <b>Action</b><br />
    <asp:DropDownList ID="ddlAction" runat="server">
     <asp:ListItem Text="" Value=""></asp:ListItem>
     <asp:ListItem Text="Update Onhand" Value="UpdateOnHand"></asp:ListItem>
     <asp:ListItem Text="Check In" Value="CheckIn"></asp:ListItem>
     <asp:ListItem Text="Check Out" Value="CheckOut"></asp:ListItem>
     <asp:ListItem Text="Receive" Value="Receive"></asp:ListItem>
    </asp:DropDownList>
   </td>
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
   <td valign="bottom"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="NavBtn" OnClick="clickSearch" /></td>
   <td valign="bottom">
    <input type="button" name="mainArea_btnReset" value="Reset" id="mainArea_btnReset" class="NavBtn" onclick="javascript: location.href = 'ToolTrackDetails.aspx';" />
   </td>
  </tr>
 </table>
 <aspx:UpdatePanel ID="uPnlDetails" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvDetails" runat="server" SkinID="Default" DataSourceID="odsDetails" DataKeyNames="TGN,ItemNum" AllowSorting="false" OnDataBound="gvBound">
    <Columns>
     <asp:BoundField HeaderText="TG#" DataField="TGN" SortExpression="TGN" InsertVisible="false" />
     <asp:BoundField HeaderText="Item#" DataField="ItemNum" SortExpression="ItemNum" InsertVisible="false" />
     <asp:BoundField HeaderText="Name" DataField="ToolName" SortExpression="ToolName" InsertVisible="false" />
     <asp:BoundField HeaderText="Status" DataField="ToolStatus" SortExpression="ToolStatus" InsertVisible="false" />
     <asp:BoundField HeaderText="Action" DataField="ActType" SortExpression="ActType" InsertVisible="false" />
     <asp:BoundField HeaderText="Qty Before" DataField="QtyBefore" SortExpression="QtyBefore" InsertVisible="false" />
     <asp:BoundField HeaderText="Qty After" DataField="QtyAfter" SortExpression="QtyAfter" InsertVisible="false" />
     <asp:BoundField HeaderText="Net" DataField="QtyNet" SortExpression="QtyNet" InsertVisible="false" />
     <asp:BoundField HeaderText="By" DataField="ActBy" SortExpression="ActBy" InsertVisible="false" />
     <asp:BoundField HeaderText="Date" DataField="ActDate" SortExpression="ActDate" InsertVisible="false" />
    </Columns>
   </asp:GridView>
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" /></Triggers>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsDetails" runat="server" TypeName="myBiz.DAL.clsToolTracking" SelectMethod="GetToolTrackingDetails">
  <SelectParameters>
   <asp:Parameter Name="isSearch" Type="Boolean" DefaultValue="False" />
   <asp:ControlParameter Name="TGN" Type="String" ControlID="txtTGN" PropertyName="Text" />
   <asp:ControlParameter Name="ItemNum" Type="String" ControlID="txtItemNum" PropertyName="Text" />
   <asp:ControlParameter Name="ToolName" Type="String" ControlID="txtToolName" PropertyName="Text" />
   <asp:ControlParameter Name="ToolStatus" Type="String" ControlID="txtToolStatus" PropertyName="Text" />
   <asp:ControlParameter Name="ActType" Type="String" ControlID="ddlAction" PropertyName="SelectedValue" />
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