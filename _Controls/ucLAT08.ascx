<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucLAT08" Codebehind="ucLAT08.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>1st PIECE INSPECTION REPORT</h3>
<asp:Panel ID="pnlTask" runat="server" Enabled="false">
 <asp:GridView ID="gvXML" runat="server" DataKeyNames="HID" SkinID="GrayHeader" DataSourceID="odsXML" OnRowDataBound="xmlBound">
  <Columns>
   <asp:TemplateField>
    <HeaderTemplate>
     <asp:CheckBox ID="chkItem" runat="server" />
    </HeaderTemplate>
    <ItemTemplate>
     <asp:CheckBox ID="chkItem" runat="server" />
    </ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="CharNo" DataField="xCharNo" SortExpression="CharNo" InsertVisible="false" />
   <asp:BoundField HeaderText="Loc" DataField="Location" SortExpression="Location" InsertVisible="false" />
   <asp:TemplateField HeaderText="Drawing Requirement" SortExpression="DrawReq">
    <ItemTemplate><%# Eval("xDrawReq") %></ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Lower Limit" DataField="LowerLimit" SortExpression="LowerLimit" InsertVisible="false" />
   <asp:BoundField HeaderText="Upper Limit" DataField="UpperLimit" SortExpression="UpperLimit" InsertVisible="false" />
  </Columns>
 </asp:GridView>
 <asp:HiddenField ID="hfChkBox" runat="server" />
 <br /><br />
 <asp:Button ID="btnXML" runat="server" Text="Transfer" OnClick="doXML" CssClass="NavBtn" />
 <br /><br />
   <asp:GridView ID="gv1stPiece" runat="server" SkinID="Default" DataKeyNames="CharNo" DataSourceID="ods1stPiece" ShowFooter="true">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
       <asp:LinkButton ID="lnkDelete" runat="server" Text="Remove" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to remove?');" />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
      </EditItemTemplate>
      <FooterTemplate><asp:Button ID="btnAdd" Text="Add New" runat="server" OnClick="btnAdd_Click" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Char No." SortExpression="CharNo" InsertVisible="false">
      <ItemTemplate><%# Eval("xCharNo") %></ItemTemplate>
      <EditItemTemplate><%# Eval("CharNo") %></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtCharNo" runat="server" Width="50px" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Loc" SortExpression="Location" InsertVisible="false">
      <ItemTemplate><asp:Literal ID="litLocation" runat="server" Text='<%# Eval("Location") %>' /></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtLocation" runat="server" Text='<%# Bind("Location") %>'></asp:TextBox></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtLocation" runat="server" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Drawing Requirement" SortExpression="DrawReq" InsertVisible="false">
      <ItemTemplate><%# Eval("xDrawReq") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtDrawReq" runat="server" Text='<%# Bind("DrawReq") %>' /></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtDrawReq" runat="server" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Measure Equipment" SortExpression="MeasureEquip" InsertVisible="false">
      <ItemTemplate><asp:Literal ID="litMeasureEquip" runat="server" Text='<%# Eval("MeasureEquip") %>' /></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtMeasureEquip" runat="server" Text='<%# Bind("MeasureEquip") %>' /></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtMeasureEquip" runat="server" /></FooterTemplate>
     </asp:TemplateField>
    </Columns>
    <EmptyDataTemplate>
     <table cellpadding="0" cellspacing="0">
     <tr style="background-color:#EEEEEE">
      <td>&nbsp;</td>
      <td><b>Char No</b></td>
      <td><b>Loc</b></td>
      <td><b>Drawing Requirement</b></td>
      <td><b>Measure Equipment</b></td>
     </tr>
     <tr>
      <td><asp:Button ID="btnEmpty" Text="Add New" runat="server" OnClick="btnAdd_Click" /></td>
      <td><asp:TextBox ID="txtCharNo" runat="server" Width="50px"></asp:TextBox></td>
      <td><asp:TextBox ID="txtLocation" runat="server"></asp:TextBox></td>
      <td><asp:TextBox ID="txtDrawReq" runat="server"></asp:TextBox></td>
      <td><asp:TextBox ID="txtMeasureEquip" runat="server"></asp:TextBox></td>
     </tr>
     </table>
    </EmptyDataTemplate>
   </asp:GridView>
 <br />

<asp:FormView ID="fvInNum" runat="server" DataSourceID="odsInNum" Enabled="false">
 <ItemTemplate>
  Check <%# Eval("Checked") %>% &amp; record <%# Eval("Record") %> in <%# Eval("InNum") %>
  <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" />
 </ItemTemplate>
 <EditItemTemplate>
  Check <asp:TextBox ID="txtChecked" runat="server" Text='<%# Bind("Checked") %>' Width="75px"></asp:TextBox>  
  &amp; record <asp:TextBox ID="txtRecord" runat="server" Text='<%# Bind("Record") %>' Width="50px"></asp:TextBox>
  in <asp:TextBox ID="txtInNum" runat="server" Text='<%# Bind("InNum") %>' Width="50px"></asp:TextBox>
  <asp:Button ID="btnSave" runat="server" Text="Update" CommandName="Update" />
 </EditItemTemplate>
</asp:FormView>
<br />
 <asp:Button ID="btnGenerate" runat="server" Text="Generate Form" OnClick="generateForm" CssClass="NavBtn" />
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />
<br /><MW:Message ID="iMsg" runat="server" />

<div id="dvForm" style="display:none"><MW:Form ID="frmInspection" runat="server" /></div>

<asp:ObjectDataSource ID="ods1stPiece" runat="server" TypeName="myBiz.DAL.clsFirstPieceInspection" SelectMethod="Select" UpdateMethod="Save" DeleteMethod="Delete">
<SelectParameters><asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" /></SelectParameters>
<UpdateParameters>
 <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 <asp:Parameter Name="CharNo" Type="Decimal" />
 <asp:Parameter Name="Location" Type="String" />
 <asp:Parameter Name="DrawReq" Type="String" />
 <asp:Parameter Name="MeasureEquip" Type="String" />
</UpdateParameters>
<DeleteParameters>
 <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 <asp:Parameter Name="CharNo" Type="Decimal" />
</DeleteParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsInNum" runat="server" TypeName="myBiz.DAL.clsInspectionReport" SelectMethod="Select" UpdateMethod="saveNum">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </SelectParameters>
 <UpdateParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="Checked" Type="Int32" />
  <asp:Parameter Name="Record" Type="Int32" />
  <asp:Parameter Name="InNum" Type="Int32" />
 </UpdateParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsXML" runat="server" TypeName="myBiz.DAL.clsFirstPieceInspection" SelectMethod="selectXML">
<SelectParameters><asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" /></SelectParameters>
</asp:ObjectDataSource>