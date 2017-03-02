<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucFIN09" Codebehind="ucFIN09.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>First Article Inspection Information</h3>
<asp:Panel ID="pnlTask" runat="server" Enabled="false">
 <asp:Button ID="btnExcel" runat="server" Text="Upload XML File (Excel)" OnClick="doUpload" CssClass="NavBtn" />
 <asp:Button ID="btnUpload" runat="server" Text="Upload XML File (SolidWork)" OnClick="doUpload" CssClass="NavBtn" /><br /><br />
 <asp:GridView ID="gvXML" runat="server" DataKeyNames="HID" SkinID="GrayHeader" DataSourceID="odsXML" OnRowDataBound="gvBound">
  <Columns>
   <asp:TemplateField>
    <ItemTemplate>
     <asp:LinkButton ID="lnkDelete" runat="server" Text="Remove" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to remove?');" />
    </ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="CharNo" DataField="xCharNo" SortExpression="CharNo" InsertVisible="false" />
   <asp:BoundField HeaderText="Loc" DataField="Location" SortExpression="Location" InsertVisible="false" />
   <asp:TemplateField HeaderText="Drawing Requirement" SortExpression="DrawReq">
    <ItemTemplate><%# Eval("xDrawReq") %></ItemTemplate>
   </asp:TemplateField>
  </Columns>
 </asp:GridView>
 <asp:LinkButton ID="lnkRefresh" runat="server" OnClick="doRefresh"></asp:LinkButton>
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />
<br /><MW:Message ID="iMsg" runat="server" />
<asp:Panel ID="pnlPopup" runat="server"></asp:Panel>

<asp:ObjectDataSource ID="odsXML" runat="server" TypeName="myBiz.DAL.cls1stArticle" SelectMethod="selectXML" DeleteMethod="deleteXML">
<SelectParameters><asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" /></SelectParameters>
<DeleteParameters><asp:Parameter Name="HID" Type="Int32" /></DeleteParameters>
</asp:ObjectDataSource>