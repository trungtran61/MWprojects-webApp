<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucQTE01.ascx.cs" Inherits="webApp._Controls.ucQTE01" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3><%= myMode.ActionName %> Final Quote</h3>

<asp:Panel ID="pnlTask" runat="server" Enabled="false">
 <b>IN-HOUSE PROCESS</b>
 <asp:GridView ID="gvFinQte" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsFinQte" ShowFooter="true" OnDataBound="gvBound">
  <Columns>
   <asp:TemplateField HeaderText="Step#" SortExpression="StepNo" InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left">
    <ItemTemplate><%# Eval("StepNo") %></ItemTemplate>
    <FooterTemplate><span style="background-color:White; color:Black;" title="Engineer Process Cost">EPC</span><br />Total</FooterTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="Step" SortExpression="StepName" InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left">
    <ItemTemplate><%# Eval("StepName") %></ItemTemplate>
    <FooterTemplate>&nbsp;</FooterTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="Program<br>Time" SortExpression="EPTime" InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
    <ItemTemplate><%# Eval("EPTime") %> <%# Eval("EPUnit") %></ItemTemplate>
    <FooterTemplate>&nbsp;</FooterTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="Setup<br>Time" SortExpression="ESTime" InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
    <ItemTemplate><%# Eval("ESTime") %> <%# Eval("ESUnit") %></ItemTemplate>
    <FooterTemplate>&nbsp;</FooterTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="Cycle<br>Time" SortExpression="ECTime" InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
    <ItemTemplate><%# Eval("ECTime") %> <%# Eval("ECUnit") %></ItemTemplate>
    <FooterTemplate>&nbsp;</FooterTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="Fixture<br>Time" SortExpression="EFTime" InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
    <ItemTemplate><%# Eval("EFTime") %> <%# Eval("EFUnit") %></ItemTemplate>
    <FooterTemplate>&nbsp;</FooterTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="Fixture<br>Material ($)" SortExpression="FixMatl" InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
    <ItemTemplate><%# Eval("FixMatl", "{0:C}")%></ItemTemplate>
    <FooterTemplate>&nbsp;</FooterTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="Tools ($)" SortExpression="ToolPrice" InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
    <ItemTemplate><%# GTLnk("Tool") %></ItemTemplate>
    <FooterTemplate>&nbsp;</FooterTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="Gages ($)" SortExpression="GagePrice" InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
    <ItemTemplate><%# GTLnk("Gage") %></ItemTemplate>
    <FooterTemplate>&nbsp;</FooterTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="Total<br>Cost ($)" SortExpression="ttCost" InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Right">
    <ItemTemplate><%# Eval("ttCost", "{0:C}")%></ItemTemplate>
    <FooterTemplate><asp:Literal ID="litCost" runat="server"></asp:Literal></FooterTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="Total<br>Time (hr)" SortExpression="ttTime" InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center">
    <ItemTemplate><%# Eval("ttTime","{0:0.00}") %></ItemTemplate>
    <FooterTemplate><asp:Literal ID="litTime" runat="server"></asp:Literal></FooterTemplate>
   </asp:TemplateField>
  </Columns>
 </asp:GridView>

 <br /><br />
 <table>
  <tr>
   <td><b>COST &amp; LEAD TIME FOR MATERIAL &amp; OPS</b></td>
   <td style="text-align:right;"><b>FINAL PRICE &amp; LEAD TIME</b></td>
  </tr>
  <tr>
   <td colspan="2">
    <asp:GridView ID="gvFinQteTb" runat="server" SkinID="Default" DataSourceID="odsFinQteTb" DataKeyNames="Ln" AllowSorting="true" ShowFooter="true" OnRowCommand="gvCmd" OnRowUpdating="gvUpdating" OnRowDataBound="rwBound" OnInit="gvInit" />
    <MW:Message ID="jMsg" runat="server" />
   </td>
  </tr> 
 </table>
 <table style="background-color:#CCCCCC; padding:5px; border-spacing:10px;">
  <tr style="background-color:#CCFFCC;">
   <td><b>Price MarkUp</b> <asp:TextBox ID="txtPctPE" runat="server" Width="35px"></asp:TextBox>%</td>
   <td><b>LeadTime MarkUp</b> <asp:TextBox ID="txtPctLT" runat="server" Width="35px"></asp:TextBox>%</td>
   <td>
    <asp:Button ID="btnCalculate" runat="server" Text="Calculate" OnClientClick="javascript:return getPriceMarkups();" CssClass="NavBtn" />
   </td>
   <td><asp:Button ID="btnMasterReset" runat="server" Text="Master Reset" OnClick="doMasterReset" CssClass="NavBtn" /></td>
  </tr>
 </table>
 <br />
 <asp:Button ID="btnSubmit" runat="server" Text="Generate Quote" OnClick="doSubmit" CssClass="NavBtn" />
 <MW:Message ID="iMsg" runat="server" />
 <asp:HiddenField ID="hfChkAllID" runat="server" />
 <br />
 <asp:GridView ID="gvQTE" runat="server" SkinID="GrayHeader" DataSourceID="odsQTE" DataKeyNames="QTENumber" OnDataBound="gvQteBound" OnRowDataBound="rwQteBound">
  <Columns>
   <asp:TemplateField>
    <ItemTemplate>
     <asp:CheckBox ID="chkQTE" runat="server" Visible='<%# Eval("isSched") %>' />
     <asp:Button ID="btnDelete" runat="server" Text="D" CommandName="Delete" CssClass="NavBtn" OnClientClick="return confirm('Are you sure you want to delete?');" Visible='<%# Eval("isDel") %>' />
     <asp:HiddenField ID="hfHID" runat="server" Value='<%# Eval("HID") %>' />
     <asp:HiddenField ID="hfSched" runat="server" Value='<%# Eval("isSched") %>' />
    </ItemTemplate>
   </asp:TemplateField>
   <asp:TemplateField HeaderText="Quote">
    <ItemTemplate><%# gLnk() %></ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Price Markup %" DataField="LineNumMarkup" SortExpression="LineNumMarkup" InsertVisible="false" />
   <asp:BoundField HeaderText="Lead Time Markup %" DataField="LeadTimeMarkup" SortExpression="LeadTimeMarkup" InsertVisible="false" />
  </Columns>
 </asp:GridView>

 <br /><asp:Button ID="btnSchedule" runat="server" Text="Schedule Quote" OnClick="doSchedule" CssClass="NavBtn" />
 <MW:Message ID="kMsg" runat="server" />
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />
<asp:HiddenField ID="hfChkBox" runat="server" />
<asp:HiddenField ID="hfPriceIDs" runat="server" />
<asp:HiddenField ID="hfPriceVal" runat="server" />

