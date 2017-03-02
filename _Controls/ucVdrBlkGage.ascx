<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucVdrBlkGage.ascx.cs" Inherits="webApp._Controls.ucVdrBlkGage" %>

<asp:GridView ID="gvBlkGage" runat="server" SkinID="Default" DataKeyNames="pHID,pKey" DataSourceID="odsVdrBlkGage" OnRowDataBound="rwBound">
 <Columns>
  <asp:BoundField HeaderText="Name" DataField="pKey" InsertVisible="false" />
  <asp:BoundField HeaderText="Value" DataField="pVal" InsertVisible="false" />
  <asp:TemplateField HeaderText="None" InsertVisible="false">
   <ItemTemplate>
    <asp:CheckBox ID="chkBlk" runat="server" Checked='<%# Eval("pBlk") %>' />
   </ItemTemplate>
  </asp:TemplateField>
 </Columns>
</asp:GridView>
<asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="doCmd" CommandName="Edit" CssClass="NavBtn" />
<asp:Button ID="btnUnblock" runat="server" Text="Unblock" OnClick="doCmd" CommandName="Unblock" CssClass="NavBtn" OnClientClick="return confirm('Are you sure you want to unblock?');" />
<asp:Button ID="btnSave" runat="server" Text="Save" OnClick="doCmd" CommandName="Save" CssClass="NavBtn" Visible="false" />
<asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="doCmd" CommandName="Cancel" CssClass="NavBtn" Visible="false" />

<asp:ObjectDataSource ID="odsVdrBlkGage" runat="server" TypeName="myBiz.DAL.clsVendor" SelectMethod="Vendor_BlkGage_S" UpdateMethod="Vendor_BlkGage_Save" OnUpdated="odsUpdated" OnSelected="odsSelected">
 <SelectParameters>
  <asp:ControlParameter Name="mID" Type="Int32" ControlID="hfID" PropertyName="Value" />
  <asp:ControlParameter Name="VendorID" Type="Int32" ControlID="hfVendorID" PropertyName="Value" />
  <asp:Parameter Name="outBlkID" Type="Int32" Direction="Output" />
 </SelectParameters>
 <UpdateParameters>
  <asp:ControlParameter Name="mID" Type="Int32" ControlID="hfID" PropertyName="Value" />
  <asp:ControlParameter Name="VendorID" Type="Int32" ControlID="hfVendorID" PropertyName="Value" />
  <asp:Parameter Name="blkName" Type="Boolean" />
  <asp:Parameter Name="vHID" Type="String" />
  <asp:Parameter Name="vBlk" Type="String" />
 </UpdateParameters>
</asp:ObjectDataSource>

<asp:HiddenField ID="hfID" runat="server" />
<asp:HiddenField ID="hfVendorID" runat="server" />
<asp:HiddenField ID="hfIsEdit" runat="server" />