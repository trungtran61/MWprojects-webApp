<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MiniMaster.master" AutoEventWireup="true" Inherits="webApp.RFQ.TaskList" Codebehind="TaskList.aspx.cs" %>
<%@ Register Src="~/_Controls/JobHeader_RFQ.ascx" TagName="JobHeader_RFQ" TagPrefix="ucHeader" %>
<%@ Register Src="~/_Controls/JobDescription.ascx" TagName="JobDescription" TagPrefix="ucDescription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" Runat="Server">
<aspx:UpdatePanel ID="uPnlTask" runat="server">
 <ContentTemplate>
 <asp:Label ID="lblHeader" runat="server" Text="RFQ INFORMATION" BackColor="Aqua" CssClass="Finger"></asp:Label>
 <asp:Panel ID="pnlHeader" runat="server"><ucHeader:JobHeader_RFQ ID="ucHeader" runat="server" /></asp:Panel>
 <ajax:CollapsiblePanelExtender ID="cpeHeader" runat="server" TargetControlID="pnlHeader" ExpandControlID="lblHeader" CollapseControlID="lblHeader" Collapsed="false" />
<br />
 <asp:Label ID="lblDesc" runat="server" Text="JOB DESCRIPTION" BackColor="Aquamarine" CssClass="Finger"></asp:Label>
 <asp:Panel ID="pnlDesc" runat="server"><ucDescription:JobDescription ID="ucDescription" runat="server" AppCode="RFQ" /></asp:Panel>
 <ajax:CollapsiblePanelExtender ID="cpeDesc" runat="server" TargetControlID="pnlDesc" ExpandControlID="lblDesc" CollapseControlID="lblDesc" Collapsed="true" />
<br />
<asp:Table ID="Table1" CellPadding="0" CellSpacing="0" runat="server">
 <asp:TableRow>
  <asp:TableCell HorizontalAlign="Left">
   <asp:Label ID="lblTask" runat="server" BackColor="Aquamarine" Text="TASKS"></asp:Label>
   <asp:LinkButton ID="lnkTraveler" runat="server" Text='View Router' OnLoad="lTral" />
   <asp:ImageButton ID="iBtnNote" runat="server" ImageUrl="~/App_Themes/Edit.jpg" ToolTip="Note" OnLoad="lTral" />
  </asp:TableCell>
  <asp:TableCell HorizontalAlign="right"><a href="javascript:location.reload(true);" class="Pointer">Refresh Content</a></asp:TableCell>
 </asp:TableRow>
 <asp:TableRow>
  <asp:TableCell ColumnSpan="2">
   <asp:GridView ID="gvTask" runat="server" DataSourceID="odsTask" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="HID" AllowPaging="False" CellPadding="4" CellSpacing="1" ForeColor="#333333" GridLines="None" OnDataBound="gvBound" OnRowDataBound="rwBound" OnPreRender="gvPreRender">
    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    <Columns>
     <asp:TemplateField>
      <HeaderTemplate>
       <asp:LinkButton ID="lnkSortStepNo" runat="server" CommandName="Sort" CommandArgument="dStepNo" ForeColor="White" Text="Step#" /><br />
       <asp:DropDownList ID="ddlStepNo" runat="server" DataTextField="dStepNo" DataValueField="dStepNo" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged" />
      </HeaderTemplate>
      <ItemTemplate><%# Eval("dStepNo") %></ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField>
      <HeaderTemplate>
       <asp:LinkButton ID="lnkSortTaskey" runat="server" CommandName="Sort" CommandArgument="Taskey" ForeColor="White" Text="ID" /><br />
       <asp:DropDownList ID="ddlTaskey" runat="server" DataTextField="Taskey" DataValueField="Taskey" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged" />
      </HeaderTemplate>
      <ItemTemplate>
      <asp:Label ID="lblTaskey" runat="server" BackColor='<%# gColor("BC") %>' ForeColor='<%# gColor("FC") %>' Text='<%# gLink("Taskey") %>'></asp:Label><br />
      </ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Name" SortExpression="dTaskName">
      <HeaderTemplate>
       <asp:LinkButton ID="lnkSortTaskName" runat="server" CommandName="Sort" CommandArgument="dTaskName" ForeColor="White" Text="Name" /><br />
       <asp:DropDownList ID="ddlTaskName" runat="server" DataTextField="dTaskName" DataValueField="dTaskName" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged" />
      </HeaderTemplate>
      <ItemTemplate>
      <asp:Literal ID="lblName" runat="server" Text='<%# gLink("dTaskName") %>'></asp:Literal><br />
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Due Date" DataField="DueDate" SortExpression="DueDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" />
     <asp:BoundField HeaderText="Completion Date" DataField="CompletionDate" SortExpression="CompletionDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" />
     <asp:BoundField HeaderText="Status" DataField="Status" SortExpression="Status" />
     <asp:TemplateField>
      <ItemTemplate>
       <asp:LinkButton ID="lnkComplete" runat="server" CommandName="markComplete" CommandArgument='<%# Eval("HID") %>' OnCommand="rwCmd" Text="Mark Complete" OnClientClick="return confirm('Are you sure you want to mark this task complete?');"></asp:LinkButton>
       <asp:Literal ID="litComplete" runat="server" Text="N/A"></asp:Literal>
      </ItemTemplate>
     </asp:TemplateField>
    </Columns>
    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="SandyBrown" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#999999" />
    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
   </asp:GridView>
  </asp:TableCell>
 </asp:TableRow>
</asp:Table>
</ContentTemplate>
</aspx:UpdatePanel>

 <asp:ObjectDataSource ID="odsTask" runat="server" TypeName="myBiz.DAL.clsTaskList" SelectMethod="Select_RFQ" UpdateMethod="completeTask">
  <SelectParameters>
   <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" DefaultValue="-1:-1:1" />
   <asp:Parameter Name="StepNo" Type="String" />
   <asp:Parameter Name="Taskey" Type="String" />
   <asp:Parameter Name="TaskName" Type="String" />
  </SelectParameters>
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="AppCode" Type="String" DefaultValue="RFQ" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>