<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Purchasing.RecdPO" Title="Verifying Orders" Codebehind="RecdPO.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" Runat="Server">
<aspx:UpdatePanel ID="uPnlPO" runat="server">
 <ContentTemplate>
  <asp:Panel ID="pnlVerifiedPO" runat="server" DefaultButton="btnVerifiedS">
   <table>
    <tr>
     <td><b>Part Number:</b></td>
     <td><b>PO Number:</b></td>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td>
      <asp:TextBox ID="txtVerifiedPN" runat="server"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="aceVerifiedPN" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtVerifiedPN">
      </ajax:AutoCompleteExtender>
     </td>
     <td>
      <asp:TextBox ID="txtVerifiedPO" runat="server"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="aceVerifiedPO" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtVerifiedPO" />
     </td>
     <td valign="bottom">
      <asp:Button ID="btnVerifiedS" runat="server" Text="Search" CssClass="NavBtn" />
     </td>
    </tr>
   </table>
  </asp:Panel>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">ORDERS HAD BEEN VERIFIED <asp:Literal ID="litVerifiedCnt" runat="server"></asp:Literal></td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvVerifiedPO" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsVerifiedPO" OnDataBound="dataBound" OnRowDataBound="rwBound" PageSize="10">
      <Columns>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
        <HeaderTemplate>
         <asp:DropDownList ID="ddlVerifiedDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
          <asp:ListItem Text="10" Value="10"></asp:ListItem>
          <asp:ListItem Text="20" Value="20"></asp:ListItem>
          <asp:ListItem Text="30" Value="30"></asp:ListItem>
          <asp:ListItem Text="All" Value="5000"></asp:ListItem>
         </asp:DropDownList>
        </HeaderTemplate>
        <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Verified By" DataField="VerifiedBy" SortExpression="VerifiedBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="VerifiedDate" SortExpression="VerifiedDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="PO #" SortExpression="PONumber" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkPONumber" runat="server" Text='<%# Eval("PONumber") %>' OnClientClick='<%# string.Format("javascript:loadPreview(\"{0}\");return false;", Eval("POLink")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Part Number" DataField="PartNumber" SortExpression="PartNumber" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Order Qty" SortExpression="Qty">
        <ItemTemplate><%# Eval("Qty") %> <%# Eval("Unit") %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Received Qty">
        <ItemTemplate><%# clsCnt() %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Verified Due Date" SortExpression="VerifiedDD">
        <ItemTemplate><%# gDD("VerifiedDD") %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Verified Location" DataField="VerifiedLoc" SortExpression="VerifiedLoc" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate>
         <a onclick="javascript:xPopup('../Note/Note.aspx?lDB=PO&lID=<%# Eval("HID") %>');" class="Finger"><img src="../App_Themes/<%# Eval("NoteImg") %>" alt="Note" /></a>
        </ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>No Orders has been verified!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>

  <br />
  <asp:Button ID="btnUndo" runat="server" Text="Undo" OnClick="doUndo" CssClass="NavBtn" />
  <br /><hr />

  <asp:Panel ID="pnlRecdPO" runat="server" DefaultButton="btnRecdS">
   <table>
    <tr>
     <td><b>Part Number:</b></td>
     <td><b>PO Number:</b></td>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td>
      <asp:TextBox ID="txtRecdPN" runat="server"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="aceRecdPN" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtRecdPN">
      </ajax:AutoCompleteExtender>
     </td>
     <td>
      <asp:TextBox ID="txtRecdPO" runat="server"></asp:TextBox>
      <ajax:AutoCompleteExtender ID="aceRecdPO" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtRecdPO" />
     </td>
     <td valign="bottom">
      <asp:Button ID="btnRecdS" runat="server" Text="Search" CssClass="NavBtn" />
     </td>
    </tr>
   </table>
  </asp:Panel>
  <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
   <tr style="background-color:#330099; color:White">
    <td align="center" style="font-weight:bold;">ORDERS NEED TO BE VERIFIED <asp:Literal ID="litRecdCnt" runat="server"></asp:Literal></td>
   </tr>
   <tr>
    <td>
     <asp:GridView ID="gvRecdPO" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsRecdPO" OnRowCommand="gvCmd" OnRowDataBound="gvBound" OnDataBound="dataBound" PageSize="10">
      <Columns>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
        <HeaderTemplate>
         <asp:DropDownList ID="ddlRecdDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
          <asp:ListItem Text="10" Value="10"></asp:ListItem>
          <asp:ListItem Text="20" Value="20"></asp:ListItem>
          <asp:ListItem Text="30" Value="30"></asp:ListItem>
          <asp:ListItem Text="All" Value="5000"></asp:ListItem>
         </asp:DropDownList>
        </HeaderTemplate>
        <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" Visible='<%# Eval("isVerified") %>' /></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Received By" DataField="RecdBy" SortExpression="RecdBy" InsertVisible="false" />
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="RecdDate" SortExpression="RecdDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="PO #" SortExpression="PONumber" InsertVisible="false">
        <ItemTemplate>
         <asp:LinkButton ID="lnkPONumber" runat="server" Text='<%# Eval("PONumber") %>' OnClientClick='<%# string.Format("javascript:loadPreview(\"{0}\");return false;", Eval("POLink")) %>'></asp:LinkButton>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Part Number" DataField="PartNumber" SortExpression="PartNumber" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Order Qty" SortExpression="Qty">
        <ItemTemplate><%# Eval("Qty") %> <%# Eval("Unit") %></ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Received Qty">
        <ItemTemplate>
         <%# clsCnt() %>
         <asp:LinkButton ID="lnkEdit" runat="server" Text="&diams;" CommandName="pEdit" />
         <asp:HiddenField ID="hfGoodCnt" runat="server" Value='<%# Eval("GoodCnt") %>' />
         <asp:HiddenField ID="hfRewrkCnt" runat="server" Value='<%# Eval("RewrkCnt") %>' />
         <asp:HiddenField ID="hfScrapCnt" runat="server" Value='<%# Eval("ScrapCnt") %>' />
         <asp:HiddenField ID="hfTotalCnt" runat="server" Value='<%# Eval("TotalCnt") %>' />
        </ItemTemplate>
       </asp:TemplateField>
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Verified Due Date" SortExpression="VerifiedDD">
        <ItemTemplate><%# gDD("VerifiedDD") %></ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Received Location" DataField="RecdLoc" SortExpression="RecdLoc" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
        <ItemTemplate>
         <a onclick="javascript:xPopup('../Note/Note.aspx?lDB=PO&lID=<%# Eval("HID") %>');" class="Finger"><img src="../App_Themes/<%# Eval("NoteImg") %>" alt="Note" /></a>
        </ItemTemplate>
       </asp:TemplateField>
      </Columns>
      <EmptyDataTemplate>You have no order to verify!</EmptyDataTemplate>
     </asp:GridView>
    </td>
   </tr>
  </table>
  <br />
  <asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="odsLocation" DataTextField="lDescription" DataValueField="HID"></asp:DropDownList>
  <asp:Button ID="btnSubmit" runat="server" Text="Approve" OnClick="doApprove" CssClass="NavBtn" />
  <MW:Message ID="iMsg" runat="server" />
  
  <table id="tblRecdCnt" runat="server" class="mdlPopup">
   <tr>
    <td>
     <table cellpadding="0" cellspacing="0" class="Tb2" width="100%">
      <tr>
       <td class="BlueBar"><b>PO#:</b></td>
       <td><asp:Literal ID="litPONumber" runat="server"></asp:Literal></td>
      </tr>
      <tr>
       <td class="BlueBar"><b>Good Count:</b></td>
       <td><asp:TextBox ID="txtGoodCnt" runat="server"></asp:TextBox></td>
      </tr>
      <tr>
       <td class="BlueBar"><b>Reworkable Count:</b></td>
       <td><asp:TextBox ID="txtRewrkCnt" runat="server"></asp:TextBox></td>
      </tr>
      <tr>
       <td class="BlueBar"><b>Scrap Count:</b></td>
       <td><asp:TextBox ID="txtScrapCnt" runat="server"></asp:TextBox></td>
      </tr>
      <tr>
       <td class="BlueBar"><b>Total Count:</b></td>
       <td><asp:TextBox ID="txtTotalCnt" runat="server" ReadOnly="true"></asp:TextBox></td>
      </tr>
     </table>
    </td>
   </tr>
   <tr>
    <td>
     <asp:Button ID="btnAdd" runat="server" Text="Save Data" OnClick="sData" CssClass="NavBtn" />
     <asp:Button ID="btnClose" runat="server" Text="Close Window" CssClass="NavBtn" />
     <MW:Message ID="jMsg" runat="server" />
     <asp:HiddenField ID="hfHID" runat="server" Value="0" />
    </td>
   </tr>
  </table>
  <ajax:ModalPopupExtender ID="mpeRecdCnt" runat="server" TargetControlID="hfHID" PopupControlID="tblRecdCnt" BackgroundCssClass="mdlBackground"
   OkControlID="btnClose" DropShadow="false" RepositionMode="RepositionOnWindowResize" />
  
 </ContentTemplate>
