<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucLAT04" Codebehind="ucLAT04.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>CHECK OUT TOOLS</h3>
<asp:LinkButton ID="lnkBlank" runat="server" Text="View Blank Setup Sheet" /> |
<asp:LinkButton ID="lnkView" runat="server" Text="View Setup Sheet" OnClick="doView" /><br /><br />

<asp:GridView ID="gvPrepSetupStatus" runat="server" SkinID="GrayHeader" DataSourceID="odsPrepSetupStatus" DataKeyNames="ItemID" AllowSorting="false">
 <Columns>
  <asp:TemplateField>
   <ItemTemplate>
    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
   </ItemTemplate>
   <EditItemTemplate>
    <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
    <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
   </EditItemTemplate>
  </asp:TemplateField>
  <asp:BoundField HeaderText="#" DataField="ItemNumber" ReadOnly="true" SortExpression="ItemNumber" InsertVisible="false" />
  <asp:BoundField HeaderText="Name" DataField="ItemName" ReadOnly="true" SortExpression="ItemName" InsertVisible="false" />
  <asp:TemplateField HeaderText="Req. Status" SortExpression="ReqStatus" InsertVisible="false">
   <ItemTemplate><%# Eval("ReqStatus") %></ItemTemplate>
   <EditItemTemplate>
    <asp:DropDownList ID="ddlReqStatus" runat="server" SelectedValue='<%# Bind("ReqStatus") %>'>
     <asp:ListItem Value="" Text=""></asp:ListItem>
     <asp:ListItem Value="Delivered" Text="Delivered"></asp:ListItem>
     <asp:ListItem Value="Out of Stock" Text="Out of Stock"></asp:ListItem>
    </asp:DropDownList>
   </EditItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Location" SortExpression="LocDesc" InsertVisible="false">
   <ItemTemplate><%# Eval("LocDesc") %></ItemTemplate>
   <EditItemTemplate><asp:DropDownList ID="ddlLocID" OnDataBinding="ddlDataBinding" runat="server" DataSourceID="odsLocByType" DataValueField="HID" DataTextField="lDescription" SelectedValue='<%# Bind("LocID") %>'></asp:DropDownList></EditItemTemplate>
  </asp:TemplateField>
 </Columns>
</asp:GridView>

 <asp:FormView ID="fvTools" runat="server" DataSourceID="odsTools" DefaultMode="ReadOnly" OnDataBound="fvBound">
  <ItemTemplate>
   <b>By:</b> <%# Eval("FullName") %>
   <asp:Button ID="btnReset" runat="server" CommandName="Delete" Text="Reset" CssClass="NavBtn" Visible='<%# xReset() %>' OnClientClick="return confirm('Are you sure you want to reset?');" />
  </ItemTemplate>
  <EditItemTemplate>
   <b>By:</b>
   <asp:DropDownList ID="ddlName" runat="server" DataSourceID="odsName" DataTextField="mwFullName" DataValueField="mwEmployeeID" SelectedValue='<%# Bind("EmployeeID") %>' />
   <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="fvSave" CssClass="NavBtn" ValidationGroup="uName"></asp:Button>
   <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="ddlName" ErrorMessage="Please select name." ValidationGroup="uName"></asp:RequiredFieldValidator>
  </EditItemTemplate>
  <EmptyDataTemplate>Tool has not been started ...</EmptyDataTemplate>
 </asp:FormView>

