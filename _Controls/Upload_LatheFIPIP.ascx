<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload_LatheFIPIP" Codebehind="Upload_LatheFIPIP.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Upload 1st Piece & In-Process Inspection Report For Lathe</h3>
You will be able to upload, edit, view, and print 1st Piece & In-Process Inspection Report for Lathe documents from here.<br /><br />
Please click on one of the buttons below to continue ...
<br /><br />
<asp:LinkButton ID="lnkMOT" runat="server" Text="View M.O.T." OnClick="viewMOT" /> |
<asp:LinkButton ID="lnkBlank" runat="server" Text="View Blank 1st Piece & In-Process Inspection Report" />
<br />

<ucMode:CurrentMode ID="myMode" runat="server" />
<br /><br />
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
   <EditItemTemplate><asp:DropDownList ID="ddlLocID" runat="server" DataSourceID="odsLocByType" DataValueField="HID" DataTextField="lDescription" SelectedValue='<%# Bind("LocID") %>'></asp:DropDownList></EditItemTemplate>
  </asp:TemplateField>
 </Columns>
</asp:GridView>

<asp:Panel ID="pnlPopup" runat="server" />

<iframe name="frmBlank" id="frmBlank" frameborder="0" height="0" width="0"></iframe>
<script language="javascript" type="text/javascript">
 function lFrame(url) {
  document.getElementById('frmBlank').src = url;
 }
</script>

 <asp:ObjectDataSource ID="odsPrepSetupStatus" runat="server" TypeName="myBiz.DAL.clsPrepSetup" SelectMethod="GetPrepSetupsStatus" UpdateMethod="SavePrepSetupStatus">
  <SelectParameters>
   <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
   <asp:Parameter Name="itemNums" Type="String" DefaultValue="6" />
  </SelectParameters>
  <UpdateParameters>
   <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
   <asp:Parameter Name="ItemID" Type="Int32" />
   <asp:Parameter Name="ReqStatus" Type="String" />
   <asp:Parameter Name="LocID" Type="Int32" />
  </UpdateParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsLocByType" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="ToolLocByType">
  <SelectParameters>
   <asp:Parameter Name="itemId" Type="String" DefaultValue="6" />
  </SelectParameters>
 </asp:ObjectDataSource>
