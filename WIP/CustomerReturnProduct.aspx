<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerReturnProduct.aspx.cs" Inherits="webApp.WIP.CustomerReturnProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title></title>
</head>
<body>
 <form id="form1" runat="server">
  <div>
   <b>CUSTOMER RETURNED PRODUCT</b>
   <aspx:ScriptManager ID="scrProduct" runat="server" EnablePartialRendering="true" EnablePageMethods="true" />
   <aspx:UpdatePanel ID="uPnlProduct" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
     <asp:FormView ID="fvProduct" runat="server" DataKeyNames="HID" DataSourceID="odsProduct" DefaultMode="ReadOnly" OnDataBound="fvBound" OnItemCommand="fvCmd" OnItemUpdating="fvUpdating">
      <ItemTemplate>
       <table style="border: solid 2px black; font-size: 14px;">
        <tr>
         <td style="border: solid 1px black;"><b>Date:</b><br /><%# Eval("ReturnedDate","{0:MM/dd/yyyy}") %></td>
         <td style="border: solid 1px black;"><b>Customer Document No.</b><br /><%# Eval("ScarNum") %></td>
         <td style="border: solid 1px black;"><b>MW Shipment No.</b><br /><%# Eval("PackNum") %></td>
         <td style="border: solid 1px black;"><b>Log No.</b><br /><%# Eval("HID") %></td>
        </tr>
        <tr>
         <td style="border: solid 1px black;"><b>Customer:</b><br /><%# Eval("CustomerName") %></td>
         <td style="border: solid 1px black;"><b>P.O. No.</b><br /><%# Eval("CustomerPO") %></td>
         <td style="border: solid 1px black;"><b>Part No.</b><br /><%# Eval("PartNumber") %></td>
         <td style="border: solid 1px black;"><b>Rev.</b><br /><%# Eval("Revision") %></td>
        </tr>
        <tr>
         <td colspan="2" style="border: solid 1px black;"><b>Description:</b><br /><%# Eval("Description") %></td>
         <td style="border: solid 1px black;"><b>Quantity Shipped:</b><br /><%# Eval("ShipQty") %></td>
         <td style="border: solid 1px black;"><b>Quantity Returned:</b><br /><%# Eval("ReturnedQty") %></td>
        </tr>
       </table>
       <br />
       <b>Non-conformance:</b><br /><%# Eval("NonConform") %><br /><br />
       <b>Cause of Non-conformance:</b><br /><%# Eval("CauseNonConform") %><br /><br />
       <b>Contributing Factor:</b><br /><%# Eval("ConFactor") %><br /><br />
       <b>Root Cause:</b><br /><%# Eval("RootCause") %><br /><br />
       <b>Disposition:</b> <%# Eval("Disposition") %><br /><br />
       <b>Corrective Action:</b> <%# Eval("CorrectiveAction") %> [<b>MWCar#:</b> <%# Eval("CarNum") %>]<br /><br />
       <b>Response By:</b> <%# Eval("ResponseDate", "{0:MM/dd/yyyy}") %><br /><br />
       <b>Approved By QA:</b> <%# Eval("AppByQa") %><br /><br />
       <b>Approved By Engineer:</b> <%# Eval("AppByEng") %><br /><br />
       <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="NavBtn" />
      </ItemTemplate>
      <EditItemTemplate>
       <table style="border: solid 2px black; font-size: 14px;">
        <tr>
         <td style="border: solid 1px black;"><b>Date:</b><br /><%# Eval("ReturnedDate","{0:MM/dd/yyyy}") %></td>
         <td style="border: solid 1px black;"><b>Customer Document No.</b><br /><%# Eval("ScarNum") %></td>
         <td style="border: solid 1px black;"><b>MW Shipment No.</b><br /><%# Eval("PackNum") %></td>
         <td style="border: solid 1px black;"><b>Log No.</b><br /><%# Eval("HID") %></td>
        </tr>
        <tr>
         <td style="border: solid 1px black;"><b>Customer:</b><br /><%# Eval("CustomerName") %></td>
         <td style="border: solid 1px black;"><b>P.O. No.</b><br /><%# Eval("CustomerPO") %></td>
         <td style="border: solid 1px black;"><b>Part No.</b><br /><%# Eval("PartNumber") %></td>
         <td style="border: solid 1px black;"><b>Rev.</b><br /><%# Eval("Revision") %></td>
        </tr>
        <tr>
         <td colspan="2" style="border: solid 1px black;"><b>Description:</b><br /><%# Eval("Description") %></td>
         <td style="border: solid 1px black;"><b>Quantity Shipped:</b><br /><%# Eval("ShipQty") %></td>
         <td style="border: solid 1px black;"><b>Quantity Returned:</b><br /><%# Eval("ReturnedQty") %></td>
        </tr>
       </table>
       <br />
       <b>Non-conformance:</b><br />
       <asp:TextBox ID="txtNonConform" runat="server" Text='<%# Bind("NonConform") %>' TextMode="MultiLine" Width="650px" Height="100px"></asp:TextBox><br /><br />
       <b>Cause of Non-conformance:</b><br />
       <asp:TextBox ID="txtCauseNonConform" runat="server" Text='<%# Bind("CauseNonConform") %>' TextMode="MultiLine" Width="650px" Height="100px"></asp:TextBox><br /><br />
       <b>Contributing Factor:</b><br />
       <asp:TextBox ID="txtConFactor" runat="server" Text='<%# Bind("ConFactor") %>' TextMode="MultiLine" Width="650px" Height="100px"></asp:TextBox><br /><br />
       <b>Root Cause:</b><br />
       <asp:TextBox ID="txtRootCause" runat="server" Text='<%# Bind("RootCause") %>' TextMode="MultiLine" Width="650px" Height="100px"></asp:TextBox><br /><br />
       <b>Disposition</b><br />
       <asp:DropDownList ID="ddlDisposition" runat="server" SelectedValue='<%# Bind("Disposition") %>'>
        <asp:ListItem Text="" Value=""></asp:ListItem>
        <asp:ListItem Text="Scrapped" Value="Scrapped"></asp:ListItem>
        <asp:ListItem Text="Rework" Value="Rework"></asp:ListItem>
       </asp:DropDownList>
       <br /><br />
       <b>Corrective Action</b><br />
       <asp:DropDownList ID="ddlCorrectiveAction" runat="server" SelectedValue='<%# Bind("CorrectiveAction") %>'>
        <asp:ListItem Text="" Value=""></asp:ListItem>
        <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
        <asp:ListItem Text="No" Value="No"></asp:ListItem>
       </asp:DropDownList>
       <asp:Button ID="btnCreateCar" runat="server" Text="Create MWCAR#" CommandName="CreateMWCar" CommandArgument='<%# Eval("HID") %>' CssClass="NavBtn" />
       [<b>MWCar#:</b> <asp:Literal ID="litCarNum" runat="server" Text='<%# Eval("CarNum") %>'></asp:Literal>]
       <br /><br />
       <b>Response By:</b><br />
       <asp:TextBox ID="txtResponseDate" runat="server" Text='<%# Bind("ResponseDate") %>'></asp:TextBox>
       <ajax:CalendarExtender ID="calResponseDate" runat="server" TargetControlID="txtResponseDate" Format="MM/dd/yyyy" />
       <br /><br />
       <b>Approved By QA:</b><br />
       <asp:TextBox ID="txtAppByQa" runat="server" Text='<%# Bind("AppByQa") %>'></asp:TextBox><br /><br />
       <b>Approved By Engineer:</b><br />
       <asp:TextBox ID="txtAppByEng" runat="server" Text='<%# Bind("AppByEng") %>'></asp:TextBox><br /><br />
       <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="Save" CssClass="NavBtn" />
       <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="NavBtn" />
      </EditItemTemplate>
     </asp:FormView>
     <MW:Message ID="iMsg" runat="server" />
    </ContentTemplate>
   </aspx:UpdatePanel>
   <asp:ObjectDataSource ID="odsProduct" runat="server" TypeName="myBiz.DAL.clsCustomerReturnLog" SelectMethod="GetProduct" UpdateMethod="SaveProduct">
    <SelectParameters><asp:QueryStringParameter Name="HID" Type="Int32" QueryStringField="HID" /></SelectParameters>
    <UpdateParameters>
     <asp:Parameter Name="HID" Type="Int32" />
     <asp:Parameter Name="NonConform" Type="String" />
     <asp:Parameter Name="CauseNonConform" Type="String" />
     <asp:Parameter Name="ConFactor" Type="String" />
     <asp:Parameter Name="RootCause" Type="String" />
     <asp:Parameter Name="Disposition" Type="String" />
     <asp:Parameter Name="CorrectiveAction" Type="String" />
     <asp:Parameter Name="ResponseDate" Type="DateTime" />
     <asp:Parameter Name="AppByQa" Type="String" />
     <asp:Parameter Name="AppByEng" Type="String" />
    </UpdateParameters>
   </asp:ObjectDataSource>
  </div>
 </form>
</body>
</html>