<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.AdminPanel.CommSetup" Title="Communication Setup" Codebehind="CommSetup.aspx.cs" %>
<%@ Register Src="~/_Controls/Progress.ascx" TagName="Progress" TagPrefix="ucProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <aspx:UpdatePanel ID="uPnlSearch" runat="server">
  <ContentTemplate>
   <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
    <table style="background-color:#CCCCCC;">
     <tr>
      <td><b>Item:</b><br /><asp:TextBox ID="txtItem" runat="server"></asp:TextBox></td>
      <td><b>Company:</b><br /><asp:TextBox ID="txtCompany" runat="server"></asp:TextBox></td>
      <td><b>Class:</b><br /><asp:TextBox ID="txtClass" runat="server"></asp:TextBox></td>
     </tr>
     <tr>
      <td><b>Type:</b><br /><asp:TextBox ID="txtType" runat="server"></asp:TextBox></td>
      <td><b>Contact:</b><br /><asp:TextBox ID="txtContact" runat="server"></asp:TextBox></td>
      <td><b>Misc:</b><br /><asp:TextBox ID="txtMisc" runat="server"></asp:TextBox></td>
     </tr>
     <tr>
      <td colspan="3" align="right">
       <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="NavBtn" />
       <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="doReset" CssClass="NavBtn" />
      </td>
     </tr>
    </table>
   </asp:Panel>
   <br />
   <ucProgress:Progress ID="abc" runat="server" />
   <asp:GridView ID="gvComm" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsComm" PageSize="20" CellSpacing="1">
    <Columns>
     <asp:BoundField HeaderText="Item" DataField="Item" SortExpression="Item" />
     <asp:TemplateField HeaderText="CompanyName" SortExpression="CompanyName">
      <ItemTemplate>
       <asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("CompanyName") %>'></asp:LinkButton>
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Class" DataField="ClassName" SortExpression="ClassName" />
     <asp:BoundField HeaderText="Type" DataField="TypeName" SortExpression="TypeName" />
     <asp:TemplateField HeaderText="Contact Name" SortExpression="FirstName">
      <ItemTemplate>
       <%# Eval("FirstName") %> <%# Eval("MiddleName") %> <%# Eval("LastName") %>
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Address" DataField="Address1" SortExpression="Address1" />
     <asp:BoundField HeaderText="City" DataField="City" SortExpression="City" />
     <asp:BoundField HeaderText="State" DataField="State" SortExpression="State" />
     <asp:BoundField HeaderText="Zip" DataField="Zip" SortExpression="Zip" />
     <asp:BoundField HeaderText="Country" DataField="Country" SortExpression="Country" />
     <asp:BoundField HeaderText="Phone" DataField="Phone" SortExpression="Phone" />
     <asp:BoundField HeaderText="Fax" DataField="Fax" SortExpression="Fax" />
     <asp:BoundField HeaderText="Email" DataField="Email" SortExpression="Email" />
    </Columns>
   </asp:GridView>
   <br />
   <asp:GridView ID="gvSendBy" runat="server" SkinID="Default" DataKeyNames="mValue" DataSourceID="odsSendBy" PageSize="500">
    <Columns>
     <asp:TemplateField HeaderText="SendBy">
      <ItemTemplate>
       <asp:CheckBox ID="chkSendBy" runat="server" Text='<%# Eval("mText") %>' Checked='<%# Eval("isSelected") %>' />
      </ItemTemplate>
     </asp:TemplateField>
    </Columns>
   </asp:GridView>
   <br /><br />
   <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="NavBtn" />
   <MW:Message ID="iMsg" runat="server" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 
 <asp:ObjectDataSource ID="odsComm" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="Select" FilterExpression="ClassName IN ({0})" OnFiltering="odsFiltering">
  <FilterParameters><asp:Parameter Name="ClassName" Type="String" /></FilterParameters>
  <SelectParameters>
   <asp:ControlParameter Name="Item" Type="String" ControlID="txtItem" PropertyName="Text" />
   <asp:ControlParameter Name="Company" Type="String" ControlID="txtCompany" PropertyName="Text" />
   <asp:ControlParameter Name="Class" Type="String" ControlID="txtClass" PropertyName="Text" />
   <asp:ControlParameter Name="Type" Type="String" ControlID="txtType" PropertyName="Text" />
   <asp:ControlParameter Name="Contact" Type="String" ControlID="txtContact" PropertyName="Text" />
   <asp:ControlParameter Name="Misc" Type="String" ControlID="txtMisc" PropertyName="Text" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsSendBy" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="SendBy_Select" UpdateMethod="SendBy_Save">
  <SelectParameters><asp:ControlParameter ControlID="gvComm" Name="CommID" Type="Int32" PropertyName="SelectedValue" /></SelectParameters>
  <UpdateParameters>
   <asp:ControlParameter ControlID="gvComm" Name="CommID" Type="Int32" PropertyName="SelectedValue" />
   <asp:Parameter Name="SendBy" Type="String" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>