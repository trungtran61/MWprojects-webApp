<%@ Page Language="C#" MasterPageFile="~/_MasterPage/myPopup.master" AutoEventWireup="true" Inherits="webApp.RFQ.Detail" Title="Quote Detail" Codebehind="Detail.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" Runat="Server">
 <aspx:UpdatePanel ID="uPnlDetail" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <asp:FormView ID="fvDetail" runat="server" DataSourceID="odsDetail" DataKeyNames="HID" OnItemUpdating="fvUpdating" OnPreRender="fvPreRender" OnItemCommand="fvCmd" OnDataBound="fvBound">
    <ItemTemplate>
     <table style="background-color:Silver">
      <tr>
       <td valign="top"><b>Quote:</b> <%# Eval("RFQ") %></td>
       <td valign="top"><b>Customer Job#:</b> <%# Eval("CustJob") %></td>
       <td valign="top" colspan="2"><b>Customer Name:</b> <asp:Literal ID="litCompanyName" runat="server" Text='<%# Eval("CompanyName") %>' />
        <asp:DropDownList ID="ddlCustomerID" runat="server" DataSourceID="odsCompanyList" DataTextField="CompanyName" DataValueField="HID" SelectedValue='<%# Eval("CustomerID") %>' Visible="false"></asp:DropDownList>
        <asp:ObjectDataSource ID="odsCompanyList" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="getCompanyList">
         <SelectParameters>
          <asp:Parameter Name="ClassName" Type="String" DefaultValue="Customer" />
          <asp:Parameter Name="TypeName" Type="String" DefaultValue="Customer" />
          <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
         </SelectParameters>
        </asp:ObjectDataSource>
       </td>
      </tr>
      <tr>
       <td valign="top"><b>Customer RFQ#:</b> <%# Eval("CustomerRFQ") %></td>
       <td valign="top"><b>Line#:</b> <%# Eval("Line") %></td>
       <td valign="top"><b>Part Number:</b> <%# Eval("PartNumber") %></td>
       <td valign="top"><b>Rev:</b> <%# Eval("Revision") %></td>
      </tr>
      <tr>
       <td valign="top"><b>Order Qty:</b> <%# Eval("mulQty") %></td>
       <td valign="top"><b>Unit Price:</b> <asp:Literal ID="litUnitPrice" runat="server" Text='<%# Eval("UnitPrice", "{0:$0.00}") %>' /><asp:TextBox ID="txtUnitPrice" runat="server" Text='<%# Eval("UnitPrice", "{0:0.00}") %>' Width="100px" Visible="false" /></td>
       <td valign="top" colspan="2"><b>Due Date:</b> <asp:Literal ID="litDueDate" runat="server" Text='<%# Eval("DueDate", "{0:MM/dd/yy hh:mm tt}")%>' /></td>
      </tr>
      <tr>
       <td valign="top" colspan="4"><b>Description:</b> <%# Util.NewLine(Eval("Description")) %><br /><br /></td>
      </tr>
      <tr>
       <td valign="top" colspan="4"><b>Description for Router:</b> <%# Util.NewLine(Eval("RouterDesc")) %></td>
      </tr>
     </table><br /><br />
     <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CssClass="NavBtn" />
     <asp:Button ID="btnEditSpec" runat="server" Text="Edit Special" CommandName="EditSpec" CssClass="NavBtn" />
     <asp:Button ID="btnCanSpec" runat="server" Text="Cancel" CommandName="CanSpec" CssClass="NavBtn" Visible="false" />
     <asp:HiddenField ID="hfStatus" runat="server" Value='<%# Eval("Status") %>' />
    </ItemTemplate>
    <EditItemTemplate>
     <table style="background-color:Silver">
      <tr>
       <td><b>Quote:</b><br /><asp:TextBox ID="txtRFQ" runat="server" Text='<%# Bind("RFQ") %>' Width="100px" /></td>
       <td><b>Customer Job#:</b><br /><asp:TextBox ID="txtCustJob" runat="server" Text='<%# Bind("CustJob") %>' Width="150px" /></td>
       <td colspan="2"><b>Customer Name:</b><asp:Literal ID="litCompanyName" runat="server" Text=" N/A" />
        <br /><asp:DropDownList ID="ddlCustomerID" runat="server" DataSourceID="odsCompanyList" DataTextField="CompanyName" DataValueField="HID" SelectedValue='<%# Bind("CustomerID") %>' Width="350px"></asp:DropDownList>
        <asp:ObjectDataSource ID="odsCompanyList" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="getCompanyList">
         <SelectParameters>
          <asp:Parameter Name="ClassName" Type="String" DefaultValue="Customer" />
          <asp:Parameter Name="TypeName" Type="String" DefaultValue="Customer" />
          <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
         </SelectParameters>
        </asp:ObjectDataSource>
       </td>
      </tr>
      <tr>
       <td><b>Customer RFQ#:</b><br /><asp:TextBox ID="txtCustomerRFQ" runat="server" Text='<%# Bind("CustomerRFQ") %>' Width="100px" /></td>
       <td><b>Line#:</b><br /><asp:TextBox ID="txtLine" runat="server" Text='<%# Bind("Line") %>' Width="40px" /></td>
       <td><b>Part Number:</b><br /><asp:TextBox ID="txtPartNumber" runat="server" Text='<%# Bind("PartNumber") %>' Width="250px" /></td>
       <td><b>Rev:</b><br /><asp:TextBox ID="txtRevision" runat="server" Text='<%# Bind("Revision") %>' Width="50px" /></td>
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
        <asp:HiddenField ID="hfmulQty" runat="server" Value='<%# Eval("mulQty") %>' />
        <asp:HiddenField ID="hfhasRouter" runat="server" Value='<%# Eval("hasRouter") %>' />
        <asp:HiddenField ID="hfEnfQty" runat="server" Value='<%# Eval("EnfQty") %>' />
       </td>
      </tr>
      <tr>
       <td colspan="2"><b>Unit Price:</b><br />$<asp:TextBox ID="txtUnitPrice" runat="server" Text='<%# Bind("UnitPrice", "{0:0.00}") %>' Width="100px" Enabled="false" />
        <asp:Literal ID="litUnitPrice" runat="server" Text="N/A" />
       </td>
       <td class="2"><b>Due Date:</b><br />
        <asp:Literal ID="litDueDate" runat="server" Text="N/A" />
        <asp:TextBox ID="txtDueDate" runat="server" Width="180px" Text='<%# Bind("DueDate") %>' />
        <ajax:CalendarExtender ID="calDueDate" runat="server" TargetControlID="txtDueDate" Format="MM/dd/yy hh:mm tt" />
       </td>
      </tr>
      <tr>
       <td colspan="4"><b>Description:</b><br /><asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' TextMode="multiLine" Width="600px" Height="100px"></asp:TextBox></td>
      </tr>
      <tr>
       <td colspan="4"><b>Description for Router:</b><br /><asp:TextBox ID="txtRouterDesc" runat="server" Text='<%# Bind("RouterDesc") %>' TextMode="multiLine" Width="600px" Height="100px"></asp:TextBox></td>
      </tr>
     </table><br /><br />
     <b>Status:</b>
     <asp:DropDownList ID="ddlStatus" runat="server" SelectedValue='<%# Bind("Status") %>'>
      <asp:ListItem Value="Open" Text="Open"></asp:ListItem>
      <asp:ListItem Value="Cancel" Text="Cancel"></asp:ListItem>
     </asp:DropDownList>
     <asp:Button ID="btnSave" runat="server" Text="Save" CommandName="Update" CssClass="NavBtn" />
     <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" CssClass="NavBtn" />
    </EditItemTemplate>
   </asp:FormView>
   <MW:Message ID="iMsg" runat="server" /><br />
   <asp:ObjectDataSource ID="odsDetail" runat="server" TypeName="myBiz.DAL.clsRFQ" SelectMethod="Select" UpdateMethod="Update" OnUpdated="odsUpdated">
    <SelectParameters>
     <asp:QueryStringParameter Name="HID" Type="String" QueryStringField="RFQID" />
     <asp:Parameter Name="isPB" Type="Boolean" DefaultValue="true" />
    </SelectParameters>
    <UpdateParameters>
     <asp:Parameter Name="HID" Type="Int32" />
     <asp:Parameter Name="RFQ" Type="String" />
     <asp:Parameter Name="PartNumber" Type="String" />
     <asp:Parameter Name="Revision" Type="String" />
     <asp:Parameter Name="CustomerID" Type="Int32" />
     <asp:Parameter Name="CustomerRFQ" Type="String" />
     <asp:Parameter Name="Line" Type="String" />
     <asp:Parameter Name="CustJob" Type="String" />
     <asp:Parameter Name="mulQty" Type="String" />
     <asp:Parameter Name="UnitPrice" Type="Decimal" />
     <asp:Parameter Name="Description" Type="String" />
     <asp:Parameter Name="RouterDesc" Type="String" />
     <asp:Parameter Name="Status" Type="String" />
     <asp:Parameter Name="DueDate" Type="DateTime" />
    </UpdateParameters>
   </asp:ObjectDataSource>
  </ContentTemplate>
 </aspx:UpdatePanel>
</asp:Content>