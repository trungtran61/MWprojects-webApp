<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="MacPmSetup.aspx.cs" Inherits="webApp.AdminPanel.MacPmSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <asp:DropDownList ID="ddlMachineList" runat="server" DataSourceID="odsMachineList" DataTextField="MacName" DataValueField="MacID" AutoPostBack="true"></asp:DropDownList>
 <br /><br />
 <aspx:UpdatePanel ID="uPnlPM" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <MW:Message ID="iMsg" runat="server" />
   <asp:GridView ID="gvPMTask" runat="server" DataSourceID="odsPMTask" DataKeyNames="HID" SkinID="Default" ShowFooter="true" OnRowCommand="rwCmd">
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:Button ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" CssClass="NavBtn" />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="vUpdate" />
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
      </EditItemTemplate>
      <FooterTemplate>
       <asp:Button ID="btnAddNew" Text="Add" runat="server" CommandName="AddNew" CommandArgument="Footer" CssClass="NavBtn" ValidationGroup="vNew" />
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Task ID" SortExpression="TaskID" InsertVisible="false">
      <ItemTemplate><%# Eval("TaskID")%></ItemTemplate>
      <EditItemTemplate>
       <asp:TextBox ID="txtTaskID" runat="server" Text='<%# Bind("TaskID") %>' />
       <asp:RequiredFieldValidator ID="rfvTaskID" runat="server" ControlToValidate="txtTaskID" ErrorMessage="*" ValidationGroup="vUpdate"></asp:RequiredFieldValidator>
      </EditItemTemplate>
      <FooterTemplate>
       <asp:TextBox ID="txtTaskID" runat="server" />
       <asp:RequiredFieldValidator ID="rfvTaskID" runat="server" ControlToValidate="txtTaskID" ErrorMessage="*" ValidationGroup="vNew"></asp:RequiredFieldValidator>
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Task Name" SortExpression="TaskName" InsertVisible="false">
      <ItemTemplate><%# Eval("TaskName")%></ItemTemplate>
      <EditItemTemplate>
       <asp:TextBox ID="txtTaskName" runat="server" Text='<%# Bind("TaskName") %>' />
       <asp:RequiredFieldValidator ID="rfvTaskName" runat="server" ControlToValidate="txtTaskName" ErrorMessage="*" ValidationGroup="vUpdate"></asp:RequiredFieldValidator>
      </EditItemTemplate>
      <FooterTemplate>
       <asp:TextBox ID="txtTaskName" runat="server" />
       <asp:RequiredFieldValidator ID="rfvTaskName" runat="server" ControlToValidate="txtTaskName" ErrorMessage="*" ValidationGroup="vNew"></asp:RequiredFieldValidator>
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Description" SortExpression="Description" InsertVisible="false">
      <ItemTemplate><%# Eval("Description")%></ItemTemplate>
      <EditItemTemplate>
       <asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' />
       <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription" ErrorMessage="*" ValidationGroup="vUpdate"></asp:RequiredFieldValidator>
      </EditItemTemplate>
      <FooterTemplate>
       <asp:TextBox ID="txtDescription" runat="server" />
       <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription" ErrorMessage="*" ValidationGroup="vNew"></asp:RequiredFieldValidator>
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="PM Interval" SortExpression="PMInterval" InsertVisible="false">
      <ItemTemplate><%# Eval("PMInterval")%> days</ItemTemplate>
      <EditItemTemplate>
       <asp:TextBox ID="txtPMInterval" runat="server" Text='<%# Bind("PMInterval") %>' Width="50px" /> days
       <asp:RequiredFieldValidator ID="rfvPMInterval" runat="server" ControlToValidate="txtPMInterval" ErrorMessage="*" ValidationGroup="vUpdate"></asp:RequiredFieldValidator>
      </EditItemTemplate>
      <FooterTemplate>
       <asp:TextBox ID="txtPMInterval" runat="server" Width="50px" /> days
       <asp:RequiredFieldValidator ID="rfvPMInterval" runat="server" ControlToValidate="txtPMInterval" ErrorMessage="*" ValidationGroup="vNew"></asp:RequiredFieldValidator>
      </FooterTemplate>
     </asp:TemplateField>
    </Columns>
    <EmptyDataTemplate>
     <table>
      <tr>
       <td><b>TaskID</b></td>
       <td><b>TaskName</b></td>
       <td><b>Description</b></td>
       <td><b>PM Interval</b></td>
       <td>&nbsp;</td>
      </tr>
      <tr>
       <td><asp:TextBox ID="txtTaskID" runat="server" /></td>
       <td><asp:TextBox ID="txtTaskName" runat="server" /></td>
       <td><asp:TextBox ID="txtDescription" runat="server" /></td>
       <td><asp:TextBox ID="txtPMInterval" runat="server" Width="50px" /> days</td>
       <td><asp:Button ID="btnNew" runat="server" Text="Save" CssClass="NavBtn" CommandName="AddNew" CommandArgument="Empty" /></td>
      </tr>
     </table>
    </EmptyDataTemplate>
   </asp:GridView>
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="ddlMachineList" EventName="SelectedIndexChanged" /></Triggers>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsMachineList" runat="server" TypeName="myBiz.DAL.clsPreventiveMaintenance" SelectMethod="ID_S"></asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsPMTask" runat="server" TypeName="myBiz.DAL.clsPreventiveMaintenance" SelectMethod="Machine_PMTask_S" UpdateMethod="Machine_PMTask_Save">
  <SelectParameters><asp:ControlParameter Name="MacID" Type="Int32" ControlID="ddlMachineList" PropertyName="SelectedValue" /></SelectParameters>
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:ControlParameter Name="MacID" Type="Int32" ControlID="ddlMachineList" PropertyName="SelectedValue" />
   <asp:Parameter Name="TaskID" Type="String" />
   <asp:Parameter Name="TaskName" Type="String" />
   <asp:Parameter Name="Description" Type="String" />
   <asp:Parameter Name="PMInterval" Type="Int32" />
   <asp:Parameter Name="IsActive" Type="Boolean" DefaultValue="true" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>