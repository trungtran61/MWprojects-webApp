<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucCommCompany" Codebehind="ucCommCompany.ascx.cs" %>

<asp:LinkButton ID="lnkMoreCompany" runat="server" Text="View All" OnClick="lMore"></asp:LinkButton> |
<asp:LinkButton ID="lnkNewCompany" runat="server" Text="New Company"></asp:LinkButton><br />
<i>Type:</i> <asp:DropDownList ID="ddlType" runat="server" DataSourceID="odsType" DataTextField="TypeName" DataValueField="HID" AutoPostBack="true" OnSelectedIndexChanged="ddlSelected"></asp:DropDownList>
<br />
 <asp:GridView ID="gvCompany" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsCompany" OnSelectedIndexChanged="gvSelected" OnRowDataBound="rwBound" PageSize="10" OnRowCommand="rwCompanyCmd">
  <Columns>
   <asp:TemplateField>
    <ItemTemplate>
     <asp:Button ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" CssClass="NavBtn" />
     <asp:HiddenField ID="hfClassName" runat="server" Value='<%# Eval("ClassName") %>' />
    </ItemTemplate>
    <EditItemTemplate>
     <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
     <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
    </EditItemTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="Name" SortExpression="CompanyName" ItemStyle-Wrap="false" InsertVisible="false">
    <ItemTemplate>
     <asp:CheckBox ID="chkSelected" runat="server" Checked='<%# Eval("isSelected") %>' Enabled="false" />
     <asp:LinkButton ID="lnkSelect" runat="server" Text='<%# Eval("CompanyName")%>' CommandName="Select" />
    </ItemTemplate>
    <EditItemTemplate><asp:TextBox ID="txtCompanyName" runat="server" Text='<%# Bind("CompanyName") %>' Width="300px" /></EditItemTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="ID" SortExpression="CompanyID" ItemStyle-Wrap="false" InsertVisible="false">
    <ItemTemplate><%# Eval("CompanyID")%></ItemTemplate>
    <EditItemTemplate><asp:TextBox ID="txtCompanyID" runat="server" Width="30px" Text='<%# Bind("CompanyID") %>' /></EditItemTemplate>
   </asp:TemplateField>
  </Columns>
 </asp:GridView>
 
 <table id="tblNewCompany" runat="server" class="mdlPopup">
  <tr><td align="right"><b>Company Name:</b></td><td><asp:TextBox ID="txtCompanyName" runat="server" Width="300px"></asp:TextBox></td></tr>
  <tr><td align="right"><b>Company ID:</b></td><td><asp:TextBox ID="txtCompanyID" runat="server" Width="30px"></asp:TextBox></td></tr>
  <tr>
   <td colspan="2" align="right">
    <asp:Button ID="btnAdd" runat="server" Text="Add New Company" OnClick="aNewCompany" CssClass="NavBtn" />
    <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="NavBtn" />
   </td>
  </tr>
 </table>
 <ajax:ModalPopupExtender ID="mpeNewCompany" runat="server" TargetControlID="lnkNewCompany" PopupControlID="tblNewCompany" BackgroundCssClass="modalBackground"
  OkControlID="btnClose" DropShadow="false" RepositionMode="RepositionOnWindowResize" />
 
 <asp:ObjectDataSource ID="odsCompany" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="Company_Select" UpdateMethod="Company_Save">
  <SelectParameters>
   <asp:Parameter Name="ClassID" Type="Int32" />
   <asp:ControlParameter Name="TypeID" Type="Int32" ControlID="ddlType" PropertyName="SelectedValue" />
   <asp:Parameter Name="isActive" Type="Boolean" DefaultValue="true" />
   <asp:Parameter Name="isMore" Type="Boolean" DefaultValue="false" />
  </SelectParameters>
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="CompanyName" Type="String" />
   <asp:Parameter Name="CompanyID" Type="String" />
   <asp:Parameter Name="isActive" Type="Boolean" DefaultValue="true" />
  </UpdateParameters>
 </asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsType" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="Type_Select">
</asp:ObjectDataSource>