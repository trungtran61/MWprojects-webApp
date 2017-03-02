<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="RecQteFrmVdr.aspx.cs" Inherits="webApp.Tools.RecQteFrmVdr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <table style="background-color:#CCCCCC;">
  <tr>
   <td><br /><asp:DropDownList ID="ddlAppCode" runat="server"><asp:ListItem Value="WIP" Text="WIP"></asp:ListItem><asp:ListItem Value="RFQ" Text="RFQ"></asp:ListItem></asp:DropDownList></td>
   <td><b>WO_QTE#:</b><br /><asp:TextBox ID="txtWO_QTE" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>Step#:</b><br /><asp:TextBox ID="txtStepNo" runat="server" Width="50px"></asp:TextBox></td>
   <td><b>RFQ#:</b><br /><asp:TextBox ID="txtRFQNumber" runat="server" Width="100px"></asp:TextBox></td>
   <td><b>Item#:</b><br /><asp:TextBox ID="txtItemNo" runat="server" Width="50px"></asp:TextBox></td>
   <td><b>Vendor Name:</b><br /><asp:TextBox ID="txtVendorName" runat="server" Width="100px"></asp:TextBox></td>
   <td><b>Price:</b><br /><asp:TextBox ID="txtUnitPrice" runat="server" Width="75px"></asp:TextBox></td>
   <td><b>Lead Time:</b><br /><asp:TextBox ID="txtLeadTime" runat="server" Width="75px"></asp:TextBox></td>
   <td valign="bottom"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="NavBtn" OnClick="clickSearch" /></td>
   <td valign="bottom">
    <input type="button" name="mainArea_btnReset" value="Reset" id="mainArea_btnReset" class="NavBtn" onclick="javascript: location.href = 'RecQteFrmVdr.aspx';" />
   </td>
  </tr>
 </table>
 <aspx:UpdatePanel ID="uPnlQuote" runat="server">
  <ContentTemplate>
   <MW:Message ID="iMsg" runat="server" />
   <asp:GridView ID="gvQuote" runat="server" SkinID="Default" DataSourceID="odsQuote" DataKeyNames="HID,MO" AllowSorting="false" OnRowDataBound="rwBound" OnRowCommand="rwCmd">
    <Columns>
   <asp:TemplateField>
    <ItemTemplate>
     <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit"  CommandName="Edit"></asp:LinkButton>
     <asp:Literal ID="litCnt" runat="server" Text='<%# Eval("sCnt") %>'></asp:Literal>
    </ItemTemplate>
    <EditItemTemplate>
     <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update"  CommandName="Update" ValidationGroup="vUpdate"></asp:LinkButton>
     <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel"  CommandName="Cancel"></asp:LinkButton>
    </EditItemTemplate>
   </asp:TemplateField>
   <asp:BoundField ReadOnly="true" HeaderText="WO_QTE#" DataField="WO_QTE" SortExpression="WO_QTE" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Step#" DataField="StepNo" SortExpression="StepNo" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="RFQ#" DataField="RFQNumber" SortExpression="RFQNumber" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Item#" DataField="ItemNo" SortExpression="ItemNo" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Description" DataField="Description" SortExpression="Description" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Quantity" DataField="Quantity" SortExpression="Quantity" InsertVisible="false" />
   <asp:BoundField ReadOnly="true" HeaderText="Unit" DataField="Unit" SortExpression="Unit" InsertVisible="false" />
   <asp:TemplateField HeaderText="Unit Price ($)" SortExpression="UnitPrice" ControlStyle-Width="50px" InsertVisible="false" >
    <ItemTemplate><%# Eval("UnitPrice","{0:C}") %></ItemTemplate>
    <EditItemTemplate>
     <asp:TextBox ID="txtUnitPrice" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:TextBox>
     <asp:RequiredFieldValidator ID="rfvUnitPrice" runat="server" ControlToValidate="txtUnitPrice" ErrorMessage="Required!" ValidationGroup="vUpdate"></asp:RequiredFieldValidator>
    </EditItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Amount ($)" DataField="Amount" SortExpression="Amount" ControlStyle-Width="75px" InsertVisible="false" />
   <asp:TemplateField HeaderText="Lead Time (d)" SortExpression="LeadTime" ControlStyle-Width="50px" InsertVisible="false" >
    <ItemTemplate><%# Eval("LeadTime") %></ItemTemplate>
    <EditItemTemplate>
     <asp:TextBox ID="txtLeadTime" runat="server" Text='<%# Bind("LeadTime") %>'></asp:TextBox>
     <asp:RequiredFieldValidator ID="rfvLeadTime" runat="server" ControlToValidate="txtLeadTime" ErrorMessage="Required!" ValidationGroup="vUpdate"></asp:RequiredFieldValidator>
    </EditItemTemplate>
   </asp:TemplateField>
   <asp:BoundField ReadOnly="true" HeaderText="Vendor" DataField="VendorName" SortExpression="VendorName" InsertVisible="false" />
   <asp:BoundField HeaderText="Vendor Quote#" DataField="VendorQuote" SortExpression="VendorQuote" InsertVisible="false" />
   <asp:TemplateField HeaderText="Estimator" SortExpression="Estimator">
    <ItemTemplate><%# Eval("Estimator") %></ItemTemplate>
    <EditItemTemplate><%# Eval("Estimator") %></EditItemTemplate>
   </asp:TemplateField>
   <asp:BoundField ReadOnly="true" HeaderText="Estimate Date" DataField="EstDate" SortExpression="EstDate" InsertVisible="false" />
   <asp:TemplateField HeaderText="No Bid">
    <ItemTemplate><%# gLnk() %></ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Comment" DataField="Comment" SortExpression="Comment" InsertVisible="false" />
   <asp:TemplateField>
    <ItemTemplate>
     <asp:LinkButton ID="lnkFile" runat="server" Text="File" CommandName="viewFile" CommandArgument='<%# string.Format("{0}:{1}",Eval("HID"),Eval("MO")) %>'></asp:LinkButton>
    </ItemTemplate>
    <EditItemTemplate>
     <asp:LinkButton ID="lnkFile" runat="server" Text="File" CommandName="uploadFile" CommandArgument='<%# string.Format("{0}:{1}",Eval("HID"),Eval("MO")) %>'></asp:LinkButton>
    </EditItemTemplate>
   </asp:TemplateField>
    </Columns>
   </asp:GridView>
 <asp:Panel ID="pnlPopup" runat="server" />
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" /></Triggers>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsQuote" runat="server" TypeName="myBiz.DAL.clsQuote" SelectMethod="GetQuotes" UpdateMethod="SaveQuote">
  <SelectParameters>
   <asp:Parameter Name="isSearch" Type="Boolean" DefaultValue="False" />
   <asp:ControlParameter Name="WO_QTE" Type="String" ControlID="txtWO_QTE" PropertyName="Text" />
   <asp:ControlParameter Name="StepNo" Type="Int32" ControlID="txtStepNo" PropertyName="Text" />
   <asp:ControlParameter Name="RFQNumber" Type="String" ControlID="txtRFQNumber" PropertyName="Text" />
   <asp:ControlParameter Name="ItemNo" Type="String" ControlID="txtItemNo" PropertyName="Text" />
   <asp:ControlParameter Name="VendorName" Type="String" ControlID="txtVendorName" PropertyName="Text" />
   <asp:ControlParameter Name="UnitPrice" Type="Decimal" ControlID="txtUnitPrice" PropertyName="Text" />
   <asp:ControlParameter Name="LeadTime" Type="String" ControlID="txtLeadTime" PropertyName="Text" />
   <asp:ControlParameter Name="AppCode" Type="String" ControlID="ddlAppCode" PropertyName="SelectedValue" />
  </SelectParameters>
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="UnitPrice" Type="Double" />
   <asp:Parameter Name="Amount" Type="Double" />
   <asp:Parameter Name="LeadTime" Type="Int32" />
   <asp:Parameter Name="VendorQuote" Type="String" />
   <asp:Parameter Name="Comment" Type="String" />
   <asp:Parameter Name="MO" Type="String" />
   <asp:ControlParameter Name="AppCode" Type="String" ControlID="ddlAppCode" PropertyName="SelectedValue" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>
