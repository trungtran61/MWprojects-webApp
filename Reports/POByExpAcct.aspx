<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="POByExpAcct.aspx.cs" Inherits="webApp.Reports.POByExpAcct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
     function loadPreview(id) {
      window.open("../File/Preview.aspx?FID=PO&Code=GeneralPO&HID=" + id, "mPopup");
     }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <asp:GridView ID="gvOpenPO" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsOpenPO">
      <Columns>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Created By" DataField="CreatedBy" SortExpression="CreatedBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="CreatedDate" SortExpression="CreatedDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="PO #" SortExpression="PONumber" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkPONumber" runat="server" Text='<%# Eval("PONumber") %>' OnClientClick='<%# string.Format("javascript:loadPreview(\"{0}\");return false;", Eval("POLink")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Total" DataField="Total" HtmlEncode="false" DataFormatString="{0:C2}" SortExpression="Total" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Part Number" DataField="PartNumber" SortExpression="PartNumber" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Supplier" SortExpression="VendorName">
        <ItemTemplate><%# gVdrName() %></ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No Record Found!</EmptyDataTemplate>
     </asp:GridView>
     <asp:ObjectDataSource ID="odsOpenPO" runat="server" TypeName="myBiz.DAL.clsPO" SelectMethod="SelectByExpAcct">
      <SelectParameters>
       <asp:QueryStringParameter Name="tExpAcct" Type="String" QueryStringField="tExpAcct" />
       <asp:QueryStringParameter Name="df" Type="DateTime" QueryStringField="df" />
       <asp:QueryStringParameter Name="dt" Type="DateTime" QueryStringField="dt" />
      </SelectParameters>
     </asp:ObjectDataSource>
    </div>
    </form>
</body>
</html>
