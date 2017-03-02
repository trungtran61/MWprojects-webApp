<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucVdrBlkGageNew.ascx.cs" Inherits="webApp._Controls.ucVdrBlkGageNew" %>

<table>
 <tr>
  <td><b>Name</b></td>
  <td>&nbsp;</td>
 </tr>
 <tr>
  <td><asp:DropDownList ID="ddlName" runat="server" AutoPostBack="true" DataSourceID="odsNameList" DataValueField="HID" DataTextField="GageName" OnSelectedIndexChanged="ddlSelected"></asp:DropDownList></td>
  <td><asp:Button ID="btnLoad" runat="server" Text="Load" OnClick="doLoad" CssClass="NavBtn" /></td>
 </tr>
</table>
<br />

<asp:GridView ID="gvBlkGage" runat="server" SkinID="Default" DataKeyNames="pHID,pKey" DataSourceID="odsVdrBlkGage" OnRowDataBound="rwBound" OnDataBound="gvBound">
 <Columns>
  <asp:BoundField HeaderText="Name" DataField="pKey" InsertVisible="false" />
  <asp:TemplateField HeaderText="Value" InsertVisible="false">
   <ItemTemplate>
    <asp:HiddenField ID="hfHID" runat="server" Value='<%# Eval("pHID") %>' />
    <asp:Literal ID="litVal" runat="server" Text='<%# Eval("pVal") %>'></asp:Literal>
    <asp:TextBox ID="txtVal" runat="server" Width="50px"></asp:TextBox>
    <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="odsUnitList" DataTextField="GageUnitTxt" DataValueField="GageUnitVal"></asp:DropDownList>    
    <asp:ObjectDataSource ID="odsUnitList" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Gage_Unit_S">
     <SelectParameters>
      <asp:ControlParameter Name="GageDmsID" Type="Int32" ControlID="hfHID" PropertyName="Value" />
      <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
     </SelectParameters>
    </asp:ObjectDataSource>
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

<asp:ObjectDataSource ID="odsVdrBlkGage" runat="server" TypeName="myBiz.DAL.clsVendor" SelectMethod="Vendor_BlkGage_S1" InsertMethod="Vendor_BlkGage_I">
 <SelectParameters>
  <asp:Parameter Name="GageNameID" Type="Int32" />
  <asp:Parameter Name="GageName" Type="String" />
 </SelectParameters>
 <InsertParameters>
  <asp:ControlParameter Name="VendorID" Type="Int32" ControlID="hfVendorID" PropertyName="Value" />
  <asp:ControlParameter Name="GageNameID" Type="Int32" ControlID="ddlName" PropertyName="SelectedValue" />
  <asp:Parameter Name="blkName" Type="Boolean" />
  <asp:Parameter Name="DmsID" Type="String" />
  <asp:Parameter Name="dVal" Type="String" />
  <asp:Parameter Name="dUnit" Type="String" />
  <asp:Parameter Name="dBlk" Type="String" />
 </InsertParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsNameList" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Gage_Name_S">
 <SelectParameters>
  <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:HiddenField ID="hfVendorID" runat="server" />