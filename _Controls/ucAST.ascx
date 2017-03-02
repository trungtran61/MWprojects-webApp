<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucAST" Codebehind="ucAST.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<script language="javascript" type="text/javascript">
 function ddlCheck(ddl){
  var val = ddl.options[ddl.selectedIndex].value;
  if (val.indexOf(':N') > -1) ddl.selectedIndex = 0;
 }
</script>

<h3>Actual Setup Time</h3>
 <asp:FormView ID="fvAst" runat="server" DefaultMode="ReadOnly" DataSourceID="odsInspectionReport" OnDataBound="fvBound" OnItemInserting="fvInserting" OnItemUpdating="fvUpdating">
  <ItemTemplate>
   <table>
    <tr><td align="right"><b>Machine:</b></td><td><%# Eval("MPID") %>: <%# Eval("MPName") %></td></tr>
    <tr><td align="right"><b>Start Date & Time:</b></td><td><asp:Literal ID="litAstDate" runat="server" Text='<%# Eval("AstDate", "{0: MM/dd/yy ddd h:mm tt}") %>' /></td></tr>
    <tr><td align="right"><b>By:</b></td><td><%# Eval("AstFullName") %></td></tr>
   </table>
   <asp:Button ID="btnReset" runat="server" CommandName="Delete" Text="Reset" CssClass="NavBtn" Visible='<%# xReset() %>' OnClientClick="return confirm('Are you sure you want to reset?');" />
  </ItemTemplate>
  <EditItemTemplate>
   <table>
    <tr>
     <td align="right"><b>Machine:</b></td>
     <td>
      <asp:DropDownList ID="ddlMPID" runat="server" DataSourceID="odsMPID" DataTextField="mText" DataValueField="MPID" onchange="javascript:ddlCheck(this);" OnPreRender="ddlPreRender" />
      <asp:RequiredFieldValidator ID="rfvMPID" runat="server" Text="Machine is required!" ControlToValidate="ddlMPID"></asp:RequiredFieldValidator>
      <asp:HiddenField ID="hfStepID" runat="server" Value='<%# Eval("StepID") %>' />
      <asp:HiddenField ID="hfSMPID" runat="server" Value='<%# Eval("SMPID") %>' />
      <asp:HiddenField ID="hfoldSMPID" runat="server" Value='<%# Eval("oldSMPID") %>' />
      <asp:ObjectDataSource ID="odsMPID" runat="server" TypeName="myBiz.DAL.clsMachine" SelectMethod="MachineList">
       <SelectParameters>
        <asp:ControlParameter Name="StepID" Type="Int32" ControlID="hfStepID" PropertyName="Value" />
       </SelectParameters>
      </asp:ObjectDataSource>
     </td>
    </tr>
    <tr>
     <td align="right"><b>Start Date & Time:</b></td>
     <td>
      <telerik:RadDateTimePicker ID="txtDate" runat="server" TimeView-Interval="00:30:00" DateInput-DateFormat="MM/dd/yy h:mm tt" DbSelectedDate='<%# Bind("AstDate") %>' />
      <asp:RequiredFieldValidator ID="rfvDate" runat="server" Text="Start Date & Time is required!" ControlToValidate="txtDate" />
     </td>
    </tr>
    <tr>
     <td align="right"><b>By:</b></td>
     <td>
      <asp:DropDownList ID="ddlName" runat="server" DataSourceID="odsName" DataTextField="mwFullName" DataValueField="mwEmployeeID" SelectedValue='<%# Bind("AstBy") %>' />
      <asp:RequiredFieldValidator ID="rfvName" runat="server" Text="Name is required!" ControlToValidate="ddlName"></asp:RequiredFieldValidator>
     </td>
    </tr>
   </table>
   <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="fvSave" CssClass="NavBtn"></asp:Button>
  </EditItemTemplate>
  <EmptyDataTemplate>Actual Setup Time has not been set ...</EmptyDataTemplate>
 </asp:FormView>

<MW:Message ID="iMsg" runat="server" /><br />
<ucMode:CurrentMode ID="myMode" runat="server" />

<asp:ObjectDataSource ID="odsInspectionReport" runat="server" TypeName="myBiz.DAL.clsInspectionReport" SelectMethod="astSelect" UpdateMethod="astSave" InsertMethod="astSave" DeleteMethod="astReset">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </SelectParameters>
 <UpdateParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="SMPID" Type="String" />
  <asp:Parameter Name="AstDate" Type="DateTime" />
  <asp:Parameter Name="AstBy" Type="String" />
 </UpdateParameters>
 <InsertParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="SMPID" Type="String" />
  <asp:Parameter Name="AstDate" Type="DateTime" />
  <asp:Parameter Name="AstBy" Type="String" />
 </InsertParameters>
 <DeleteParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </DeleteParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsName" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="Select_Employee">
</asp:ObjectDataSource>
