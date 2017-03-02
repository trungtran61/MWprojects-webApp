<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="NewRFQEntry.aspx.cs" Inherits="webApp.RFQ.NewRFQEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
<aspx:UpdatePanel ID="uPnlSearch" runat="server" UpdateMode="Conditional">
 <ContentTemplate>
  <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
   <table>
    <tr>
     <td><b>Part Number:</b></td>
     <td><b>Quote #:</b></td>
     <td><b>Customer:</b></td>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td>
      <asp:TextBox ID="txtPN" runat="server"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="acePartNumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtPN">
      </ajax:AutoCompleteExtender>
     </td>
     <td>
      <asp:TextBox ID="txtRFQ" runat="server"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="aceRFQ" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetRFQ" TargetControlID="txtRFQ" />
     </td>
     <td><asp:TextBox ID="txtCN" runat="server"></asp:TextBox></td>
     <td valign="bottom"><asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" /> <asp:Button ID="btnNew" runat="server" Text="Add New" Enabled="false" OnClick="btnNew_Click" /></td>
    </tr>
    <tr>
     <td colspan="3"><MW:Message ID="jMsg" runat="server" /></td>
    </tr>
   </table><br />
   Next RFQ#: <%= (new clsRFQ()).NextRFQ %><br />
   <asp:GridView ID="gvSearch" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="HID" DataSourceID="odsSearch" ForeColor="#333333" GridLines="None" OnPreRender="gv_PreRender" OnSelectedIndexChanged="gv_Changed" OnRowDataBound="Rw_Bound">
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <RowStyle BackColor="#EFF3FB" />
    <Columns>
     <asp:TemplateField HeaderText="Quote" SortExpression="RFQ">
      <ItemTemplate>
       <asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("RFQ") %>' />
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Part Number" DataField="PartNumber" SortExpression="PartNumber" InsertVisible="false" />
     <asp:BoundField HeaderText="Revision" DataField="Revision" SortExpression="Revision" InsertVisible="false" />
     <asp:BoundField HeaderText="UnitPrice" DataField="UnitPrice" SortExpression="UnitPrice" DataFormatString="{0:C}" InsertVisible="false" />
     <asp:BoundField HeaderText="CustomerName" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" />
     <asp:BoundField HeaderText="Customer RFQ#" DataField="CustomerRFQ" SortExpression="CustomerRFQ" InsertVisible="false" />
    </Columns>
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#9999CC" />
    <AlternatingRowStyle BackColor="White" />
   </asp:GridView>
  </asp:Panel>
  <asp:ObjectDataSource ID="odsSearch" runat="server" TypeName="myBiz.DAL.clsRFQ" SelectMethod="Select">
   <SelectParameters>
    <asp:ControlParameter ControlID="txtRFQ" PropertyName="Text" Name="RFQ" Type="String" />
    <asp:ControlParameter ControlID="txtPN" PropertyName="Text" Name="PartNumber" Type="String" />
    <asp:ControlParameter ControlID="txtCN" PropertyName="Text" Name="CustomerName" Type="String" />
    <asp:Parameter Name="isPB" Type="Boolean" />
   </SelectParameters>
  </asp:ObjectDataSource>
 </ContentTemplate>
 <Triggers><aspx:AsyncPostBackTrigger ControlID="btnBack" EventName="Click" /></Triggers>
