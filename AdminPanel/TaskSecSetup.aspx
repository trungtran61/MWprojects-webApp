<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.AdminPanel.TaskSecSetup" Title="Task Security Setup" Codebehind="TaskSecSetup.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <table>
  <tr>
   <td><b>Group:</b><br />
    <asp:DropDownList ID="ddlGroup" runat="server" DataSourceID="odsGroup" DataTextField="gName" DataValueField="HID"></asp:DropDownList>
   </td>
   <td><b>Dept/Step:</b><br />
    <asp:DropDownList ID="ddlDeptStep" runat="server" DataSourceID="odsDeptStep" DataTextField="Name" DataValueField="HID"></asp:DropDownList>
   </td>
   <td valign="bottom"><asp:Button ID="btnLoad" runat="server" Text="Load" OnClick="doLoad" CssClass="NavBtn" /></td>
   <td valign="bottom">
    <aspx:UpdatePanel ID="uPnlSave" runat="server" UpdateMode="Conditional">
     <ContentTemplate><asp:Button ID="btnSave" runat="server" Text="Save" OnClick="doSave" CssClass="NavBtn" Enabled="false" /></ContentTemplate>
     <Triggers><aspx:AsyncPostBackTrigger ControlID="btnLoad" EventName="Click" /></Triggers>
    </aspx:UpdatePanel>
   </td>
  </tr>
 </table>
 <aspx:UpdatePanel ID="uPnlTaskSec" runat="server">
  <ContentTemplate>
   <MW:Message ID="iMsg" runat="server" />
   <asp:GridView ID="gvTaskSec" runat="server" SkinID="Default" DataSourceID="odsTaskSec" DataKeyNames="HID" OnDataBound="gvBound">
    <Columns>
     <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="TaskID" DataField="Taskey" SortExpression="Taskey" InsertVisible="false" />
     <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Description" DataField="TaskDesc" SortExpression="TaskDesc" InsertVisible="false" />
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Func 01">
      <ItemTemplate><asp:CheckBox ID="chk01" runat="server" Checked='<%# Eval("t01") %>' Text='<%# Eval("v01") %>' Visible='<%# !Eval("v01").ToString().Equals("None") %>' /></ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Func 02">
      <ItemTemplate><asp:CheckBox ID="chk02" runat="server" Checked='<%# Eval("t02") %>' Text='<%# Eval("v02") %>' Visible='<%# !Eval("v02").ToString().Equals("None") %>' /></ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Func 03">
      <ItemTemplate><asp:CheckBox ID="chk03" runat="server" Checked='<%# Eval("t03") %>' Text='<%# Eval("v03") %>' Visible='<%# !Eval("v03").ToString().Equals("None") %>' /></ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Func 04">
      <ItemTemplate><asp:CheckBox ID="chk04" runat="server" Checked='<%# Eval("t04") %>' Text='<%# Eval("v04") %>' Visible='<%# !Eval("v04").ToString().Equals("None") %>' /></ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Func 05">
      <ItemTemplate><asp:CheckBox ID="chk05" runat="server" Checked='<%# Eval("t05") %>' Text='<%# Eval("v05") %>' Visible='<%# !Eval("v05").ToString().Equals("None") %>' /></ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Func 06">
      <ItemTemplate><asp:CheckBox ID="chk06" runat="server" Checked='<%# Eval("t06") %>' Text='<%# Eval("v06") %>' Visible='<%# !Eval("v06").ToString().Equals("None") %>' /></ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Func 07">
      <ItemTemplate><asp:CheckBox ID="chk07" runat="server" Checked='<%# Eval("t07") %>' Text='<%# Eval("v07") %>' Visible='<%# !Eval("v07").ToString().Equals("None") %>' /></ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Func 08">
      <ItemTemplate><asp:CheckBox ID="chk08" runat="server" Checked='<%# Eval("t08") %>' Text='<%# Eval("v08") %>' Visible='<%# !Eval("v08").ToString().Equals("None") %>' /></ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Func 09">
      <ItemTemplate><asp:CheckBox ID="chk09" runat="server" Checked='<%# Eval("t09") %>' Text='<%# Eval("v09") %>' Visible='<%# !Eval("v09").ToString().Equals("None") %>' /></ItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Func 10">
      <ItemTemplate><asp:CheckBox ID="chk10" runat="server" Checked='<%# Eval("t10") %>' Text='<%# Eval("v10") %>' Visible='<%# !Eval("v10").ToString().Equals("None") %>' /></ItemTemplate>
     </asp:TemplateField>
    </Columns>
   </asp:GridView>
  </ContentTemplate>
  <Triggers>
   <aspx:AsyncPostBackTrigger ControlID="btnLoad" EventName="Click" />
   <aspx:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
  </Triggers>
 </aspx:UpdatePanel>
 
 <asp:ObjectDataSource ID="odsGroup" runat="server" TypeName="myBiz.DAL.clsUserGroup" SelectMethod="GroupName_S"></asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsDeptStep" runat="server" TypeName="myBiz.DAL.clsUserGroup" SelectMethod="DeptStep_S">
  <SelectParameters><asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" /></SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsTaskSec" runat="server" TypeName="myBiz.DAL.clsUserGroup" SelectMethod="Task_Security_S1">
  <SelectParameters>
   <asp:ControlParameter Name="GroupID" Type="Int32" ControlID="ddlGroup" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="DeptStep" Type="String" ControlID="ddlDeptStep" PropertyName="SelectedValue" />
   <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>