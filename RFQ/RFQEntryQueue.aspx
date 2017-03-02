<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="RFQEntryQueue.aspx.cs" Inherits="webApp.RFQ.RFQEntryQueue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlReady" runat="server">
  <ContentTemplate>
   <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
    <tr style="background-color:#330099; color:White">
     <td align="center" style="font-weight:bold;">RFQ (FROM CUSTOMER) NEED TO BE ENTERED</td>
    </tr>
    <tr>
     <td>
      <asp:GridView ID="gvReady" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID,CustType" DataSourceID="odsReady" OnRowDataBound="rwBound" OnRowCommand="rwCmd" PageSize="10">
       <Columns>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
         <HeaderTemplate>
          <asp:DropDownList ID="ddlReadyDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
           <asp:ListItem Text="10" Value="10"></asp:ListItem>
           <asp:ListItem Text="20" Value="20"></asp:ListItem>
           <asp:ListItem Text="30" Value="30"></asp:ListItem>
           <asp:ListItem Text="All" Value="5000"></asp:ListItem>
          </asp:DropDownList>
         </HeaderTemplate>
         <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Uploaded By" DataField="ByName" SortExpression="ByName" InsertVisible="false" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="ByDate" SortExpression="ByDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer Name" SortExpression="CompanyName" InsertVisible="false">
         <ItemTemplate><%# Eval("CompanyName") %></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="RFQ Entry Due Date" SortExpression="RFQEntryDueDate">
         <ItemTemplate><%# gDD("RFQEntryDueDate") %></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="FoU Times" DataField="fouCount" SortExpression="fouCount" InsertVisible="false" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Status" DataField="Status" SortExpression="Status" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="RFQ #" SortExpression="RFQ">
        <ItemTemplate>
         <asp:LinkButton ID="lnkRFQ" runat="server" Text='<%# Eval("RFQ") %>' CommandName="viewRFQ" CommandArgument='<%# string.Format("{0}:{1}", Eval("HID") , Eval("CustType")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
         <ItemTemplate><%# gNote() %></ItemTemplate>
        </asp:TemplateField>
       </Columns>
       <EmptyDataTemplate>No RFQ is ready!</EmptyDataTemplate>
      </asp:GridView>
     </td>
    </tr>
   </table>

   <br />
   <asp:Button ID="btnEnter" runat="server" Text="Complete" OnClick="doEntering" CssClass="NavBtn" />
   <hr /><br />

   <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
    <tr style="background-color:#330099; color:White">
     <td align="center" style="font-weight:bold;">RFQ (FROM CUSTOMER) HAD BEEN ENTERED</td>
    </tr>
    <tr>
     <td>
      <asp:GridView ID="gvRFQEntered" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID,CustType" DataSourceID="odsRFQEntered" OnRowDataBound="rwBound" OnRowCommand="rwCmd" PageSize="10">
       <Columns>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
         <HeaderTemplate>
          <asp:DropDownList ID="ddlRFQEnteredDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
           <asp:ListItem Text="10" Value="10"></asp:ListItem>
           <asp:ListItem Text="20" Value="20"></asp:ListItem>
           <asp:ListItem Text="30" Value="30"></asp:ListItem>
           <asp:ListItem Text="All" Value="5000"></asp:ListItem>
          </asp:DropDownList>
         </HeaderTemplate>
         <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Entered By" DataField="ByName" SortExpression="ByName" InsertVisible="false" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="ByDate" SortExpression="ByDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer Name" SortExpression="CompanyName" InsertVisible="false">
         <ItemTemplate><%# Eval("CompanyName") %></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="RFQ Entry Due Date" SortExpression="RFQEntryDueDate">
         <ItemTemplate><%# gDD("RFQEntryDueDate") %></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="FoU Times" DataField="fouCount" SortExpression="fouCount" InsertVisible="false" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Status" DataField="Status" SortExpression="Status" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="RFQ #" SortExpression="RFQ">
        <ItemTemplate>
         <asp:LinkButton ID="lnkRFQ" runat="server" Text='<%# Eval("RFQ") %>' CommandName="viewRFQ" CommandArgument='<%# string.Format("{0}:{1}", Eval("HID") , Eval("CustType")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
         <ItemTemplate><%# gNote() %></ItemTemplate>
        </asp:TemplateField>
       </Columns>
       <EmptyDataTemplate>No RFQ has been entered!</EmptyDataTemplate>
      </asp:GridView>
     </td>
    </tr>
   </table>
   <br />
   <asp:Button ID="btnUndoEnter" runat="server" Text="Undo Complete" OnClick="doEntering" CssClass="NavBtn" />
   <asp:Panel ID="pnlPopup" runat="server" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsReady" runat="server" TypeName="myBiz.DAL.clsCustFU" SelectMethod="Cust_EntryQueue">
  <SelectParameters>
   <asp:Parameter Name="St" Type="String" DefaultValue="RFQ Ready" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
   <asp:Parameter Name="uID" Type="String" DefaultValue="" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsRFQEntered" runat="server" TypeName="myBiz.DAL.clsCustFU" SelectMethod="Cust_EntryQueue">
  <SelectParameters>
   <asp:Parameter Name="St" Type="String" DefaultValue="Entered RFQ" />
   <asp:Parameter Name="lMode" Type="String" DefaultValue="" />
   <asp:Parameter Name="uID" Type="String" DefaultValue="" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>