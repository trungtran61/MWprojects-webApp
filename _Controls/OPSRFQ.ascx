<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.OPSRFQ" Codebehind="OPSRFQ.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>RFQ FOR OPS</h3>

Please select the item(s) that you wish to create RFQ for OPS;<br />then click Submit button to create RFQ for selected item(s).<br /><br />
<asp:Panel ID="pnlTask" runat="server" Enabled="false">
   <asp:GridView ID="gvItems" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="HID" DataSourceID="odsItems" ForeColor="#333333" GridLines="None" OnRowDataBound="rwBound">
    <RowStyle BackColor="#EFF3FB" />
    <Columns>
     <asp:TemplateField>
      <HeaderTemplate><input id="chkAlls" type="checkbox" name="chkAlls" onclick="javascript:chkAll(this,true);" /></HeaderTemplate>
      <ItemTemplate>
       <asp:CheckBox ID="chkItem" runat="server" />
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Items #" SortExpression="ItemNo" DataField="ItemNo" />
     <asp:BoundField HeaderText="Description" SortExpression="viewDescription" DataField="viewDescription" ItemStyle-Width="900px" />
     <asp:BoundField HeaderText="Qty" SortExpression="Qty" DataField="Qty" />
     <asp:BoundField HeaderText="Unit" SortExpression="Unit" DataField="Unit" />
    </Columns>
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#9999CC" />
    <AlternatingRowStyle BackColor="White" />
    <EmptyDataTemplate>Sorry! You have no item to create RFQ!</EmptyDataTemplate>
   </asp:GridView>
   <br />
 <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="NavBtn" />
 <br /><br />
 <asp:DropDownList ID="ddlRFQ" runat="server" DataSourceID="odsRFQ" DataTextField="RFQNumber" DataValueField="RFQNumber" AutoPostBack="true" OnDataBound="rfqBound" OnSelectedIndexChanged="rfqSelected" />
 <asp:Button ID="btnPreview" runat="server" Text="Preview" CssClass="NavBtn" Enabled="false" />
 <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="deleteRFQ" CssClass="NavBtn" OnClientClick="return confirm('Are you sure you want to delete?');" />
 <MW:Message ID="iMsg" runat="server" />
</asp:Panel>
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:HiddenField ID="hfChkBox" runat="server" />

<asp:ObjectDataSource ID="odsItems" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="Select_Items" InsertMethod="RFQ_Insert">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </SelectParameters>
 <InsertParameters>
  <asp:Parameter Name="TaskID" Type="String" />
  <asp:Parameter Name="ItemID" Type="String" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </InsertParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsRFQ" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="Distinct_RFQ">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </SelectParameters>
</asp:ObjectDataSource>

<script language="javascript" type="text/javascript">
 function chkAll(chk, isAll) {
  var myBoxes = document.getElementById('<%= hfChkBox.ClientID %>').value.split(':');
  var len = myBoxes.length;
  var Cnt = 0;
  for (var i = 0; i < len; i++) {
   if (isAll) document.getElementById(myBoxes[i]).checked = chk.checked;
   else if (document.getElementById(myBoxes[i]).checked) Cnt++;
  }
  if (!isAll) document.getElementById('chkAlls').checked = Cnt == len;
 }
</script>