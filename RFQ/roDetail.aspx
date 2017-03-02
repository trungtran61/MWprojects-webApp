<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="roDetail.aspx.cs" Inherits="webApp.RFQ.roDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <aspx:ScriptManager ID="scrDetail" runat="server" EnablePartialRendering="true"></aspx:ScriptManager>
     <aspx:UpdatePanel ID="uPnlDetail" runat="server" UpdateMode="Conditional">
      <ContentTemplate>
       <h1><asp:Label ID="lblDetailHeader" runat="server" Font-Bold="true" OnLoad="lblLoad"></asp:Label></h1>
       <asp:GridView ID="gvDetail" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsDetail" AllowSorting="false" OnRowDataBound="rwBound" OnDataBound="gvBound" OnRowCommand="rwCmd">
        <Columns>
         <asp:TemplateField>
          <ItemTemplate>
           <asp:Button ID="btnSelect" runat="server" Text="S" CommandName="Select" Visible='<%# Eval("isSelected").Equals(false) %>' />
           <asp:HiddenField ID="hfSelected" runat="server" Value='<%# Eval("isSelected") %>' />
           <asp:HiddenField ID="hfCode" runat="server" Value='<%# Eval("Code") %>' />
          </ItemTemplate>
         </asp:TemplateField>
         <asp:BoundField HeaderText="RFQ Number" DataField="RFQNumber" InsertVisible="false" />
         <asp:BoundField HeaderText="Item#" DataField="ItemNo" InsertVisible="false" />
         <asp:BoundField HeaderText="Description" DataField="Description" InsertVisible="false" />
         <asp:BoundField HeaderText="Qty" DataField="Quantity" InsertVisible="false" />
         <asp:BoundField HeaderText="Unit" DataField="Unit" InsertVisible="false" />
         <asp:BoundField HeaderText="Price" DataField="UnitPrice" DataFormatString="{0:C}" InsertVisible="false" />
         <asp:BoundField HeaderText="Total" DataField="Total" DataFormatString="{0:C}" InsertVisible="false" />
         <asp:BoundField HeaderText="Lead Time" DataField="LeadTime" InsertVisible="false" />
         <asp:BoundField HeaderText="Vendor" DataField="VendorName" InsertVisible="false" />
         <asp:BoundField HeaderText="Comment" DataField="Comment" InsertVisible="false" />
         <asp:TemplateField>
          <ItemTemplate>
           <asp:LinkButton ID="lnkFile" runat="server" Text="File" CommandName="viewFile" CommandArgument='<%# Eval("HID") %>'></asp:LinkButton>
          </ItemTemplate>
         </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>No Record Found!</EmptyDataTemplate>
       </asp:GridView>
       <asp:Literal ID="litMsg" runat="server"></asp:Literal>
       <asp:Panel ID="pnlPopup" runat="server" />
       <asp:ObjectDataSource ID="odsDetail" runat="server" TypeName="myBiz.DAL.clsFinQte" SelectMethod="roDetail" UpdateMethod="roDetail_Update">
        <SelectParameters>
         <asp:QueryStringParameter Name="RFQID" Type="Int32" QueryStringField="RFQID" />
         <asp:QueryStringParameter Name="Ln" Type="Int32" QueryStringField="Ln" />
         <asp:QueryStringParameter Name="sNo" Type="Int32" QueryStringField="sNo" />
         <asp:QueryStringParameter Name="sNm" Type="String" QueryStringField="sNm" />
        </SelectParameters>
        <UpdateParameters>
         <asp:QueryStringParameter Name="RFQID" Type="Int32" QueryStringField="RFQID" />
         <asp:QueryStringParameter Name="Ln" Type="Int32" QueryStringField="Ln" />
         <asp:QueryStringParameter Name="sNo" Type="Int32" QueryStringField="sNo" />
         <asp:Parameter Name="Total" Type="Decimal" />
         <asp:Parameter Name="LeadTime" Type="Int32" />
        </UpdateParameters>
       </asp:ObjectDataSource>
      </ContentTemplate>
     </aspx:UpdatePanel>
    </div>
    </form>
</body>
</html>
