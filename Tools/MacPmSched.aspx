<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="MacPmSched.aspx.cs" Inherits="webApp.Tools.MacPmSched" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <table style="background-color:#CCCCCC;">
  <tr>
   <td><b>Machine ID:</b><br /><asp:TextBox ID="txtMachineID" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>Task ID:</b><br /><asp:TextBox ID="txtTaskID" runat="server" Width="75px"></asp:TextBox></td>
   <td>
    <b>Status</b><br />
    <asp:DropDownList ID="ddlStatus" runat="server">
     <asp:ListItem Text="" Value=""></asp:ListItem>
     <asp:ListItem Text="Up" Value="Up"></asp:ListItem>
     <asp:ListItem Text="Available" Value="Available"></asp:ListItem>
     <asp:ListItem Text="Down" Value="Down"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td>
    <b>Date Range:</b><br />
    <asp:DropDownList ID="ddlMonth" runat="server">
     <asp:ListItem Text="" Value="0"></asp:ListItem>
     <asp:ListItem Text="1 Month" Value="1"></asp:ListItem>
     <asp:ListItem Text="2 Months" Value="2"></asp:ListItem>
     <asp:ListItem Text="3 Months" Value="3"></asp:ListItem>
     <asp:ListItem Text="4 Months" Value="4"></asp:ListItem>
     <asp:ListItem Text="5 Months" Value="5"></asp:ListItem>
     <asp:ListItem Text="6 Months" Value="6"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td valign="bottom"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="NavBtn" OnClick="clickSearch" /></td>
   <td valign="bottom">
    <input type="button" name="mainArea_btnReset" value="Reset" id="mainArea_btnReset" class="NavBtn" onclick="javascript: location.href = 'MacPmSched.aspx';" />
   </td>
  </tr>
 </table>
 <br />
 <aspx:UpdatePanel ID="uPnlPmSched" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvPmSched" runat="server" SkinID="Default" DataSourceID="odsPmSched" DataKeyNames="HID" AllowSorting="false" OnDataBound="gvBound">
    <Columns>
     <asp:BoundField HeaderText="Machine ID" DataField="MachineID" SortExpression="MachineID" InsertVisible="false" />
     <asp:BoundField HeaderText="Task ID" DataField="TaskID" SortExpression="TaskID" InsertVisible="false" />
     <asp:BoundField HeaderText="Task Name" DataField="TaskName" SortExpression="TaskName" InsertVisible="false" />
     <asp:BoundField HeaderText="Last PM Date" DataField="LastPMDate" SortExpression="LastPMDate" InsertVisible="false" />
     <asp:BoundField HeaderText="By" DataField="PMBy" SortExpression="PMBy" InsertVisible="false" />
     <asp:BoundField HeaderText="Status" DataField="curStatus" SortExpression="curStatus" InsertVisible="false" />
     <asp:BoundField HeaderText="Next PM Date" DataField="NextPMDate" SortExpression="NextPMDate" InsertVisible="false" />
    </Columns>
   </asp:GridView>
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" /></Triggers>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsPmSched" runat="server" TypeName="myBiz.DAL.clsPreventiveMaintenance" SelectMethod="Machine_PMSchedule_S">
  <SelectParameters>
   <asp:Parameter Name="isSearch" Type="Boolean" DefaultValue="False" />
   <asp:ControlParameter Name="MachineID" Type="String" ControlID="txtMachineID" PropertyName="Text" />
   <asp:ControlParameter Name="TaskID" Type="String" ControlID="txtTaskID" PropertyName="Text" />
   <asp:ControlParameter Name="Status" Type="String" ControlID="ddlStatus" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="Month" Type="Int32" ControlID="ddlMonth" PropertyName="SelectedValue" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>