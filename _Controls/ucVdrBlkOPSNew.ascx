<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucVdrBlkOPSNew.ascx.cs" Inherits="webApp._Controls.ucVdrBlkOPSNew" %>

<table>
 <tr>
  <td><b>Type</b></td>
  <td><b>Spec</b></td>
  <td><b>Desc</b></td>
  <td>&nbsp;</td>
 </tr>
 <tr>
  <td><asp:DropDownList ID="ddlType" runat="server" AutoPostBack="true" DataSourceID="odsTypeList" DataValueField="HID" DataTextField="OPSType" OnSelectedIndexChanged="ddlSelected"></asp:DropDownList></td>
  <td><asp:DropDownList ID="ddlSpec" runat="server" AutoPostBack="true" DataSourceID="odsSpecList" DataValueField="HID" DataTextField="OPSSpec" OnSelectedIndexChanged="ddlSelected"></asp:DropDownList></td>
  <td><asp:DropDownList ID="ddlDesc" runat="server" AutoPostBack="true" DataSourceID="odsDescList" DataValueField="HID" DataTextField="OPSDesc" OnSelectedIndexChanged="ddlSelected"></asp:DropDownList></td>
  <td><asp:Button ID="btnLoad" runat="server" Text="Load" OnClick="doLoad" CssClass="NavBtn" /></td>
 </tr>
</table>
<br />

<asp:GridView ID="gvBlkOPS" runat="server" SkinID="Default" DataKeyNames="pHID,pKey" DataSourceID="odsVdrBlkOPS" OnRowDataBound="rwBound" OnDataBound="gvBound">
 <Columns>
  <asp:BoundField HeaderText="Name" DataField="pKey" InsertVisible="false" />
  <asp:TemplateField HeaderText="Value" InsertVisible="false">
   <ItemTemplate>
    <asp:HiddenField ID="hfHID" runat="server" Value='<%# Eval("pHID") %>' />
    <asp:Literal ID="litVal" runat="server" Text='<%# Eval("pVal") %>'></asp:Literal>
   </ItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="None" InsertVisible="false">
   <ItemTemplate>
    <asp:CheckBox ID="chkBlk" runat="server" />
   </ItemTemplate>
  </asp:TemplateField>
 </Columns>
</asp:GridView>
<asp:Button ID="btnSave" runat="server" Text="Save" OnClick="doSave" CssClass="NavBtn" />
<MW:Message ID="iMsg" runat="server" />

<asp:ObjectDataSource ID="odsVdrBlkOPS" runat="server" TypeName="myBiz.DAL.clsVendor" SelectMethod="Vendor_BlkOPS_S1" InsertMethod="Vendor_BlkOPS_I">
 <SelectParameters>
  <asp:Parameter Name="OPSTypeID" Type="Int32" />
  <asp:Parameter Name="OPSType" Type="String" />
  <asp:Parameter Name="OPSSpecID" Type="Int32" />
  <asp:Parameter Name="OPSSpec" Type="String" />
  <asp:Parameter Name="OPSDescID" Type="Int32" />
  <asp:Parameter Name="OPSDesc" Type="String" />
 </SelectParameters>
 <InsertParameters>
  <asp:ControlParameter Name="VendorID" Type="Int32" ControlID="hfVendorID" PropertyName="Value" />
  <asp:ControlParameter Name="OPSDescID" Type="Int32" ControlID="ddlDesc" PropertyName="SelectedValue" />
  <asp:Parameter Name="blkType" Type="Boolean" />
  <asp:Parameter Name="blkSpec" Type="Boolean" />
  <asp:Parameter Name="blkDesc" Type="Boolean" />
 </InsertParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsTypeList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Type_S1">
 <SelectParameters><asp:ControlParameter Name="VendorID" Type="Int32" ControlID="hfVendorID" PropertyName="Value" /></SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsSpecList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Spec_S">
 <SelectParameters>
  <asp:ControlParameter Name="OPSTypeID" Type="Int32" ControlID="ddlType" PropertyName="SelectedValue" />
  <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
 </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsDescList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Desc_S">
 <SelectParameters>
  <asp:ControlParameter Name="OPSSpecID" Type="Int32" ControlID="ddlSpec" PropertyName="SelectedValue" />
  <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:HiddenField ID="hfVendorID" runat="server" />