<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.JobHeader" Codebehind="JobHeader.ascx.cs" %>
<asp:FormView ID="fvHeader" runat="server" DataSourceID="odsHeader" DataKeyNames="HID" OnItemCommand="fvCmd">
 <ItemTemplate>
  <table cellspacing="5" cellpadding="5" style="border: solid 1px black; font-size: 14px;">
   <tr>
    <td style="border-top: solid 0px black; border-left: solid 0px black;"><b>WO#:</b> <%# Eval("WorkOrder") %></td>
    <td style="border-top: solid 0px black; border-left: solid 1px gray;"><b>Customer ID:</b> <%# Eval("CompanyID") %></td>
    <td style="border-top: solid 0px black; border-left: solid 1px gray;"><b>Due Date:</b> <asp:Literal ID="litDueDate" runat="server" Text='<%# Eval("DueDate") %>' /></td>
   </tr>
   <tr>
    <td style="border-top: solid 1px gray; border-left: solid 0px black;"><b>Part No. Rev.:</b> <asp:LinkButton ID="lnkBP" runat="server" CommandName="BluePrint" CommandArgument='<%# Eval("PartID") %>' Text='<%# string.Format("{0} Rev {1}", Eval("PartNumber"), Eval("Revision")) %>'></asp:LinkButton></td>
    <td style="border-top: solid 1px gray; border-left: solid 1px gray;"><b>Part Name:</b> <%# Eval("PartName") %>&nbsp;</td>
    <td style="border-top: solid 1px gray; border-left: solid 1px gray;"><b>PO#:</b> <asp:LinkButton ID="lnkCPO" runat="server" CommandName="CustomerPO" CommandArgument='<%# Eval("CustPOID") %>' Text='<%# Eval("CustomerPO") %>' />; <b>Line#:</b> <%# Eval("Line") %>; <b>Job#:</b> <%# Eval("CustJob") %></td>
   </tr>
   <tr>
    <td style="border-top: solid 1px gray; border-left: solid 0px black;"><b>Qty Ordered:</b> <asp:LinkButton ID="lnkPL" runat="server" Text='<%# Eval("oQty") %>' OnClientClick='<%# gLnk() %>'></asp:LinkButton></td>
    <td style="border-top: solid 1px gray; border-left: solid 1px gray;"><b>Qty to Make:</b> <%# Eval("mQty") %></td>
    <td style="border-top: solid 1px gray; border-left: solid 1px gray;"><b>Make for:</b> <%# Eval("MakeFor") %></td>
   </tr>
  </table>
 </ItemTemplate>
</asp:FormView>

<asp:Panel ID="pnlPopup" runat="server" />

<asp:ObjectDataSource ID="odsHeader" runat="server" TypeName="myBiz.DAL.clsWorkOrder" SelectMethod="SelectWithMakeFor">
 <SelectParameters><asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" /></SelectParameters>
</asp:ObjectDataSource>