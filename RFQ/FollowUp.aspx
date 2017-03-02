<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="FollowUp.aspx.cs" Inherits="webApp.RFQ.FollowUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlSched" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">[1] QUOTES NEED TO BE SENT</td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvSched" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="QTEID" DataSourceID="odsSched" PageSize="10">
      <Columns>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Schedule By" DataField="SendBy" SortExpression="SendBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="SendDate" SortExpression="SendDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Quote #" SortExpression="QTENumber" InsertVisible="false">
        <ItemTemplate><%# gLnk() %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Part Number" DataField="PN" SortExpression="PN" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="RFQ #" DataField="CustomerRFQ" SortExpression="CustomerRFQ" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Send Due Date" SortExpression="fouDueDate">
        <ItemTemplate><%# gDD("fouDueDate") %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Status" DataField="Status" SortExpression="Status" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate><%# gNote() %></ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No Quote has been scheduled!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  </ContentTemplate>
 </aspx:UpdatePanel>
 
 <br /><br />

 <aspx:UpdatePanel ID="uPnlFoU" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">[2] QUOTES NEED TO BE FOLLOWED UP</td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvFoU" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="QTEID" DataSourceID="odsFoU" PageSize="10">
      <Columns>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Send By" DataField="SendBy" SortExpression="SendBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="SendDate" SortExpression="SendDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Quote #" SortExpression="QTENumber" InsertVisible="false">
        <ItemTemplate><%# gLnk() %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Part Number" DataField="PN" SortExpression="PN" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="RFQ #" DataField="CustomerRFQ" SortExpression="CustomerRFQ" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="FoU Due Date" SortExpression="fouDueDate">
        <ItemTemplate><%# gDD("fouDueDate") %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="FoU Times" DataField="fouCount" SortExpression="fouCount" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Status" DataField="Status" SortExpression="Status" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate><%# gNote() %></ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No Quote has been sent!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  </ContentTemplate>
 </aspx:UpdatePanel>

 <br /><br />

 <aspx:UpdatePanel ID="uPnlFoUPO" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">[3] WAITING FOR PO FROM CUSTOMER</td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvFoUPO" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="QTEID" DataSourceID="odsFoUPO" PageSize="10">
      <Columns>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Send By" DataField="SendBy" SortExpression="SendBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="SendDate" SortExpression="SendDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Quote #" SortExpression="QTENumber" InsertVisible="false">
        <ItemTemplate><%# gLnk() %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Part Number" DataField="PN" SortExpression="PN" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="RFQ #" DataField="CustomerRFQ" SortExpression="CustomerRFQ" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="FoU Due Date" SortExpression="fouDueDate">
        <ItemTemplate><%# gDD("fouDueDate") %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="FoU Times" DataField="fouCount" SortExpression="fouCount" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Status" DataField="Status" SortExpression="Status" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate><%# gNote() %></ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No Quote has been approved!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  </ContentTemplate>
 </aspx:UpdatePanel>

 <br /><br />

 <aspx:UpdatePanel ID="uPnlFoUHis" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">[4] QUOTE HISTORY</td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvFoUHis" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="QTEID" DataSourceID="odsFoUHis" PageSize="10">
      <Columns>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Send By" DataField="SendBy" SortExpression="SendBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="SendDate" SortExpression="SendDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Quote #" SortExpression="QTENumber" InsertVisible="false">
        <ItemTemplate><%# gLnk() %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Part Number" DataField="PN" SortExpression="PN" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="RFQ #" DataField="CustomerRFQ" SortExpression="CustomerRFQ" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="FoU Due Date" SortExpression="fouDueDate">
        <ItemTemplate><%# gDD("fouDueDate") %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="FoU Times" DataField="fouCount" SortExpression="fouCount" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Status" DataField="Status" SortExpression="Status" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate><%# gNote() %></ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No Quote has been gone into history!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  </ContentTemplate>
 </aspx:UpdatePanel>

<asp:ObjectDataSource ID="odsSched" runat="server" TypeName="myBiz.DAL.clsFollowUp" SelectMethod="RFQ_FollowUp">
 <SelectParameters>
  <asp:Parameter Name="St" Type="String" DefaultValue="Open" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsFoU" runat="server" TypeName="myBiz.DAL.clsFollowUp" SelectMethod="RFQ_FollowUp">
 <SelectParameters>
  <asp:Parameter Name="St" Type="String" DefaultValue="Confirming:Follow Up" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsFoUPO" runat="server" TypeName="myBiz.DAL.clsFollowUp" SelectMethod="RFQ_FollowUp">
 <SelectParameters>
  <asp:Parameter Name="St" Type="String" DefaultValue="Waiting PO" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsFoUHis" runat="server" TypeName="myBiz.DAL.clsFollowUp" SelectMethod="RFQ_FollowUp">
 <SelectParameters>
  <asp:Parameter Name="St" Type="String" DefaultValue="History" />
  <asp:Parameter Name="lMode" Type="String" DefaultValue="" />
 </SelectParameters>
</asp:ObjectDataSource>
</asp:Content>
