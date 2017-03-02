<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Qty2Make" Codebehind="Qty2Make.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Create Quantity to Make</h3>
<b>Current work order detail:</b><br />
<u>Quantity Order:</u> <asp:Literal ID="litoQty" runat="server"></asp:Literal><br />
<u>Quantity to Make:</u> <asp:Literal ID="litmQty" runat="server"></asp:Literal><br />
<u>Use Work Order:</u> <asp:Literal ID="litUseWO" runat="server"></asp:Literal><br />
<u>Calculating QTY Made:</u> <asp:Label ID="lblCount" runat="server" Text="0" /><br />
<br />
Please click on the <b><u><%= myMode.ActionName %></u></b> button below to start creating the quantity to make for this work order.
<br /><br />
<asp:GridView ID="gvQ2M" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="HID" ForeColor="#333333" GridLines="None" OnDataBound="gvBound">
 <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
 <RowStyle BackColor="#EFF3FB" />
 <Columns>
  <asp:BoundField HeaderText="Work Order" DataField="WorkOrder" SortExpression="WorkOrder" />
  <asp:BoundField HeaderText="Qty Order" DataField="oQty" SortExpression="oQty" />
  <asp:BoundField HeaderText="Due Date" DataField="DueDate" SortExpression="DueDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" />
  <asp:TemplateField>
   <ItemTemplate>
    <asp:CheckBox ID="chkUse" runat="server" Checked='<%# Eval("isUse") %>' Enabled='<%# Eval("isUndo") %>' />
   </ItemTemplate>
  </asp:TemplateField>
 </Columns>
 <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
 <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
 <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
 <EditRowStyle BackColor="#9999CC" />
 <AlternatingRowStyle BackColor="White" />
</asp:GridView>
<br />
<asp:Button ID="btnSave" runat="server" Text="Submit" Visible="False" OnClick="btn_Submit" CssClass="NavBtn" />
<asp:Button ID="btnClear" runat="server" Text="Clear" Visible="False" CssClass="NavBtn" OnClientClick="return confirm('Are you sure you want to clear?');" OnClick="btn_Clear" />
<MW:Message ID="iMsg" runat="server" />

<ucMode:CurrentMode ID="myMode" runat="server" />

<asp:ObjectDataSource ID="odsQ2M" runat="server" TypeName="myBiz.DAL.clsQty2Make" SelectMethod="Select" UpdateMethod="Update">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </SelectParameters>
 <UpdateParameters>
  <asp:QueryStringParameter Name="ID" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="IDs" Type="String" />
 </UpdateParameters>
</asp:ObjectDataSource>