<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucLAT12" Codebehind="ucLAT12.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>1st PIECE BY INSPECTOR</h3>
 <asp:FormView ID="fvInspector" runat="server" DefaultMode="ReadOnly" DataSourceID="odsInspectionReport">
  <ItemTemplate>
   <table>
    <tr><td align="right"><b>Inspector Name:</b></td><td><%# Eval("InsFullName") %></td></tr>
    <tr><td align="right"><b>Buy-Off:</b></td><td><asp:CheckBox ID="chkBuyOff" runat="server" Checked='<%# Eval("InsBuyOff") %>' Enabled="false" /></td></tr>
    <tr><td align="right"><b>Date & Time:</b></td><td><%# Eval("InsDate", "{0: MM/dd/yy ddd h:mm tt}") %></td></tr>
   </table>
  </ItemTemplate>
  <EditItemTemplate>
   <table>
    <tr>
     <td align="right"><b>Inspector Name:</b></td>
     <td><asp:DropDownList ID="ddlName" runat="server" DataSourceID="odsName" DataTextField="mwFullName" DataValueField="mwEmployeeID" SelectedValue='<%# Bind("InsName") %>' /></td>
    </tr>
    <tr>
     <td align="right"><b>Buy-Off:</b></td>
     <td><asp:CheckBox ID="chkBuyOff" runat="server" Checked='<%# Bind("InsBuyOff") %>' /></td>
    </tr>
    <tr>
     <td align="right"><b>Date & Time:</b></td>
     <td>
      <asp:TextBox ID="txtDate" runat="server" Text='<%# Bind("InsDate") %>' />
      <asp:RequiredFieldValidator ID="rfvDate" runat="server" Text="Date & Time is required!" ControlToValidate="txtDate" />
      <ajax:CalendarExtender ID="calDate" runat="server" TargetControlID="txtDate" Format="MM/dd/yy h:mm:ss tt" />
     </td>
    </tr>
   </table>
   <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="fvSave" CssClass="NavBtn"></asp:Button>
  </EditItemTemplate>
  <EmptyDataTemplate>Setup Man Name has not been set ...</EmptyDataTemplate>
 </asp:FormView>

<ucMode:CurrentMode ID="myMode" runat="server" />
<br /><MW:Message ID="iMsg" runat="server" />


<asp:ObjectDataSource ID="odsInspectionReport" runat="server" TypeName="myBiz.DAL.clsInspectionReport" SelectMethod="Select" UpdateMethod="insSave" InsertMethod="insSave">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </SelectParameters>
 <UpdateParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="InsName" Type="String" />
  <asp:Parameter Name="InsBuyOff" Type="Boolean" />
  <asp:Parameter Name="InsDate" Type="datetime" />
 </UpdateParameters>
 <InsertParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="InsName" Type="String" />
  <asp:Parameter Name="InsBuyOff" Type="Boolean" />
  <asp:Parameter Name="InsDate" Type="datetime" />
 </InsertParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsName" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="Select_Employee">
</asp:ObjectDataSource>