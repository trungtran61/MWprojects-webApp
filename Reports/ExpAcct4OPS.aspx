<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExpAcct4OPS.aspx.cs" Inherits="webApp.Reports.ExpAcct4OPS" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <asp:GridView ID="gvExpAcct" runat="server" SkinID="Default" AllowSorting="false" DataSourceID="odsExpAcct">
       <Columns>
        <asp:BoundField HeaderText="Expenses" DataField="tExpAcct" InsertVisible="false" />
        <asp:BoundField HeaderText="$ Amount" DataField="Amt" InsertVisible="false" DataFormatString="{0:N}" ItemStyle-HorizontalAlign="Center" />
        <asp:BoundField HeaderText="% / P-Income" DataField="pIncPt" InsertVisible="false" DataFormatString="{0:P}" ItemStyle-HorizontalAlign="Center" />
        <asp:BoundField HeaderText="% / Income" DataField="rIncPt" InsertVisible="false" DataFormatString="{0:P}" ItemStyle-HorizontalAlign="Center" />
        <asp:BoundField HeaderText="% / Expenses" DataField="rExpPt" InsertVisible="false" DataFormatString="{0:P}" ItemStyle-HorizontalAlign="Center" />
       </Columns>
      </asp:GridView>
     <asp:ObjectDataSource ID="odsExpAcct" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="ExpAcct4OPS">
      <SelectParameters>
       <asp:QueryStringParameter Name="Df" Type="DateTime" QueryStringField="Df" />
       <asp:QueryStringParameter Name="Dt" Type="DateTime" QueryStringField="Dt" />
      </SelectParameters>
     </asp:ObjectDataSource>
    </div>
    </form>
</body>
</html>
