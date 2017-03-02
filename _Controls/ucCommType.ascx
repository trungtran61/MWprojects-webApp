<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucCommType" Codebehind="ucCommType.ascx.cs" %>

<asp:LinkButton ID="lnkMoreType" runat="server" Text="View All" OnClick="lMore"></asp:LinkButton><br />
<asp:GridView ID="gvType" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsType" OnSelectedIndexChanged="gvSelected" OnRowCommand="rwCmd" OnRowDataBound="rwBound">
 <Columns>
  <asp:TemplateField ItemStyle-Wrap="false" HeaderText="Type Name" SortExpression="TypeName">
   <ItemTemplate>
    <asp:CheckBox ID="chkSelected" runat="server" Checked='<%# Eval("isSelected") %>' Enabled="false" />
    <asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("TypeName") %>'></asp:LinkButton>
   </ItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField ItemStyle-Wrap="false" HeaderText="Blk?" SortExpression="blkID">
   <ItemTemplate>
    <asp:HiddenField ID="hfBlkID" runat="server" Value='<%# Eval("blkID") %>' />
    <asp:CheckBox ID="chkBlk" runat="server" OnCheckedChanged="chkChanged" AutoPostBack="true" Visible='<%# Eval("isSelected") %>' />
   </ItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField ItemStyle-Wrap="false" SortExpression="CVT">
   <HeaderTemplate><span title="Controlled Vendor Type">CVT</span></HeaderTemplate>
   <ItemTemplate>
    <asp:CheckBox ID="chkCVT" runat="server" OnCheckedChanged="chkChangedCVT" AutoPostBack="true" Checked='<%# Eval("CVT") %>' />
   </ItemTemplate>
  </asp:TemplateField>
 </Columns>
</asp:GridView>

<asp:ObjectDataSource ID="odsType" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="Type_Select">
 <SelectParameters>
  <asp:Parameter Name="CompanyID" Type="Int32" />
  <asp:Parameter Name="ClassID" Type="Int32" />
  <asp:Parameter Name="isMore" Type="Boolean" DefaultValue="false" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:HiddenField ID="hfCompanyID" runat="server" />
<asp:HiddenField ID="hfIsInAct" runat="server" />