</aspx:UpdatePanel>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadPreview(id)
  {
   window.radopen("../File/Preview.aspx?FID=PO&Code=GeneralPO&HID=" + id, "mPopup").maximize();
  }
 </script>
</telerik:RadCodeBlock>

<asp:HiddenField ID="hfUID" runat="server" />
<asp:HiddenField ID="hfValx" runat="server" />
<asp:ObjectDataSource ID="odsVerifiedPO" runat="server" TypeName="myBiz.DAL.clsPO" SelectMethod="Select" UpdateMethod="Verified_U">
 <SelectParameters>
  <asp:ControlParameter Name="xHID" Type="String" ControlID="hfValx" PropertyName="Value" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Verified" />
  <asp:ControlParameter Name="PN" Type="String" ControlID="txtVerifiedPN" PropertyName="Text" />
  <asp:ControlParameter Name="PO" Type="String" ControlID="txtVerifiedPO" PropertyName="Text" />
  <asp:Parameter Name="Supplier" Type="String" />
  <asp:Parameter Name="Invoice" Type="String" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:Parameter Name="lMode" Type="String" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="UN" Type="String" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Received" />
  <asp:Parameter Name="LocID" Type="Int32" />
 </UpdateParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsRecdPO" runat="server" TypeName="myBiz.DAL.clsPO" SelectMethod="Select" UpdateMethod="Verified_U" InsertMethod="RecdCnt_Save">
 <SelectParameters>
  <asp:ControlParameter Name="xHID" Type="String" ControlID="hfValx" PropertyName="Value" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Received" />
  <asp:ControlParameter Name="PN" Type="String" ControlID="txtRecdPN" PropertyName="Text" />
  <asp:ControlParameter Name="PO" Type="String" ControlID="txtRecdPO" PropertyName="Text" />
  <asp:Parameter Name="Supplier" Type="String" />
  <asp:Parameter Name="Invoice" Type="String" />
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
 </SelectParameters>
 <UpdateParameters>
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:Parameter Name="IDs" Type="String" />
  <asp:Parameter Name="Status" Type="String" DefaultValue="Verified" />
  <asp:ControlParameter Name="LocID" Type="Int32" ControlID="ddlLocation" PropertyName="SelectedValue" />
 </UpdateParameters>
 <InsertParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="GoodCnt" Type="Decimal" />
  <asp:Parameter Name="RewrkCnt" Type="Decimal" />
  <asp:Parameter Name="ScrapCnt" Type="Decimal" />
 </InsertParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsLocation" runat="server" TypeName="myBiz.DAL.clsLocation" SelectMethod="Select">
 <SelectParameters>
  <asp:Parameter Name="Dept" Type="String" DefaultValue="Verified" />
  <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
  <asp:Parameter Name="isBlank" Type="Boolean" DefaultValue="True" />
 </SelectParameters>
</asp:ObjectDataSource>
</asp:Content>