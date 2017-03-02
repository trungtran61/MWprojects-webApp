<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucRIM12" Codebehind="ucRIM12.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Received Material</h3>

 <asp:FormView ID="fvMaterial" runat="server" DefaultMode="ReadOnly" DataSourceID="odsMaterial" DataKeyNames="HID">
  <ItemTemplate>
   <table>
    <tr><td align="right"><b>Type:</b></td><td><%# Eval("Type") %></td></tr>
    <tr><td align="right"><b>Ams:</b></td><td><%# Eval("Ams") %></td></tr>
    <tr><td align="right"><b>Size:</b></td><td><%# Eval("Size") %> <%# Eval("Unit") %></td></tr>
    <tr><td align="right"><b>Heat Lot:</b></td><td><%# Eval("HeatLot") %></td></tr>
    <tr><td align="right"><b>Cert#:</b></td><td><%# Eval("CertNo") %></td></tr>
    <tr><td align="right"><b>PO Number:</b></td><td><asp:Literal ID="litPONum" runat="server" Text='<%# Eval("PONum") %>' /></td></tr>
    <tr><td align="right"><b>Vendor:</b></td><td><%# Eval("CompanyName") %></td></tr>
   </table>
  </ItemTemplate>
  <EditItemTemplate>
   <table>
    <tr>
     <td align="right"><b>Type:</b></td>
     <td><asp:TextBox ID="txtType" runat="server" Text='<%# Bind("Type") %>' /></td>
    </tr>
    <tr>
     <td align="right"><b>Ams:</b></td>
     <td><asp:TextBox ID="txtAms" runat="server" Text='<%# Bind("Ams") %>' /></td>
    </tr>
    <tr>
     <td align="right"><b>Size:</b></td>
     <td><asp:TextBox ID="txtSize" runat="server" Text='<%# Bind("Size") %>' /></td>
    </tr>
    <tr>
     <td align="right"><b>Heat Lot:</b></td>
     <td><asp:TextBox ID="txtHeatLot" runat="server" Text='<%# Bind("HeatLot") %>' /></td>
    </tr>
    <tr>
     <td align="right"><b>Cert#:</b></td>
     <td><asp:TextBox ID="txtCert" runat="server" Text='<%# Bind("CertNo") %>' /></td>
    </tr>
    <tr>
     <td align="right"><b>PO#:</b></td>
     <td>
      <asp:TextBox ID="txtPONum" runat="server" Text='<%# Bind("PONum") %>' />
      <asp:RequiredFieldValidator ID="rfvPONum" runat="server" Text="PO Number is required!" ControlToValidate="txtPONum" ValidationGroup="vEdit" />
     </td>
    </tr>
    <tr>
     <td align="right"><b>Vendor:</b></td>
     <td>
      <asp:DropDownList ID="ddlVendor" runat="server" DataSourceID="odsVendor" DataTextField="CompanyName" DataValueField="HID" SelectedValue='<%# Bind("VendorID") %>' />
      <asp:ObjectDataSource ID="odsVendor" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="getCompanyList">
       <SelectParameters>
        <asp:Parameter Name="ClassName" Type="String" DefaultValue="Supplier" />
        <asp:Parameter Name="TypeName" Type="String" DefaultValue="Material" />
        <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
       </SelectParameters>
      </asp:ObjectDataSource>
     </td>
    </tr>
   </table>
   <asp:Button ID="btnSave" runat="server" Text="Save" CommandName="Update" CssClass="NavBtn" ValidationGroup="vEdit"></asp:Button>
  </EditItemTemplate>
  <EmptyDataTemplate>There is no material for receiving</EmptyDataTemplate>
 </asp:FormView>

<ucMode:CurrentMode ID="myMode" runat="server" />

<asp:ObjectDataSource ID="odsMaterial" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Count_Select" UpdateMethod="Count_U">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="Type" Type="String" />
  <asp:Parameter Name="Ams" Type="String" />
  <asp:Parameter Name="Size" Type="String" />
  <asp:Parameter Name="HeatLot" Type="String" />
  <asp:Parameter Name="CertNo" Type="String" />
  <asp:Parameter Name="PONum" Type="String" />
  <asp:Parameter Name="VendorID" Type="Int32" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </UpdateParameters>
</asp:ObjectDataSource>