<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Reports.ExpAcct" Title="Expense Account Report"  CodeBehind="ExpAcct.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
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
    <br /><asp:Button ID="btnGo" runat="server" Text="Calculate Expense Account" OnClick="doCalculate" CssClass="NavBtn" />
   </td>
  </tr>
 </table>
 <br /><br />
 <table>
  <tr valign="top">
   <td>
    <aspx:UpdatePanel ID="uPnlExpAcct" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
      <asp:GridView ID="gvDetail" runat="server" SkinID="Default" AllowSorting="false">
       <Columns>
        <asp:BoundField DataField="Title" InsertVisible="false" />
        <asp:BoundField HeaderText="Real Time" DataField="RealTime" InsertVisible="false" ItemStyle-HorizontalAlign="Right" />
        <asp:BoundField HeaderText="Predict" DataField="Predict" InsertVisible="false" ItemStyle-HorizontalAlign="Right" />
       </Columns>
      </asp:GridView>
      <br />
      <asp:GridView ID="gvExpAcct" runat="server" SkinID="Default" AllowSorting="false">
       <Columns>
        <asp:TemplateField HeaderText="Expenses" InsertVisible="false">
         <ItemTemplate><%# gExp() %></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="$ Amount" SortExpression="Amt" InsertVisible="false">
         <ItemTemplate><%# gExpLink() %></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="% / P-Income" DataField="pIncPt" InsertVisible="false" DataFormatString="{0:P}" ItemStyle-HorizontalAlign="Center" />
        <asp:BoundField HeaderText="% / Income" DataField="rIncPt" InsertVisible="false" DataFormatString="{0:P}" ItemStyle-HorizontalAlign="Center" />
        <asp:BoundField HeaderText="% / Expenses" DataField="rExpPt" InsertVisible="false" DataFormatString="{0:P}" ItemStyle-HorizontalAlign="Center" />
       </Columns>
      </asp:GridView>
     </ContentTemplate>
     <Triggers><aspx:AsyncPostBackTrigger ControlID="btnGo" EventName="Click" /></Triggers>
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
