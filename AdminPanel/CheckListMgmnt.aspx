<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="CheckListMgmnt.aspx.cs" Inherits="webApp.AdminPanel.CheckListMgmnt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlCheckListMgmnt" runat="server">
  <ContentTemplate>
   <ajax:TabContainer ID="tabCheckListMgmnt" runat="server" ActiveTabIndex="0">
    <ajax:TabPanel ID="tabCheckList" runat="server" HeaderText="Check List">
     <ContentTemplate>
      <table>
       <tr style="vertical-align:top">
        <td>
         <aspx:UpdatePanel ID="uPnlCheckList" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <b>Active?</b> <asp:DropDownList ID="ddlCheckListActive" runat="server" DataTextField="mText" DataValueField="mValue" DataSourceID="odsActiveList" AutoPostBack="true"></asp:DropDownList>
           <asp:GridView ID="gvCheckList" runat="server" DataSourceID="odsCheckList" DataKeyNames="HID" SkinID="Default" OnRowCommand="rwCmd" ShowFooter="true">
            <Columns>
             <asp:TemplateField ItemStyle-Wrap="false">
              <ItemTemplate>
               <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="NavBtn" CommandName="Edit" />
              </ItemTemplate>
              <EditItemTemplate>
               <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="NavBtn" CommandName="Update" ValidationGroup="vEditT" />
               <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="NavBtn" CommandName="Cancel" />
              </EditItemTemplate>
              <FooterTemplate><asp:Button ID="btnAddCheckList" Text="Add" runat="server" CssClass="NavBtn" CommandName="AddNew" ValidationGroup="vAddT" /></FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="List Name" SortExpression="CheckListName" InsertVisible="false">
              <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("CheckListName") %>'></asp:LinkButton></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtCheckListName" runat="server" Text='<%# Bind("CheckListName") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvCheckListName" runat="server" ErrorMessage="List Name is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtCheckListName" ValidationGroup="vEditT" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtCheckListName" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvCheckListName" runat="server" ErrorMessage="List Name is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtCheckListName" ValidationGroup="vAddT" />
              </FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Active?" SortExpression="Active" InsertVisible="false">
              <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("Active")%>' Enabled="false" /></ItemTemplate>
              <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("Active")%>' /></EditItemTemplate>
              <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></FooterTemplate>
             </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
             <table cellpadding="5">
              <tr style="background-color:#507CD1; color:White;">
               <td>&nbsp;</td>
               <td align="center" style="white-space:nowrap;"><b>List Name</b></td>
               <td align="center" style="white-space:nowrap;"><b>Active?</b></td>
              </tr>
              <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
               <td><asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="NavBtn" CommandName="InsertNew" ValidationGroup="vNewT" /></td>
               <td>
                <asp:TextBox ID="txtCheckListName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCheckListName" runat="server" ErrorMessage="List Name is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtCheckListName" ValidationGroup="vNewT" />
               </td>
               <td><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsCheckList" runat="server" TypeName="myBiz.DAL.clsCheckList" SelectMethod="GetCheckLists" UpdateMethod="SaveCheckList">
            <SelectParameters><asp:ControlParameter Name="Active" Type="Int32" ControlID="ddlCheckListActive" PropertyName="SelectedValue" /></SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:Parameter Name="CheckListName" Type="String" />
             <asp:Parameter Name="Active" Type="Boolean" />
            </UpdateParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
         </aspx:UpdatePanel>
        </td>
        <td>
         <aspx:UpdatePanel ID="uPnlCheckListItems" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <b>Active?</b> <asp:DropDownList ID="ddlCheckListItemsActive" runat="server" DataTextField="mText" DataValueField="mValue" DataSourceID="odsActiveList" AutoPostBack="true"></asp:DropDownList>
           <asp:GridView ID="gvCheckListItems" runat="server" DataSourceID="odsCheckListItems" DataKeyNames="HID" SkinID="Default" OnRowCommand="rwCmd" ShowFooter="true">
            <Columns>
             <asp:TemplateField ItemStyle-Wrap="false">
              <ItemTemplate>
               <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="NavBtn" CommandName="Edit" />
              </ItemTemplate>
              <EditItemTemplate>
               <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="NavBtn" CommandName="Update" ValidationGroup="vEditA" />
               <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="NavBtn" CommandName="Cancel" />
              </EditItemTemplate>
              <FooterTemplate><asp:Button ID="btnAddCheckListItems" Text="Add" runat="server" CssClass="NavBtn" CommandName="AddNew" ValidationGroup="vAddA" /></FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Priority" SortExpression="Priority" InsertVisible="false">
              <ItemTemplate><%# Eval("Priority") %></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtPriority" runat="server" Text='<%# Bind("Priority") %>' Width="50px"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvPriority" runat="server" ErrorMessage="Priority is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtPriority" ValidationGroup="vEditA" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtPriority" runat="server" Width="50px"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvPriority" runat="server" ErrorMessage="Priority is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtPriority" ValidationGroup="vAddA" />
              </FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" ControlStyle-Width="100px" FooterStyle-Width="100px" HeaderStyle-Width="100px" ItemStyle-Width="100px" HeaderText="Time" SortExpression="ItemTime" InsertVisible="false">
              <ItemTemplate><%# Eval("ItemTime") %></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtItemTime" runat="server" Text='<%# Bind("ItemTime") %>' Width="100px"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvItemTime" runat="server" ErrorMessage="Time is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtItemTime" ValidationGroup="vEditA" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtItemTime" runat="server" Width="100px"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvItemTime" runat="server" ErrorMessage="Time is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtItemTime" ValidationGroup="vAddA" />
              </FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Name" SortExpression="Name" InsertVisible="false">
              <ItemTemplate><%# Eval("ItemName") %></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtItemName" runat="server" Text='<%# Bind("ItemName") %>' TextMode="MultiLine" Width="300px" Height="75px"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvItemName" runat="server" ErrorMessage="Name is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtItemName" ValidationGroup="vEditA" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtItemName" runat="server" TextMode="MultiLine" Width="300px" Height="75px"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvItemName" runat="server" ErrorMessage="Name is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtItemName" ValidationGroup="vAddA" />
              </FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Description" SortExpression="Description" InsertVisible="false">
              <ItemTemplate><%# Eval("Description") %></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine" Width="500px" Height="75px"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Description is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtDescription" ValidationGroup="vEditA" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Width="500px" Height="75px"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Description is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtDescription" ValidationGroup="vAddA" />
              </FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Active?" SortExpression="Active" InsertVisible="false">
              <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("Active")%>' Enabled="false" /></ItemTemplate>
              <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("Active")%>' /></EditItemTemplate>
              <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></FooterTemplate>
             </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
             <table cellpadding="5">
              <tr style="background-color:#507CD1; color:White;">
               <td>&nbsp;</td>
               <td align="center" style="white-space:nowrap;"><b>Priority</b></td>
               <td align="center" style="white-space:nowrap;"><b>Time</b></td>
               <td align="center" style="white-space:nowrap;"><b>Name</b></td>
               <td align="center" style="white-space:nowrap;"><b>Description</b></td>
               <td align="center" style="white-space:nowrap;"><b>Active?</b></td>
              </tr>
              <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
               <td><asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="NavBtn" CommandName="InsertNew" ValidationGroup="vNewA" /></td>
               <td>
                <asp:TextBox ID="txtPriority" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPriority" runat="server" ErrorMessage="Priority is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtPriority" ValidationGroup="vNewA" />
               </td>
               <td>
                <asp:TextBox ID="txtItemTime" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvItemTime" runat="server" ErrorMessage="Time is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtItemTime" ValidationGroup="vNewA" />
               </td>
               <td>
                <asp:TextBox ID="txtItemName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvItemName" runat="server" ErrorMessage="Name is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtItemName" ValidationGroup="vNewA" />
               </td>
               <td>
                <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Description is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtDescription" ValidationGroup="vNewA" />
               </td>
               <td><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsCheckListItems" runat="server" TypeName="myBiz.DAL.clsCheckList" SelectMethod="GetCheckListItems" UpdateMethod="SaveCheckListItem">
            <SelectParameters>
             <asp:ControlParameter Name="CheckListID" Type="Int32" ControlID="gvCheckList" PropertyName="SelectedValue" />
             <asp:ControlParameter Name="Active" Type="Int32" ControlID="ddlCheckListItemsActive" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:ControlParameter Name="CheckListID" Type="Int32" ControlID="gvCheckList" PropertyName="SelectedValue" />
             <asp:Parameter Name="Priority" Type="Int32" />
             <asp:Parameter Name="ItemTime" Type="String" />
             <asp:Parameter Name="ItemName" Type="String" />
             <asp:Parameter Name="Description" Type="String" />
             <asp:Parameter Name="Active" Type="Boolean" />
            </UpdateParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
         </aspx:UpdatePanel>
        </td>
       </tr>
      </table>
      <MW:Message ID="iCheckListMsg" runat="server" />
     </ContentTemplate>
    </ajax:TabPanel>
    <ajax:TabPanel ID="tabUser" runat="server" HeaderText="Users">
     <ContentTemplate>
      <table>
       <tr style="vertical-align:top">
        <td>
         <aspx:UpdatePanel ID="uPnlCheckListUser" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <b>Check List:</b> <asp:DropDownList ID="ddlCheckListUser" runat="server" DataTextField="CheckListName" DataValueField="HID" DataSourceID="odsCheckListUser" AutoPostBack="true"></asp:DropDownList>
           <br /><br />
           <MW:ChkBoxList ID="cblUser" runat="server" DataSourceID="odsUser" DataCheckedField="Selected" DataTextField="UserName" DataValueField="UserName" RepeatColumns="5"></MW:ChkBoxList>
           <br /><asp:Button ID="btnSave" runat="server" Text="Save" OnClick="doSave" CssClass="NavBtn" />
           <asp:ObjectDataSource ID="odsCheckListUser" runat="server" TypeName="myBiz.DAL.clsCheckList" SelectMethod="GetCheckLists">
            <SelectParameters><asp:Parameter Name="Active" Type="Int32" DefaultValue="1" /></SelectParameters>
           </asp:ObjectDataSource>
           <asp:ObjectDataSource ID="odsUser" runat="server" TypeName="myBiz.DAL.clsCheckList" SelectMethod="GetCheckListUsers" UpdateMethod="SaveCheckListUsers">
            <SelectParameters>
             <asp:ControlParameter Name="CheckListID" Type="Int32" ControlID="ddlCheckListUser" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
             <asp:ControlParameter Name="CheckListID" Type="Int32" ControlID="ddlCheckListUser" PropertyName="SelectedValue" />
             <asp:ControlParameter Name="UserNames" Type="String" ControlID="cblUser" PropertyName="SelectedValues" />
            </UpdateParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
         </aspx:UpdatePanel>
        </td>
       </tr>
      </table>
      <MW:Message ID="iCheckListUserMsg" runat="server" />
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
</asp:Content>