<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />
<br /><br />
<b>Setup Preparation</b> <asp:Button ID="btnScan" runat="server" OnClientClick="javascript:location.reload(true);" Text="Scan" CssClass="NavBtn" />
<asp:GridView ID="gvPrepSetup" runat="server" SkinID="GrayHeader" DataSourceID="odsPrepSetup" DataKeyNames="ItemID" OnRowDataBound="rwBound" AllowSorting="false" OnRowUpdating="rwUpdating">
 <Columns>
  <asp:TemplateField>
   <ItemTemplate>
    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
   </ItemTemplate>
   <EditItemTemplate>
    <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
    <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
    <asp:HiddenField ID="hfPending" runat="server" Value='<%# Eval("Pending") %>' />
   </EditItemTemplate>
  </asp:TemplateField>
  <asp:BoundField HeaderText="#" DataField="ItemNumber" ReadOnly="true" SortExpression="ItemNumber" InsertVisible="false" />
  <asp:BoundField HeaderText="Name" DataField="ItemName" ReadOnly="true" SortExpression="ItemName" InsertVisible="false" />
  <asp:TemplateField SortExpression="Requested" InsertVisible="false">
   <HeaderTemplate><span title="đã yêu cầu">Requested</span></HeaderTemplate>
   <ItemTemplate><asp:CheckBox ID="chkRequested" runat="server" Checked='<%# Eval("Requested") %>' Enabled="false" /></ItemTemplate>
   <EditItemTemplate><asp:CheckBox ID="chkRequested" runat="server" Checked='<%# Bind("Requested") %>' /></EditItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField SortExpression="Delivered" InsertVisible="false">
   <HeaderTemplate><span title="đã giao">Delivered</span></HeaderTemplate>
   <ItemTemplate><asp:CheckBox ID="chkDelivered" runat="server" Checked='<%# Eval("Delivered") %>' Enabled="false" /></ItemTemplate>
   <EditItemTemplate><asp:CheckBox ID="chkDelivered" runat="server" Checked='<%# Bind("Delivered") %>' Enabled="false" /></EditItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField SortExpression="Received" InsertVisible="false">
   <HeaderTemplate><span title="đã nhận">Received</span></HeaderTemplate>
   <ItemTemplate><asp:CheckBox ID="chkReceived" runat="server" Checked='<%# Eval("Received") %>' Enabled="false" /></ItemTemplate>
   <EditItemTemplate><asp:CheckBox ID="chkReceived" runat="server" Checked='<%# Bind("Received") %>' /></EditItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField SortExpression="Verified" InsertVisible="false">
   <HeaderTemplate><span title="đã kiểm tra">Verified</span></HeaderTemplate>
   <ItemTemplate><asp:CheckBox ID="chkVerified" runat="server" Checked='<%# Eval("Verified") %>' Enabled="false" /></ItemTemplate>
   <EditItemTemplate><asp:CheckBox ID="chkVerified" runat="server" Checked='<%# Bind("Verified") %>' /></EditItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Location" SortExpression="LocDesc" InsertVisible="false">
   <ItemTemplate><%# Eval("LocDesc") %></ItemTemplate>
   <EditItemTemplate><%# Eval("LocDesc") %></EditItemTemplate>
  </asp:TemplateField>
 </Columns>
</asp:GridView>
<MW:Message ID="iMsg" runat="server" />

<iframe name="frmBlank" id="frmBlank" frameborder="0" height="0" width="0"></iframe>
<script language="javascript" type="text/javascript">
 function lFrame(url){
  document.getElementById('frmBlank').src = url;
 }
</script>

<asp:ObjectDataSource ID="odsTools" runat="server" TypeName="myBiz.DAL.clsUpdateCount" SelectMethod="Tools_Select" UpdateMethod="Tools_Save" InsertMethod="Tools_Save" DeleteMethod="Tools_Delete">
 <SelectParameters><asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" /></SelectParameters>
 <UpdateParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="EmployeeID" Type="String" />
 </UpdateParameters>
 <InsertParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="EmployeeID" Type="String" />
 </InsertParameters>
 <DeleteParameters><asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" /></DeleteParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsName" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="Select_Employee">
</asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsPrepSetup" runat="server" TypeName="myBiz.DAL.clsPrepSetup" SelectMethod="GetPrepSetups" UpdateMethod="SavePrepSetup">
  <SelectParameters>
   <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  </SelectParameters>
  <UpdateParameters>
   <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
   <asp:Parameter Name="ItemID" Type="Int32" />
   <asp:Parameter Name="Requested" Type="Boolean" />
   <asp:Parameter Name="Delivered" Type="Boolean" />
   <asp:Parameter Name="Received" Type="Boolean" />
   <asp:Parameter Name="Verified" Type="Boolean" />
  </UpdateParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsLocByType" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="ToolLocByType">
  <SelectParameters>
   <asp:Parameter Name="itemId" Type="String" DefaultValue="0" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsPrepSetupStatus" runat="server" TypeName="myBiz.DAL.clsPrepSetup" SelectMethod="GetPrepSetupsStatus" UpdateMethod="SavePrepSetupStatus">
  <SelectParameters>
   <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
   <asp:Parameter Name="itemNums" Type="String" DefaultValue="2:3:4:5:9" />
  </SelectParameters>
  <UpdateParameters>
   <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
   <asp:Parameter Name="ItemID" Type="Int32" />
   <asp:Parameter Name="ReqStatus" Type="String" />
   <asp:Parameter Name="LocID" Type="Int32" />
  </UpdateParameters>
 </asp:ObjectDataSource>
