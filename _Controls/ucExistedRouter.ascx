<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucExistedRouter.ascx.cs" Inherits="webApp._Controls.ucExistedRouter" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Check Existed Router</h3>

<asp:Panel ID="pnlTask" runat="server">
 <b>WO_QTE</b> <asp:TextBox ID="txtRFQ" runat="server"></asp:TextBox>
 <b>PN:</b> <asp:TextBox ID="txtPN" runat="server"></asp:TextBox>
 <asp:Button ID="btnGo" runat="server" Text="Go" OnClick="doLoad" CssClass="NavBtn" /><br />
 <ajax:AutoCompleteExtender ID="aceRFQ" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetRFQ" TargetControlID="txtRFQ" />
 <ajax:AutoCompleteExtender ID="acePN" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtPN" />

 <asp:GridView ID="gvExisted" runat="server" SkinID="Default" DataKeyNames="RFQID" OnRowCommand="gvCmd" AllowPaging="false" AllowSorting="false">
  <Columns>
   <asp:CommandField ShowSelectButton="true" SelectText="Use" />
   <asp:BoundField HeaderText="RFQ#" DataField="RFQ" SortExpression="RFQ" InsertVisible="false" />
   <asp:BoundField HeaderText="Status" DataField="SavedBy" SortExpression="SavedBy" InsertVisible="false" />
   <asp:BoundField HeaderText="Created Date" DataField="SavedDate" SortExpression="SavedDate" InsertVisible="false" HtmlEncode="false" DataFormatString="{0:MM/dd/yy}" />
  </Columns>
 </asp:GridView><br />
 <asp:GridView ID="gvExistedTraveler" runat="server" SkinID="Default" DataKeyNames="WOID" OnRowCommand="gvCmd" AllowPaging="false" AllowSorting="false">
  <Columns>
   <asp:CommandField ShowSelectButton="true" SelectText="Use" />
   <asp:BoundField HeaderText="WO#" DataField="WorkOrder" SortExpression="WorkOrder" InsertVisible="false" />
   <asp:BoundField HeaderText="Status" DataField="SavedBy" SortExpression="SavedBy" InsertVisible="false" />
   <asp:BoundField HeaderText="Created Date" DataField="SavedDate" SortExpression="SavedDate" InsertVisible="false" HtmlEncode="false" DataFormatString="{0:MM/dd/yy}" />
  </Columns>
 </asp:GridView><br />
 <asp:Button ID="btnSave" runat="server" Text="Generate Router" OnClick="doGenerate" CssClass="NavBtn" Visible="false" />

 <br />
 <b>Router Creator:</b> <asp:DropDownList ID="ddlName" runat="server" DataSourceID="odsName" DataTextField="mwName" DataValueField="mwUserName" />
 <asp:Button ID="btnRouterCreator" runat="server" Text="Assign" OnClick="doAssign" CssClass="NavBtn" />

 <br /><MW:Message ID="iMsg" runat="server" />
</asp:Panel>
<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:HiddenField ID="hfHasRouter" runat="server" />
<asp:HiddenField ID="hfRouterCreator" runat="server" />
<asp:ObjectDataSource ID="odsName" runat="server" TypeName="myBiz.DAL.clsUser" SelectMethod="RouterCreator_S">
</asp:ObjectDataSource>