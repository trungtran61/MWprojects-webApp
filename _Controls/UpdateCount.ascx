<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.UpdateCount" Codebehind="UpdateCount.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Update Count</h3>
 <asp:FormView ID="fvUpdateCount" runat="server" DataSourceID="odsUpdateCount" OnDataBound="fvBound">
  <ItemTemplate>
   <table>
    <tr><td align="right"><b>Good Count:</b></td><td><%# Eval("GoodCnt") %> <%# Eval("Unit") %></td></tr>
    <tr><td align="right"><b>Reworkable Count:</b></td><td><%# Eval("ReworkableCnt") %> <%# Eval("Unit") %></td></tr>
    <tr><td align="right"><b>Scrap Count:</b></td><td><%# Eval("ScrapCnt") %> <%# Eval("Unit") %></td></tr>
    <tr><td align="right"><b>Total Count:</b></td><td><asp:Literal ID="litTotalCnt" runat="server" Text='<%# Eval("TotalCnt") %>' /> <%# Eval("Unit") %></td></tr>
    <tr><td align="right"><b>Location:</b></td><td><%# Eval("LocDesc") %></td></tr>
    <tr><td align="right"><b>Date & Time:</b></td><td><%# Eval("EndDate", "{0: MM/dd/yy @ h:mm tt}") %></td></tr>
    <tr><td align="right"><b>By:</b></td><td><%# Eval("FullName") %></td></tr>
   </table>
   <asp:Button ID="btnReset" runat="server" CommandName="Delete" Text="Reset" CssClass="NavBtn" Visible='<%# !myMode.isOR && !myMode.pTask && isYN("t06") %>' OnClientClick="return confirm('Are you sure you want to reset?');" />
   <asp:Button ID="btnOverride" runat="server" Text="Edit" CssClass="NavBtn" Visible='<%# myMode.isOR %>' OnClientClick="return false;" />
   <asp:Panel ID="pnlOverride" runat="server" Visible='<%# myMode.isOR %>'>
    <b>UN</b>: <asp:TextBox ID="txtUN" runat="server" Width="75px"></asp:TextBox><br />
    <b>PW</b>: <asp:TextBox ID="txtPW" runat="server" Width="75px" TextMode="Password"></asp:TextBox><br />
    <asp:Button ID="btnCheckOverride" runat="server" Text="Override" OnClick="chkOverride" CssClass="NavBtn" />
    <asp:Button ID="btnCancelOverride" runat="server" Text="Cancel" CssClass="NavBtn" OnClientClick="return false;" />
   </asp:Panel>
   <ajax:CollapsiblePanelExtender ID="cpeOverride" runat="server" Enabled='<%# myMode.isOR %>' TargetControlID="pnlOverride" ExpandControlID="btnOverride" CollapseControlID="btnCancelOverride" Collapsed="true" />
  </ItemTemplate>
  <EditItemTemplate>
   <table>
    <tr>
     <td align="right"><b>Unit:</b></td>
     <td>
      <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="odsUnit" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("Unit") %>' />
      <asp:RequiredFieldValidator ID="rfvUnit" runat="server" ControlToValidate="ddlUnit" ErrorMessage="Please select unit."></asp:RequiredFieldValidator>
     </td>
    </tr>
    <tr>
     <td align="right"><b>Good Count:</b></td>
     <td>
      <asp:TextBox ID="txtGoodCnt" runat="server" Width="50px" Text='<%# Bind("GoodCnt") %>' />
      <asp:RegularExpressionValidator ID="revGoodCnt" runat="server" ErrorMessage="Invalid Good Count [integer only]" ControlToValidate="txtGoodCnt" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
     </td>
    </tr>
    <tr>
     <td align="right"><b>Reworkable Count:</b></td>
     <td>
      <asp:TextBox ID="txtReworkableCnt" runat="server" Width="50px" Text='<%# Bind("ReworkableCnt") %>' />
      <asp:RegularExpressionValidator ID="revReworkableCnt" runat="server" ErrorMessage="Invalid Reworkable Count [integer only]" ControlToValidate="txtReworkableCnt" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
     </td>
    </tr>
    <tr>
     <td align="right"><b>Scrap Count:</b></td>
     <td>
      <asp:TextBox ID="txtScrapCnt" runat="server" Width="50px" Text='<%# Bind("ScrapCnt") %>' />
      <asp:RegularExpressionValidator ID="revScrapCnt" runat="server" ErrorMessage="Invalid Scrap Count [integer only]" ControlToValidate="txtScrapCnt" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
     </td>
    </tr>
    <tr>
     <td align="right"><b>Total Count:</b></td>
     <td>
      <asp:TextBox ID="txtTotalCnt" runat="server" Width="50px" Enabled="false" Text='<%# Bind("TotalCnt") %>' />
      <asp:RegularExpressionValidator ID="revTotalCnt" runat="server" ErrorMessage="Invalid Total Count [integer only]" ControlToValidate="txtTotalCnt" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
     </td>
    </tr>
    <tr>
     <td align="right"><b>Location:</b></td>
     <td>
      <asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID" SelectedValue='<%# Bind("LocID") %>'></asp:DropDownList>
      <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddlLocation" ErrorMessage="Please select location." InitialValue="-1"></asp:RequiredFieldValidator>
      <asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
       <SelectParameters>
        <asp:Parameter Name="Dept" Type="String" DefaultValue="MFG" />
        <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
        <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
       </SelectParameters>
      </asp:ObjectDataSource>
     </td>
    </tr>
    <tr>
     <td align="right"><b>Date & Time:</b></td>
     <td>
      <telerik:RadDateTimePicker ID="txtEndDate" runat="server" TimeView-Interval="00:30:00" DateInput-DateFormat="MM/dd/yy h:mm tt" DbSelectedDate='<%# Bind("EndDate") %>' />
      <asp:RequiredFieldValidator ID="rfvDate" runat="server" Text="Date & Time is required!" ControlToValidate="txtEndDate" />
     </td>
    </tr>
    <tr>
     <td align="right"><b>By:</b></td>
     <td>
      <asp:DropDownList ID="ddlName" runat="server" DataSourceID="odsName" DataTextField="mwFullName" DataValueField="mwEmployeeID" SelectedValue='<%# Bind("EmployeeID") %>' />
      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlName" ErrorMessage="Please select name."></asp:RequiredFieldValidator>
     </td>
    </tr>
   </table>
   <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="fvSave" CssClass="NavBtn"></asp:Button>
  </EditItemTemplate>
  <EmptyDataTemplate>Update count has not been started ...</EmptyDataTemplate>
 </asp:FormView>
 
