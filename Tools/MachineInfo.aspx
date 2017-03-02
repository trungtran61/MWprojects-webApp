<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Tools.MachineInfo" Title="Machine Info" Codebehind="MachineInfo.aspx.cs" %>
<%@ Register Src="~/_Controls/Progress.ascx" TagName="Progress" TagPrefix="ucProgress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" Runat="Server">
 <ucProgress:Progress ID="abc" runat="server" />
 <aspx:Timer ID="tRefresh" runat="server" OnTick="doRefresh"></aspx:Timer>
 <asp:Button ID="btnRefresh" runat="server" OnClick="doRefresh" Text="Refresh" CssClass="NavBtn"></asp:Button>
 <asp:Button ID="btnReset" runat="server" OnClick="doReset" Text="Reset" CssClass="NavBtn"></asp:Button>
 <br /><br />
 <ajax:TabContainer ID="tabMachine" runat="server" ActiveTabIndex="0">
  <ajax:TabPanel ID="tbStatus" runat="server" HeaderText="Status">
   <ContentTemplate>
    <aspx:UpdatePanel ID="uPnlStatus" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
      <table width="100%">
       <tr valign="top">
        <td align="left">
         <asp:DropDownList ID="ddlStFilter" runat="server" DataSourceID="odsStFilter" DataTextField="mText" DataValueField="mValue" AutoPostBack="true"></asp:DropDownList>
         <asp:CheckBox ID="chkStSug" runat="server" AutoPostBack="true" Text="Suggested Only" />
        </td>
        <td align="right"><asp:Literal ID="litStRefresh" runat="server"></asp:Literal></td>
       </tr>
      </table><br />
      <asp:DataList ID="dlMacStatus" runat="server" DataSourceID="odsMacStatus" RepeatColumns="3" RepeatDirection="Horizontal">
       <ItemTemplate><%# showMachine() %></ItemTemplate>
      </asp:DataList>
      <asp:HiddenField ID="hfStType" runat="server" OnLoad="hfLoad" />
      <asp:ObjectDataSource ID="odsMacStatus" runat="server" TypeName="myBiz.DAL.clsMachine" SelectMethod="Machine_Status_S">
       <SelectParameters>
        <asp:ControlParameter Name="MacType" Type="String" ControlID="hfStType" PropertyName="Value" />
        <asp:ControlParameter Name="MacTypeID" Type="String" ControlID="ddlStFilter" PropertyName="SelectedValue" />
        <asp:ControlParameter Name="curStatus" Type="Boolean" ControlID="chkStSug" PropertyName="Checked" />
       </SelectParameters>
      </asp:ObjectDataSource>
      <asp:ObjectDataSource ID="odsStFilter" runat="server" TypeName="myBiz.DAL.clsMachine" SelectMethod="MachineType_S">
       <SelectParameters><asp:ControlParameter Name="MacType" Type="String" ControlID="hfStType" PropertyName="Value" /></SelectParameters>
      </asp:ObjectDataSource>
     </ContentTemplate>
     <Triggers>
      <aspx:AsyncPostBackTrigger ControlID="tRefresh" EventName="Tick" />
      <aspx:AsyncPostBackTrigger ControlID="btnRefresh" EventName="Click" />
      <aspx:AsyncPostBackTrigger ControlID="btnReSet" EventName="Click" />
     </Triggers>
    </aspx:UpdatePanel>
   </ContentTemplate>
  </ajax:TabPanel>
  <ajax:TabPanel ID="tbSched" runat="server" HeaderText="Schedule">
   <ContentTemplate>
    <aspx:UpdatePanel ID="uPnlSched" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
      <table width="100%">
       <tr valign="top">
        <td align="left">
         <asp:DropDownList ID="ddlScFilter" runat="server" DataSourceID="odsScFilter" DataTextField="mText" DataValueField="mValue" AutoPostBack="true"></asp:DropDownList>
         <asp:CheckBox ID="chkScSug" runat="server" AutoPostBack="true" Text="Suggested Only" />
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Work Order:</b>
         <asp:TextBox ID="txtWorkOrder" runat="server" Width="50px"></asp:TextBox>
         <asp:Button ID="btnLoad" runat="server" Text="Search" CssClass="NavBtn" />
        </td>
        <td align="right"><asp:Literal ID="litScRefresh" runat="server"></asp:Literal></td>
       </tr>
      </table><br />
      <asp:GridView ID="gvMacSched" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsMacSched" PageSize="50">
       <Columns>
        <asp:TemplateField HeaderText="ID" SortExpression="MacID" InsertVisible="false">
         <ItemTemplate>
          <asp:Label ID="lblMacID" runat="server" Text='<%# Eval("MacID") %>' BackColor='<%# gColor("BC") %>' ForeColor='<%# gColor("FC") %>'></asp:Label>
         </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="Machine Name" DataField="MacName" SortExpression="MacName" InsertVisible="false" />
        <asp:TemplateField HeaderImageUrl="~/App_Themes/thumbsUp.png" SortExpression="isThumbUp" InsertVisible="false" ItemStyle-HorizontalAlign="Center">
         <ItemTemplate>
          <%# Eval("pMacID") %>
          <asp:Image ID="imgThumbUp" runat="server" ImageUrl="~/App_Themes/thumbsUp.png" Visible='<%# Convert.ToBoolean(Eval("isThumbUp")) %>' />
         </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="WO#" SortExpression="WorkOrder" InsertVisible="false">
         <ItemTemplate><%# sColor("WorkOrder") %></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="P/N" DataField="PN" SortExpression="PN" InsertVisible="false" />
        <asp:BoundField HeaderText="QtyM" DataField="mQty" SortExpression="mQty" InsertVisible="false" />
        <asp:TemplateField HeaderText="St/Op#" SortExpression="St_Op" InsertVisible="false">
         <ItemTemplate><%# sColor("St_Op") %></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Due Date" SortExpression="DueDate" InsertVisible="false">
         <ItemTemplate><%# gDD() %></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="PEST" SortExpression="EST" InsertVisible="false">
         <ItemTemplate><%# gTime("EST") %></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="PERT" SortExpression="ERT" InsertVisible="false">
         <ItemTemplate><%# gTime("ERT") %></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Total" SortExpression="ttTime" InsertVisible="false">
         <ItemTemplate><%# gTime("ttTime") %></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="ESD" DataField="ESD" SortExpression="ESD" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
        <asp:TemplateField HeaderText="ECD" SortExpression="ECD" InsertVisible="false">
         <ItemTemplate><%# sDate("ECD") %></ItemTemplate>
        </asp:TemplateField>
       </Columns>
      </asp:GridView>
      <asp:HiddenField ID="hfScType" runat="server" OnLoad="hfLoad" />
      <asp:ObjectDataSource ID="odsMacSched" runat="server" TypeName="myBiz.DAL.clsMachine" SelectMethod="Machine_Schedule">
       <SelectParameters>
        <asp:ControlParameter Name="MacType" Type="String" ControlID="hfScType" PropertyName="Value" />
        <asp:ControlParameter Name="MacTypeID" Type="String" ControlID="ddlScFilter" PropertyName="SelectedValue" />
        <asp:ControlParameter Name="WorkOrder" Type="String" ControlID="txtWorkOrder" PropertyName="Text" />
        <asp:ControlParameter Name="curStatus" Type="Boolean" ControlID="chkScSug" PropertyName="Checked" />
       </SelectParameters>
      </asp:ObjectDataSource>
      <asp:ObjectDataSource ID="odsScFilter" runat="server" TypeName="myBiz.DAL.clsMachine" SelectMethod="MachineType_S">
       <SelectParameters><asp:ControlParameter Name="MacType" Type="String" ControlID="hfScType" PropertyName="Value" /></SelectParameters>
      </asp:ObjectDataSource>
     </ContentTemplate>
     <Triggers>
      <aspx:AsyncPostBackTrigger ControlID="tRefresh" EventName="Tick" />
      <aspx:AsyncPostBackTrigger ControlID="btnRefresh" EventName="Click" />
      <aspx:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
     </Triggers>
    </aspx:UpdatePanel>
   </ContentTemplate>
  </ajax:TabPanel>
 </ajax:TabContainer>
 </asp:Content>