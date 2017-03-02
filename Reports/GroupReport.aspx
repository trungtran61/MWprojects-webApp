<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroupReport.aspx.cs" Inherits="webApp.Reports.GroupReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     Group Report for: <b><%= Request.QueryString["gName"] %></b><br /><br />
     <asp:GridView ID="gvReport" runat="server" SkinID="GrayHeader" DataSourceID="odsReport" PageSize="500">
      <Columns>
       <asp:BoundField HeaderText="Page" DataField="PageName" SortExpression="PageName" InsertVisible="false" />
       <asp:BoundField HeaderText="Feature" DataField="CodeName" SortExpression="CodeName" InsertVisible="false" />
       <asp:CheckBoxField HeaderText="Enabled" DataField="CodeVal" InsertVisible="false" />
      </Columns>
     </asp:GridView>
     <asp:ObjectDataSource ID="odsReport" runat="server" TypeName="myBiz.DAL.clsUserGroup" SelectMethod="GroupReport">
      <SelectParameters><asp:QueryStringParameter Name="GroupID" Type="Int32" QueryStringField="gID" /></SelectParameters>
     </asp:ObjectDataSource>
    </div>
    </form>
</body>
</html>
