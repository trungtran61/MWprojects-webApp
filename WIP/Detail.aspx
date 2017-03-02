<%@ Page Language="C#" MasterPageFile="~/_MasterPage/myPopup.master" AutoEventWireup="true" Inherits="webApp.WIP.Detail" Title="Work Order Detail" Codebehind="Detail.aspx.cs" %>
<%@ Register Src="~/_Controls/ucFileCnt.ascx" TagName="ucFileCnt" TagPrefix="ucFileC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" Runat="Server">
 <aspx:UpdatePanel ID="uPnlDetail" runat="server">
  <ContentTemplate>
   <asp:FormView ID="fvDetail" runat="server" DataSourceID="odsDetail" DataKeyNames="HID" OnItemUpdating="fvUpdating" OnPreRender="fvPreRender" OnItemCommand="fvCmd" OnDataBound="fvBound">
    <ItemTemplate>
     <table style="background-color:Silver">
      <tr>
       <td valign="top"><b>Work Order:</b> <%# Eval("WorkOrder") %></td>
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
       <td valign="top"><b>Customer PO#:</b> <%# Eval("CustomerPO") %></td>
       <td valign="top"><b>Line#:</b> <%# Eval("Line") %></td>
       <td valign="top"><b>Part Number:</b> <%# Eval("PartNumber") %></td>
       <td valign="top"><b>Rev:</b> <%# Eval("Revision") %></td>
      </tr>
      <tr>
       <td valign="top"><b>Order Qty:</b> <%# Eval("oQty") %></td>
       <td valign="top"><b>Unit Price:</b> <asp:Literal ID="litUnitPrice" runat="server" Text='<%# Eval("UnitPrice", "{0:$0.00}") %>' /><asp:TextBox ID="txtUnitPrice" runat="server" Text='<%# Eval("UnitPrice", "{0:0.00}") %>' Width="100px" Visible="false" /></td>
       <td valign="top"><b>Qty Need:</b> <%# Eval("nQty") %></td>
       <td valign="top"><b>Due Date:</b> <asp:Literal ID="litDueDate" runat="server" Text='<%# Eval("DueDate", "{0:MM/dd/yy hh:mm tt}")%>' /></td>
      </tr>
      <tr>
       <td valign="top" colspan="4"><b>Description:</b><div style="max-width:950px; max-height:550px; overflow:auto;"><%# Util.NewLine(Eval("Description")) %></div><br /><br /></td>
      </tr>
      <tr>
       <td valign="top" colspan="4"><b>Description for Traveler:</b><div style="max-width:750px; max-height:250px; overflow:auto;"><%# Util.NewLine(Eval("TravelDesc")) %></div></td>
      </tr>
     </table><br /><br />
     <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CssClass="NavBtn" />
     <asp:Button ID="btnReport" runat="server" Text="Show Report" CommandName="ShowReport" CssClass="NavBtn" />
     <asp:Button ID="btnEditSpec" runat="server" Text="Edit Special" CommandName="EditSpec" CssClass="NavBtn" />
     <asp:Button ID="btnCanSpec" runat="server" Text="Cancel" CommandName="CanSpec" CssClass="NavBtn" Visible="false" />
     <asp:HiddenField ID="hfStatus" runat="server" Value='<%# Eval("Status") %>' />
    </ItemTemplate>
    <EditItemTemplate>
     <table style="background-color:Silver">
      <tr>
       <td><b>Work Order:</b><br /><asp:TextBox ID="txtWorkOrder" runat="server" Text='<%# Bind("WorkOrder") %>' Enabled='<%# Eval("ChildID").ToString().Equals("0") %>' Width="100px" /></td>
       <td><b>Customer Job#:</b><br /><asp:TextBox ID="txtCustJob" runat="server" Text='<%# Bind("CustJob") %>' Width="100px" /></td>
       <td colspan="2"><b>Customer Name:</b><asp:Literal ID="litCompanyName" runat="server" Text=" N/A" />
        <br /><asp:DropDownList ID="ddlCustomerID" runat="server" DataSourceID="odsCompanyList" DataTextField="CompanyName" DataValueField="HID" SelectedValue='<%# Bind("CustomerID") %>'></asp:DropDownList>
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
       <td><b>Customer PO#:</b><br /><asp:TextBox ID="txtCustomerPO" runat="server" Text='<%# Bind("CustomerPO") %>' Width="100px" /></td>
       <td><b>Line#:</b><br /><asp:TextBox ID="txtLine" runat="server" Text='<%# Bind("Line") %>' Width="50px" /></td>
       <td><b>Part Number:</b><br /><asp:TextBox ID="txtPartNumber" runat="server" Text='<%# Bind("PartNumber") %>' /></td>
       <td><b>Rev:</b><br /><asp:TextBox ID="txtRevision" runat="server" Text='<%# Bind("Revision") %>' Width="50px" /></td>
      </tr>
      <tr>
       <td><b>Order Qty:</b><br /><asp:TextBox ID="txtoQty" runat="server" Text='<%# Bind("oQty") %>' Width="100px" /></td>
       <td><b>Unit Price:</b><br />$<asp:TextBox ID="txtUnitPrice" runat="server" Text='<%# Bind("UnitPrice", "{0:0.00}") %>' Width="100px" />
        <asp:Literal ID="litUnitPrice" runat="server" Text="N/A" />
       </td>
       <td class="2"><b>Due Date:</b><br />
        <asp:Literal ID="litDueDate" runat="server" Text="N/A" />
        <asp:TextBox ID="txtDueDate" runat="server" Width="110px" Text='<%# Bind("DueDate") %>' />
        <ajax:CalendarExtender ID="calDueDate" runat="server" TargetControlID="txtDueDate" Format="MM/dd/yy hh:mm tt" />
       </td>
      </tr>
      <tr>
       <td colspan="4"><b>Description:</b><br /><asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' TextMode="multiLine" Width="950px" Height="550px"></asp:TextBox></td>
      </tr>
      <tr>
       <td colspan="4"><b>Description for Traveler:</b><br /><asp:TextBox ID="txtTravelDesc" runat="server" Text='<%# Bind("TravelDesc") %>' TextMode="multiLine" Width="950px" Height="550px"></asp:TextBox></td>
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
   <asp:LinkButton ID="lnkTraveler" runat="server" Text='View Traveler' OnLoad="lTral" />
   <asp:GridView ID="gvError" runat="server" SkinID="GrayHeader" PageSize="500" DataSourceID="odsError">
    <Columns>
     <asp:BoundField HeaderText="Dept" DataField="Dept" SortExpression="Dept" InsertVisible="false" />
     <asp:BoundField HeaderText="ID" DataField="TaskID" SortExpression="TaskID" InsertVisible="false" />
     <asp:BoundField HeaderText="M.O.T. OP#" DataField="OpNo" SortExpression="OpNo" InsertVisible="false" />
     <asp:BoundField HeaderText="Name" DataField="TaskName" SortExpression="TaskName" InsertVisible="false" />
    </Columns>
   </asp:GridView>
   <ucFileC:ucFileCnt ID="ucFile" runat="server" WOID="0" />
   <br /><br />
   <asp:Button ID="btnCheckInventory" runat="server" Text="Undo Check Inventory" OnClick="doCheck" CssClass="NavBtn" Visible="false" />
   <asp:Button ID="btnUseWO" runat="server" Text="Undo Use Other" OnClick="undoUseWO" CssClass="NavBtn" Visible="false" />

   <asp:ObjectDataSource ID="odsError" runat="server" TypeName="myBiz.DAL.clsWorkOrder" SelectMethod="Update">
    <SelectParameters>
     <asp:QueryStringParameter Name="WOID" Type="String" QueryStringField="WOID" />
     <asp:Parameter Name="Status" Type="String" />
     <asp:Parameter Name="isUpdate" Type="Boolean" DefaultValue="False" />
    </SelectParameters>
   </asp:ObjectDataSource>
   <asp:ObjectDataSource ID="odsDetail" runat="server" TypeName="myBiz.DAL.clsWorkOrder" SelectMethod="Select" UpdateMethod="Update">
    <SelectParameters>
     <asp:QueryStringParameter Name="HID" Type="String" QueryStringField="WOID" />
     <asp:Parameter Name="isPB" Type="Boolean" DefaultValue="true" />
    </SelectParameters>
    <UpdateParameters>
     <asp:Parameter Name="HID" Type="Int32" />
     <asp:Parameter Name="WorkOrder" Type="String" />
     <asp:Parameter Name="PartNumber" Type="String" />
     <asp:Parameter Name="Revision" Type="String" />
     <asp:Parameter Name="CustomerID" Type="Int32" />
     <asp:Parameter Name="CustomerPO" Type="String" />
     <asp:Parameter Name="Line" Type="String" />
     <asp:Parameter Name="CustJob" Type="String" />
     <asp:Parameter Name="oQty" Type="Int32" />
     <asp:Parameter Name="UnitPrice" Type="String" />
     <asp:Parameter Name="Description" Type="String" />
     <asp:Parameter Name="TravelDesc" Type="String" />
     <asp:Parameter Name="Status" Type="String" />
     <asp:Parameter Name="DueDate" Type="String" />
    </UpdateParameters>
   </asp:ObjectDataSource>
  </ContentTemplate>
 </aspx:UpdatePanel>
 
 <telerik:RadWindowManager ID="radWindow" runat="server" Skin="Vista" Title="Modal Popup">
  <Windows>
   <telerik:RadWindow ID="mPopup" runat="server" Title="Modal Popup" Height="450px" 
    Width="800px" Left="150px" ReloadOnShow="true" VisibleStatusbar="false" ShowContentDuringLoad="false" Modal="true" Skin="Vista" VisibleTitlebar="true" />
  </Windows>
 </telerik:RadWindowManager>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript" language="javascript">
  function lFrame(url) {
   document.getElementById('frmPartTag').src = url;
  }
  function loadPreview(id)
  {
   window.radopen("../File/Preview.aspx?FID=PackingList&Code=PackingList&HID=" + id, "preview").maximize();
  }
  function loadC(frm,cd,id)
  {
   window.radopen("../File/Preview.aspx?FID=" + frm + "&Code=" + cd + "&HID=" + id, "preview").maximize();
  }
  function loadPView(id)
  {
   window.radopen("../File/ShowImage.aspx?PackID=" + id, "preview").maximize();
  }
  function loadUpload(cmd)
  {
   window.radopen("../File/Upload.aspx?cmd=" + cmd, "preview").maximize();
  }
  function lPopup(xURL) { window.radopen(xURL, "mPopup").maximize(); }
 </script>
</telerik:RadCodeBlock>
 
</asp:Content>