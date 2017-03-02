<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="OPSTypeMgmnt.aspx.cs" Inherits="webApp.Tools.OPSTypeMgmnt" %>
<%@ Register Src="~/_Controls/ucVdrBlkOPS.ascx" TagName="ucVdrBlkOPS" TagPrefix="ucBlkOPS" %>
<%@ Register Src="~/_Controls/ucVdrBlkOPSNew.ascx" TagName="ucVdrBlkOPSNew" TagPrefix="ucBlkOPS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlOPSTypeMgmnt" runat="server">
  <ContentTemplate>
   <ajax:TabContainer ID="tabOPSTypeMgmnt" runat="server" ActiveTabIndex="0">
    <ajax:TabPanel ID="tabTypeList" runat="server" HeaderText="OPS Type List">
     <ContentTemplate>
      <table>
       <tr valign="top">
        <td>
         <aspx:UpdatePanel ID="uPnlType" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <b>Active?</b> <asp:DropDownList ID="ddlTypeActive" runat="server" DataTextField="mText" DataValueField="mValue" DataSourceID="odsActiveList" AutoPostBack="true"></asp:DropDownList>
           <asp:GridView ID="gvTypeList" runat="server" DataSourceID="odsTypeList" DataKeyNames="HID" SkinID="Default" OnRowCommand="rwCmd" ShowFooter="true">
            <Columns>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Type" SortExpression="OPSType" InsertVisible="false">
              <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("OPSType") %>'></asp:LinkButton></ItemTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Active?" SortExpression="isActive" InsertVisible="false">
              <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Eval("isActive")%>' Enabled="false" /></ItemTemplate>
             </asp:TemplateField>
            </Columns>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsTypeList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Type_S">
            <SelectParameters><asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlTypeActive" PropertyName="SelectedValue" /></SelectParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
         </aspx:UpdatePanel>
        </td>
        <td>
         <aspx:UpdatePanel ID="uPnlSpec" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <b>Active?</b> <asp:DropDownList ID="ddlSpecActive" runat="server" DataTextField="mText" DataValueField="mValue" DataSourceID="odsActiveList" AutoPostBack="true"></asp:DropDownList>
           <asp:GridView ID="gvSpecList" runat="server" DataSourceID="odsSpecList" DataKeyNames="HID" SkinID="Default" OnRowCommand="rwCmd" ShowFooter="true">
            <Columns>
             <asp:TemplateField ItemStyle-Wrap="false">
              <ItemTemplate>
               <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="NavBtn" CommandName="Edit" />
              </ItemTemplate>
              <EditItemTemplate>
               <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="NavBtn" CommandName="Update" ValidationGroup="vEditS" />
               <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="NavBtn" CommandName="Cancel" />
              </EditItemTemplate>
              <FooterTemplate><asp:Button ID="btnAddSpec" Text="Add" runat="server" CssClass="NavBtn" CommandName="AddNew" ValidationGroup="vAddS" /></FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Spec" SortExpression="OPSSpec" InsertVisible="false">
              <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("OPSSpec") %>'></asp:LinkButton></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtOPSSpec" runat="server" Text='<%# Bind("OPSSpec") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvSpec" runat="server" ErrorMessage="Spec is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtOPSSpec" ValidationGroup="vEditS" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtOPSSpec" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvSpec" runat="server" ErrorMessage="Spec is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtOPSSpec" ValidationGroup="vAddS" />
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
               <td align="center" style="white-space:nowrap;"><b>Spec</b></td>
               <td align="center" style="white-space:nowrap;"><b>Active?</b></td>
              </tr>
              <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
               <td><asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="NavBtn" CommandName="InsertNew" ValidationGroup="vNewS" /></td>
               <td>
                <asp:TextBox ID="txtOPSSpec" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvSpec" runat="server" ErrorMessage="Spec is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtOPSSpec" ValidationGroup="vNewS" />
               </td>
               <td><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsSpecList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Spec_S" UpdateMethod="OPS_Spec_Save">
            <SelectParameters>
             <asp:ControlParameter Name="OPSTypeID" Type="Int32" ControlID="gvTypeList" PropertyName="SelectedValue" />
             <asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlSpecActive" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:ControlParameter Name="OPSTypeID" Type="Int32" ControlID="gvTypeList" PropertyName="SelectedValue" />
             <asp:Parameter Name="OPSSpec" Type="String" />
             <asp:Parameter Name="isActive" Type="Boolean" />
            </UpdateParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
         </aspx:UpdatePanel>
        </td>
        <td>
         <aspx:UpdatePanel ID="uPnlDesc" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <b>Active?</b> <asp:DropDownList ID="ddlDescActive" runat="server" DataTextField="mText" DataValueField="mValue" DataSourceID="odsActiveList" AutoPostBack="true"></asp:DropDownList>
           <asp:GridView ID="gvDescList" runat="server" DataSourceID="odsDescList" DataKeyNames="HID" SkinID="Default" OnRowCommand="rwCmd" ShowFooter="true">
            <Columns>
             <asp:TemplateField ItemStyle-Wrap="false">
              <ItemTemplate>
               <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="NavBtn" CommandName="Edit" />
              </ItemTemplate>
              <EditItemTemplate>
               <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="NavBtn" CommandName="Update" ValidationGroup="vEditD" />
               <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="NavBtn" CommandName="Cancel" />
              </EditItemTemplate>
              <FooterTemplate><asp:Button ID="btnAddDesc" Text="Add" runat="server" CssClass="NavBtn" CommandName="AddNew" ValidationGroup="vAddD" /></FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Desc" SortExpression="OPSDesc" InsertVisible="false">
              <ItemTemplate><div style="max-width:500px; max-height:150px; overflow:auto; white-space:normal"><%# Util.NewLine(Eval("OPSDesc")) %></div>
              </ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtOPSDesc" runat="server" Text='<%# Bind("OPSDesc") %>' TextMode="multiLine" Width="500px" Height="150px"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvDesc" runat="server" ErrorMessage="Desc is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtOPSDesc" ValidationGroup="vEditD" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtOPSDesc" runat="server" TextMode="multiLine" Width="500px" Height="150px"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvDesc" runat="server" ErrorMessage="Desc is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtOPSDesc" ValidationGroup="vAddD" />
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
               <td align="center" style="white-space:nowrap;"><b>Desc</b></td>
               <td align="center" style="white-space:nowrap;"><b>Active?</b></td>
              </tr>
              <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
               <td><asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="NavBtn" CommandName="InsertNew" ValidationGroup="vNewD" /></td>
               <td>
                <asp:TextBox ID="txtOPSDesc" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDesc" runat="server" ErrorMessage="Desc is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtOPSDesc" ValidationGroup="vNewD" />
               </td>
               <td><asp:CheckBox ID="chkActive" runat="server" Checked="true" /></td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsDescList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Desc_S" UpdateMethod="OPS_Desc_Save">
            <SelectParameters>
             <asp:ControlParameter Name="OPSSpecID" Type="Int32" ControlID="gvSpecList" PropertyName="SelectedValue" />
             <asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlDescActive" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:ControlParameter Name="OPSSpecID" Type="Int32" ControlID="gvSpecList" PropertyName="SelectedValue" />
             <asp:Parameter Name="OPSDesc" Type="String" />
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
             <ContentTemplate><ucBlkOPS:ucVdrBlkOPSNew ID="ucNewBlk" runat="server" /></ContentTemplate>
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
              <ContentTemplate><ucBlkOPS:ucVdrBlkOPS ID="ucBM" mID='<%# Eval("HID") %>' VendorID="0" runat="server" /></ContentTemplate>
             </aspx:UpdatePanel>
            </ItemTemplate>
           </asp:DataList>
          </td>
         </tr>
        </table><br />
        <asp:ObjectDataSource ID="odsBlkVendor" runat="server" TypeName="myBiz.DAL.clsVendor" SelectMethod="Vendor_BlkOPS_IDs">
         <SelectParameters><asp:ControlParameter Name="VendorID" Type="Int32" ControlID="ddlVendorList" PropertyName="SelectedValue" /></SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsVendorList" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="OPS_Vendors" />
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
