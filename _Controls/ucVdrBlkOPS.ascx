<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucVdrBlkOPS.ascx.cs" Inherits="webApp._Controls.ucVdrBlkOPS" %>

<asp:GridView ID="gvBlkOPS" runat="server" SkinID="Default" DataKeyNames="pHID,pKey" DataSourceID="odsVdrBlkOPS" OnRowDataBound="rwBound">
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

<asp:ObjectDataSource ID="odsVdrBlkOPS" runat="server" TypeName="myBiz.DAL.clsVendor" SelectMethod="Vendor_BlkOPS_S" UpdateMethod="Vendor_BlkOPS_Save" OnUpdated="odsUpdated" OnSelected="odsSelected">
 <SelectParameters>
  <asp:ControlParameter Name="mID" Type="Int32" ControlID="hfID" PropertyName="Value" />
  <asp:ControlParameter Name="VendorID" Type="Int32" ControlID="hfVendorID" PropertyName="Value" />
  <asp:Parameter Name="outBlkID" Type="Int32" Direction="Output" />
 </SelectParameters>
 <UpdateParameters>
  <asp:ControlParameter Name="mID" Type="Int32" ControlID="hfID" PropertyName="Value" />
  <asp:ControlParameter Name="VendorID" Type="Int32" ControlID="hfVendorID" PropertyName="Value" />
  <asp:Parameter Name="blkType" Type="Boolean" />
  <asp:Parameter Name="blkSpec" Type="Boolean" />
  <asp:Parameter Name="blkDesc" Type="Boolean" />
 </UpdateParameters>
</asp:ObjectDataSource>

<asp:HiddenField ID="hfID" runat="server" />
<asp:HiddenField ID="hfVendorID" runat="server" />
<asp:HiddenField ID="hfIsEdit" runat="server" />