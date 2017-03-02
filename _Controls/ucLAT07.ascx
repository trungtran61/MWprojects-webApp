<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucLAT07" Codebehind="ucLAT07.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Actual Cycle Time</h3>
 <asp:FormView ID="fvCycle" runat="server" DefaultMode="ReadOnly" DataSourceID="odsInspectionReport" OnDataBound="fvBound">
  <ItemTemplate>
   <table>
    <tr><td align="right"><b>Actual Qty:</b></td><td><%# Eval("OpQty") %></td></tr>
    <tr><td align="right"><b>Actual Cycle Time:</b></td><td><asp:Literal ID="litOpCycle" runat="server" Text='<%# Eval("OpCycle") %>' /> <%# Eval("OpUnit") %></td></tr>
    <tr><td align="right"><b>Operator Name:</b></td><td><%# Eval("OpFullName") %></td></tr>
    <tr><td align="right"><b>Date & Time:</b></td><td><%# Eval("OpDate", "{0: MM/dd/yy ddd h:mm tt}") %></td></tr>
   </table>
   <asp:Button ID="btnReset" runat="server" CommandName="Delete" Text="Reset" CssClass="NavBtn" Visible='<%# xReset() %>' OnClientClick="return confirm('Are you sure you want to reset?');" />
  </ItemTemplate>
  <EditItemTemplate>
   <table>
    <tr>
     <td align="right"><b>Actual Qty:</b></td>
     <td>
      <asp:TextBox ID="txtOpQty" runat="server" Text='<%# Bind("OpQty") %>' Width="75px" />
      <asp:RegularExpressionValidator ID="revOpQty" runat="server" Text="Actual Qty [number only]" ControlToValidate="txtOpQty" ValidationExpression="^[1-9][0-9]*$"></asp:RegularExpressionValidator>
      <asp:RequiredFieldValidator ID="rfvOpQty" runat="server" Text="Actual Qty is required!" ControlToValidate="txtOpQty"></asp:RequiredFieldValidator>
     </td>
    </tr>
    <tr>
     <td align="right"><b>Actual Cycle Time:</b></td>
     <td>
      <asp:TextBox ID="txtCycle" runat="server" Text='<%# Bind("OpCycle") %>' Width="75px" />
      <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="odsUnit" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("OpUnit") %>' />
      <asp:RequiredFieldValidator ID="rfvUnit" runat="server" Text="Unit is required!" ControlToValidate="ddlUnit"></asp:RequiredFieldValidator>
      <asp:RegularExpressionValidator ID="revCycle" runat="server" Text="Invalid Cycle Time [number only]" ControlToValidate="txtCycle" ValidationExpression="^(?=.*[1-9])\d*(?:\.\d{1,2})?$"></asp:RegularExpressionValidator>
      <asp:RequiredFieldValidator ID="rfvCycle" runat="server" Text="Cycle Time is required!" ControlToValidate="txtCycle"></asp:RequiredFieldValidator>
     </td>
    </tr>
    <tr>
     <td align="right"><b>Operator Name:</b></td>
     <td>
      <asp:DropDownList ID="ddlName" runat="server" DataSourceID="odsName" DataTextField="mwFullName" DataValueField="mwEmployeeID" SelectedValue='<%# Bind("OpName") %>' />
      <asp:RequiredFieldValidator ID="rfvName" runat="server" Text="Operator name is required!" ControlToValidate="ddlName"></asp:RequiredFieldValidator>
     </td>
    </tr>
    <tr>
     <td align="right"><b>Date & Time:</b></td>
     <td>
      <telerik:RadDateTimePicker ID="txtDate" runat="server" TimeView-Interval="00:30:00" DateInput-DateFormat="MM/dd/yy h:mm tt" DbSelectedDate='<%# Bind("OpDate") %>' />
      <asp:RequiredFieldValidator ID="rfvDate" runat="server" Text="Date & Time is required!" ControlToValidate="txtDate" />
     </td>
    </tr>
   </table>
   <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="fvSave" CssClass="NavBtn"></asp:Button>
  </EditItemTemplate>
  <EmptyDataTemplate>Actual Cycle Time has not been set ...</EmptyDataTemplate>
 </asp:FormView>
 
<div id="dvForm" style="display:none">What exactly do you want to print?</div>
<ucMode:CurrentMode ID="myMode" runat="server" />
<br /><MW:Message ID="iMsg" runat="server" />

<asp:ObjectDataSource ID="odsInspectionReport" runat="server" TypeName="myBiz.DAL.clsInspectionReport" SelectMethod="Select" UpdateMethod="opSave" InsertMethod="opSave" DeleteMethod="opReset">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </SelectParameters>
 <UpdateParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="OpCycle" Type="Decimal" />
  <asp:Parameter Name="OpName" Type="String" />
  <asp:Parameter Name="OpDate" Type="datetime" />
  <asp:Parameter Name="OpUnit" Type="String" />
  <asp:Parameter Name="OpQty" Type="Int32" />
 </UpdateParameters>
 <InsertParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="OpCycle" Type="Decimal" />
  <asp:Parameter Name="OpName" Type="String" />
  <asp:Parameter Name="OpDate" Type="datetime" />
  <asp:Parameter Name="OpUnit" Type="String" />
  <asp:Parameter Name="OpQty" Type="Int32" />
 </InsertParameters>
 <DeleteParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </DeleteParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsUnit" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
 <SelectParameters>
  <asp:Parameter Name="Cate" Type="String" DefaultValue="ACTUnit" />
  <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
 </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsName" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="Select_Employee">
</asp:ObjectDataSource>
