<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="CustFU.aspx.cs" Inherits="webApp.RFQ.CustFU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlFoU" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">[1] CURRENT CUSTOMERS NEED TO BE FOLLOWED UP</td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvFoU" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsFoU" PageSize="10">
      <Columns>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Entered By" DataField="ByName" SortExpression="ByName" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="ByDate" SortExpression="ByDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer Name" SortExpression="CompanyName" InsertVisible="false">
        <ItemTemplate><%# gLnk() %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="FoU Due Date" SortExpression="fouDueDate">
        <ItemTemplate><%# gDD("fouDueDate") %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="FoU Times" DataField="fouCount" SortExpression="fouCount" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Status" DataField="Status" SortExpression="Status" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate><%# gNote() %></ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No Customer has been entered!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  </ContentTemplate>
 </aspx:UpdatePanel>

 <br /><br />

 <aspx:UpdatePanel ID="uPnlFoURFQ" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">[2] WAITING FOR RFQ/PO FROM CURRENT CUSTOMERS</td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvFoURFQ" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsFoURFQ" PageSize="10">
      <Columns>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Followed Up By" DataField="ByName" SortExpression="ByName" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="ByDate" SortExpression="ByDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer Name" SortExpression="CompanyName" InsertVisible="false">
        <ItemTemplate><%# gLnk() %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="FoU Due Date" SortExpression="fouDueDate">
        <ItemTemplate><%# gDD("fouDueDate") %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="FoU Times" DataField="fouCount" SortExpression="fouCount" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Status" DataField="Status" SortExpression="Status" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate><%# gNote() %></ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No RFQ has been approved!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  </ContentTemplate>
 </aspx:UpdatePanel>

 <br /><br />

 <aspx:UpdatePanel ID="uPnlFoURecd" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">[3] RECEIVED RFQ/PO FROM CURRENT CUSTOMERS</td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvFoURecd" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsFoURecd" OnRowCommand="rwCmd" PageSize="10">
      <Columns>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
        <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" Visible='<%# Eval("Status").ToString().EndsWith("Uploaded") %>' /></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Received By" DataField="ByName" SortExpression="ByName" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="ByDate" SortExpression="ByDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer Name" SortExpression="CompanyName" InsertVisible="false">
        <ItemTemplate><%# gLnk() %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="RFQ/PO Upload Due Date" SortExpression="fouDueDate">
        <ItemTemplate><%# gDD("fouDueDate") %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="FoU Times" DataField="fouCount" SortExpression="fouCount" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Status" DataField="Status" SortExpression="Status" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="RFQ/PO #" SortExpression="RFQ">
        <ItemTemplate>
         <asp:LinkButton ID="lnkEdit" runat="server" Text="&diams;" CommandName="pEdit" />
         <asp:LinkButton ID="lnkRFQ" runat="server" Text='<%# Eval("RFQ") %>' CommandName="uploadRFQ" CommandArgument='<%# Eval("HID") %>'></asp:LinkButton>
         <asp:LinkButton ID="lnkView" runat="server" Text="&hearts;" CommandName="viewRFQ" CommandArgument='<%# Eval("HID") %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate><%# gNote() %></ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No RFQ/PO has been received!</EmptyDataTemplate>
     </asp:GridView>
     <asp:LinkButton ID="lnkRefresh" runat="server" OnClick="doRefresh"></asp:LinkButton>
     <table id="tblRFQ" runat="server" class="mdlPopup">
      <tr class="GrayBar">
       <td align="right"><b>RFQ/PO#:</b></td>
       <td><asp:TextBox ID="txtRFQ" runat="server" Width="100px" /></td>
       <td><asp:Button ID="btnSaveRFQ" runat="server" Text="Save" CssClass="NavBtn" OnClick="saveRFQ" /></td>
       <td>
        <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="NavBtn" />
        <asp:HiddenField ID="hfHID" runat="server" />
       </td>
      </tr>
     </table>
     <ajax:ModalPopupExtender ID="mpeRFQ" runat="server" TargetControlID="txtRFQ" PopupControlID="tblRFQ" BackgroundCssClass="mdlBackground"
      OkControlID="btnClose" DropShadow="false" RepositionMode="RepositionOnWindowResize" />
    </td>
   </tr>
  </table>
  <br />
  <asp:Button ID="btnReady" runat="server" Text="Ready" OnClick="doReady" CssClass="NavBtn" />
  <hr />
   <asp:Panel ID="pnlPopup" runat="server" />
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="btnUndoReady" EventName="Click" /></Triggers>
 </aspx:UpdatePanel>

 <br /><br />

 <aspx:UpdatePanel ID="uPnlReady" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">[4] UPLOADED RFQ/PO (FROM CUSTOMER) NEED TO BE BEEN ENTERED</td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvReady" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsReady" OnRowCommand="rwCmd" PageSize="10">
      <Columns>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
        <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Uploaded By" DataField="ByName" SortExpression="ByName" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="ByDate" SortExpression="ByDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer Name" SortExpression="CompanyName" InsertVisible="false">
         <ItemTemplate><%# Eval("CompanyName") %></ItemTemplate>
        </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="RFQ/PO Entry Due Date" SortExpression="RFQEntryDueDate">
        <ItemTemplate><%# gDD("RFQEntryDueDate") %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="FoU Times" DataField="fouCount" SortExpression="fouCount" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Status" DataField="Status" SortExpression="Status" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="RFQ/PO #" SortExpression="RFQ">
        <ItemTemplate>
         <asp:LinkButton ID="lnkRFQ" runat="server" Text='<%# Eval("RFQ") %>' CommandName="viewRFQReady" CommandArgument='<%# Eval("HID") %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate><%# gNote() %></ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No RFQ/PO is ready!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  <br />
  <asp:Button ID="btnUndoReady" runat="server" Text="Undo Ready" OnClick="doReady" CssClass="NavBtn" />
   <asp:Panel ID="pnlUpload" runat="server" />
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="btnReady" EventName="Click" /></Triggers>
 </aspx:UpdatePanel>

 <asp:HiddenField ID="hfUID" runat="server" />
<asp:ObjectDataSource ID="odsFoU" runat="server" TypeName="myBiz.DAL.clsCustFU" SelectMethod="Cust_FollowUp">
 <SelectParameters>
  <asp:Parameter Name="St" Type="String" DefaultValue="Follow Up" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
  <asp:ControlParameter Name="uID" Type="String" ControlID="hfUID" PropertyName="Value" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsFoURFQ" runat="server" TypeName="myBiz.DAL.clsCustFU" SelectMethod="Cust_FollowUp">
 <SelectParameters>
  <asp:Parameter Name="St" Type="String" DefaultValue="Waiting RFQ:Waiting PO" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
  <asp:Parameter Name="uID" Type="String" DefaultValue="" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsFoURecd" runat="server" TypeName="myBiz.DAL.clsCustFU" SelectMethod="Cust_FollowUp">
 <SelectParameters>
  <asp:Parameter Name="St" Type="String" DefaultValue="Received RFQ:Received PO:RFQ Uploaded:PO Uploaded" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
  <asp:Parameter Name="uID" Type="String" DefaultValue="" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsReady" runat="server" TypeName="myBiz.DAL.clsCustFU" SelectMethod="Cust_FollowUp">
 <SelectParameters>
  <asp:Parameter Name="St" Type="String" DefaultValue="RFQ Ready:PO Ready" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
  <asp:Parameter Name="uID" Type="String" DefaultValue="" />
 </SelectParameters>
</asp:ObjectDataSource>
</asp:Content>