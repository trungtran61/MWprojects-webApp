<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucVdrBlkMatlNew.ascx.cs" Inherits="webApp._Controls.ucVdrBlkMatlNew" %>

<table>
 <tr>
  <td><b>Type</b></td>
  <td><b>Ams</b></td>
  <td><b>Form</b></td>
  <td>&nbsp;</td>
 </tr>
 <tr>
  <td><asp:DropDownList ID="ddlType" runat="server" AutoPostBack="true" DataSourceID="odsTypeList" DataValueField="HID" DataTextField="MatlType" OnSelectedIndexChanged="ddlSelected"></asp:DropDownList></td>
  <td><asp:DropDownList ID="ddlAms" runat="server" AutoPostBack="true" DataSourceID="odsAmsList" DataValueField="HID" DataTextField="MatlAms" OnSelectedIndexChanged="ddlSelected"></asp:DropDownList></td>
  <td><asp:DropDownList ID="ddlForm" runat="server" AutoPostBack="true" DataSourceID="odsFormList" DataValueField="HID" DataTextField="MatlForm" OnSelectedIndexChanged="ddlSelected"></asp:DropDownList></td>
  <td><asp:Button ID="btnLoad" runat="server" Text="Load" OnClick="doLoad" CssClass="NavBtn" /></td>
 </tr>
</table>
<br />

<asp:GridView ID="gvBlkMatl" runat="server" SkinID="Default" DataKeyNames="pHID,pKey" DataSourceID="odsVdrBlkMatl" OnRowDataBound="rwBound" OnDataBound="gvBound">
 <Columns>
  <asp:BoundField HeaderText="Name" DataField="pKey" InsertVisible="false" />
  <asp:TemplateField HeaderText="Value" InsertVisible="false">
   <ItemTemplate>
    <asp:HiddenField ID="hfHID" runat="server" Value='<%# Eval("pHID") %>' />
    <asp:Literal ID="litVal" runat="server" Text='<%# Eval("pVal") %>'></asp:Literal>
    <asp:TextBox ID="txtVal" runat="server" Width="50px"></asp:TextBox>
    <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="odsUnitList" DataTextField="MatlUnitTxt" DataValueField="MatlUnitVal"></asp:DropDownList>    
    <asp:ObjectDataSource ID="odsUnitList" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Material_Unit_S">
     <SelectParameters>
      <asp:ControlParameter Name="MatlDmsID" Type="Int32" ControlID="hfHID" PropertyName="Value" />
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

<asp:ObjectDataSource ID="odsVdrBlkMatl" runat="server" TypeName="myBiz.DAL.clsVendor" SelectMethod="Vendor_BlkMatl_S1" InsertMethod="Vendor_BlkMatl_I">
 <SelectParameters>
  <asp:Parameter Name="MatlTypeID" Type="Int32" />
  <asp:Parameter Name="MatlType" Type="String" />
  <asp:Parameter Name="MatlAmsID" Type="Int32" />
  <asp:Parameter Name="MatlAms" Type="String" />
  <asp:Parameter Name="MatlFormID" Type="Int32" />
  <asp:Parameter Name="MatlForm" Type="String" />
 </SelectParameters>
 <InsertParameters>
  <asp:ControlParameter Name="VendorID" Type="Int32" ControlID="hfVendorID" PropertyName="Value" />
  <asp:ControlParameter Name="MatlAmsID" Type="Int32" ControlID="ddlAms" PropertyName="SelectedValue" />
  <asp:ControlParameter Name="MatlFormID" Type="Int32" ControlID="ddlForm" PropertyName="SelectedValue" />
  <asp:Parameter Name="blkType" Type="Boolean" />
  <asp:Parameter Name="blkAms" Type="Boolean" />
  <asp:Parameter Name="blkForm" Type="Boolean" />
  <asp:Parameter Name="DmsID" Type="String" />
  <asp:Parameter Name="dVal" Type="String" />
  <asp:Parameter Name="dUnit" Type="String" />
  <asp:Parameter Name="dBlk" Type="String" />
 </InsertParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsTypeList" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Material_Type_S">
 <SelectParameters><asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" /></SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsAmsList" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Material_Ams_S">
 <SelectParameters>
  <asp:ControlParameter Name="MatlTypeID" Type="Int32" ControlID="ddlType" PropertyName="SelectedValue" />
  <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
 </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsFormList" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Material_Form_S">
 <SelectParameters><asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" /></SelectParameters>
</asp:ObjectDataSource>

<asp:HiddenField ID="hfVendorID" runat="server" />