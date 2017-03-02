<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.OPS10" Codebehind="OPS10.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3><asp:Literal ID="litHeader" runat="server" /></h3>
<asp:LinkButton ID="lnkMOT" runat="server" Text="View M.O.T." OnClick="doView" /><br />

 <asp:FormView ID="fvOPS_SendRecdBy" runat="server" DefaultMode="ReadOnly" DataSourceID="odsOPS_SendRecdBy" OnDataBound="fvBound" DataKeyNames="HID">
  <ItemTemplate>
   <table>
    <tr><td align="right"><b>PO Number:</b></td><td><%# Eval("PONumber") %></td></tr>
    <tr><td align="right"><b>Received By:</b></td><td><asp:Literal ID="litSendRecdBy" runat="server" Text='<%# Eval("SendRecdBy") %>'></asp:Literal></td></tr>
    <tr><td align="right"><b>Date & Time:</b></td><td><asp:Literal ID="litSendRecdDate" runat="server" Text='<%# Eval("SendRecdDate", "{0: MM/dd/yy ddd h:mm tt}") %>'></asp:Literal></td></tr>
    <tr><td align="right"><b>Location:</b></td><td><%# Eval("LocDesc") %></td></tr>
   </table>
   <asp:Button ID="btnReset" runat="server" CommandName="Delete" Text="Reset" CssClass="NavBtn" Visible='<%# xReset() %>' OnClientClick="return confirm('Are you sure you want to reset?');" />
  </ItemTemplate>
  <EditItemTemplate>
   <table>
    <tr>
     <td align="right"><b>PO Number:</b></td>
     <td>
      <asp:TextBox ID="txtPONum" runat="server" Text='<%# Eval("PONumber") %>' Enabled="false" Width="75px" />
      <asp:RequiredFieldValidator ID="rfvPONum" runat="server" Text="PO Number is required!" ControlToValidate="txtPONum" ValidationGroup="vEdit" />
     </td>
    </tr>
    <tr>
     <td align="right"><b>Received By:</b></td>
     <td>
      <asp:DropDownList ID="ddlName" runat="server" DataSourceID="odsName" DataTextField="mwFullName" DataValueField="mwFullName" SelectedValue='<%# Bind("SendRecdBy") %>' Width="200px" />
      <asp:RequiredFieldValidator ID="rfvName" runat="server" Text="Received By is required!" ControlToValidate="ddlName" ValidationGroup="vEdit" />
     </td>
    </tr>
    <tr>
     <td align="right"><b>Date & Time:</b></td>
     <td>
      <telerik:RadDateTimePicker ID="txtDate" runat="server" TimeView-Interval="00:30:00" DateInput-DateFormat="MM/dd/yy h:mm tt" DbSelectedDate='<%# Bind("SendRecdDate") %>' Width="200px" />
      <asp:RequiredFieldValidator ID="rfvDate" runat="server" Text="Date & Time is required!" ControlToValidate="txtDate" ValidationGroup="vEdit" />
     </td>
    </tr>
    <tr>
     <td align="right"><b>Location:</b></td>
     <td>
      <asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID" SelectedValue='<%# Bind("LocID") %>' Width="200px" />
      <asp:RequiredFieldValidator ID="rfvLocation" runat="server" Text="Location is required!" InitialValue="-1" ControlToValidate="ddlLocation" ValidationGroup="vEdit" />
     </td>
    </tr>
   </table>
   <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="fvSave" CssClass="NavBtn" ValidationGroup="vEdit"></asp:Button>
  </EditItemTemplate>
  <EmptyDataTemplate>Nobody has received the PO</EmptyDataTemplate>
 </asp:FormView>

<div id="dvForm" style="display:none">What exactly do you want to print?</div>
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server"></asp:Panel>
<br /><MW:Message ID="iMsg" runat="server" />

<asp:ObjectDataSource ID="odsOPS_SendRecdBy" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_SendRecdBy_S" UpdateMethod="OPS_SendRecdBy_U" DeleteMethod="OPS_SendRecdBy_D" OnInit="odsInit">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="SoR" Type="String" DefaultValue="OPS Received On " />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="SendRecdBy" Type="String" />
  <asp:Parameter Name="SendRecdDate" Type="datetime" />
  <asp:Parameter Name="SoR" Type="String" DefaultValue="OPS Received On " />
  <asp:Parameter Name="LocID" Type="Int32" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </UpdateParameters>
 <DeleteParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="SoR" Type="String" DefaultValue="OPS Received On " />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </DeleteParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsName" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="Select_Employee">
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
 <SelectParameters>
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Received" />
  <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
  <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
 </SelectParameters>
</asp:ObjectDataSource>