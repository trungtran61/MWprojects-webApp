<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.ucFIN02" Codebehind="ucFIN02.ascx.cs" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>1st ARTICLE INSPECTION REPORT</h3>
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
  </Columns>
 </asp:GridView>
 <asp:HiddenField ID="hfChkBox" runat="server" />
 <br /><br />
 <asp:Button ID="btnXML" runat="server" Text="Transfer" OnClick="doXML" CssClass="NavBtn" />
 <br /><br />
   <asp:GridView ID="gv1stArticle" runat="server" SkinID="Default" DataKeyNames="CharNo" DataSourceID="ods1stArticle" ShowFooter="true">
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

 <asp:Button ID="btnGenerate" runat="server" Text="Generate Form" OnClick="generateForm" CssClass="NavBtn" />
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />
<br /><MW:Message ID="iMsg" runat="server" />

<div id="dvForm1" style="display:none"><MW:Form ID="frmOne" runat="server" FormID="f00004" /></div>
<div id="dvForm2" style="display:none"><MW:Form ID="frmTwo" runat="server" FormID="f00005" /></div>
<div id="dvForm3" style="display:none"><MW:Form ID="frmInspection" runat="server" /></div>

<telerik:RadWindowManager ID="radWindow" runat="server" Skin="Vista" Title="Form Preview"  >
 <Windows>
  <telerik:RadWindow ID="preview" runat="server" Title="Form Preview" Height="500px" 
  Width="500px" Left="150px" ReloadOnShow="true" VisibleStatusbar="false" ShowContentDuringLoad="false" Modal="true" Skin="Vista" VisibleTitlebar="true" />
 </Windows>
</telerik:RadWindowManager>

<asp:ObjectDataSource ID="ods1stArticle" runat="server" TypeName="myBiz.DAL.cls1stArticle" SelectMethod="Select" UpdateMethod="Save" DeleteMethod="Delete">
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

<asp:ObjectDataSource ID="odsXML" runat="server" TypeName="myBiz.DAL.cls1stArticle" SelectMethod="selectXML">
<SelectParameters><asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" /></SelectParameters>
</asp:ObjectDataSource>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript" language="javascript">
  function chkAll(chk, isAll){
   var myBoxes = document.getElementById('<%= hfChkBox.ClientID %>').value.split(':');
   var len = myBoxes.length;
   var Cnt = 1;
   for (var i = 0; i < len; i++) {
    if (isAll) document.getElementById(myBoxes[i]).checked = chk.checked;
    else if (document.getElementById(myBoxes[i]).checked && i > 0) Cnt++;
   }
   if (!isAll) document.getElementById(myBoxes[0]).checked = Cnt == len;
  }
  function loadForm(frm,cd,id)
  {
   window.open("File/Preview.aspx?FID=" + frm + "&Code=" + cd + "&HID=" + id, "preview");
  }
 </script>
</telerik:RadCodeBlock>