<asp:ObjectDataSource ID="odsFinQte" runat="server" TypeName="myBiz.DAL.clsRouter" SelectMethod="Finalize">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:ControlParameter Name="LineNum" Type="Int32" ControlID="gvFinQteTb" PropertyName="SelectedValue" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsFinQteTb" runat="server" TypeName="myBiz.DAL.clsFinQte" SelectMethod="FinQte_S" UpdateMethod="FinQte_Save" InsertMethod="QTE_Insert" DeleteMethod="FinQte_D">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:ControlParameter Name="pctPE" Type="string" ControlID="txtPctPE" PropertyName="Text" />
  <asp:ControlParameter Name="pctLT" Type="string" ControlID="txtPctLT" PropertyName="Text" />
  <asp:ControlParameter Name="PriceVal" Type="String" ControlID="hfPriceVal" PropertyName="Value" />
 </SelectParameters>
 <UpdateParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="Ln" Type="Int32" />
  <asp:Parameter Name="Qty" Type="Int32" />
  <asp:Parameter Name="iSN" Type="String" />
  <asp:Parameter Name="iC" Type="String" />
  <asp:Parameter Name="iL" Type="String" />
 </UpdateParameters>
 <InsertParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:ControlParameter Name="PriceMarkup" Type="Decimal" ControlID="txtPctPE" PropertyName="Text" />
  <asp:ControlParameter Name="LeadTimeMarkup" Type="Decimal" ControlID="txtPctLT" PropertyName="Text" />
  <asp:Parameter Name="PriceVal" Type="String" />
  <asp:Parameter Name="Ln" Type="String" />
 </InsertParameters>
 <DeleteParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="Ln" Type="Int32" />
 </DeleteParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsQTE" runat="server" TypeName="myBiz.DAL.clsFinQte" SelectMethod="Distinct_QTE" DeleteMethod="QTE_Delete" OnDeleted="odsDeleted">
 <SelectParameters><asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" /></SelectParameters>
</asp:ObjectDataSource>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadGT(RFQID, sNo, sNm, GageTool, PartQty) {
   window.radopen('RFQ/gtDetail.aspx?RFQID=' + RFQID + '&sNo=' + sNo + '&sNm=' + sNm + '&GageTool=' + GageTool + '&pQty=' + PartQty, "gtDetail");
  }
  function loadRO(RFQID, Ln, sNo, sNm) {
   window.radopen('RFQ/roDetail.aspx?RFQID=' + RFQID + '&Ln=' + Ln + '&sNo=' + sNo + '&sNm=' + sNm, "gtDetail");
  }
 </script>
</telerik:RadCodeBlock>

<telerik:RadWindowManager ID="radWindow" runat="server" Skin="Vista" Title="View Detail">
 <Windows>
  <telerik:RadWindow ID="gtDetail" runat="server" Title="View Detail" Height="500px" 
  Width="750px" Left="150px" ReloadOnShow="true" VisibleStatusbar="false" ShowContentDuringLoad="false" Modal="true" Skin="Vista" VisibleTitlebar="true" />
 </Windows>
</telerik:RadWindowManager>
