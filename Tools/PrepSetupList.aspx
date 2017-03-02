<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="PrepSetupList.aspx.cs" Inherits="webApp.Tools.PrepSetupList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
 <script type="text/javascript" src="../App_Themes/jquery-ui.min.js" ></script>
 <link rel="Stylesheet" href="../App_Themes/jquery-ui.min.css" />
 <script type="text/javascript">
  function GetSource(request, response, xCode) {
   var req = new Object();
   req.Token = $('#<%= hfToken.ClientID %>').val();
   req.Channel = $('#<%= hfChannel.ClientID %>').val();
   req.PreText = request.term;
   req.ListName = xCode;

   $.support.cors = true;

   $.ajax({
    url: $('#<%= hfApiListUrl.ClientID %>').val(),
    type: 'POST',
    dataType: 'json',
    data: req,
    success: function (data) {
     response($.map(data.Items, function (item) {
      return {
       label: item.Text,
       value: item.Value
      }
     }));
    },
    error: function (xhr, textStatus, errorThrown) {
     alert(xhr.responseJSON.ErrorMessage);
    }
   });
  }
 </script>
 <script type="text/javascript">
  $(function () { $('#<%= txtWorkOrder.ClientID %>').autocomplete({ source: function (request, response) { GetSource(request, response, "WorkOrderList") }, minLength: 1 }); });
  $(function () { $('#<%= txtPartNumber.ClientID %>').autocomplete({ source: function (request, response) { GetSource(request, response, "PartNumberList") }, minLength: 1 }); });
 </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <table style="background-color:#CCCCCC;">
  <tr>
   <td><b>WO#:</b><br /><asp:TextBox ID="txtWorkOrder" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>PN:</b><br /><asp:TextBox ID="txtPartNumber" runat="server"></asp:TextBox></td>
   <td><b>Step#:</b><br /><asp:TextBox ID="txtStepNo" runat="server" Width="50px"></asp:TextBox></td>
   <td><b>Op#:</b><br /><asp:TextBox ID="txtOpNo" runat="server" Width="50px"></asp:TextBox></td>
   <td><b>Op. Name:</b><br />
    <asp:DropDownList ID="ddlOpName" runat="server">
     <asp:ListItem Value="" Text=""></asp:ListItem>
     <asp:ListItem Value="LATHE" Text="LATHE"></asp:ListItem>
     <asp:ListItem Value="MILL" Text="MILL"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td><b>Item Name:</b><br />
    <asp:DropDownList ID="ddlItemName" runat="server">
     <asp:ListItem Value="" Text=""></asp:ListItem>
     <asp:ListItem Value="Program" Text="1 - Program"></asp:ListItem>
     <asp:ListItem Value="Tools" Text="2 - Tools"></asp:ListItem>
     <asp:ListItem Value="Tool Holders" Text="3 - Tool Holders"></asp:ListItem>
     <asp:ListItem Value="Parts for Setup (Sample)" Text="4 - Parts for Setup (Sample)"></asp:ListItem>
     <asp:ListItem Value="Part Holding (Working Holding)" Text="5 - Part Holding (Working Holding)"></asp:ListItem>
     <asp:ListItem Value="Gages" Text="6 - Gages"></asp:ListItem>
     <asp:ListItem Value="M.O.T" Text="7 - M.O.T"></asp:ListItem>
     <asp:ListItem Value="Inspection Report (1st pcs & In-Process)" Text="8 - Inspection Report (1st pcs & In-Process)"></asp:ListItem>
     <asp:ListItem Value="Wrenchs & Miscellaneous" Text="9 - Wrenchs & Miscellaneous"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td><b>Status:</b><br />
    <asp:DropDownList ID="ddlStatus" runat="server">
     <asp:ListItem Value="" Text=""></asp:ListItem>
     <asp:ListItem Value="Open" Text="Open"></asp:ListItem>
     <asp:ListItem Value="Requested" Text="Requested: đã yêu cầu"></asp:ListItem>
     <asp:ListItem Value="Delivered" Text="Delivered: đã giao"></asp:ListItem>
     <asp:ListItem Value="Received" Text="Received: đã nhận"></asp:ListItem>
     <asp:ListItem Value="Verified" Text="Verified: đã kiểm tra"></asp:ListItem>
     <asp:ListItem Value="Pending" Text="Pending"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td><b>Time Range:</b><br />
    <asp:DropDownList ID="ddlTimeRange" runat="server">
     <asp:ListItem Value="" Text=""></asp:ListItem>
     <asp:ListItem Value="1" Text="1 month"></asp:ListItem>
     <asp:ListItem Value="2" Text="2 months"></asp:ListItem>
     <asp:ListItem Value="3" Text="3 months"></asp:ListItem>
     <asp:ListItem Value="4" Text="4 months"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td valign="bottom"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="NavBtn" OnClick="clickSearch" /></td>
   <td valign="bottom">
    <input type="button" name="mainArea_btnReset" value="Reset" id="mainArea_btnReset" class="NavBtn" onclick="javascript: location.href = 'PrepSetupList.aspx';" />
    <asp:HiddenField ID="hfToken" runat="server" />
    <asp:HiddenField ID="hfChannel" runat="server" />
    <asp:HiddenField ID="hfApiListUrl" runat="server" />
   </td>
  </tr>
 </table>
 <aspx:UpdatePanel ID="uPnlPrepSetupList" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvPrepSetupList" runat="server" SkinID="Default" DataSourceID="odsPrepSetupList" DataKeyNames="WorkOrder" AllowSorting="false" OnDataBound="gvBound">
    <Columns>
     <asp:BoundField HeaderText="WO#" DataField="WorkOrder" SortExpression="WorkOrder" InsertVisible="false" />
     <asp:BoundField HeaderText="PN" DataField="PartNumber" SortExpression="PartNumber" InsertVisible="false" />
     <asp:BoundField HeaderText="Rev" DataField="Revision" SortExpression="Revision" InsertVisible="false" />
     <asp:BoundField HeaderText="St/Op" DataField="St_Op" SortExpression="St_Op" InsertVisible="false" />
     <asp:BoundField HeaderText="Op. Name" DataField="OpName" SortExpression="OpName" InsertVisible="false" />
     <asp:BoundField HeaderText="Item Name" DataField="ItemName" SortExpression="ItemName" InsertVisible="false" />
     <asp:BoundField HeaderText="Status" DataField="Status" SortExpression="Status" InsertVisible="false" />
     <asp:TemplateField HeaderText="Due Date" SortExpression="DueDate" InsertVisible="false">
      <ItemTemplate><%# gDD("DueDate") %></ItemTemplate>
      <EditItemTemplate><%# gDD("DueDate") %></EditItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Location" DataField="LocDesc" SortExpression="LocDesc" InsertVisible="false" />
    </Columns>
   </asp:GridView>
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" /></Triggers>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsPrepSetupList" runat="server" TypeName="myBiz.DAL.clsPrepSetup" SelectMethod="GetPrepSetupList">
  <SelectParameters>
   <asp:Parameter Name="isSearch" Type="Boolean" DefaultValue="False" />
   <asp:ControlParameter Name="workOrder" Type="String" ControlID="txtWorkOrder" PropertyName="Text" />
   <asp:ControlParameter Name="partNumber" Type="String" ControlID="txtPartNumber" PropertyName="Text" />
   <asp:ControlParameter Name="stepNo" Type="Int32" ControlID="txtStepNo" PropertyName="Text" />
   <asp:ControlParameter Name="opNo" Type="String" ControlID="txtOpNo" PropertyName="Text" />
   <asp:ControlParameter Name="opName" Type="String" ControlID="ddlOpName" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="itemName" Type="String" ControlID="ddlItemName" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="Status" Type="String" ControlID="ddlStatus" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="timeRange" Type="Int32" ControlID="ddlTimeRange" PropertyName="SelectedValue" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>