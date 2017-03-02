<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.AdminPanel.OpHrs" Title="Operation Hours" Codebehind="OpHrs.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <aspx:UpdatePanel ID="uPnlOpHrs" runat="server">
  <ContentTemplate>
   <table>
    <tr valign="top">
     <td>
      <asp:GridView ID="gvOpHrs" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="HID" DataSourceID="odsOpHrs" ForeColor="#333333" GridLines="None" OnRowCommand="gvCmd" OnRowDataBound="rwBound" OnDataBound="gvBound">
       <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
       <RowStyle BackColor="#EFF3FB" />
       <Columns>
        <asp:TemplateField ItemStyle-Wrap="false" FooterStyle-Wrap="false">
         <ItemTemplate>
          <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
          <asp:LinkButton ID="lnkDelete" runat="server" Text="Remove" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to remove?');" />
         </ItemTemplate>
         <EditItemTemplate>
          <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
          <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
         </EditItemTemplate>
         <FooterTemplate><asp:Button ID="btnAdd" Text="Add" runat="server" CommandName="AddNew" CssClass="NavBtn" /></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Day" SortExpression="dNum" ItemStyle-Wrap="false" FooterStyle-Wrap="false" InsertVisible="false">
         <ItemTemplate><%# Eval("DoW") %></ItemTemplate>
         <EditItemTemplate><%# Eval("DoW") %></EditItemTemplate>
         <FooterTemplate><asp:DropDownList ID="ddlDoW" runat="server" DataSourceID="odsDoW" DataValueField="mValue" DataTextField="mText" /></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Start" SortExpression="sDate" ItemStyle-Wrap="false" FooterStyle-Wrap="false" InsertVisible="false">
         <ItemTemplate><%# Eval("sDate", "{0:hh:mm tt}") %></ItemTemplate>
         <EditItemTemplate><telerik:RadTimePicker ID="rtpsDate" runat="server" TimeView-Interval="00:30:00" MinDate="1/1/1900" DbSelectedDate='<%# Bind("sDate") %>'></telerik:RadTimePicker></EditItemTemplate>
         <FooterTemplate><telerik:RadTimePicker ID="rtpsDate" runat="server" TimeView-Interval="00:30:00" MinDate="1/1/1900"></telerik:RadTimePicker></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="End" SortExpression="eDate" ItemStyle-Wrap="false" FooterStyle-Wrap="false" InsertVisible="false">
         <ItemTemplate><%# Eval("eDate", "{0:hh:mm tt}")%></ItemTemplate>
         <EditItemTemplate><telerik:RadTimePicker ID="rtpeDate" runat="server" TimeView-Interval="00:30:00" MinDate="1/1/1900" DbSelectedDate='<%# Bind("eDate") %>'></telerik:RadTimePicker></EditItemTemplate>
         <FooterTemplate><telerik:RadTimePicker ID="rtpeDate" runat="server" TimeView-Interval="00:30:00" MinDate="1/1/1900"></telerik:RadTimePicker></FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Duration" SortExpression="Sec" ItemStyle-Wrap="false" FooterStyle-Wrap="false" InsertVisible="false">
         <ItemTemplate><%# getDuration("Sec") %></ItemTemplate>
         <EditItemTemplate>N/A</EditItemTemplate>
         <FooterTemplate>N/A</FooterTemplate>
        </asp:TemplateField>
       </Columns>
       <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
       <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
       <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
       <EditRowStyle BackColor="#9999CC" />
       <AlternatingRowStyle BackColor="White" />
      </asp:GridView>
      <MW:Message ID="iMsg" runat="server" />
     </td>
     <td>
      <asp:GridView ID="gvTotalHrs" runat="server" SkinID="GrayHeader" DataKeyNames="dNum" DataSourceID="odsTotalHrs" OnRowDataBound="ttBound">
       <Columns>
        <asp:BoundField HeaderText="Day" DataField="DoW" SortExpression="dNum" InsertVisible="false" />
        <asp:TemplateField HeaderText="Total" SortExpression="TotalSec" InsertVisible="false">
         <ItemTemplate><%# getDuration("TotalSec") %></ItemTemplate>
        </asp:TemplateField>
       </Columns>
      </asp:GridView>
     </td>
    </tr>
   </table>
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsOpHrs" runat="server" TypeName="myBiz.DAL.clsOpHrs" SelectMethod="OpHrs_S" UpdateMethod="OpHrs_Save" DeleteMethod="OpHrs_D">
  <UpdateParameters>
   <asp:Parameter Name="HID" Type="Int32" />
   <asp:Parameter Name="DoW" Type="String" DefaultValue="" />
   <asp:Parameter Name="sDate" Type="DateTime" />
   <asp:Parameter Name="eDate" Type="DateTime" />
  </UpdateParameters>
  <DeleteParameters><asp:Parameter Name="HID" Type="Int32" /></DeleteParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsTotalHrs" runat="server" TypeName="myBiz.DAL.clsOpHrs" SelectMethod="OpHrs_Total"></asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsDoW" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="DoW" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="0" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>