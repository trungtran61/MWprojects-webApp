<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="PoCustMgmnt.aspx.cs" Inherits="webApp.AdminPanel.PoCustMgmnt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlCustomer" runat="server">
  <ContentTemplate>
    <table>
     <tr valign="top">
      <td>
       <b>Active:</b>
       <asp:DropDownList ID="ddlActive" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
        <asp:ListItem Value="true" Text="Yes"></asp:ListItem>
        <asp:ListItem Value="false" Text="No"></asp:ListItem>
       </asp:DropDownList>
       <br />
       <asp:GridView ID="gvCustomer" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsCustomer" AllowSorting="true" ShowFooter="true" OnRowCommand="gvCustCmd">
        <Columns>
         <asp:TemplateField>
          <ItemTemplate>
           <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="NavBtn" />
          </ItemTemplate>
          <EditItemTemplate>
           <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="Update" CssClass="NavBtn" />
           <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="NavBtn" />
          </EditItemTemplate>
          <FooterTemplate><asp:Button ID="btnAdd" runat="server" CommandName="Add" Text="Add" CssClass="NavBtn" /></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Customer Name" SortExpression="CompanyName">
          <ItemTemplate><asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("CompanyName") %>' /></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtCompanyName" runat="server" Text='<%# Bind("CompanyName") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtCompanyName" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Customer ID" SortExpression="CompanyID">
          <ItemTemplate><%# Eval("CompanyID") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtCompanyID" runat="server" Text='<%# Bind("CompanyID") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtCompanyID" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Entered By" SortExpression="EnteredBy">
          <ItemTemplate><%# Eval("EnteredBy") %></ItemTemplate>
          <EditItemTemplate><%# Eval("EnteredBy") %></EditItemTemplate>
          <FooterTemplate>N/A</FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Entered Date" SortExpression="EnteredDate">
          <ItemTemplate><%# Eval("EnteredDate") %></ItemTemplate>
          <EditItemTemplate><%# Eval("EnteredDate") %></EditItemTemplate>
          <FooterTemplate>N/A</FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Active" SortExpression="isActive">
          <ItemTemplate><asp:CheckBox ID="chkActive" runat="server" Enabled="false" Checked='<%# Eval("isActive") %>' /></ItemTemplate>
          <EditItemTemplate><asp:CheckBox ID="chkActive" runat="server" Checked='<%# Bind("isActive") %>' Enabled='<%# Bind("isEnable") %>' /></EditItemTemplate>
          <FooterTemplate><asp:CheckBox ID="chkActive" runat="server" /></FooterTemplate>
         </asp:TemplateField>
        </Columns>
       </asp:GridView>
       <asp:ObjectDataSource ID="odsCustomer" runat="server" TypeName="myBiz.DAL.clsPoCustFU" SelectMethod="PoCustFU_Data_S" UpdateMethod="PoCustFU_Data_Save">
        <SelectParameters><asp:ControlParameter Name="isActive" Type="Boolean" ControlID="ddlActive" PropertyName="SelectedValue" /></SelectParameters>
        <UpdateParameters>
         <asp:Parameter Name="HID" Type="Int32" />
         <asp:Parameter Name="CompanyName" Type="String" />
         <asp:Parameter Name="CompanyID" Type="String" />
         <asp:Parameter Name="isActive" Type="Boolean" />
         <asp:Parameter Name="uID" Type="String" />
        </UpdateParameters>
       </asp:ObjectDataSource>
      </td>
      <td style="background-color: #fefaed">
       <asp:GridView ID="gvContacts" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsContacts" ShowFooter="true" OnRowCommand="gvContactCmd">
        <Columns>
         <asp:TemplateField>
          <ItemTemplate>
           <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="NavBtn" />
          </ItemTemplate>
          <EditItemTemplate>
           <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="Update" CssClass="NavBtn" />
           <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="NavBtn" />
          </EditItemTemplate>
          <FooterTemplate><asp:Button ID="btnAdd" runat="server" CommandName="Add" Text="Add" CssClass="NavBtn" /></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="First Name" SortExpression="FirstName" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
          <ItemTemplate><%# Eval("FirstName") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtFirstName" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Last Name" SortExpression="LastName" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
          <ItemTemplate><%# Eval("LastName") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtLastName" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtLastName" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Department" SortExpression="Dept" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
          <ItemTemplate><%# Eval("Dept") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtDept" runat="server" Text='<%# Bind("Dept") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtDept" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Phone" SortExpression="Phone" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
          <ItemTemplate><%# Eval("Phone") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtPhone" runat="server" Text='<%# Bind("Phone") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtPhone" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Fax" SortExpression="Fax" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
          <ItemTemplate><%# Eval("Fax") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtFax" runat="server" Text='<%# Bind("Fax") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtFax" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Cell" SortExpression="Cell" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
          <ItemTemplate><%# Eval("Cell") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtCell" runat="server" Text='<%# Bind("Cell") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtCell" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Email" SortExpression="Email" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
          <ItemTemplate><%# Eval("Email") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtEmail" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Address1" SortExpression="Address1" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
          <ItemTemplate><%# Eval("Address1") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtAddress1" runat="server" Text='<%# Bind("Address1") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtAddress1" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Address2" SortExpression="Address2" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
          <ItemTemplate><%# Eval("Address2") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtAddress2" runat="server" Text='<%# Bind("Address2") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtAddress2" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="City" SortExpression="City" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
          <ItemTemplate><%# Eval("City") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtCity" runat="server" Text='<%# Bind("City") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtCity" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="State" SortExpression="State" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
          <ItemTemplate><%# Eval("State") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtState" runat="server" Text='<%# Bind("State") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtState" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Zip" SortExpression="Zip" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
          <ItemTemplate><%# Eval("Zip") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtZip" runat="server" Text='<%# Bind("Zip") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtZip" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Website" SortExpression="Website" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
          <ItemTemplate><%# Eval("Website") %></ItemTemplate>
          <EditItemTemplate><asp:TextBox ID="txtWebsite" runat="server" Text='<%# Bind("Website") %>'></asp:TextBox></EditItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtWebsite" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
       <table>
        <tr>
         <td align="right"><b>First Name:</b></td>
         <td><asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox></td>
         <td align="right"><b>Last Name:</b></td>
         <td><asp:TextBox ID="txtLastName" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
         <td align="right"><b>Department:</b></td>
         <td><asp:TextBox ID="txtDept" runat="server"></asp:TextBox></td>
         <td align="right"><b>Phone:</b></td>
         <td><asp:TextBox ID="txtPhone" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
         <td align="right"><b>Fax:</b></td>
         <td><asp:TextBox ID="txtFax" runat="server"></asp:TextBox></td>
         <td align="right"><b>Cell:</b></td>
         <td><asp:TextBox ID="txtCell" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
         <td align="right"><b>Address1:</b></td>
         <td><asp:TextBox ID="txtAddress1" runat="server"></asp:TextBox></td>
         <td align="right"><b>Address2:</b></td>
         <td><asp:TextBox ID="txtAddress2" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
         <td align="right"><b>City:</b></td>
         <td><asp:TextBox ID="txtCity" runat="server"></asp:TextBox></td>
         <td align="right"><b>State:</b></td>
         <td><asp:TextBox ID="txtState" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
         <td align="right"><b>Zip:</b></td>
         <td><asp:TextBox ID="txtZip" runat="server"></asp:TextBox></td>
         <td align="right"><b>Email:</b></td>
         <td><asp:TextBox ID="txtEmail" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
         <td align="right"><b>Website:</b></td>
         <td><asp:TextBox ID="txtWebsite" runat="server"></asp:TextBox></td>
         <td colspan="2" align="right"><asp:Button ID="btnAddNew" runat="server" CommandName="AddNew" Text="Add New" CssClass="NavBtn" /></td>
        </tr>
       </table>


        </EmptyDataTemplate>
       </asp:GridView>
       <asp:ObjectDataSource ID="odsContacts" runat="server" TypeName="myBiz.DAL.clsPoCustFU" SelectMethod="PoCustFU_Contact_S" UpdateMethod="PoCustFU_Contact_Save">
        <SelectParameters><asp:ControlParameter Name="CustID" Type="Int32" ControlID="gvCustomer" PropertyName="SelectedValue" /></SelectParameters>
        <UpdateParameters>
         <asp:Parameter Name="HID" Type="Int32" />
         <asp:Parameter Name="CustID" Type="Int32" DefaultValue="-1" />
         <asp:Parameter Name="FirstName" Type="String" />
         <asp:Parameter Name="LastName" Type="String" />
         <asp:Parameter Name="Dept" Type="String" />
         <asp:Parameter Name="Phone" Type="String" />
         <asp:Parameter Name="Fax" Type="String" />
         <asp:Parameter Name="Cell" Type="String" />
         <asp:Parameter Name="Email" Type="String" />
         <asp:Parameter Name="Address1" Type="String" />
         <asp:Parameter Name="Address2" Type="String" />
         <asp:Parameter Name="City" Type="String" />
         <asp:Parameter Name="State" Type="String" />
         <asp:Parameter Name="Zip" Type="String" />
         <asp:Parameter Name="Website" Type="String" />
        </UpdateParameters>
       </asp:ObjectDataSource>
       <br /><br />
       <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="doRegister" CssClass="NavBtn" />
       <MW:Message ID="iCustMsg" runat="server" />
      </td>
     </tr>
    </table>
  </ContentTemplate>
 </aspx:UpdatePanel>
</asp:Content>