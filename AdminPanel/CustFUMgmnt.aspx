<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="CustFUMgmnt.aspx.cs" Inherits="webApp.AdminPanel.CustFUMgmnt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <ajax:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
  <ajax:TabPanel ID="tabResult" runat="server" HeaderText="Result">
   <ContentTemplate>
    <aspx:UpdatePanel ID="uPnlResult" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
      <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="true">
       <asp:ListItem Text="Follow Up" Value="Follow Up"></asp:ListItem>
       <asp:ListItem Text="Waiting RFQ" Value="Waiting RFQ"></asp:ListItem>
       <asp:ListItem Text="Waiting PO" Value="Waiting PO"></asp:ListItem>
       <asp:ListItem Text="Received RFQ" Value="Received RFQ"></asp:ListItem>
       <asp:ListItem Text="Received PO" Value="Received PO"></asp:ListItem>
      </asp:DropDownList>
      <br /><br />
      <asp:GridView ID="gvResult" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsResult" ShowFooter="true" OnRowCommand="gvCmd">
       <Columns>
        <asp:TemplateField>
         <ItemTemplate>
          <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
         </ItemTemplate>
         <EditItemTemplate>
          <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="vEdit" />
          <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
         </EditItemTemplate>
         <FooterTemplate><asp:Button ID="btnAdd" Text="Add New" runat="server" CommandName="AddNew" CssClass="NavBtn" ValidationGroup="vAdd" /></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Result" SortExpression="mText" InsertVisible="false">
         <ItemTemplate><%# Eval("mText") %></ItemTemplate>
         <EditItemTemplate>
          <asp:TextBox ID="txtmText" runat="server" Text='<%# Bind("mText") %>' Width="500px" />
          <asp:RequiredFieldValidator ID="rfvResult" runat="server" ControlToValidate="txtmText" Text="*" ErrorMessage="Result is required!" ValidationGroup="vEdit"></asp:RequiredFieldValidator>
         </EditItemTemplate>
         <FooterTemplate>
          <asp:TextBox ID="txtmText" runat="server" />
          <asp:RequiredFieldValidator ID="rfvResult" runat="server" ControlToValidate="txtmText" Text="*" ErrorMessage="Result is required!" ValidationGroup="vAdd"></asp:RequiredFieldValidator>
         </FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Next Status" SortExpression="nextStatus" InsertVisible="false">
         <ItemTemplate><%# Eval("nextStatus") %></ItemTemplate>
         <EditItemTemplate>
          <asp:TextBox ID="txtNextStatus" runat="server" Text='<%# Bind("nextStatus") %>' />
          <asp:RequiredFieldValidator ID="rfvNextStatus" runat="server" ControlToValidate="txtNextStatus" Text="*" ErrorMessage="Next Status is required!" ValidationGroup="vEdit"></asp:RequiredFieldValidator>
         </EditItemTemplate>
         <FooterTemplate>
          <asp:TextBox ID="txtNextStatus" runat="server" />
          <asp:RequiredFieldValidator ID="rfvNextStatus" runat="server" ControlToValidate="txtNextStatus" Text="*" ErrorMessage="Next Status is required!" ValidationGroup="vAdd"></asp:RequiredFieldValidator>
         </FooterTemplate>
        </asp:TemplateField>
       </Columns>
      </asp:GridView>
      <asp:ObjectDataSource ID="odsResult" runat="server" TypeName="myBiz.DAL.clsCustFU" SelectMethod="Result_S" UpdateMethod="Result_Save">
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
    <span title="Call if there is RFQ">CIRFQ:</span> <asp:TextBox ID="txtCIRFQ" runat="server" Width="100px"></asp:TextBox> hours<br />
    <span title="Follow Up if there is RFQ">FIRFQ:</span> <asp:TextBox ID="txtFIRFQ" runat="server" Width="100px"></asp:TextBox> days<br />
    <span title="Follow Up for RFQ Period">FoURFQP:</span> <asp:TextBox ID="txtFoURFQP" runat="server" Width="100px"></asp:TextBox> days<br />
    <span title="RFQ Upload">RFQU:</span> <asp:TextBox ID="txtRFQU" runat="server" Width="100px"></asp:TextBox> hours<br />
    <span title="RFQ Entry">RFQE:</span> <asp:TextBox ID="txtRFQE" runat="server" Width="100px"></asp:TextBox> hours<br />
    <span title="Early Mark">Early Mark:</span> <asp:TextBox ID="txtEarlyMark" runat="server" Width="100px"></asp:TextBox> days<br />
    <span title="Be Late">Be Late:</span> <asp:TextBox ID="txtBeLate" runat="server" Width="100px"></asp:TextBox> days<br /><br />
    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="NavBtn" OnClick="doSave" /><br /><br />
    <MW:Message ID="iMsg" runat="server" />
   </ContentTemplate>
  </ajax:TabPanel>
  <ajax:TabPanel ID="tabCustomer" runat="server" HeaderText="Customers">
   <ContentTemplate>
    <MW:ChkBoxList ID="cblCustomers" runat="server" DataSourceID="odsCustomer" DataTextField="CompanyName" DataValueField="CustID" DataCheckedField="isSelected" RepeatColumns="5" RepeatDirection="Horizontal"></MW:ChkBoxList>
    <br /><br />
    <asp:Button ID="btnCustSave" runat="server" Text="Save" OnClick="doCustSave" />
    <br />
    <MW:Message ID="iCustMsg" runat="server" />
    <asp:ObjectDataSource ID="odsCustomer" runat="server" TypeName="myBiz.DAL.clsCustFU" SelectMethod="CustFU_ID_S" UpdateMethod="CustFU_ID_Save">
     <UpdateParameters>
      <asp:ControlParameter Name="HIDs" Type="String" ControlID="cblCustomers" PropertyName="SelectedValues" />
     </UpdateParameters>
    </asp:ObjectDataSource>
   </ContentTemplate>
  </ajax:TabPanel>
 </ajax:TabContainer>
</asp:Content>
