<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="LMTasks.aspx.cs" Inherits="webApp.Tools.LMTasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <table style="background-color:#CCCCCC;">
  <tr>
   <td><b>WO#:</b><br /><asp:TextBox ID="txtWO_QTE" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>Step#:</b><br /><asp:TextBox ID="txtStepNo" runat="server" Width="75px"></asp:TextBox></td>
   <td>
    <b>Task ID: Task Name</b><br />
    <asp:DropDownList ID="ddlTaskID" runat="server">
     <asp:ListItem Text="" Value=""></asp:ListItem>
     <asp:ListItem Text="LAT03: Upload SETUP SHEET" Value="LAT03"></asp:ListItem>
     <asp:ListItem Text="LAT04: Check OUT TOOLS" Value="LAT04"></asp:ListItem>
     <asp:ListItem Text="LAT17: Upload PROVEN PROGRAM" Value="LAT17"></asp:ListItem>
     <asp:ListItem Text="MIL03: Upload SETUP SHEET" Value="MIL03"></asp:ListItem>
     <asp:ListItem Text="MIL04: Check OUT TOOLS" Value="MIL04"></asp:ListItem>
     <asp:ListItem Text="MIL17: Upload PROVEN PROGRAM" Value="MIL17"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td>
    <b>Due Date:</b><br />
    <asp:DropDownList ID="ddlMonth" runat="server">
     <asp:ListItem Text="" Value=""></asp:ListItem>
     <asp:ListItem Text="1 Month" Value="1"></asp:ListItem>
     <asp:ListItem Text="2 Months" Value="2"></asp:ListItem>
     <asp:ListItem Text="3 Months" Value="3"></asp:ListItem>
     <asp:ListItem Text="4 Months" Value="4"></asp:ListItem>
     <asp:ListItem Text="5 Months" Value="5"></asp:ListItem>
     <asp:ListItem Text="6 Months" Value="6"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td>
    <b>Status:</b><br />
    <asp:DropDownList ID="ddlStatus" runat="server">
     <asp:ListItem Text="" Value=""></asp:ListItem>
     <asp:ListItem Text="Requested" Value="Requested"></asp:ListItem>
     <asp:ListItem Text="Open" Value="Open"></asp:ListItem>
     <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td valign="bottom"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="NavBtn" OnClick="clickSearch" /></td>
   <td valign="bottom">
    <input type="button" name="mainArea_btnReset" value="Reset" id="mainArea_btnReset" class="NavBtn" onclick="javascript: location.href = 'LMTasks.aspx';" />
   </td>
  </tr>
 </table>
 <aspx:UpdatePanel ID="uPnlTask" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvTask" runat="server" SkinID="Default" DataSourceID="odsTask" DataKeyNames="WO_QTE" AllowSorting="false" OnDataBound="gvBound">
    <Columns>
     <asp:BoundField HeaderText="WO#" DataField="WO_QTE" SortExpression="WO_QTE" InsertVisible="false" />
     <asp:BoundField HeaderText="Step#" DataField="StepNo" SortExpression="StepNo" InsertVisible="false" />
     <asp:TemplateField HeaderText="TaskID: Task Name" SortExpression="TaskName" InsertVisible="false">
      <ItemTemplate><%# gLink() %></ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Due Date" SortExpression="DueDate" InsertVisible="false">
      <ItemTemplate><%# gDD("DueDate") %></ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Completion Date" DataField="CompletionDate" SortExpression="CompletionDate" InsertVisible="false" />
     <asp:BoundField HeaderText="Status" DataField="Status" SortExpression="Status" InsertVisible="false" />
    </Columns>
   </asp:GridView>
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" /></Triggers>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsTask" runat="server" TypeName="myBiz.DAL.clsTask" SelectMethod="GetTasks">
  <SelectParameters>
   <asp:Parameter Name="isSearch" Type="Boolean" DefaultValue="False" />
   <asp:ControlParameter Name="WO_QTE" Type="String" ControlID="txtWO_QTE" PropertyName="Text" />
   <asp:ControlParameter Name="StepNo" Type="Int32" ControlID="txtStepNo" PropertyName="Text" />
   <asp:ControlParameter Name="TaskID" Type="String" ControlID="ddlTaskID" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="Month" Type="Int32" ControlID="ddlMonth" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="Status" Type="String" ControlID="ddlStatus" PropertyName="SelectedValue" />
   <asp:Parameter Name="AppCode" Type="String" DefaultValue="WIP:0" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>
