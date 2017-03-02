<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="GageTrak.aspx.cs" Inherits="webApp.Tools.GageTrak" %>

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
  $(function () { $('#<%= txtGageID.ClientID %>').autocomplete({ source: function (request, response) { GetSource(request, response, "GageTrakIdList") }, minLength: 1 }); });
  $(function () { $('#<%= txtDescription.ClientID %>').autocomplete({ source: function (request, response) { GetSource(request, response, "GageTrakDescriptionList") }, minLength: 1 }); });
 </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <table style="background-color:#CCCCCC;">
  <tr>
   <td><b>GG#:</b><br /><asp:TextBox ID="txtGrpNum" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>GageID:</b><br /><asp:TextBox ID="txtGageID" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>Description:</b><br /><asp:TextBox ID="txtDescription" runat="server"></asp:TextBox></td>
   <td><b>Expire:</b><br />
    <asp:DropDownList ID="ddlExpire" runat="server">
     <asp:ListItem Value="Both" Text="Both"></asp:ListItem>
     <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
     <asp:ListItem Value="No" Text="No" Selected="True"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td><b>Checking Method:</b><br /><asp:DropDownList ID="ddlCheck" runat="server" DataSourceID="odsCheck" DataTextField="mText" DataValueField="mValue"></asp:DropDownList></td>
   <td><b>Owner:</b><br /><asp:TextBox ID="txtOwner" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>Internal Location:</b><br /><asp:DropDownList ID="ddlIntLocID" runat="server" DataSourceID="odsIntLoc" DataTextField="lDescription" DataValueField="HID"></asp:DropDownList></td>
   <td><b>External Location:</b><br /><asp:DropDownList ID="ddlExtLocID" runat="server" DataSourceID="odsExtLoc" DataTextField="lDescription" DataValueField="HID"></asp:DropDownList></td>
   <td><b>Status:</b><br />
    <asp:DropDownList ID="ddlStatus" runat="server">
     <asp:ListItem Value="" Text=""></asp:ListItem>
     <asp:ListItem Value="1 - Active" Text="1 - Active"></asp:ListItem>
     <asp:ListItem Value="2 - Inactive" Text="2 - Inactive"></asp:ListItem>
     <asp:ListItem Value="3 - Out for Repair" Text="3 - Out for Repair"></asp:ListItem>
     <asp:ListItem Value="4 - In Calibration" Text="4 - In Calibration"></asp:ListItem>
     <asp:ListItem Value="5 - Lost" Text="5 - Lost"></asp:ListItem>
     <asp:ListItem Value="6 - Out for Calibration" Text="6 - Out for Calibration"></asp:ListItem>
     <asp:ListItem Value="7 - Reference Only" Text="7 - Reference Only"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td valign="bottom"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="NavBtn" OnClick="clickSearch" /></td>
   <td valign="bottom">
    <input type="button" name="mainArea_btnReset" value="Reset" id="mainArea_btnReset" class="NavBtn" onclick="javascript: location.href = 'GageTrak.aspx';" />
    <asp:HiddenField ID="hfToken" runat="server" />
    <asp:HiddenField ID="hfChannel" runat="server" />
    <asp:HiddenField ID="hfApiListUrl" runat="server" />
   </td>
  </tr>
 </table>
 <aspx:UpdatePanel ID="uPnlGageTrak" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvGageTrak" runat="server" SkinID="Default" DataSourceID="odsGageTrak" DataKeyNames="GageID,CalibrationDate" AllowSorting="false" OnRowDataBound="rwBound" OnRowUpdating="rwUpdating">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
      </EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="GG#" SortExpression="GrpNum" InsertVisible="false">
      <ItemTemplate><%# Eval("GrpNum") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtGrpNum" runat="server" Text='<%# Bind("GrpNum") %>'></asp:TextBox></EditItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Gage ID" ReadOnly="true" DataField="GageID" SortExpression="GageID" InsertVisible="false" />
     <asp:BoundField HeaderText="Description" ReadOnly="true" DataField="Description" SortExpression="Description" InsertVisible="false" />
     <asp:TemplateField HeaderText="Qty" SortExpression="Qty" InsertVisible="false">
      <ItemTemplate><%# Eval("Qty") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtQty" runat="server" Text='<%# Bind("Qty") %>' Width="75px"></asp:TextBox></EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Graduation" SortExpression="Graduation" InsertVisible="false">
      <ItemTemplate><%# Eval("Graduation") %></ItemTemplate>
      <EditItemTemplate><asp:DropDownList ID="ddlGrad" runat="server" DataSourceID="odsGrad" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("Graduation") %>'></asp:DropDownList></EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Low Limit" SortExpression="LowLimit" InsertVisible="false">
      <ItemTemplate><%# Eval("LowLimit") %></ItemTemplate>
      <EditItemTemplate><asp:DropDownList ID="ddlLow" runat="server" DataSourceID="odsLow" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("LowLimit") %>'></asp:DropDownList></EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="High Limit" SortExpression="HighLimit" InsertVisible="false">
      <ItemTemplate><%# Eval("HighLimit") %></ItemTemplate>
      <EditItemTemplate><asp:DropDownList ID="ddlHigh" runat="server" DataSourceID="odsHigh" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("HighLimit") %>'></asp:DropDownList></EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Checking Method" SortExpression="CheckingMethod" InsertVisible="false">
      <ItemTemplate><%# Eval("CheckingMethod") %></ItemTemplate>
      <EditItemTemplate>
       <asp:ListBox ID="lbxCheck" runat="server" DataSourceID="odsCheck" DataTextField="mText" DataValueField="mValue" SelectionMode="Multiple" Width="100px" Height="75px"></asp:ListBox>
       <asp:HiddenField ID="hfCheck" runat="server" Value='<%# Eval("CheckingMethod") %>' />
      </EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Owner" SortExpression="Owner" InsertVisible="false">
      <ItemTemplate><%# Eval("Owner") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtOwner" runat="server" Text='<%# Bind("Owner") %>'></asp:TextBox></EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Internal Location" SortExpression="IntLocID" InsertVisible="false">
      <ItemTemplate><%# Eval("IntLoc") %></ItemTemplate>
      <EditItemTemplate><asp:DropDownList ID="ddlIntLoc" runat="server" DataSourceID="odsIntLoc" DataTextField="lDescription" DataValueField="HID" SelectedValue='<%# Eval("IntLocID") %>'></asp:DropDownList></EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="External Location" SortExpression="ExtLocID" InsertVisible="false">
      <ItemTemplate><%# Eval("ExtLoc") %></ItemTemplate>
      <EditItemTemplate><asp:DropDownList ID="ddlExtLoc" runat="server" DataSourceID="odsExtLoc" DataTextField="lDescription" DataValueField="HID" SelectedValue='<%# Eval("ExtLocID") %>'></asp:DropDownList></EditItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Status" ReadOnly="true" DataField="Status" SortExpression="Status" InsertVisible="false" />
     <asp:TemplateField HeaderText="Expire Date" SortExpression="ExpireDate" InsertVisible="false">
      <ItemTemplate><%# gDD("ExpireDate") %></ItemTemplate>
      <EditItemTemplate><%# gDD("ExpireDate") %></EditItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Calibration Date" ReadOnly="true" DataField="CalibrationDate" SortExpression="CalibrationDate" DataFormatString="{0:MM/dd/yyyy}" InsertVisible="false" />
    </Columns>
   </asp:GridView>
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" /></Triggers>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsGageTrak" runat="server" TypeName="myBiz.DAL.clsGageTrak" SelectMethod="GetGageTraks" UpdateMethod="SaveGageTraks">
  <SelectParameters>
   <asp:Parameter Name="isSearch" Type="Boolean" DefaultValue="False" />
   <asp:ControlParameter Name="GrpNum" Type="String" ControlID="txtGrpNum" PropertyName="Text" />
   <asp:ControlParameter Name="GageID" Type="String" ControlID="txtGageID" PropertyName="Text" />
   <asp:ControlParameter Name="Description" Type="String" ControlID="txtDescription" PropertyName="Text" />
   <asp:ControlParameter Name="Expire" Type="String" ControlID="ddlExpire" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="IntLocID" Type="Int32" ControlID="ddlIntLocID" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="ExtLocID" Type="Int32" ControlID="ddlExtLocID" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="Status" Type="String" ControlID="ddlStatus" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="CheckingMethod" Type="String" ControlID="ddlCheck" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="Owner" Type="String" ControlID="txtOwner" PropertyName="Text" />
  </SelectParameters>
  <UpdateParameters>
   <asp:Parameter Name="GrpNum" Type="String" />
   <asp:Parameter Name="GageID" Type="String" />
   <asp:Parameter Name="CalibrationDate" Type="DateTime" />
   <asp:Parameter Name="ExpireDate" Type="DateTime" />
   <asp:Parameter Name="IntLocID" Type="Int32" />
   <asp:Parameter Name="ExtLocID" Type="Int32" />
   <asp:Parameter Name="Description" Type="String" />
   <asp:Parameter Name="Graduation" Type="String" />
   <asp:Parameter Name="LowLimit" Type="String" />
   <asp:Parameter Name="HighLimit" Type="String" />
   <asp:Parameter Name="CheckingMethod" Type="String" />
   <asp:Parameter Name="Owner" Type="String" />
   <asp:Parameter Name="Status" Type="String" />
   <asp:Parameter Name="Qty" Type="Int32" />
  </UpdateParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsIntLoc" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
  <SelectParameters>
   <asp:Parameter Name="Dept" Type="String" DefaultValue="Gage Internal" />
   <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
   <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsExtLoc" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
  <SelectParameters>
   <asp:Parameter Name="Dept" Type="String" DefaultValue="Gage External" />
   <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
   <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsGrad" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="Graduation" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsLow" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="LowLimit" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsHigh" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="HighLimit" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsCheck" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="CheckingMethod" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>