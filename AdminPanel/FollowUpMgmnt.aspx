<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="FollowUpMgmnt.aspx.cs" Inherits="webApp.AdminPanel.FollowUpMgmnt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <ajax:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
  <ajax:TabPanel ID="tabResult" runat="server" HeaderText="Result">
   <ContentTemplate>
    <aspx:UpdatePanel ID="uPnlResult" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
      <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="true">
       <asp:ListItem Text="Confirming" Value="Confirming"></asp:ListItem>
       <asp:ListItem Text="Follow Up" Value="Follow Up"></asp:ListItem>
       <asp:ListItem Text="Waiting PO" Value="Waiting PO"></asp:ListItem>
       <asp:ListItem Text="History" Value="History"></asp:ListItem>
      </asp:DropDownList>
      <br /><br />
      <asp:GridView ID="gvResult" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsResult" ShowFooter="true" OnRowCommand="gvCmd">
       <Columns>
        <asp:TemplateField>
         <ItemTemplate>
          <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
         </ItemTemplate>
         <EditItemTemplate>
          <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
          <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
         </EditItemTemplate>
         <FooterTemplate><asp:Button ID="btnAdd" Text="Add New" runat="server" CommandName="AddNew" CssClass="NavBtn" /></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Result" SortExpression="mText" InsertVisible="false">
         <ItemTemplate><%# Eval("mText") %></ItemTemplate>
         <EditItemTemplate><asp:TextBox ID="txtmText" runat="server" Text='<%# Bind("mText") %>' Width="500px" /></EditItemTemplate>
         <FooterTemplate><asp:TextBox ID="txtmText" runat="server" /></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Next Status" SortExpression="nextStatus" InsertVisible="false">
         <ItemTemplate><%# Eval("nextStatus") %></ItemTemplate>
         <EditItemTemplate><asp:TextBox ID="txtNextStatus" runat="server" Text='<%# Bind("nextStatus") %>' /></EditItemTemplate>
         <FooterTemplate><asp:TextBox ID="txtNextStatus" runat="server" /></FooterTemplate>
        </asp:TemplateField>
       </Columns>
      </asp:GridView>
      <asp:ObjectDataSource ID="odsResult" runat="server" TypeName="myBiz.DAL.clsFollowUp" SelectMethod="Result_S" UpdateMethod="Result_Save">
       <SelectParameters><asp:ControlParameter ControlID="ddlStatus" Name="curStatus" Type="String" PropertyName="SelectedValue" /></SelectParameters>
       <UpdateParameters>
        <asp:Parameter Name="HID" Type="Int32" />
        <asp:Parameter Name="curStatus" Type="String" />
        <asp:Parameter Name="nextStatus" Type="String" />
        <asp:Parameter Name="mText" Type="String" />
       </UpdateParameters>
      </asp:ObjectDataSource>
     </ContentTemplate>
    </aspx:UpdatePanel>
   </ContentTemplate>
  </ajax:TabPanel>
  <ajax:TabPanel ID="tabCutOffs" runat="server" HeaderText="Cut-Offs">
   <ContentTemplate>
    <span title="Send Period">SNP:</span> <asp:TextBox ID="txtSNP" runat="server" Width="100px"></asp:TextBox> hours<br />
    <span title="Call to Confirm Period">CCP:</span> <asp:TextBox ID="txtCCP" runat="server" Width="100px"></asp:TextBox> hours<br />
    <span title="Follow Up Period">FoUP:</span> <asp:TextBox ID="txtFoUP" runat="server" Width="100px"></asp:TextBox> days<br />
    <span title="Follow Up Period for PO">FoUPPO:</span> <asp:TextBox ID="txtFoUPPO" runat="server" Width="100px"></asp:TextBox> days<br />
    <span title="Early Mark">Early Mark:</span> <asp:TextBox ID="txtEarlyMark" runat="server" Width="100px"></asp:TextBox> days<br />
    <span title="Be Late">Be Late:</span> <asp:TextBox ID="txtBeLate" runat="server" Width="100px"></asp:TextBox> days<br /><br />
    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="NavBtn" OnClick="doSave" /><br /><br />
    <MW:Message ID="iMsg" runat="server" />
   </ContentTemplate>
  </ajax:TabPanel>
 </ajax:TabContainer>

</asp:Content>
