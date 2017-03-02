﻿<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="ToolTypeMgmnt.aspx.cs" Inherits="webApp.Tools.ToolTypeMgmnt" %>
<%@ Register Src="~/_Controls/ucVdrBlkTool.ascx" TagName="ucVdrBlkTool" TagPrefix="ucBlkTool" %>
<%@ Register Src="~/_Controls/ucVdrBlkToolNew.ascx" TagName="ucVdrBlkToolNew" TagPrefix="ucBlkTool" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlToolTypeMgmnt" runat="server">
  <ContentTemplate>
   <ajax:TabContainer ID="tabToolTypeMgmnt" runat="server" ActiveTabIndex="0">
    <ajax:TabPanel ID="tabTypeList" runat="server" HeaderText="Tool Type List">
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
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Type" SortExpression="ToolType" InsertVisible="false">
              <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("ToolType") %>'></asp:LinkButton></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtToolType" runat="server" Text='<%# Bind("ToolType") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvType" runat="server" ErrorMessage="Type is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtToolType" ValidationGroup="vEditT" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtToolType" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvType" runat="server" ErrorMessage="Type is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtToolType" ValidationGroup="vAddT" />
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
                <asp:TextBox ID="txtToolType" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvType" runat="server" ErrorMessage="Type is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtToolType" ValidationGroup="vNewT" />
               </td>
               <td><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsTypeList" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Tool_Type_S" UpdateMethod="Tool_Type_Save">
            <SelectParameters><asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlTypeActive" PropertyName="SelectedValue" /></SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:Parameter Name="ToolType" Type="String" />
             <asp:Parameter Name="isActive" Type="Boolean" />
            </UpdateParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
         </aspx:UpdatePanel>
        </td>
        <td>
         <aspx:UpdatePanel ID="uPnlName" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <b>Active?</b> <asp:DropDownList ID="ddlNameActive" runat="server" DataTextField="mText" DataValueField="mValue" DataSourceID="odsActiveList" AutoPostBack="true"></asp:DropDownList>
           <asp:GridView ID="gvNameList" runat="server" DataSourceID="odsNameList" DataKeyNames="HID" SkinID="Default" OnRowCommand="rwCmd" ShowFooter="true">
            <Columns>
             <asp:TemplateField ItemStyle-Wrap="false">
              <ItemTemplate>
               <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="NavBtn" CommandName="Edit" />
              </ItemTemplate>
              <EditItemTemplate>
               <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="NavBtn" CommandName="Update" ValidationGroup="vEditA" />
               <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="NavBtn" CommandName="Cancel" />
              </EditItemTemplate>
              <FooterTemplate><asp:Button ID="btnAddName" Text="Add" runat="server" CssClass="NavBtn" CommandName="AddNew" ValidationGroup="vAddA" /></FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Name" SortExpression="ToolName" InsertVisible="false">
              <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("ToolName") %>'></asp:LinkButton></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtToolName" runat="server" Text='<%# Bind("ToolName") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtToolName" ValidationGroup="vEditA" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtToolName" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtToolName" ValidationGroup="vAddA" />
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
               <td align="center" style="white-space:nowrap;"><b>Name</b></td>
               <td align="center" style="white-space:nowrap;"><b>Active?</b></td>
              </tr>
              <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
               <td><asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="NavBtn" CommandName="InsertNew" ValidationGroup="vNewA" /></td>
               <td>
                <asp:TextBox ID="txtToolName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtToolName" ValidationGroup="vNewA" />
               </td>
               <td><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsNameList" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Tool_Name_S" UpdateMethod="Tool_Name_Save">
            <SelectParameters>
             <asp:ControlParameter Name="ToolTypeID" Type="Int32" ControlID="gvTypeList" PropertyName="SelectedValue" />
             <asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlNameActive" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:ControlParameter Name="ToolTypeID" Type="Int32" ControlID="gvTypeList" PropertyName="SelectedValue" />
             <asp:Parameter Name="ToolName" Type="String" />
             <asp:Parameter Name="isActive" Type="Boolean" />
            </UpdateParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
          <Triggers>
           <aspx:AsyncPostBackTrigger ControlID="gvTypeList" EventName="SelectedIndexChanged" />
          </Triggers>
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
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Dimension" SortExpression="ToolDms" InsertVisible="false">
              <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("ToolDms") %>'></asp:LinkButton></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtToolDms" runat="server" Text='<%# Bind("ToolDms") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvDms" runat="server" ErrorMessage="Dimension is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtToolDms" ValidationGroup="vEditD" />
              </EditItemTemplate>
              <FooterTemplate>&nbsp;</FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Active?" SortExpression="isActive" InsertVisible="false">
              <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("isActive")%>' Enabled="false" /></ItemTemplate>
              <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive")%>' /></EditItemTemplate>
              <FooterTemplate>&nbsp;</FooterTemplate>
             </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
             <table cellpadding="5">
              <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
               <td><asp:Button ID="btnAdd" runat="server" Text="Add New Dimension" CssClass="NavBtn" CommandName="InsertNew" ValidationGroup="vNewD" /></td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsDmsList" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Tool_Dms_S" UpdateMethod="Tool_Dms_Save" InsertMethod="Tool_Dms_I">
            <SelectParameters>
             <asp:ControlParameter Name="ToolNameID" Type="Int32" ControlID="gvNameList" PropertyName="SelectedValue" />
             <asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlDmsActive" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:ControlParameter Name="ToolNameID" Type="Int32" ControlID="gvNameList" PropertyName="SelectedValue" />
             <asp:Parameter Name="ToolDms" Type="String" />
             <asp:Parameter Name="isActive" Type="Boolean" />
            </UpdateParameters>
            <InsertParameters>
             <asp:ControlParameter Name="ToolNameID" Type="Int32" ControlID="gvNameList" PropertyName="SelectedValue" />
             <asp:Parameter Name="ToolDmsIDs" Type="String" />
            </InsertParameters>
           </asp:ObjectDataSource>
           <asp:HiddenField ID="hfHID" runat="server" />
           <table id="tblDms" runat="server" class="mdlPopup">
            <tr>
             <td>
              <MW:ChkBoxList ID="clbDmsLib" runat="server" RepeatColumns="5" RepeatDirection="Horizontal" DataSourceID="odsDmsLib" DataValueField="HID" DataTextField="GenDms"></MW:ChkBoxList>
              <asp:ObjectDataSource ID="odsDmsLib" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Generic_Dms_S">
               <SelectParameters><asp:Parameter Name="GenMOGT" Type="String" DefaultValue="Tool" /></SelectParameters>
              </asp:ObjectDataSource>
             </td>
            </tr>
            <tr>
             <td>
              <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="addDms" CssClass="NavBtn" />
              <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="NavBtn" />
             </td>
            </tr>
           </table>
           <ajax:ModalPopupExtender ID="mpeDms" runat="server" TargetControlID="hfHID" PopupControlID="tblDms" BackgroundCssClass="mdlBackground"
            OkControlID="btnCancel" DropShadow="false" RepositionMode="RepositionOnWindowResize" />
          </ContentTemplate>
          <Triggers>
           <aspx:AsyncPostBackTrigger ControlID="gvNameList" EventName="SelectedIndexChanged" />
          </Triggers>
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
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Unit Text" SortExpression="ToolUnitTxt" InsertVisible="false">
              <ItemTemplate><%# Eval("ToolUnitTxt") %></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtToolUnitTxt" runat="server" Text='<%# Bind("ToolUnitTxt") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvUnitTxt" runat="server" ErrorMessage="Unit Text is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtToolUnitTxt" ValidationGroup="vEditU" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtToolUnitTxt" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvUnitTxt" runat="server" ErrorMessage="Unit Text is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtToolUnitTxt" ValidationGroup="vAddU" />
              </FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Unit Value" SortExpression="ToolUnitVal" InsertVisible="false">
              <ItemTemplate><%# Eval("ToolUnitVal")%></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtToolUnitVal" runat="server" Text='<%# Bind("ToolUnitVal") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvUnitVal" runat="server" ErrorMessage="Unit Value is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtToolUnitVal" ValidationGroup="vEditU" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtToolUnitVal" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvUnitVal" runat="server" ErrorMessage="Unit Value is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtToolUnitVal" ValidationGroup="vAddU" />
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
                <asp:TextBox ID="txtToolUnitTxt" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUnitTxt" runat="server" ErrorMessage="Unit Text is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtToolUnitTxt" ValidationGroup="vNewU" />
               </td>
               <td>
                <asp:TextBox ID="txtToolUnitVal" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUnitVal" runat="server" ErrorMessage="Unit Value is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtToolUnitVal" ValidationGroup="vNewU" />
               </td>
               <td><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsUnitList" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Tool_Unit_S" UpdateMethod="Tool_Unit_Save">
            <SelectParameters>
             <asp:ControlParameter Name="ToolDmsID" Type="Int32" ControlID="gvDmsList" PropertyName="SelectedValue" />
             <asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlUnitActive" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:ControlParameter Name="ToolDmsID" Type="Int32" ControlID="gvDmsList" PropertyName="SelectedValue" />
             <asp:Parameter Name="ToolUnitTxt" Type="String" />
             <asp:Parameter Name="ToolUnitVal" Type="String" />
             <asp:Parameter Name="isActive" Type="Boolean" />
            </UpdateParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
          <Triggers>
           <aspx:AsyncPostBackTrigger ControlID="gvDmsList" EventName="SelectedIndexChanged" />
          </Triggers>
         </aspx:UpdatePanel>
        </td>
       </tr>
      </table>
      <MW:Message ID="iTypeMsg" runat="server" />
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
           <asp:Label ID="lblNew" runat="server" Text="Add new tool to block for selected vendor" BackColor="Wheat" CssClass="Finger" Visible="false"></asp:Label>
           <asp:Panel ID="pnlNew" runat="server" BackColor="GhostWhite" Visible="false">
            <aspx:UpdatePanel ID="uPnlNewBlk" runat="server" UpdateMode="Conditional">
             <ContentTemplate><ucBlkTool:ucVdrBlkToolNew ID="ucNewBlk" runat="server" /></ContentTemplate>
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
              <ContentTemplate><ucBlkTool:ucVdrBlkTool ID="ucBM" mID='<%# Eval("HID") %>' VendorID="0" runat="server" /></ContentTemplate>
             </aspx:UpdatePanel>
            </ItemTemplate>
           </asp:DataList>
          </td>
         </tr>
        </table><br />
        <asp:ObjectDataSource ID="odsBlkVendor" runat="server" TypeName="myBiz.DAL.clsVendor" SelectMethod="Vendor_BlkTool_IDs">
         <SelectParameters><asp:ControlParameter Name="VendorID" Type="Int32" ControlID="ddlVendorList" PropertyName="SelectedValue" /></SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsVendorList" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="getCompanyList">
         <SelectParameters>
          <asp:Parameter Name="ClassName" Type="String" DefaultValue="Supplier" />
          <asp:Parameter Name="TypeName" Type="String" DefaultValue="Tools-Cutting-New" />
          <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
         </SelectParameters>
        </asp:ObjectDataSource>
       </ContentTemplate>
      </aspx:UpdatePanel>
     </ContentTemplate>
    </ajax:TabPanel>
    <ajax:TabPanel ID="tabDDL" runat="server" HeaderText="Cutting Method List">
     <ContentTemplate>
      <asp:GridView ID="gvDDL" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsDDL" ShowFooter="true" OnRowCommand="gvCmd">
       <Columns>
        <asp:TemplateField>
         <ItemTemplate>
          <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
         </ItemTemplate>
         <EditItemTemplate>
          <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" CssClass="NavBtn" />
          <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" CssClass="NavBtn" />
         </EditItemTemplate>
         <FooterTemplate><asp:Button ID="btnAdd" Text="Add New" runat="server" CommandName="AddNew" CssClass="NavBtn" /></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="ID" SortExpression="mValue" InsertVisible="false">
         <ItemTemplate><%# Eval("mValue") %></ItemTemplate>
         <EditItemTemplate><asp:TextBox ID="txtmValue" runat="server" Text='<%# Bind("mValue") %>' /></EditItemTemplate>
         <FooterTemplate><asp:TextBox ID="txtmValue" runat="server" /></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Name" SortExpression="mText" InsertVisible="false">
         <ItemTemplate><%# Eval("mText") %></ItemTemplate>
         <EditItemTemplate><asp:TextBox ID="txtmText" runat="server" Text='<%# Bind("mText") %>' /></EditItemTemplate>
         <FooterTemplate><asp:TextBox ID="txtmText" runat="server" /></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="SortOrder" SortExpression="SortOrder" InsertVisible="false">
         <ItemTemplate><%# Eval("SortOrder") %></ItemTemplate>
         <EditItemTemplate><asp:TextBox ID="txtSortOrder" runat="server" Text='<%# Bind("SortOrder") %>' Width="50px" /></EditItemTemplate>
         <FooterTemplate><asp:TextBox ID="txtSortOrder" runat="server" Width="50px" /></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Active">
         <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("isActive") %>' Enabled="false" /></ItemTemplate>
         <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' /></EditItemTemplate>
         <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" /></FooterTemplate>
        </asp:TemplateField>
       </Columns>
      </asp:GridView>
      <asp:ObjectDataSource ID="odsDDL" runat="server" TypeName="myBiz.DAL.clsDDL" SelectMethod="Select" UpdateMethod="Save">
       <SelectParameters><asp:Parameter Name="Category" Type="String" DefaultValue="CuttingMethod" /></SelectParameters>
       <UpdateParameters>
        <asp:Parameter Name="HID" Type="Int32" />
        <asp:Parameter Name="Category" Type="String" DefaultValue="CuttingMethod" />
        <asp:Parameter Name="mText" Type="String" />
        <asp:Parameter Name="mValue" Type="String" />
        <asp:Parameter Name="isActive" Type="Boolean" />
        <asp:Parameter Name="SortOrder" Type="Int32" />
       </UpdateParameters>
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
</asp:Content>
