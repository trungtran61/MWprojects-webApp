<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucExistedTraveler" Codebehind="ucExistedTraveler.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>Check Existed Job Traveler</h3>

<asp:Panel ID="pnlTask" runat="server">

 <b>WO_QTE:</b> <asp:TextBox ID="txtWO" runat="server"></asp:TextBox>
 <b>PN:</b> <asp:TextBox ID="txtPN" runat="server"></asp:TextBox>
 <asp:Button ID="btnGo" runat="server" Text="Go" OnClick="doLoad" CssClass="NavBtn" /><br />
 <ajax:AutoCompleteExtender ID="aceWO" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetWorkOrder" TargetControlID="txtWO" />
 <ajax:AutoCompleteExtender ID="acePN" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtPN" />

 <asp:GridView ID="gvExisted" runat="server" SkinID="Default" DataKeyNames="WOID" OnRowCommand="gvCmd" AllowPaging="false" AllowSorting="false">
  <Columns>
   <asp:CommandField ShowSelectButton="true" SelectText="Use" />
   <asp:BoundField HeaderText="WO#" DataField="WorkOrder" SortExpression="WorkOrder" InsertVisible="false" />
   <asp:BoundField HeaderText="Status" DataField="SavedBy" SortExpression="SavedBy" InsertVisible="false" />
   <asp:BoundField HeaderText="Created Date" DataField="SavedDate" SortExpression="SavedDate" InsertVisible="false" HtmlEncode="false" DataFormatString="{0:MM/dd/yy}" />
  </Columns>
 </asp:GridView><br />
 <asp:GridView ID="gvExistedRouter" runat="server" SkinID="Default" DataKeyNames="RFQID" OnRowCommand="gvCmd" AllowPaging="false" AllowSorting="false">
  <Columns>
   <asp:CommandField ShowSelectButton="true" SelectText="Use" />
   <asp:BoundField HeaderText="RFQ#" DataField="RFQ" SortExpression="RFQ" InsertVisible="false" />
   <asp:BoundField HeaderText="Status" DataField="SavedBy" SortExpression="SavedBy" InsertVisible="false" />
   <asp:BoundField HeaderText="Created Date" DataField="SavedDate" SortExpression="SavedDate" InsertVisible="false" HtmlEncode="false" DataFormatString="{0:MM/dd/yy}" />
  </Columns>
 </asp:GridView><br />
 <asp:Button ID="btnSave" runat="server" Text="Generate Traveler" OnClick="doGenerate" CssClass="NavBtn" Visible="false" />
 <br /><MW:Message ID="iMsg" runat="server" />
</asp:Panel>
<ucMode:CurrentMode ID="myMode" runat="server" />
