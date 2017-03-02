<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Tools.Docs" Codebehind="Docs.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <aspx:UpdatePanel ID="uPnlDocs" runat="server">
  <ContentTemplate>
   <asp:GridView ID="gvDocs" runat="server" SkinID="Default" DataSourceID="odsDocs" DataKeyNames="HID" OnRowCommand="gvCmd" OnRowDataBound="gvBound">
    <Columns>
     <asp:TemplateField ItemStyle-VerticalAlign="Top" FooterStyle-VerticalAlign="Top">
      <ItemTemplate>
       <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
       <asp:LinkButton ID="lnkFileU" runat="server" Text='Upload' CommandName="showFile" CommandArgument='<%# string.Format("UL:{0}",Eval("HID")) %>' />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="vEdit" />
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
      </EditItemTemplate>
      <FooterTemplate><asp:Button ID="btnAdd" Text="Add New" runat="server" CommandName="AddNew" CssClass="NavBtn" ValidationGroup="vNew" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Type" SortExpression="Type" InsertVisible="false" ItemStyle-VerticalAlign="Top" FooterStyle-VerticalAlign="Top">
      <ItemTemplate><%# Eval("Type") %></ItemTemplate>
      <EditItemTemplate><asp:DropDownList ID="ddlDocType" runat="server" DataSourceID="odsDocType" DataValueField="mValue" DataTextField="mText" SelectedValue='<%# Bind("Type") %>' /><br />
       <asp:RequiredFieldValidator ID="rfvDocType" runat="server" ControlToValidate="ddlDocType" ErrorMessage="Required!" ValidationGroup="vEdit"></asp:RequiredFieldValidator>
      </EditItemTemplate>
      <FooterTemplate><asp:DropDownList ID="ddlDocType" runat="server" DataSourceID="odsDocType" DataValueField="mValue" DataTextField="mText" /><br />
       <asp:RequiredFieldValidator ID="rfvDocType" runat="server" ControlToValidate="ddlDocType" ErrorMessage="Required!" ValidationGroup="vNew"></asp:RequiredFieldValidator>
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Name" SortExpression="Name" InsertVisible="false" ItemStyle-VerticalAlign="Top" FooterStyle-VerticalAlign="Top">
      <ItemTemplate><%# Eval("Name") %></ItemTemplate>
      <EditItemTemplate>
       <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox><br />
       <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Required!" ValidationGroup="vEdit"></asp:RequiredFieldValidator>
      </EditItemTemplate>
      <FooterTemplate>
       <asp:TextBox ID="txtName" runat="server"></asp:TextBox><br />
       <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Required!" ValidationGroup="vNew"></asp:RequiredFieldValidator>
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Description" SortExpression="Description" InsertVisible="false" ItemStyle-VerticalAlign="Top" FooterStyle-VerticalAlign="Top">
      <ItemTemplate><asp:Label ID="lblDesc" runat="server" Text='<%# Eval("Description") %>' Width="600px" /></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine" Width="600px" Height="50px"></asp:TextBox></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Width="600px" Height="50px"></asp:TextBox></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Status" SortExpression="Status" InsertVisible="false" ItemStyle-VerticalAlign="Top" FooterStyle-VerticalAlign="Top">
      <ItemTemplate><%# Eval("Status") %></ItemTemplate>
      <EditItemTemplate><asp:DropDownList ID="ddlDocStatus" runat="server" DataSourceID="odsDocStatus" DataValueField="mValue" DataTextField="mText" SelectedValue='<%# Bind("Status") %>' /><br />
       <asp:RequiredFieldValidator ID="rfvDocStatus" runat="server" ControlToValidate="ddlDocStatus" ErrorMessage="Required!" ValidationGroup="vEdit"></asp:RequiredFieldValidator>
      </EditItemTemplate>
      <FooterTemplate><asp:DropDownList ID="ddlDocStatus" runat="server" DataSourceID="odsDocStatus" DataValueField="mValue" DataTextField="mText" /><br />
       <asp:RequiredFieldValidator ID="rfvDocStatus" runat="server" ControlToValidate="ddlDocStatus" ErrorMessage="Required!" ValidationGroup="vNew"></asp:RequiredFieldValidator>
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Doc" ItemStyle-VerticalAlign="Top" FooterStyle-VerticalAlign="Top">
      <ItemTemplate><asp:LinkButton ID="lnkFileD" runat="server" Text='<%# Eval("hasFile") %>' CommandName="showFile" CommandArgument='<%# string.Format("DL:{0}",Eval("HID")) %>'></asp:LinkButton></ItemTemplate>
      <EditItemTemplate>N/A</EditItemTemplate>
      <FooterTemplate>N/A</FooterTemplate>
     </asp:TemplateField>
    </Columns>
    <EmptyDataTemplate>
     <table cellpadding="0" cellspacing="0">
     <tr style="background-color:#EEEEEE">
      <td>&nbsp;</td>
      <td><b>Type</b></td>
      <td><b>Name</b></td>
      <td><b>Description</b></td>
      <td><b>Status</b></td>
     </tr>
     <tr>
      <td><asp:Button ID="btnEmpty" Text="Add" runat="server" CommandName="AddEmpty" CssClass="NavBtn" /></td>
      <td><asp:DropDownList ID="ddlDocType" runat="server" DataSourceID="odsDocType" DataValueField="mValue" DataTextField="mText" /></td>
      <td><asp:TextBox ID="txtName" runat="server"></asp:TextBox></td>
      <td><asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Width="600px" Height="50px"></asp:TextBox></td>
      <td><asp:DropDownList ID="ddlDocStatus" runat="server" DataSourceID="odsDocStatus" DataValueField="mValue" DataTextField="mText" /></td>
     </tr>
     </table>
    </EmptyDataTemplate>
   </asp:GridView>
   <asp:LinkButton ID="lnkRefresh" runat="server" OnClick="lRefresh"></asp:LinkButton>
   <asp:Panel ID="pnlPopup" runat="server" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:HiddenField ID="hfValx" runat="server" />

<asp:ObjectDataSource ID="odsDocType" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
 <SelectParameters>
  <asp:Parameter Name="Cate" Type="String" DefaultValue="DocType" />
  <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
 </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsDocStatus" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
 <SelectParameters>
  <asp:Parameter Name="Cate" Type="String" DefaultValue="DocStatus" />
  <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
 </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsDocs" runat="server" TypeName="myBiz.DAL.clsDocs" SelectMethod="Select" UpdateMethod="Save">
 <SelectParameters>
  <asp:ControlParameter Name="HID" Type="Int32" ControlID="hfValx" PropertyName="Value" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="Type" Type="String" />
  <asp:Parameter Name="Name" Type="String" />
  <asp:Parameter Name="Description" Type="String" />
  <asp:Parameter Name="Status" Type="String" />
 </UpdateParameters>
</asp:ObjectDataSource>
</asp:Content>