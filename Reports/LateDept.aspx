<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="LateDept.aspx.cs" Inherits="webApp.Reports.LateDept" %>

<asp:Content ID="cntHead" ContentPlaceHolderID="cphHead" runat="server">
 <script language="javascript" type="text/javascript" src="../App_Themes/jquery-1.6.4.min.js"></script>
 <script language="javascript" type="text/javascript">
  function doChange() {
   var x = $('#<%= ddlRange.ClientID %> option:selected').val();
   var txt = $('#<%= ddlRange.ClientID %> option:selected').text();

   if (x.indexOf(':') > 0) {
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
 </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <table>
  <tr valign="top">
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
    <asp:Button ID="btnGo" runat="server" Text="Show Late Deliveries" CssClass="NavBtn" />   
   </td>
  </tr>
 </table>
 <br /><br />
 <table>
  <tr valign="top">
   <td>
    <aspx:UpdatePanel ID="uPnlLateDept" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
      <asp:GridView ID="gvLateDept" runat="server" SkinID="Default" DataSourceID="odsLateDept" DataKeyNames="WorkOrderID,StepNo">
       <Columns>
        <asp:BoundField HeaderText="WorkOrder" DataField="WorkOrder" SortExpression="WorkOrder" InsertVisible="false" />
        <asp:BoundField HeaderText="Employee" DataField="EmployeeName" SortExpression="EmployeeName" InsertVisible="false" />
        <asp:BoundField HeaderText="Task" DataField="Task" SortExpression="Task" InsertVisible="false" />
        <asp:BoundField HeaderText="Due Date" DataField="DueDate" SortExpression="DueDate" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
        <asp:BoundField HeaderText="Complete Date" DataField="CompletionDate" SortExpression="CompletionDate" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       </Columns>
      </asp:GridView>
      <asp:ObjectDataSource ID="odsLateDept" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="LateDept">
       <SelectParameters>
        <asp:ControlParameter Name="Df" Type="DateTime" ControlID="txtDf" PropertyName="Text" />
        <asp:ControlParameter Name="Dt" Type="DateTime" ControlID="txtDt" PropertyName="Text" />
        <asp:Parameter Name="DeptID" Type="String" DefaultValue="" />
        <asp:Parameter Name="StepID" Type="String" DefaultValue="4" />
        <asp:Parameter Name="xQueue" Type="String" DefaultValue="" />
       </SelectParameters>
      </asp:ObjectDataSource>
     </ContentTemplate>
     <Triggers>
      <aspx:AsyncPostBackTrigger ControlID="btnGo" EventName="Click" />
     </Triggers>
    </aspx:UpdatePanel>
   </td>
  </tr>
 </table>

 <asp:ObjectDataSource ID="odsRange" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="DateRange" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>
