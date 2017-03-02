<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.InvUpdate" Codebehind="InvUpdate.ascx.cs" %>

<asp:GridView ID="gvInvCnt" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsInvCnt" ShowFooter="true" OnRowCommand="gvCmd" OnRowDataBound="rwBound" OnRowUpdating="gvUpdating" OnRowEditing="gvEditing">
 <Columns>
  <asp:TemplateField>
   <ItemTemplate>
    <asp:Button ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" CssClass="NavBtn" />
    <asp:Button ID="btnOverride" runat="server" Text="Edit" CssClass="NavBtn" OnClientClick="return false;"></asp:Button>
    <asp:Panel ID="pnlOverride" runat="server">
     <b>UN</b>: <asp:TextBox ID="txtUN" runat="server" Width="75px"></asp:TextBox><br />
     <b>PW</b>: <asp:TextBox ID="txtPW" runat="server" Width="75px" TextMode="Password"></asp:TextBox><br />
     <asp:Button ID="btnCheckOverride" runat="server" Text="Override" CommandName="Edit" CssClass="NavBtn" />
     <asp:Button ID="btnCancelOverride" runat="server" Text="Cancel" CssClass="NavBtn" OnClientClick="return false;" />
    </asp:Panel>
    <ajax:CollapsiblePanelExtender ID="cpeOverride" runat="server" TargetControlID="pnlOverride" ExpandControlID="btnOverride" CollapseControlID="btnCancelOverride" Collapsed="true" />
    <asp:HiddenField ID="hfisEdit" runat="server" Value='<%# Eval("isEdit") %>' />
   </ItemTemplate>
   <EditItemTemplate>
    <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="vUpdate" />
    <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
    <asp:HiddenField ID="hfisEdit" runat="server" Value='<%# Eval("isEdit") %>' />
   </EditItemTemplate>
   <FooterTemplate>
    <asp:Button ID="btnAddNew" Text="Add" runat="server" CommandName="AddNew" CommandArgument="Footer" CssClass="NavBtn" ValidationGroup="vNew" />
   </FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Entered By" SortExpression="EnteredBy" InsertVisible="false">
   <ItemTemplate><%# Eval("EnteredBy")%></ItemTemplate>
   <EditItemTemplate><asp:Literal ID="litEnteredBy" runat="server" Text='<%# Bind("EnteredBy")%>' /></EditItemTemplate>
   <FooterTemplate>&nbsp;</FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Date" SortExpression="InvDate" InsertVisible="false">
   <ItemTemplate><%# Eval("InvDate")%></ItemTemplate>
   <EditItemTemplate><%# Eval("InvDate")%></EditItemTemplate>
   <FooterTemplate>&nbsp;</FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="On-Hand" SortExpression="Qty" InsertVisible="false">
   <ItemTemplate><%# Eval("Qty")%></ItemTemplate>
   <EditItemTemplate>
    <asp:Literal ID="litQty" runat="server" Text='<%# Eval("Qty") %>'></asp:Literal>
    <asp:TextBox ID="txtQty" runat="server" Text='<%# Eval("Qty") %>' Width="50px" />
   </EditItemTemplate>
   <FooterTemplate>##</FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Available" SortExpression="Available" InsertVisible="false">
   <ItemTemplate><%# Eval("Available")%></ItemTemplate>
   <EditItemTemplate><asp:Literal ID="litAvailable" runat="server" Text='<%# Eval("Available") %>'></asp:Literal></EditItemTemplate>
   <FooterTemplate>##</FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Entered" SortExpression="iQty" InsertVisible="false">
   <ItemTemplate><asp:Literal ID="litiQty" runat="server" Text='<%# Eval("iQty") %>'></asp:Literal></ItemTemplate>
   <EditItemTemplate>
    <asp:Literal ID="litiQty" runat="server" Text='<%# Eval("iQty") %>'></asp:Literal>
    <asp:TextBox ID="txtiQty" runat="server" Text='<%# Eval("iQty") %>' Width="50px" />
    <asp:RequiredFieldValidator ID="rfviQty" runat="server" ControlToValidate="txtiQty" ErrorMessage="*" ValidationGroup="vUpdate"></asp:RequiredFieldValidator>
   </EditItemTemplate>
   <FooterTemplate>
    <asp:TextBox ID="txtQty" runat="server" Width="50px" />
    <asp:RequiredFieldValidator ID="rfvQty" runat="server" ControlToValidate="txtQty" ErrorMessage="*" ValidationGroup="vNew"></asp:RequiredFieldValidator>
   </FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Location" SortExpression="LocDesc" InsertVisible="false">
   <ItemTemplate>
    <asp:LinkButton ID="lnkLocOnly" runat="server" CommandName="Edit" CommandArgument="LocOnly" Text="&diams;" ToolTip="Edit Location Only!"></asp:LinkButton>
    <%# Eval("LocDesc")%>
   </ItemTemplate>
   <EditItemTemplate>
    <asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID"></asp:DropDownList>
    <asp:HiddenField ID="hfLocation" runat="server" Value='<%# Eval("LocID") %>' />
   </EditItemTemplate>
   <FooterTemplate><asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID"></asp:DropDownList></FooterTemplate>
  </asp:TemplateField>
 </Columns>
 <EmptyDataTemplate>
  <table>
   <tr><td><b>Qty</b></td><td><asp:TextBox ID="txtQty" runat="server" Width="30px"></asp:TextBox></td></tr>
   <tr><td><b>Location:</b></td><td><asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID"></asp:DropDownList></td></tr>
   <tr><td colspan="2"><asp:Button ID="btnNew" runat="server" Text="Save" CssClass="NavBtn" CommandName="AddNew" CommandArgument="Empty" /></td></tr>
  </table>
 </EmptyDataTemplate>
</asp:GridView>
Total Made: <asp:Literal ID="litTotal" runat="server" Text="0"></asp:Literal>
<br /><MW:Message ID="iMsg" runat="server" />

<asp:ObjectDataSource ID="odsInvCnt" runat="server" TypeName="myBiz.DAL.clsPartInv" SelectMethod="Select" UpdateMethod="Save">
 <SelectParameters><asp:ControlParameter ControlID="hfIDs" Name="IDs" Type="String" PropertyName="Value" /></SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:ControlParameter ControlID="hfIDs" Name="IDs" Type="String" PropertyName="Value" />
  <asp:Parameter Name="EnteredBy" Type="String" />
  <asp:Parameter Name="Qty" Type="Int32" />
  <asp:Parameter Name="LocID" Type="Int32" />
 </UpdateParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
 <SelectParameters>
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Inventory" />
  <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
  <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:HiddenField ID="hfIDs" runat="server" />
