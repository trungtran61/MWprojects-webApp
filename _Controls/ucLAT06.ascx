<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucLAT06" Codebehind="ucLAT06.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>1st PIECE BY SETUP MAN</h3>
 <asp:FormView ID="fvSetupMan" runat="server" DefaultMode="ReadOnly" DataSourceID="odsInspectionReport" OnDataBound="fvBound">
  <ItemTemplate>
   <table>
    <tr><td align="right"><b>SetupMan Name:</b></td><td><%# Eval("SetFullName") %></td></tr>
    <tr><td align="right"><b>Buy-Off:</b></td><td><asp:CheckBox ID="chkBuyOff" runat="server" Checked='<%# Eval("SetBuyOff") %>' Enabled="false" /></td></tr>
    <tr><td align="right"><b>Date & Time:</b></td><td><%# Eval("SetDate", "{0: MM/dd/yy ddd h:mm tt}") %></td></tr>
   </table>
   <asp:Button ID="btnReset" runat="server" CommandName="Delete" Text="Reset" CssClass="NavBtn" Visible='<%# xReset() %>' OnClientClick="return confirm('Are you sure you want to reset?');" />
  </ItemTemplate>
  <EditItemTemplate>
   <table>
    <tr>
     <td align="right"><b>SetupMan Name:</b></td>
     <td>
      <asp:DropDownList ID="ddlName" runat="server" DataSourceID="odsName" DataTextField="mwFullName" DataValueField="mwEmployeeID" SelectedValue='<%# Bind("SetName") %>' />
      <asp:RequiredFieldValidator ID="rfvName" runat="server" Text="Setup man name is required!" ControlToValidate="ddlName"></asp:RequiredFieldValidator>
     </td>
    </tr>
    <tr>
     <td align="right"><b>Buy-Off:</b></td>
     <td><asp:CheckBox ID="chkBuyOff" runat="server" Checked='<%# Bind("SetBuyOff") %>' /></td>
    </tr>
    <tr>
     <td align="right"><b>Date & Time:</b></td>
     <td>
      <telerik:RadDateTimePicker ID="txtDate" runat="server" TimeView-Interval="00:30:00" DateInput-DateFormat="MM/dd/yy h:mm tt" DbSelectedDate='<%# Bind("SetDate") %>' />
      <asp:RequiredFieldValidator ID="rfvDate" runat="server" Text="Date & Time is required!" ControlToValidate="txtDate" />
     </td>
    </tr>
   </table>
   <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="fvSave" CssClass="NavBtn"></asp:Button>
  </EditItemTemplate>
  <EmptyDataTemplate>Setup Man Name has not been set ...</EmptyDataTemplate>
 </asp:FormView>

<div id="dvForm" style="display:none">What exactly do you want to print?</div>
<ucMode:CurrentMode ID="myMode" runat="server" />
<br /><MW:Message ID="iMsg" runat="server" />

<asp:ObjectDataSource ID="odsInspectionReport" runat="server" TypeName="myBiz.DAL.clsInspectionReport" SelectMethod="Select" UpdateMethod="setSave" InsertMethod="setSave" DeleteMethod="setReset">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </SelectParameters>
 <UpdateParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="SetName" Type="String" />
  <asp:Parameter Name="SetBuyOff" Type="Boolean" />
  <asp:Parameter Name="SetDate" Type="datetime" />
 </UpdateParameters>
 <InsertParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="SetName" Type="String" />
  <asp:Parameter Name="SetBuyOff" Type="Boolean" />
  <asp:Parameter Name="SetDate" Type="datetime" />
 </InsertParameters>
 <DeleteParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </DeleteParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsName" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="Select_Employee">
</asp:ObjectDataSource>