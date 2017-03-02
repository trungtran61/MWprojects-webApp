<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="gtDetail.aspx.cs" Inherits="webApp.RFQ.gtDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <aspx:ScriptManager ID="scrDetail" runat="server" EnablePartialRendering="true"></aspx:ScriptManager>
     <aspx:UpdatePanel ID="uPnlGage" runat="server" UpdateMode="Conditional">
      <ContentTemplate>
       <h1><asp:Label ID="lblGageHeader" runat="server" Font-Bold="true" OnLoad="lblLoad"></asp:Label></h1>
       <asp:GridView ID="gvGageDetail" runat="server" SkinID="Default" DataKeyNames="ItemNo" DataSourceID="odsGageDetail" ShowFooter="true" AllowSorting="false" OnDataBound="gvBound">
        <Columns>
         <asp:TemplateField HeaderText="ItemNo" InsertVisible="false">
          <ItemTemplate><%# Eval("ItemNo") %></ItemTemplate>
          <FooterTemplate><b>Total</b></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Desc" InsertVisible="false">
          <ItemTemplate><%# Eval("GTDesc") %></ItemTemplate>
          <FooterTemplate>&nbsp;</FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Qty" InsertVisible="false">
          <ItemTemplate><%# Eval("Qty") %></ItemTemplate>
          <FooterTemplate>&nbsp;</FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Price" InsertVisible="false">
          <ItemTemplate><%# Eval("UnitPrice") %></ItemTemplate>
          <FooterTemplate>&nbsp;</FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Total" InsertVisible="false">
          <ItemTemplate><%# Eval("Total","{0:C}") %><asp:HiddenField ID="hfTotal" runat="server" Value='<%# Eval("Total") %>' /></ItemTemplate>
          <FooterTemplate><asp:Literal ID="litTotal" runat="server"></asp:Literal></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Vendor" InsertVisible="false">
          <ItemTemplate><%# Eval("VendorName") %></ItemTemplate>
          <FooterTemplate>&nbsp;</FooterTemplate>
         </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>No Record Found!</EmptyDataTemplate>
       </asp:GridView>
       <asp:ObjectDataSource ID="odsGageDetail" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="getDetail">
        <SelectParameters>
         <asp:QueryStringParameter Name="RFQID" Type="Int32" QueryStringField="RFQID" />
         <asp:QueryStringParameter Name="StepNo" Type="Int32" QueryStringField="sNo" />
        </SelectParameters>
       </asp:ObjectDataSource>
      </ContentTemplate>
     </aspx:UpdatePanel>

     <aspx:UpdatePanel ID="uPnlTool" runat="server" UpdateMode="Conditional">
      <ContentTemplate>
       <h1><asp:Label ID="lblToolHeader" runat="server" Font-Bold="true" OnLoad="lblLoad"></asp:Label></h1>
       <asp:GridView ID="gvToolDetail" runat="server" SkinID="Default" DataKeyNames="ItemNo" DataSourceID="odsToolDetail" ShowFooter="true" AllowSorting="false" OnDataBound="gvBound">
        <Columns>
         <asp:TemplateField HeaderText="ItemNo" InsertVisible="false">
          <ItemTemplate><%# Eval("ItemNo") %></ItemTemplate>
          <FooterTemplate><b>Total</b></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Desc" InsertVisible="false">
          <ItemTemplate><%# Eval("GTDesc") %></ItemTemplate>
          <FooterTemplate>&nbsp;</FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Parts/ Tool" InsertVisible="false">
          <ItemTemplate><%# Eval("PartTool") %></ItemTemplate>
          <FooterTemplate>&nbsp;</FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Tool Qty" InsertVisible="false">
          <ItemTemplate><%# Eval("Qty") %></ItemTemplate>
          <FooterTemplate>&nbsp;</FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Price" InsertVisible="false">
          <ItemTemplate><%# Eval("UnitPrice") %></ItemTemplate>
          <FooterTemplate>&nbsp;</FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Total" InsertVisible="false">
          <ItemTemplate><%# Eval("Total","{0:C}") %><asp:HiddenField ID="hfTotal" runat="server" Value='<%# Eval("Total") %>' /></ItemTemplate>
          <FooterTemplate><asp:Literal ID="litTotal" runat="server"></asp:Literal></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Vendor" InsertVisible="false">
          <ItemTemplate><%# Eval("VendorName") %></ItemTemplate>
          <FooterTemplate>&nbsp;</FooterTemplate>
         </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>No Record Found!</EmptyDataTemplate>
       </asp:GridView>
       <asp:ObjectDataSource ID="odsToolDetail" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="getDetail">
        <SelectParameters>
         <asp:QueryStringParameter Name="RFQID" Type="Int32" QueryStringField="RFQID" />
         <asp:QueryStringParameter Name="StepNo" Type="Int32" QueryStringField="sNo" />
         <asp:QueryStringParameter Name="PartQty" Type="Int32" QueryStringField="pQty" />
        </SelectParameters>
       </asp:ObjectDataSource>
      </ContentTemplate>
     </aspx:UpdatePanel>
    </div>
    </form>
</body>
</html>
