<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.JobMaterial" Codebehind="JobMaterial.ascx.cs" %>

 <asp:FormView ID="fvMaterial" runat="server" DefaultMode="ReadOnly" DataSourceID="odsMaterial" DataKeyNames="HID">
  <ItemTemplate>
   <table>
    <tr><td align="right"><b>WO#:</b></td><td colspan="3"><%# Eval("WorkOrder") %></td></tr>
    <tr>
     <td align="right"><b>PN:</b></td><td><%# Eval("PartNumber") %></td>
     <td align="right"><b>REV#:</b></td><td><%# Eval("Revision") %></td>
    </tr>
    <tr>
     <td align="right"><b>PO#:</b></td><td><%# Eval("PONum") %></td>
     <td align="right"><b>Cert#:</b></td><td><%# Eval("CertNo") %></td>
    </tr>
    <tr>
     <td align="right"><b>Type:</b></td><td><%# Eval("Type") %></td>
     <td align="right"><b>Ams#:</b></td><td><%# Eval("Ams") %></td>
    </tr>
    <tr>
     <td align="right"><b>HeatLot#:</b></td><td><%# Eval("HeatLot") %></td>
     <td align="right"><b>Size:</b></td><td><%# Eval("Size") %> <%# Eval("Unit") %></td>
    </tr>
    <tr><td align="right"><b>Total:</b></td><td colspan="3"><%# Eval("GoodCnt") %></td></tr>
    <tr><td align="right"><b>Vendor:</b></td><td colspan="3"><%# Eval("CompanyName") %></td></tr>
    <tr><td align="right"><b>By:</b></td><td colspan="3"><%# Eval("FullName") %></td></tr>
   </table>
  </ItemTemplate>
 </asp:FormView>

<MW:Print ID="btnPrint" runat="server" CssClass="NavBtn" PrintButton="Print Tag" OnInit="prtInit" />
<asp:Literal ID="litTags" runat="server"></asp:Literal>

<asp:ObjectDataSource ID="odsMaterial" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Tag_Select">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="isTop" Type="String" DefaultValue="Y" />
 </SelectParameters>
</asp:ObjectDataSource>