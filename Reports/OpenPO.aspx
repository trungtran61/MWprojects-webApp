<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Reports.OpenPO" Title="Open PO Report for Customer" Codebehind="OpenPO.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
 <script language="javascript" type="text/javascript" src="../App_Themes/jquery-1.6.4.min.js"></script>
 <script language="javascript" type="text/javascript">
  function doOpen(x){
   $('#<%= hfUseField.ClientID %>').val(x);
   $find('<%= mpeAddress.ClientID %>').show();
  }
  function doOK(){
   var x = ''; var y;
   var cID = 'xAddress_';
   var Cnt = $('#<%= hfCnt.ClientID %>').val();
   
   for (var i = 0; i < Cnt; i++){
    y = document.getElementById(cID+i);
    if (y.checked) {
     if (x.length>0) x = x + ', ' + y.value;
     else x = y.value;
     y.checked = false;
    }
   }
   
   $('#' + $('#<%= hfUseField.ClientID %>').val()).val(x);
  }
 </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <h3>Open PO Report for Customer</h3>
 <table>
  <tr>
   <td><b>Customer Name</b></td>
   <td><b>Customer PO</b></td>
   <td><b>Line#</b></td>
   <td><b>Part#</b></td>
   <td><b>WO#</b></td>
   <td><b>Step Name</b></td>
   <td><b>Status</b></td>
  </tr>
  <tr>
   <td><asp:DropDownList ID="ddlCustomerName" runat="server" DataSourceID="odsCustomerName" DataValueField="HID" DataTextField="CompanyName" OnPreRender="ddlLoad"></asp:DropDownList></td>
   <td><asp:TextBox ID="txtPO" runat="server" Width="75px"></asp:TextBox></td>
   <td><asp:TextBox ID="txtLN" runat="server" Width="50px"></asp:TextBox></td>
   <td><asp:TextBox ID="txtPN" runat="server" Width="75px"></asp:TextBox></td>
   <td><asp:TextBox ID="txtWO" runat="server" Width="75px"></asp:TextBox></td>
   <td>
    <asp:DropDownList ID="ddlSN" runat="server">
     <asp:ListItem Text="" Value=""></asp:ListItem>
     <asp:ListItem Text="RIM" Value="RIM"></asp:ListItem>
     <asp:ListItem Text="Lathe" Value="Lathe"></asp:ListItem>
     <asp:ListItem Text="Mill" Value="Mill"></asp:ListItem>
     <asp:ListItem Text="OPS" Value="OPS"></asp:ListItem>
     <asp:ListItem Text="PAM" Value="PAM"></asp:ListItem>
     <asp:ListItem Text="HF" Value="HF"></asp:ListItem>
     <asp:ListItem Text="FIN" Value="FIN"></asp:ListItem>
     <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td>
    <asp:DropDownList ID="ddlST" runat="server">
     <asp:ListItem Text="" Value=""></asp:ListItem>
     <asp:ListItem Text="Late" Value="Late"></asp:ListItem>
     <asp:ListItem Text="Behind" Value="Behind"></asp:ListItem>
     <asp:ListItem Text="On Track" Value="On Track"></asp:ListItem>
    </asp:DropDownList>
   </td>
   <td><asp:Button ID="btnGo" runat="server" Text="Run Report" CssClass="NavBtn" /></td>
  </tr>
 </table>
 <table>
  <tr valign="top">
   <td>
    <aspx:UpdatePanel ID="uPnlOpenPO" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
      <asp:Button ID="btnEmail" runat="server" Text="Email" OnClientClick="javascript:$('#dvEmail').show();return false;" CssClass="NavBtn" Visible="false" /><br />
      <asp:Literal ID="litOpenPO" runat="server"></asp:Literal>
      <asp:GridView ID="gvOpenPO" runat="server" SkinID="Default" DataSourceID="odsOpenPO" OnDataBound="gvBound" OnRowDataBound="rwBound" PageSize="20">
       <Columns>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle">
         <HeaderTemplate>
          <asp:DropDownList ID="ddlDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
           <asp:ListItem Text="10" Value="10"></asp:ListItem>
           <asp:ListItem Text="20" Value="20"></asp:ListItem>
           <asp:ListItem Text="40" Value="40"></asp:ListItem>
           <asp:ListItem Text="All" Value="*"></asp:ListItem>
          </asp:DropDownList>
          <asp:LinkButton ID="lnkSortPO" runat="server" CommandName="Sort" ForeColor="White" CommandArgument="CustomerPO" Text="PO Number" />
         </HeaderTemplate>
         <ItemTemplate><%# Eval("CustomerPO") %></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="Line" DataField="Line" SortExpression="Line" InsertVisible="false" />
        <asp:TemplateField HeaderText="P/N" SortExpression="PN" InsertVisible="false">
         <ItemTemplate><%# gPN() %></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="Qty" DataField="oQty" SortExpression="oQty" InsertVisible="false" ItemStyle-HorizontalAlign="Right" />
        <asp:BoundField HeaderText="Due Date" DataField="DueDate" SortExpression="DueDate" InsertVisible="false" DataFormatString="{0:MM/dd/yyyy}" />
        <asp:BoundField HeaderText="WO#" DataField="WorkOrder" SortExpression="WorkOrder" InsertVisible="false" />
        <asp:BoundField HeaderText="Step Name" DataField="StepName" SortExpression="StepName" InsertVisible="false" />
        <asp:BoundField HeaderText="Step#/#Step" DataField="StepNum" SortExpression="StepNum" InsertVisible="false" />
        <asp:TemplateField HeaderText="Status" SortExpression="Status" InsertVisible="false">
         <ItemTemplate><%# gStatus() %></ItemTemplate>
        </asp:TemplateField>
       </Columns>
      </asp:GridView>
     </ContentTemplate>
     <Triggers><aspx:AsyncPostBackTrigger ControlID="btnGo" EventName="Click" /></Triggers>
    </aspx:UpdatePanel>
   </td>
   <td>
    <div id="dvEmail" style="display:none;">
     <aspx:UpdatePanel ID="uPnlOpenPO1" runat="server" UpdateMode="Conditional">
      <ContentTemplate>
       <table style="background:#CCFFCC;">
        <tr><td><b>From:</b></td><td><asp:TextBox ID="txtFrom" runat="server" Width="300px"></asp:TextBox></td></tr>
        <tr><td><b><a onclick="javascript:doOpen('<%= txtTo.ClientID %>');" class="Pointer">To:</a></b></td><td><asp:TextBox ID="txtTo" runat="server" Width="300px"></asp:TextBox></td></tr>
        <tr><td><b>Subject:</b></td><td><asp:TextBox ID="txtSubject" runat="server" Width="300px"></asp:TextBox></td></tr>
        <tr><td colspan="2"><asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine" Width="365px" Height="150px"></asp:TextBox></td></tr>
        <tr>
         <td align="right" colspan="2">
          <asp:Button ID="btnSend" runat="server" Text="Send" OnClick="doSend" CssClass="NavBtn" />
          <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick="javascript:$('#dvEmail').hide(); return false;" CssClass="NavBtn" />
         </td>
        </tr>
       </table><br />
       <MW:Message ID="iMsg" runat="server" />
       <table id="tblAddress" runat="server" class="mdlPopup">
        <tr><td><asp:Literal ID="litEmail" runat="server"></asp:Literal></td></tr>
        <tr><td><asp:Button ID="btnAddOK" runat="server" Text="OK" CssClass="NavBtn" /></td></tr>
       </table>
       <ajax:ModalPopupExtender ID="mpeAddress" runat="server" TargetControlID="hfUseField" PopupControlID="tblAddress" BackgroundCssClass="mdlBackground"
        OkControlID="btnAddOK" DropShadow="false" RepositionMode="RepositionOnWindowResize" OnOkScript="doOK()" />

       <asp:HiddenField ID="hfCnt" runat="server" />
       <asp:HiddenField ID="hfUseField" runat="server" />
      </ContentTemplate>
      <Triggers><aspx:AsyncPostBackTrigger ControlID="btnGo" EventName="Click" /></Triggers>
     </aspx:UpdatePanel>
    </div>
   </td>
  </tr>
 </table>

 <asp:ObjectDataSource ID="odsCustomerName" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="CompanyList">
  <SelectParameters>
   <asp:Parameter Name="ClassName" Type="String" DefaultValue="Customer" />
   <asp:Parameter Name="isAll" Type="Boolean" DefaultValue="True" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsOpenPO" runat="server" TypeName="myBiz.DAL.clsReport" SelectMethod="OpenPO">
  <SelectParameters>
   <asp:ControlParameter Name="CustID" Type="Int32" ControlID="ddlCustomerName" PropertyName="SelectedValue"  />
   <asp:ControlParameter Name="PO" Type="String" ControlID="txtPO" PropertyName="Text"  />
   <asp:ControlParameter Name="LN" Type="String" ControlID="txtLN" PropertyName="Text"  />
   <asp:ControlParameter Name="PN" Type="String" ControlID="txtPN" PropertyName="Text"  />
   <asp:ControlParameter Name="WO" Type="String" ControlID="txtWO" PropertyName="Text"  />
   <asp:ControlParameter Name="SN" Type="String" ControlID="ddlSN" PropertyName="SelectedValue"  />
   <asp:ControlParameter Name="ST" Type="String" ControlID="ddlST" PropertyName="SelectedValue"  />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>