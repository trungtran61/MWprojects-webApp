<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="MatlTypeMgmnt.aspx.cs" Inherits="webApp.Tools.MatlTypeMgmnt" %>
<%@ Register Src="~/_Controls/ucVdrBlkMatl.ascx" TagName="ucVdrBlkMatl" TagPrefix="ucBlkMatl" %>
<%@ Register Src="~/_Controls/ucVdrBlkMatlNew.ascx" TagName="ucVdrBlkMatlNew" TagPrefix="ucBlkMatl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlMatlTypeMgmnt" runat="server">
  <ContentTemplate>
   <ajax:TabContainer ID="tabMatlTypeMgmnt" runat="server" ActiveTabIndex="0">
    <ajax:TabPanel ID="tabTypeList" runat="server" HeaderText="Material Type List">
     <ContentTemplate>
      <table>
       <tr valign="top">
        <td>
         <aspx:UpdatePanel ID="uPnlType" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <b>Active?</b> <asp:DropDownList ID="ddlTypeActive" runat="server" DataTextField="mText" DataValueField="mValue" DataSourceID="odsActiveList" AutoPostBack="true"></asp:DropDownList>
           <asp:GridView ID="gvTypeList" runat="server" DataSourceID="odsTypeList" DataKeyNames="HID" SkinID="Default" OnRowCommand="rwCmd" ShowFooter="true">
            <Columns>
             <asp:TemplateField ItemStyle-Wrap="false">
              <ItemTemplate>
               <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="NavBtn" CommandName="Edit" />
              </ItemTemplate>
              <EditItemTemplate>
               <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="NavBtn" CommandName="Update" ValidationGroup="vEditT" />
               <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="NavBtn" CommandName="Cancel" />
              </EditItemTemplate>
              <FooterTemplate><asp:Button ID="btnAddType" Text="Add" runat="server" CssClass="NavBtn" CommandName="AddNew" ValidationGroup="vAddT" /></FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Type" SortExpression="MatlType" InsertVisible="false">
              <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("MatlType") %>'></asp:LinkButton></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtMatlType" runat="server" Text='<%# Bind("MatlType") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvType" runat="server" ErrorMessage="Type is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlType" ValidationGroup="vEditT" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtMatlType" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvType" runat="server" ErrorMessage="Type is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlType" ValidationGroup="vAddT" />
              </FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Active?" SortExpression="isActive" InsertVisible="false">
              <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("isActive")%>' Enabled="false" /></ItemTemplate>
              <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive")%>' /></EditItemTemplate>
              <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></FooterTemplate>
             </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
             <table cellpadding="5">
              <tr style="background-color:#507CD1; color:White;">
               <td>&nbsp;</td>
               <td align="center" style="white-space:nowrap;"><b>Type</b></td>
               <td align="center" style="white-space:nowrap;"><b>Active?</b></td>
              </tr>
              <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
               <td><asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="NavBtn" CommandName="InsertNew" ValidationGroup="vNewT" /></td>
               <td>
                <asp:TextBox ID="txtMatlType" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvType" runat="server" ErrorMessage="Type is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlType" ValidationGroup="vNewT" />
               </td>
               <td><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsTypeList" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Material_Type_S" UpdateMethod="Material_Type_Save">
            <SelectParameters><asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlTypeActive" PropertyName="SelectedValue" /></SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:Parameter Name="MatlType" Type="String" />
             <asp:Parameter Name="isActive" Type="Boolean" />
            </UpdateParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
         </aspx:UpdatePanel>
        </td>
        <td>
         <aspx:UpdatePanel ID="uPnlAms" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <b>Active?</b> <asp:DropDownList ID="ddlAmsActive" runat="server" DataTextField="mText" DataValueField="mValue" DataSourceID="odsActiveList" AutoPostBack="true"></asp:DropDownList>
           <asp:GridView ID="gvAmsList" runat="server" DataSourceID="odsAmsList" DataKeyNames="HID" SkinID="Default" OnRowCommand="rwCmd" ShowFooter="true">
            <Columns>
             <asp:TemplateField ItemStyle-Wrap="false">
              <ItemTemplate>
               <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="NavBtn" CommandName="Edit" />
              </ItemTemplate>
              <EditItemTemplate>
               <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="NavBtn" CommandName="Update" ValidationGroup="vEditA" />
               <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="NavBtn" CommandName="Cancel" />
              </EditItemTemplate>
              <FooterTemplate><asp:Button ID="btnAddAms" Text="Add" runat="server" CssClass="NavBtn" CommandName="AddNew" ValidationGroup="vAddA" /></FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Ams" SortExpression="MatlAms" InsertVisible="false">
              <ItemTemplate><%# Eval("MatlAms") %></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtMatlAms" runat="server" Text='<%# Bind("MatlAms") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvAms" runat="server" ErrorMessage="Ams is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlAms" ValidationGroup="vEditA" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtMatlAms" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvAms" runat="server" ErrorMessage="Ams is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlAms" ValidationGroup="vAddA" />
              </FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Active?" SortExpression="isActive" InsertVisible="false">
              <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("isActive")%>' Enabled="false" /></ItemTemplate>
              <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive")%>' /></EditItemTemplate>
              <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></FooterTemplate>
             </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
             <table cellpadding="5">
              <tr style="background-color:#507CD1; color:White;">
               <td>&nbsp;</td>
               <td align="center" style="white-space:nowrap;"><b>Ams</b></td>
               <td align="center" style="white-space:nowrap;"><b>Active?</b></td>
              </tr>
              <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
               <td><asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="NavBtn" CommandName="InsertNew" ValidationGroup="vNewA" /></td>
               <td>
                <asp:TextBox ID="txtMatlAms" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAms" runat="server" ErrorMessage="Ams is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlAms" ValidationGroup="vNewA" />
               </td>
               <td><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsAmsList" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Material_Ams_S" UpdateMethod="Material_Ams_Save">
            <SelectParameters>
             <asp:ControlParameter Name="MatlTypeID" Type="Int32" ControlID="gvTypeList" PropertyName="SelectedValue" />
             <asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlAmsActive" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:ControlParameter Name="MatlTypeID" Type="Int32" ControlID="gvTypeList" PropertyName="SelectedValue" />
             <asp:Parameter Name="MatlAms" Type="String" />
             <asp:Parameter Name="isActive" Type="Boolean" />
            </UpdateParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
         </aspx:UpdatePanel>
        </td>
       </tr>
      </table>
      <MW:Message ID="iTypeMsg" runat="server" />
     </ContentTemplate>
    </ajax:TabPanel>
    <ajax:TabPanel ID="tabFormList" runat="server" HeaderText="Material Form List">
     <ContentTemplate>
      <table>
       <tr valign="top">
        <td>
         <aspx:UpdatePanel ID="uPnlForm" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <b>Active?</b> <asp:DropDownList ID="ddlFormActive" runat="server" DataTextField="mText" DataValueField="mValue" DataSourceID="odsActiveList" AutoPostBack="true"></asp:DropDownList>
           <asp:GridView ID="gvFormList" runat="server" DataSourceID="odsFormList" DataKeyNames="HID" SkinID="Default" OnRowCommand="rwCmd" ShowFooter="true">
            <Columns>
             <asp:TemplateField ItemStyle-Wrap="false">
              <ItemTemplate>
               <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="NavBtn" CommandName="Edit" />
              </ItemTemplate>
              <EditItemTemplate>
               <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="NavBtn" CommandName="Update" ValidationGroup="vEditF" />
               <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="NavBtn" CommandName="Cancel" />
              </EditItemTemplate>
              <FooterTemplate><asp:Button ID="btnAddForm" Text="Add" runat="server" CssClass="NavBtn" CommandName="AddNew" ValidationGroup="vAddF" /></FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Form" SortExpression="MatlForm" InsertVisible="false">
              <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("MatlForm") %>'></asp:LinkButton></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtMatlForm" runat="server" Text='<%# Bind("MatlForm") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvForm" runat="server" ErrorMessage="Form is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlForm" ValidationGroup="vEditF" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtMatlForm" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvForm" runat="server" ErrorMessage="Form is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlForm" ValidationGroup="vAddF" />
              </FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Active?" SortExpression="isActive" InsertVisible="false">
              <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("isActive")%>' Enabled="false" /></ItemTemplate>
              <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive")%>' /></EditItemTemplate>
              <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></FooterTemplate>
             </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
             <table cellpadding="5">
              <tr style="background-color:#507CD1; color:White;">
               <td>&nbsp;</td>
               <td align="center" style="white-space:nowrap;"><b>Form</b></td>
               <td align="center" style="white-space:nowrap;"><b>Active?</b></td>
              </tr>
              <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
               <td><asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="NavBtn" CommandName="InsertNew" ValidationGroup="vNewF" /></td>
               <td>
                <asp:TextBox ID="txtMatlForm" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvForm" runat="server" ErrorMessage="Form is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlForm" ValidationGroup="vNewF" />
               </td>
               <td><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsFormList" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Material_Form_S" UpdateMethod="Material_Form_Save">
            <SelectParameters><asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlFormActive" PropertyName="SelectedValue" /></SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:Parameter Name="MatlForm" Type="String" />
             <asp:Parameter Name="isActive" Type="Boolean" />
            </UpdateParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
         </aspx:UpdatePanel>
        </td>
        <td>
         <aspx:UpdatePanel ID="uPnlDms" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <b>Active?</b> <asp:DropDownList ID="ddlDmsActive" runat="server" DataTextField="mText" DataValueField="mValue" DataSourceID="odsActiveList" AutoPostBack="true"></asp:DropDownList>
           <asp:GridView ID="gvDmsList" runat="server" DataSourceID="odsDmsList" DataKeyNames="HID" SkinID="Default" OnRowCommand="rwCmd" ShowFooter="true">
            <Columns>
             <asp:TemplateField ItemStyle-Wrap="false">
              <ItemTemplate>
               <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="NavBtn" CommandName="Edit" />
              </ItemTemplate>
              <EditItemTemplate>
               <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="NavBtn" CommandName="Update" ValidationGroup="vEditD" />
               <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="NavBtn" CommandName="Cancel" />
              </EditItemTemplate>
              <FooterTemplate><asp:Button ID="btnAddDms" Text="Add" runat="server" CssClass="NavBtn" CommandName="AddNew" ValidationGroup="vAddD" /></FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Dimension" SortExpression="MatlDms" InsertVisible="false">
              <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("MatlDms") %>'></asp:LinkButton></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtMatlDms" runat="server" Text='<%# Bind("MatlDms") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvDms" runat="server" ErrorMessage="Dimension is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlDms" ValidationGroup="vEditD" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtMatlDms" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvDms" runat="server" ErrorMessage="Dimension is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlDms" ValidationGroup="vAddD" />
              </FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Active?" SortExpression="isActive" InsertVisible="false">
              <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("isActive")%>' Enabled="false" /></ItemTemplate>
              <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive")%>' /></EditItemTemplate>
              <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></FooterTemplate>
             </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
             <table cellpadding="5">
              <tr style="background-color:#507CD1; color:White;">
               <td>&nbsp;</td>
               <td align="center" style="white-space:nowrap;"><b>Dimension</b></td>
               <td align="center" style="white-space:nowrap;"><b>Active?</b></td>
              </tr>
              <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
               <td><asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="NavBtn" CommandName="InsertNew" ValidationGroup="vNewD" /></td>
               <td>
                <asp:TextBox ID="txtMatlDms" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDms" runat="server" ErrorMessage="Dimension is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlDms" ValidationGroup="vNewD" />
               </td>
               <td><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsDmsList" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Material_Dms_S" UpdateMethod="Material_Dms_Save">
            <SelectParameters>
             <asp:ControlParameter Name="MatlFormID" Type="Int32" ControlID="gvFormList" PropertyName="SelectedValue" />
             <asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlDmsActive" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:ControlParameter Name="MatlFormID" Type="Int32" ControlID="gvFormList" PropertyName="SelectedValue" />
             <asp:Parameter Name="MatlDms" Type="String" />
             <asp:Parameter Name="isActive" Type="Boolean" />
            </UpdateParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
         </aspx:UpdatePanel>
        </td>
        <td>
         <aspx:UpdatePanel ID="uPnlUnit" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <b>Active?</b> <asp:DropDownList ID="ddlUnitActive" runat="server" DataTextField="mText" DataValueField="mValue" DataSourceID="odsActiveList" AutoPostBack="true"></asp:DropDownList>
           <asp:GridView ID="gvUnitList" runat="server" DataSourceID="odsUnitList" DataKeyNames="HID" SkinID="Default" OnRowCommand="rwCmd" ShowFooter="true">
            <Columns>
             <asp:TemplateField ItemStyle-Wrap="false">
              <ItemTemplate>
               <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="NavBtn" CommandName="Edit" />
              </ItemTemplate>
              <EditItemTemplate>
               <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="NavBtn" CommandName="Update" ValidationGroup="vEditU" />
               <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="NavBtn" CommandName="Cancel" />
              </EditItemTemplate>
              <FooterTemplate><asp:Button ID="btnAddUnit" Text="Add" runat="server" CssClass="NavBtn" CommandName="AddNew" ValidationGroup="vAddU" /></FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Unit Text" SortExpression="MatlUnitTxt" InsertVisible="false">
              <ItemTemplate><%# Eval("MatlUnitTxt") %></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtMatlUnitTxt" runat="server" Text='<%# Bind("MatlUnitTxt") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvUnitTxt" runat="server" ErrorMessage="Unit Text is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlUnitTxt" ValidationGroup="vEditU" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtMatlUnitTxt" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvUnitTxt" runat="server" ErrorMessage="Unit Text is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlUnitTxt" ValidationGroup="vAddU" />
              </FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Unit Value" SortExpression="MatlUnitVal" InsertVisible="false">
              <ItemTemplate><%# Eval("MatlUnitVal") %></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtMatlUnitVal" runat="server" Text='<%# Bind("MatlUnitVal") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvUnitVal" runat="server" ErrorMessage="Unit Value is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlUnitVal" ValidationGroup="vEditU" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtMatlUnitVal" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvUnitVal" runat="server" ErrorMessage="Unit Value is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlUnitVal" ValidationGroup="vAddU" />
              </FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Active?" SortExpression="isActive" InsertVisible="false">
              <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("isActive")%>' Enabled="false" /></ItemTemplate>
              <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive")%>' /></EditItemTemplate>
              <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></FooterTemplate>
             </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
             <table cellpadding="5">
              <tr style="background-color:#507CD1; color:White;">
               <td>&nbsp;</td>
               <td align="center" style="white-space:nowrap;"><b>Unit Text</b></td>
               <td align="center" style="white-space:nowrap;"><b>Unit Value</b></td>
               <td align="center" style="white-space:nowrap;"><b>Active?</b></td>
              </tr>
              <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
               <td><asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="NavBtn" CommandName="InsertNew" ValidationGroup="vNewU" /></td>
               <td>
                <asp:TextBox ID="txtMatlUnitTxt" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUnitTxt" runat="server" ErrorMessage="Unit Text is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlUnitTxt" ValidationGroup="vNewU" />
               </td>
               <td>
                <asp:TextBox ID="txtMatlUnitVal" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUnitVal" runat="server" ErrorMessage="Unit Value is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtMatlUnitVal" ValidationGroup="vNewU" />
               </td>
               <td><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsUnitList" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Material_Unit_S" UpdateMethod="Material_Unit_Save">
            <SelectParameters>
             <asp:ControlParameter Name="MatlDmsID" Type="Int32" ControlID="gvDmsList" PropertyName="SelectedValue" />
             <asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlUnitActive" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:ControlParameter Name="MatlDmsID" Type="Int32" ControlID="gvDmsList" PropertyName="SelectedValue" />
             <asp:Parameter Name="MatlUnitTxt" Type="String" />
             <asp:Parameter Name="MatlUnitVal" Type="String" />
             <asp:Parameter Name="isActive" Type="Boolean" />
            </UpdateParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
         </aspx:UpdatePanel>
        </td>
       </tr>
      </table>
      <MW:Message ID="iFormMsg" runat="server" />
     </ContentTemplate>
    </ajax:TabPanel>
    <ajax:TabPanel ID="tabVendorList" runat="server" HeaderText="Blocked Vendors">
     <ContentTemplate>
      <aspx:UpdatePanel ID="uPnlVendorList" runat="server" UpdateMode="Conditional">
       <ContentTemplate>
        <table>
         <tr><td><b>Vendor</b></td></tr>
         <tr>
          <td><asp:DropDownList ID="ddlVendorList" runat="server" DataSourceID="odsVendorList" DataTextField="CompanyName" DataValueField="HID" AutoPostBack="true" OnSelectedIndexChanged="ddlSelected"></asp:DropDownList><br /><br /></td>
         </tr>
         <tr>
          <td>
           <asp:Label ID="lblNew" runat="server" Text="Add new material to block for selected vendor" BackColor="Wheat" CssClass="Finger" Visible="false"></asp:Label>
           <asp:Panel ID="pnlNew" runat="server" BackColor="GhostWhite" Visible="false">
            <aspx:UpdatePanel ID="uPnlNewBlk" runat="server" UpdateMode="Conditional">
             <ContentTemplate><ucBlkMatl:ucVdrBlkMatlNew ID="ucNewBlk" runat="server" /></ContentTemplate>
            </aspx:UpdatePanel>
           </asp:Panel>
           <ajax:CollapsiblePanelExtender ID="cpeNew" runat="server" TargetControlID="pnlNew" ExpandControlID="lblNew" CollapseControlID="lblNew" Collapsed="true" Enabled="false" />
           <br />
          </td>
         </tr>
         <tr>
          <td>
           <asp:DataList ID="dlBlkVendor" runat="server" RepeatColumns="5" RepeatDirection="Horizontal" DataSourceID="odsBlkVendor" AlternatingItemStyle-VerticalAlign="Top" ItemStyle-VerticalAlign="Top">
            <ItemTemplate>
             <aspx:UpdatePanel ID="nPnlBlkVendor" runat="server" UpdateMode="Conditional">
              <ContentTemplate><ucBlkMatl:ucVdrBlkMatl ID="ucBM" mID='<%# Eval("HID") %>' VendorID="0" runat="server" /></ContentTemplate>
             </aspx:UpdatePanel>
            </ItemTemplate>
           </asp:DataList>
          </td>
         </tr>
        </table><br />
        <asp:ObjectDataSource ID="odsBlkVendor" runat="server" TypeName="myBiz.DAL.clsVendor" SelectMethod="Vendor_BlkMatl_IDs">
         <SelectParameters><asp:ControlParameter Name="VendorID" Type="Int32" ControlID="ddlVendorList" PropertyName="SelectedValue" /></SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsVendorList" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="getCompanyList">
         <SelectParameters>
          <asp:Parameter Name="ClassName" Type="String" DefaultValue="Supplier" />
          <asp:Parameter Name="TypeName" Type="String" DefaultValue="Material" />
          <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
         </SelectParameters>
        </asp:ObjectDataSource>
       </ContentTemplate>
      </aspx:UpdatePanel>
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