</aspx:UpdatePanel>
<aspx:UpdatePanel ID="uPnlAddNew" runat="server" UpdateMode="Conditional">
 <ContentTemplate>
  <asp:Panel ID="pnlAddNew" runat="server" Visible="false">
   Next RFQ#: <%= (new clsRFQ()).NextRFQ %><br />
   <table style="background-color:Silver">
    <tr>
     <td><b>Quote:</b><br /><asp:TextBox ID="txtQuote" runat="server" Width="100px" /></td>
     <td><b>Customer Job#:</b><br /><asp:TextBox ID="txtCustJob" runat="server" Width="150px" /></td>
     <td><b>Customer Name:</b><br /><asp:DropDownList ID="ddlCustomerID" runat="server" DataSourceID="odsCompanyList" DataTextField="CompanyName" DataValueField="HID" Width="350px"></asp:DropDownList></td>
    </tr>
    <tr>
     <td><b>Customer RFQ#:</b><br /><asp:TextBox ID="txtCustomerRFQ" runat="server" Width="100px" /></td>
     <td><b>Line#:</b><br /><asp:TextBox ID="txtLine" runat="server" Width="40px" /></td>
     <td>
      <table>
       <tr>
        <td><b>Part Number:</b><br /><asp:TextBox ID="txtPartNumber" runat="server" Width="250px" /></td>
        <td><b>Rev:</b><br /><asp:TextBox ID="txtRevision" runat="server" Width="50px" /></td>
       </tr>
      </table>
     </td>
    </tr>
    <tr>
     <td colspan="3">
      <b>Order Qty(s):</b><br />
      <asp:PlaceHolder ID="plhOrderQty" runat="server">
       <asp:TextBox ID="txtOrderQty1" runat="server" Width="50px"></asp:TextBox>
       <asp:TextBox ID="txtOrderQty2" runat="server" Width="50px" Visible="false"></asp:TextBox>
       <asp:TextBox ID="txtOrderQty3" runat="server" Width="50px" Visible="false"></asp:TextBox>
       <asp:TextBox ID="txtOrderQty4" runat="server" Width="50px" Visible="false"></asp:TextBox>
       <asp:TextBox ID="txtOrderQty5" runat="server" Width="50px" Visible="false"></asp:TextBox>
       <asp:TextBox ID="txtOrderQty6" runat="server" Width="50px" Visible="false"></asp:TextBox>
       <asp:TextBox ID="txtOrderQty7" runat="server" Width="50px" Visible="false"></asp:TextBox>
       <asp:TextBox ID="txtOrderQty8" runat="server" Width="50px" Visible="false"></asp:TextBox>
       <asp:TextBox ID="txtOrderQty9" runat="server" Width="50px" Visible="false"></asp:TextBox>
       <asp:TextBox ID="txtOrderQty10" runat="server" Width="50px" Visible="false"></asp:TextBox>
       <asp:TextBox ID="txtOrderQty11" runat="server" Width="50px" Visible="false"></asp:TextBox>
       <asp:TextBox ID="txtOrderQty12" runat="server" Width="50px" Visible="false"></asp:TextBox>
      </asp:PlaceHolder>
      <asp:LinkButton ID="lnkNewBox" runat="server" Text="More" OnClick="newBox"></asp:LinkButton>
      <asp:HiddenField ID="hfBoxCount" runat="server" Value="1" />
     </td>
    </tr>
    <tr>
     <td colspan="2"><b>Unit Price:</b><br />$<asp:TextBox ID="txtUnitPrice" runat="server" Width="75px" Text="0" Enabled="false" /></td>
     <td><b>Due Date:</b><br />
      <asp:TextBox ID="txtDueDate" runat="server" Width="180px" />
      <ajax:CalendarExtender ID="calDueDate" runat="server" TargetControlID="txtDueDate" Format="MM/dd/yy hh:mm tt" OnClientDateSelectionChanged="setDate" />
     </td>
    </tr>
    <tr>
     <td colspan="3"><b>Description:</b><br /><asp:TextBox ID="txtDescription" runat="server" TextMode="multiLine" Width="600px" Height="100px"></asp:TextBox></td>
    </tr>
    <tr>
     <td colspan="4"><b>Description for Router:</b><br /><asp:TextBox ID="txtRouterDesc" runat="server" TextMode="multiLine" Width="600px" Height="100px"></asp:TextBox></td>
    </tr>
   </table><br /><br />
   <asp:Button ID="btnSave" runat="server" Text="Save New Quote" OnClick="btnSave_Click" />
   <asp:Button ID="btnBack" runat="server" Text="Back to Search" OnClick="btnBack_Click" />
   <br /><MW:Message ID="iMsg" runat="server" />
  </asp:Panel>
  <asp:ObjectDataSource ID="odsCompanyList" runat="server" TypeName="myBiz.DAL.clsRFQ" SelectMethod="CustomerList"></asp:ObjectDataSource>
 </ContentTemplate>
 <Triggers>
  <aspx:AsyncPostBackTrigger ControlID="btnNew" EventName="Click" />
  <aspx:AsyncPostBackTrigger ControlID="gvSearch" EventName="SelectedIndexChanged" />
 </Triggers>
</aspx:UpdatePanel>
</asp:Content>