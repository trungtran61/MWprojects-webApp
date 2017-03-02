<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.AdminPanel.MachineProcess" Title="Machine & Process" Codebehind="MachineProcess.aspx.cs" %>
<%@ Register Src="~/_Controls/Progress.ascx" TagName="Progress" TagPrefix="ucProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <h3>Machine & Process Management</h3>
 Please use this panel to manage machine list as well as process type.
 <ucProgress:Progress ID="abc" runat="server" />
 <aspx:UpdatePanel ID="uPnl1" runat="server">
  <ContentTemplate>
    <ajax:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
     <ajax:TabPanel ID="tabMachine" runat="server" HeaderText="Machine">
      <ContentTemplate>
       Show Active? <asp:DropDownList ID="ddlMAL" runat="server" AutoPostBack="true" DataSourceID="odsActiveList" DataValueField="mValue" DataTextField="mText" /><br /><br />
       <asp:GridView ID="gvMachine" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="HID" DataSourceID="odsMachine" ForeColor="#333333" GridLines="None" OnRowDataBound="gv_Bound">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
         <asp:TemplateField ItemStyle-Wrap="false">
          <ItemTemplate>
           <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
           <asp:LinkButton ID="lnkDelete" runat="server" Text="Remove" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to remove?');" />
          </ItemTemplate>
          <EditItemTemplate>
           <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="vEditM" />
           <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
          </EditItemTemplate>
          <FooterTemplate>
           <asp:Button ID="btnAddMachine" Text="Add New" runat="server" OnClick="btnAdd_Click" ValidationGroup="vAddM" /></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Machine ID" SortExpression="MachineID" InsertVisible="false">
          <ItemTemplate><%# Eval("MachineID") %></ItemTemplate>
          <EditItemTemplate><asp:Label ID="lblMachineID" runat="server" Text='<%# Bind("MachineID") %>' /></EditItemTemplate>
          <FooterTemplate>
           <asp:TextBox ID="txtMachineID" runat="server" Width="50px" Text='<%# Bind("MachineID") %>' />
           <asp:RequiredFieldValidator ID="rfvMachineID" runat="server" ErrorMessage="*" SetFocusOnError="true" Text="*" ControlToValidate="txtMachineID" ValidationGroup="vAddM" />
          </FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Name" SortExpression="Name" InsertVisible="false">
          <ItemTemplate><%# Eval("Name")%></ItemTemplate>
          <EditItemTemplate><asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>' /></EditItemTemplate>
          <FooterTemplate>
           <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' />
           <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="*" SetFocusOnError="true" Text="*" ControlToValidate="txtName" ValidationGroup="vAddM" />
          </FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField ItemStyle-Wrap="false" HeaderText="Manufacture" SortExpression="Manufacture" InsertVisible="false">
          <ItemTemplate><%# Eval("Manufacture")%></ItemTemplate>
          <EditItemTemplate>
           <asp:TextBox ID="txtManufacture" runat="server" Text='<%# Bind("Manufacture") %>' />
          </EditItemTemplate>
          <FooterTemplate>
           <asp:TextBox ID="txtManufacture" runat="server" Text='<%# Bind("Manufacture") %>' />
          </FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField ItemStyle-Wrap="false" HeaderText="Model" SortExpression="Model" InsertVisible="false">
          <ItemTemplate><%# Eval("Model")%></ItemTemplate>
          <EditItemTemplate>
           <asp:TextBox ID="txtModel" runat="server" Text='<%# Bind("Model") %>' />
          </EditItemTemplate>
          <FooterTemplate>
           <asp:TextBox ID="txtModel" runat="server" Text='<%# Bind("Model") %>' />
          </FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField ItemStyle-Wrap="false" HeaderText="Serial" SortExpression="Serial" InsertVisible="false">
          <ItemTemplate><%# Eval("Serial")%></ItemTemplate>
          <EditItemTemplate>
           <asp:TextBox ID="txtSerial" runat="server" Text='<%# Bind("Serial") %>' />
          </EditItemTemplate>
          <FooterTemplate>
           <asp:TextBox ID="txtSerial" runat="server" Text='<%# Bind("Serial") %>' />
          </FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField ItemStyle-Wrap="false" HeaderText="Type" SortExpression="Type" InsertVisible="false">
          <ItemTemplate>
           <%# Eval("Type") %>
          </ItemTemplate>
          <EditItemTemplate>
           <asp:DropDownList ID="ddlMachineType" runat="server" DataSourceID="odsMachineType" DataValueField="mValue" DataTextField="mText" SelectedValue='<%# Bind("Type") %>' />
          </EditItemTemplate>
          <FooterTemplate><asp:DropDownList ID="ddlMachineType" runat="server" DataSourceID="odsMachineType" DataValueField="mValue" DataTextField="mText" SelectedValue='<%# Bind("Type") %>' /></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField ItemStyle-Wrap="false" HeaderText="Active" InsertVisible="false">
          <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' Enabled="false" /></ItemTemplate>
          <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' /></EditItemTemplate>
          <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' /></FooterTemplate>
         </asp:TemplateField>
        </Columns>
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#9999CC" />
        <AlternatingRowStyle BackColor="White" />
        <EmptyDataTemplate>No Machine Found!</EmptyDataTemplate>
       </asp:GridView>
       <asp:ObjectDataSource ID="odsMachineType" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
        <SelectParameters>
         <asp:Parameter Name="Cate" Type="String" DefaultValue="MachineType" />
         <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="0" />
        </SelectParameters>
       </asp:ObjectDataSource>
       <asp:ObjectDataSource ID="odsMachine" runat="server" TypeName="myBiz.DAL.clsMachine" SelectMethod="Select" UpdateMethod="Update" InsertMethod="Insert" DeleteMethod="Delete">
        <SelectParameters>
         <asp:ControlParameter ControlID="ddlMAL" PropertyName="SelectedValue" Name="isActive" Type="Int32" DefaultValue="1" />
        </SelectParameters>
        <DeleteParameters>
         <asp:Parameter Name="HID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
         <asp:Parameter Name="HID" Type="Int32" />
         <asp:Parameter Name="MachineID" Type="String" />
         <asp:Parameter Name="Name" Type="String" />
         <asp:Parameter Name="Manufacture" Type="String" />
         <asp:Parameter Name="Model" Type="String" />
         <asp:Parameter Name="Serial" Type="String" />
         <asp:Parameter Name="Type" Type="String" />
         <asp:Parameter Name="isActive" Type="Boolean" />
        </UpdateParameters>
        <InsertParameters>
         <asp:Parameter Name="MachineID" Type="String" />
         <asp:Parameter Name="Name" Type="String" />
         <asp:Parameter Name="Manufacture" Type="String" />
         <asp:Parameter Name="Model" Type="String" />
         <asp:Parameter Name="Serial" Type="String" />
         <asp:Parameter Name="Type" Type="String" />
         <asp:Parameter Name="isActive" Type="Boolean" />
        </InsertParameters>
       </asp:ObjectDataSource>
      </ContentTemplate>
     </ajax:TabPanel>
     <ajax:TabPanel ID="tabProcess" runat="server" HeaderText="Process">
      <ContentTemplate>
       Show Active? <asp:DropDownList ID="ddlPAL" runat="server" AutoPostBack="true" DataSourceID="odsActiveList" DataValueField="mValue" DataTextField="mText" /><br /><br />
       <asp:GridView ID="gvProcess" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsProcess" OnRowDataBound="gv_Bound" OnRowCommand="gvCmd">
        <Columns>
         <asp:TemplateField>
          <ItemTemplate>
           <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="pEdit" />
           <asp:LinkButton ID="lnkDelete" runat="server" Text="Remove" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to remove?');" />
           <asp:HiddenField ID="hfvDefAcct" runat="server" Value='<%# Eval("vDefAcct") %>' />
           <asp:HiddenField ID="hfExpAcct" runat="server" Value='<%# Eval("ExpAcct") %>' />
           <asp:HiddenField ID="hfProCate" runat="server" Value='<%# Eval("ProCate") %>' />
          </ItemTemplate>
          <FooterTemplate><asp:Button ID="btnAddProcess" Text="Add New" runat="server" OnClick="btnAdd_Click" ValidationGroup="vAddP" /></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Process ID" SortExpression="ProcessID" InsertVisible="false">
          <ItemTemplate><%# Eval("ProcessID") %></ItemTemplate>
          <FooterTemplate>
           <asp:TextBox ID="txtProcessID" runat="server" Width="50px" />
           <asp:RequiredFieldValidator ID="rfvProcessID" runat="server" ErrorMessage="*" Text="*" ControlToValidate="txtProcessID" ValidationGroup="vAddP" />
          </FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Name" SortExpression="Name" InsertVisible="false">
          <ItemTemplate><%# Eval("Name")%></ItemTemplate>
          <FooterTemplate>
           <asp:TextBox ID="txtName" runat="server" />
           <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="*" Text="*" ControlToValidate="txtName" ValidationGroup="vAddP" />
          </FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Verification Time" SortExpression="TimeMargin" InsertVisible="false">
          <ItemTemplate><asp:Literal ID="litTimeMargin" runat="server" Text='<%# Eval("TimeMargin")%>'></asp:Literal></ItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtTimeMargin" runat="server" Width="75px" /></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Expense Acct." SortExpression="ExpAcct" InsertVisible="false">
          <ItemTemplate><%# Eval("tDefAcct")%></ItemTemplate>
          <FooterTemplate>&nbsp;</FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Catetory" SortExpression="ProCate" InsertVisible="false">
          <ItemTemplate><%# Eval("ProCate")%></ItemTemplate>
          <FooterTemplate><asp:DropDownList ID="ddlProCate" runat="server" DataSourceID="odsProCate" DataTextField="mText" DataValueField="mValue"></asp:DropDownList></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Active" InsertVisible="false">
          <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("isActive") %>' Enabled="false" /></ItemTemplate>
          <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" /></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="General Used" InsertVisible="false">
          <ItemTemplate><asp:CheckBox ID="chkGenUsed" runat="server" Checked='<%# Eval("GeneralUsed") %>' Enabled="false" /></ItemTemplate>
          <FooterTemplate><asp:CheckBox ID="chkGenUsed" runat="server" /></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="TNV" InsertVisible="false">
          <ItemTemplate><asp:Literal ID="litTnv" runat="server" Text='<%# Eval("Tnv") %>'></asp:Literal></ItemTemplate>
          <FooterTemplate>&nbsp;</FooterTemplate>
         </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>No Process Type Found!</EmptyDataTemplate>
       </asp:GridView>       
       
       <table id="tblProcess" runat="server" class="mdlPopup">
        <tr>
         <td>
          <table cellpadding="0" cellspacing="0" class="Tb2" width="100%">
           <tr>
            <td class="BlueBar"><b>Time [Hrs]:</b></td>
            <td>
             <asp:TextBox ID="txtTimeMargin" runat="server" Width="75px"></asp:TextBox>
             <asp:CheckBox ID="chkActive" runat="server" /> Active?
             <asp:CheckBox ID="chkGenUsed" runat="server" /> General Used?
            </td>
           </tr>
           <tr>
            <td class="BlueBar"><b>Target # of Vendor (TNV):</b></td>
            <td><asp:TextBox ID="txtTnv" runat="server" Width="30px"></asp:TextBox></td>
           </tr>
           <tr>
            <td colspan="2"><b>Expenses Account:</b><br />
             <MW:ChkBoxList ID="cblExpAcct" runat="server" DataCheckedField="isSelected" DataTextField="mText" DataValueField="mValue" RepeatColumns="3"></MW:ChkBoxList>
            </td>
           </tr>
           <tr>
            <td class="BlueBar"><b>Default Account:</b></td>
            <td><asp:TextBox ID="txtvDefAcct" runat="server" Width="50px"></asp:TextBox></td>
           </tr>
           <tr><td colspan="2">&nbsp;</td></tr>
           <tr>
            <td class="BlueBar"><b>Category:</b></td>
            <td><asp:DropDownList ID="ddlProCate" runat="server" DataSourceID="odsProCate" DataTextField="mText" DataValueField="mValue"></asp:DropDownList></td>
           </tr>
          </table>
         </td>
        </tr>
        <tr>
         <td>
          <asp:Button ID="btnAdd" runat="server" Text="Save Data" OnClick="sData" CssClass="NavBtn" />
          <asp:Button ID="btnClose" runat="server" Text="Close Window" CssClass="NavBtn" />
          <MW:Message ID="jMsg" runat="server" />
          <asp:HiddenField ID="hfHID" runat="server" Value="0" />
         </td>
        </tr>
       </table>
       <ajax:ModalPopupExtender ID="mpeProcess" runat="server" TargetControlID="hfHID" PopupControlID="tblProcess" BackgroundCssClass="modalBackground"
        OkControlID="btnClose" DropShadow="false" RepositionMode="RepositionOnWindowResize" />
       
       <asp:ObjectDataSource ID="odsProcess" runat="server" TypeName="myBiz.DAL.clsProcessType" SelectMethod="Select" UpdateMethod="Update1" InsertMethod="Insert" DeleteMethod="Delete">
        <SelectParameters>
         <asp:ControlParameter ControlID="ddlPAL" PropertyName="SelectedValue" Name="isActive" Type="Int32" />
         <asp:Parameter Name="AppCode" Type="String" DefaultValue="WIP" />
        </SelectParameters>
        <DeleteParameters>
         <asp:Parameter Name="HID" Type="Int32" />
         <asp:Parameter Name="AppCode" Type="String" DefaultValue="WIP" />
        </DeleteParameters>
        <UpdateParameters>
         <asp:Parameter Name="HID" Type="Int32" />
         <asp:Parameter Name="TimeMrg" Type="Decimal" />
         <asp:Parameter Name="ExpAcct" Type="String" />
         <asp:Parameter Name="vEAcct" Type="Int32" />
         <asp:Parameter Name="ProCate" Type="String" />
         <asp:Parameter Name="isActive" Type="Boolean" />
         <asp:Parameter Name="GeneralUsed" Type="Boolean" />
         <asp:Parameter Name="Tnv" Type="Int32" />
         <asp:Parameter Name="AppCode" Type="String" DefaultValue="WIP" />
        </UpdateParameters>
        <InsertParameters>
         <asp:Parameter Name="ProcessID" Type="String" />
         <asp:Parameter Name="Name" Type="String" />
         <asp:Parameter Name="TimeMargin" Type="Decimal" />
         <asp:Parameter Name="ProCate" Type="String" />
         <asp:Parameter Name="isActive" Type="Boolean" />
         <asp:Parameter Name="GeneralUsed" Type="Boolean" />
         <asp:Parameter Name="AppCode" Type="String" DefaultValue="WIP" />
        </InsertParameters>
       </asp:ObjectDataSource>
      </ContentTemplate>
     </ajax:TabPanel>
    </ajax:TabContainer>
  </ContentTemplate>
 </aspx:UpdatePanel>
 
 <asp:ObjectDataSource ID="odsActiveList" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="ActiveList" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="0" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsProCate" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="ProCate" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>