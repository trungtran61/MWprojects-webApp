<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Budget.aspx.cs" Inherits="webApp.Tools.Budget" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>Budget Table</title>
 <link href="../App_Themes/Default/mwStyle.css" rel="stylesheet" type="text/css" />
 <script type="text/javascript">
  function loadReport(URL) {
   var oWindow = null;
   location.href = URL;

   if (window.radWindow) oWindow = window.radWindow;
   else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;

   oWindow.maximize();
  }
 </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <asp:Literal ID="litOTLimit" runat="server"></asp:Literal>
       <asp:GridView ID="gvBudget" runat="server" SkinID="Default" DataKeyNames="tExpAcct" DataSourceID="odsBudget" OnRowDataBound="rwBound" OnDataBound="gvBound">
        <Columns>
         <asp:BoundField HeaderText="Expense" DataField="tExpAcct" InsertVisible="false" />
         <asp:TemplateField InsertVisible="false" ItemStyle-HorizontalAlign="Center">
          <HeaderTemplate><span title='Maximum Allowable $ Amount'>Limit ($)</span></HeaderTemplate>
          <ItemTemplate>
           <%# Eval("LimAmt","{0:0.00}") %>
           <asp:HiddenField ID="hfLimAmt" runat="server" Value='<%# Eval("LimAmt") %>' />
          </ItemTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" SortExpression="CurAmt" InsertVisible="false">
          <HeaderTemplate><asp:LinkButton ID="lnkCurAmt" runat="server" CommandName="Sort" style="color:white;"><span title='$ Amount Had Been Used'>Current ($)</span></asp:LinkButton></HeaderTemplate>
          <ItemTemplate><%# gExpLink() %>
           <asp:HiddenField ID="hfCurAmt" runat="server" Value='<%# Eval("CurAmt") %>' />
          </ItemTemplate>
         </asp:TemplateField>
         <asp:TemplateField InsertVisible="false" ItemStyle-HorizontalAlign="Center">
          <HeaderTemplate><span title='Limit - Current'>Balance ($)</span></HeaderTemplate>
          <ItemTemplate>
           <%# Eval("DifAmt","{0:0.00}") %>
           <asp:HiddenField ID="hfDifAmt" runat="server" Value='<%# Eval("DifAmt") %>' />
          </ItemTemplate>
         </asp:TemplateField>
         <asp:BoundField HeaderText="Note" DataField="Note" InsertVisible="false" />
        </Columns>
       </asp:GridView>
       <asp:ObjectDataSource ID="odsBudget" runat="server" TypeName="myBiz.DAL.clsBudget" SelectMethod="BudgetForcast_S1"></asp:ObjectDataSource>
    </div>
    </form>
</body>
</html>
