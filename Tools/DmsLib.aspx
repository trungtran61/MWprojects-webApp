<%@ Page Title="Dimension Library" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="DmsLib.aspx.cs" Inherits="webApp.Tools.DmsLib" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlDmsLib" runat="server">
  <ContentTemplate>
   <asp:DropDownList ID="ddlMOGT" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSelected">
    <asp:ListItem Text="Gage" Value="Gage"></asp:ListItem>
    <asp:ListItem Text="Tool" Value="Tool"></asp:ListItem>
   </asp:DropDownList>
   <br />
      <table>
       <tr valign="top">
        <td>
         <aspx:UpdatePanel ID="uPnlDms" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <asp:GridView ID="gvDmsList" runat="server" DataSourceID="odsDmsList" DataKeyNames="HID" SkinID="Default" OnRowCommand="rwCmd" ShowFooter="true">
            <Columns>
             <asp:TemplateField ItemStyle-Wrap="false">
              <ItemTemplate>
               <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="NavBtn" CommandName="Edit" />
               <asp:Button ID="btnRemove" runat="server" Text="Remove" CssClass="NavBtn" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to remove?');" />
              </ItemTemplate>
              <EditItemTemplate>
               <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="NavBtn" CommandName="Update" ValidationGroup="vEditD" />
               <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="NavBtn" CommandName="Cancel" />
              </EditItemTemplate>
              <FooterTemplate><asp:Button ID="btnAddDms" Text="Add" runat="server" CssClass="NavBtn" CommandName="AddNew" ValidationGroup="vAddD" /></FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Dimension" SortExpression="GenDms" InsertVisible="false">
              <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("GenDms") %>'></asp:LinkButton></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtGenDms" runat="server" Text='<%# Bind("GenDms") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvDms" runat="server" ErrorMessage="Dimension is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtGenDms" ValidationGroup="vEditD" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtGenDms" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvDms" runat="server" ErrorMessage="Dimension is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtGenDms" ValidationGroup="vAddD" />
              </FooterTemplate>
             </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
             <table cellpadding="5">
              <tr style="background-color:#507CD1; color:White;">
               <td>&nbsp;</td>
               <td align="center" style="white-space:nowrap;"><b>Dimension</b></td>
              </tr>
              <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
               <td><asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="NavBtn" CommandName="InsertNew" ValidationGroup="vNewD" /></td>
               <td>
                <asp:TextBox ID="txtGenDms" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDms" runat="server" ErrorMessage="Dimension is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtGenDms" ValidationGroup="vNewD" />
               </td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsDmsList" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Generic_Dms_S" UpdateMethod="Generic_Dms_Save" DeleteMethod="Generic_Dms_D">
            <SelectParameters><asp:ControlParameter Name="GenMOGT" Type="String" ControlID="ddlMOGT" PropertyName="SelectedValue" /></SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:ControlParameter Name="GenMOGT" Type="String" ControlID="ddlMOGT" PropertyName="SelectedValue" />
             <asp:Parameter Name="GenDms" Type="String" />
            </UpdateParameters>
            <DeleteParameters><asp:Parameter Name="HID" Type="Int32" /></DeleteParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
         </aspx:UpdatePanel>
        </td>
        <td>
         <aspx:UpdatePanel ID="uPnlUnit" runat="server" UpdateMode="Conditional">
          <ContentTemplate>
           <asp:GridView ID="gvUnitList" runat="server" DataSourceID="odsUnitList" DataKeyNames="HID" SkinID="Default" OnRowCommand="rwCmd" ShowFooter="true">
            <Columns>
             <asp:TemplateField ItemStyle-Wrap="false">
              <ItemTemplate>
               <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="NavBtn" CommandName="Edit" />
               <asp:Button ID="btnRemove" runat="server" Text="Remove" CssClass="NavBtn" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to remove?');" />
              </ItemTemplate>
              <EditItemTemplate>
               <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="NavBtn" CommandName="Update" ValidationGroup="vEditU" />
               <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="NavBtn" CommandName="Cancel" />
              </EditItemTemplate>
              <FooterTemplate><asp:Button ID="btnAddUnit" Text="Add" runat="server" CssClass="NavBtn" CommandName="AddNew" ValidationGroup="vAddU" /></FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Unit Text" SortExpression="GenUnitTxt" InsertVisible="false">
              <ItemTemplate><%# Eval("GenUnitTxt") %></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtGenUnitTxt" runat="server" Text='<%# Bind("GenUnitTxt") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvUnitTxt" runat="server" ErrorMessage="Unit Text is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtGenUnitTxt" ValidationGroup="vEditU" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtGenUnitTxt" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvUnitTxt" runat="server" ErrorMessage="Unit Text is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtGenUnitTxt" ValidationGroup="vAddU" />
              </FooterTemplate>
             </asp:TemplateField>
             <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false" HeaderText="Unit Value" SortExpression="GenUnitVal" InsertVisible="false">
              <ItemTemplate><%# Eval("GenUnitVal")%></ItemTemplate>
              <EditItemTemplate>
               <asp:TextBox ID="txtGenUnitVal" runat="server" Text='<%# Bind("GenUnitVal") %>'></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvUnitVal" runat="server" ErrorMessage="Unit Value is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtGenUnitVal" ValidationGroup="vEditU" />
              </EditItemTemplate>
              <FooterTemplate>
               <asp:TextBox ID="txtGenUnitVal" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="rfvUnitVal" runat="server" ErrorMessage="Unit Value is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtGenUnitVal" ValidationGroup="vAddU" />
              </FooterTemplate>
             </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
             <table cellpadding="5">
              <tr style="background-color:#507CD1; color:White;">
               <td>&nbsp;</td>
               <td align="center" style="white-space:nowrap;"><b>Unit Text</b></td>
               <td align="center" style="white-space:nowrap;"><b>Unit Value</b></td>
              </tr>
              <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
               <td><asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="NavBtn" CommandName="InsertNew" ValidationGroup="vNewU" /></td>
               <td>
                <asp:TextBox ID="txtGenUnitTxt" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUnitTxt" runat="server" ErrorMessage="Unit Text is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtGenUnitTxt" ValidationGroup="vNewU" />
               </td>
               <td>
                <asp:TextBox ID="txtGenUnitVal" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUnitVal" runat="server" ErrorMessage="Unit Value is required!" SetFocusOnError="true" Text="*" ControlToValidate="txtGenUnitVal" ValidationGroup="vNewU" />
               </td>
              </tr>
             </table>
            </EmptyDataTemplate>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsUnitList" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Generic_Unit_S" UpdateMethod="Generic_Unit_Save" DeleteMethod="Generic_Unit_D">
            <SelectParameters><asp:ControlParameter Name="GenDmsID" Type="Int32" ControlID="gvDmsList" PropertyName="SelectedValue" /></SelectParameters>
            <UpdateParameters>
             <asp:Parameter Name="HID" Type="Int32" />
             <asp:ControlParameter Name="GenDmsID" Type="Int32" ControlID="gvDmsList" PropertyName="SelectedValue" />
             <asp:Parameter Name="GenUnitTxt" Type="String" />
             <asp:Parameter Name="GenUnitVal" Type="String" />
            </UpdateParameters>
            <DeleteParameters><asp:Parameter Name="HID" Type="Int32" /></DeleteParameters>
           </asp:ObjectDataSource>
          </ContentTemplate>
          <Triggers>
           <aspx:AsyncPostBackTrigger ControlID="gvDmsList" EventName="SelectedIndexChanged" />
          </Triggers>
         </aspx:UpdatePanel>
        </td>
       </tr>
      </table>
      <MW:Message ID="iMsg" runat="server" />



  </ContentTemplate>
 </aspx:UpdatePanel>
</asp:Content>