<MW:Message ID="iMsg" runat="server" /><br />
<ucMode:CurrentMode ID="myMode" runat="server" />

<asp:ObjectDataSource ID="odsUpdateCount" runat="server" TypeName="myBiz.DAL.clsUpdateCount" SelectMethod="Select" UpdateMethod="Save" InsertMethod="Save" DeleteMethod="Delete">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Completed" />
 </SelectParameters>
 <UpdateParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="GoodCnt" Type="Int32" />
  <asp:Parameter Name="ReworkableCnt" Type="Int32" />
  <asp:Parameter Name="ScrapCnt" Type="Int32" />
  <asp:Parameter Name="TotalCnt" Type="Int32" />
  <asp:Parameter Name="Unit" Type="String" />
  <asp:Parameter Name="EmployeeID" Type="String" />
  <asp:Parameter Name="LocID" Type="Int32" />
  <asp:Parameter Name="EndDate" Type="DateTime" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Completed" />
 </UpdateParameters>
 <InsertParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="GoodCnt" Type="Int32" />
  <asp:Parameter Name="ReworkableCnt" Type="Int32" />
  <asp:Parameter Name="ScrapCnt" Type="Int32" />
  <asp:Parameter Name="TotalCnt" Type="Int32" />
  <asp:Parameter Name="Unit" Type="String" />
  <asp:Parameter Name="EmployeeID" Type="String" />
  <asp:Parameter Name="LocID" Type="Int32" />
  <asp:Parameter Name="EndDate" Type="DateTime" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Completed" />
 </InsertParameters>
 <DeleteParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Completed" />
 </DeleteParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsUnit" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
 <SelectParameters>
  <asp:Parameter Name="Cate" Type="String" DefaultValue="Unit" />
  <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
 </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsName" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="Select_Employee">
</asp:ObjectDataSource>