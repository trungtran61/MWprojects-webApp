<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="StepName.aspx.cs" Inherits="webApp.AdminPanel.StepName" %>
<%@ Register Src="~/_Controls/Progress.ascx" TagName="Progress" TagPrefix="ucProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <h3><%= this.Title %></h3>
 <ucProgress:Progress ID="abc" runat="server" />
 <aspx:UpdatePanel ID="udPnl" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   Show Active? <asp:DropDownList ID="ddlAL" runat="server" AutoPostBack="true" DataSourceID="odsActiveList" DataValueField="mValue" DataTextField="mText" /><br /><br />
   <asp:GridView ID="gvStepName" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="HID" DataSourceID="odsStepName" ForeColor="#333333" GridLines="None" ShowFooter="true" OnSelectedIndexChanged="gv_Select" OnRowDataBound="gv_Bound">
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <RowStyle BackColor="#EFF3FB" />
    <Columns>
     <asp:TemplateField FooterStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top">
      <ItemTemplate>
       <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" OnClick="lnk_Reset" />
       <asp:LinkButton ID="lnkDelete" runat="server" Text="Remove" CommandName="Delete" OnClick="lnk_Reset" OnClientClick="return confirm('Are you sure you want to remove?');" />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="vEdit" />
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
      </EditItemTemplate>
      <FooterTemplate><asp:Button ID="btnAdd" Text="Add New" runat="server" OnClick="btnAdd_Click" ValidationGroup="vAdd" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField FooterStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" HeaderText="Name" SortExpression="Name" InsertVisible="false">
      <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" Text='<%# Eval("Name") %>' CommandName="Select" /></ItemTemplate>
      <EditItemTemplate><asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>' /></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' />
       <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Step Name is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtName" ValidationGroup="vAdd" />
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField FooterStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" HeaderText="Description" SortExpression="Description" InsertVisible="false">
      <ItemTemplate><%# Eval("Description") %></ItemTemplate>
      <EditItemTemplate><asp:Label ID="lblDescription" runat="server" Text='<%# Bind("Description") %>' /></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField FooterStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" HeaderText="Top Note" SortExpression="TopNote" InsertVisible="false">
      <ItemTemplate><%# Eval("TopNote") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtTopNote" runat="server" Text='<%# Bind("TopNote") %>' TextMode="MultiLine" Width="300px" Height="100px" /></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtTopNote" runat="server" Text='<%# Bind("TopNote") %>' TextMode="MultiLine" Width="300px" Height="100px" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField FooterStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" HeaderText="Bottom Note" SortExpression="BottomNote" InsertVisible="false">
      <ItemTemplate><%# Eval("BottomNote") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtBottomNote" runat="server" Text='<%# Bind("BottomNote") %>' TextMode="MultiLine" Width="300px" Height="100px" /></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtBottomNote" runat="server" Text='<%# Bind("BottomNote") %>' TextMode="MultiLine" Width="300px" Height="100px" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField FooterStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top" HeaderText="Active" InsertVisible="false">
      <ItemTemplate>
       <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' Enabled="false" /></ItemTemplate>
      <EditItemTemplate>
       <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' /></EditItemTemplate>
      <FooterTemplate>
       <asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' /></FooterTemplate>
     </asp:TemplateField>
    </Columns>
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#9999CC" />
    <AlternatingRowStyle BackColor="White" />
    <EmptyDataTemplate>No Step Name Found!</EmptyDataTemplate>
   </asp:GridView>
   <br />
    <asp:ValidationSummary ID="vsEdit" runat="server" ValidationGroup="vEdit" />
    <asp:ValidationSummary ID="vsAdd" runat="server" ValidationGroup="vAdd" />
    <MW:Message ID="iMsg" runat="server" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <aspx:UpdatePanel ID="udPnl2" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
    <ajax:TabContainer ID="TabContainer1" runat="server" Visible="false" ActiveTabIndex="0">
     <ajax:TabPanel ID="tabMachine" runat="server" HeaderText="Machine/Process">
      <ContentTemplate>
       <asp:Table ID="tblMachine" runat="server" BackColor="Aquamarine">
        <asp:TableRow>
         <asp:TableCell Font-Bold="true">Available Machine/Tool ...</asp:TableCell>
         <asp:TableCell>&nbsp;</asp:TableCell>
         <asp:TableCell Font-Bold="true">Currently Used Machines ...</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
         <asp:TableCell><asp:ListBox ID="lbxRemM" runat="server" Height="350px" Width="350px" DataTextField="mText" DataValueField="mValue" /></asp:TableCell>
         <asp:TableCell HorizontalAlign="center">
          <asp:Button ID="btnAddProcessList" runat="server" Text=">>> Add >>>" OnClick="btnAddProcessList_Click" /><br />
          <asp:Button ID="btnDelProcessList" runat="server" Text="<< Remove <" OnClick="btnDelProcessList_Click" />
         </asp:TableCell>
         <asp:TableCell><asp:ListBox ID="lbxAddM" runat="server" Height="350px" Width="350px" DataTextField="mText" DataValueField="mValue" /></asp:TableCell>
        </asp:TableRow>
       </asp:Table>
      </ContentTemplate>
     </ajax:TabPanel>
     <ajax:TabPanel ID="tabTask" runat="server" HeaderText="Task">
      <ContentTemplate>
       <asp:Table ID="tblTask" runat="server" BackColor="BurlyWood">
        <asp:TableRow>
         <asp:TableCell Font-Bold="true">Available Tasks ...</asp:TableCell>
         <asp:TableCell>&nbsp;</asp:TableCell>
         <asp:TableCell Font-Bold="true">Currently Required Tasks ...</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
         <asp:TableCell><asp:ListBox ID="lbxRemT" runat="server" Height="350px" Width="350px" DataTextField="mText" DataValueField="HID" /></asp:TableCell>
         <asp:TableCell HorizontalAlign="center">
          <asp:Button ID="btnAddTask" runat="server" Text=">>> Add >>>" OnClick="btnAddTask_Click" /><br />
          <asp:Button ID="btnDelTask" runat="server" Text="<< Remove <" OnClick="btnDelTask_Click" />
         </asp:TableCell>
         <asp:TableCell><asp:ListBox ID="lbxAddT" runat="server" Height="350px" Width="350px" DataTextField="mText" DataValueField="HID" /></asp:TableCell>
        </asp:TableRow>
       </asp:Table>
      </ContentTemplate>
     </ajax:TabPanel>
    </ajax:TabContainer>
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="gvStepName" EventName="RowCommand" /></Triggers>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsActiveList" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="ActiveList" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="0" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsStepName" runat="server" TypeName="myBiz.DAL.clsStepName" InsertMethod="Insert" SelectMethod="Select" UpdateMethod="Update" DeleteMethod="Delete" OnInserted="odsUpdated">
  <SelectParameters><asp:ControlParameter ControlID="ddlAL" PropertyName="SelectedValue" Name="isActive" Type="Int32" /></SelectParameters>
  <DeleteParameters>
   <asp:Parameter Name="HID" Type="Int32" />
  </DeleteParameters>
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="Name" Type="String" />
   <asp:Parameter Name="Description" Type="String" />
   <asp:Parameter Name="TopNote" Type="String" />
   <asp:Parameter Name="BottomNote" Type="String" />
   <asp:Parameter Name="isActive" Type="Boolean" />
  </UpdateParameters>
  <InsertParameters>
   <asp:Parameter Name="Name" Type="String" />
   <asp:Parameter Name="Description" Type="String" />
   <asp:Parameter Name="TopNote" Type="String" />
   <asp:Parameter Name="BottomNote" Type="String" />
   <asp:Parameter Name="isActive" Type="Boolean" />
  </InsertParameters>
 </asp:ObjectDataSource>
</asp:Content>
