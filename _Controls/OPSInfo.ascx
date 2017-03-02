<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.OPSInfo" Codebehind="OPSInfo.ascx.cs" %>
<%@ Register Src="~/_Controls/ucMOGT.ascx" TagName="ucMOGT" TagPrefix="ucMOGT" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<h3>INFORMATION FOR OPS</h3>
<asp:Panel ID="pnlTask" runat="server" Enabled="false">
<asp:FormView ID="fvOPS" runat="server" DataSourceID="odsOPS" DefaultMode="Edit" OnItemCommand="fvCmd">
 <ItemTemplate><b>ProcessID: </b><%# Eval("ProcessName") %></ItemTemplate>
 <EditItemTemplate>
  <b>ProcessID: </b>
  <asp:DropDownList ID="ddlProcessType" runat="server" DataSourceID="odsProcessType" DataTextField="ProcessName" DataValueField="HID" SelectedValue='<%# Bind("PID") %>'></asp:DropDownList>
  <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="NavBtn" ValidationGroup="uReq" CommandName="Update" />
  <br />
  <asp:RequiredFieldValidator ID="rfvProcessType" runat="server" ControlToValidate="ddlProcessType" InitialValue="-1" ErrorMessage="ProcessID is Required!" ValidationGroup="uReq"></asp:RequiredFieldValidator>
 </EditItemTemplate>
</asp:FormView>
<br />
   <asp:GridView ID="gvItems" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="HID" DataSourceID="odsItems" ForeColor="#333333" GridLines="None" ShowFooter="true" OnDataBound="gv_Bound" OnRowCommand="rwCmd" OnRowDataBound="rBound">
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <RowStyle BackColor="#EFF3FB" />
    <Columns>
     <asp:TemplateField>
      <ItemTemplate>
       <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" />
      </ItemTemplate>
      <EditItemTemplate>
       <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" />
       <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
      </EditItemTemplate>
      <FooterTemplate><asp:Button ID="btnAdd" Text="Add" runat="server" OnClick="btnAdd_Click" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Items #" SortExpression="ItemNo" InsertVisible="false" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><%# Eval("ItemNo") %></ItemTemplate>
      <EditItemTemplate><%# Eval("ItemNo") %></EditItemTemplate>
      <FooterTemplate>##</FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Type" SortExpression="Type" InsertVisible="false" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><asp:Literal ID="litType" runat="server" Text='<%# Eval("OPSType") %>' /></ItemTemplate>
      <EditItemTemplate>
       <asp:HiddenField ID="hfTypeID" runat="server" Value='<%# Eval("OPSTypeID") %>' />
       <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="true" DataSourceID="odsTypeList" DataValueField="HID" DataTextField="OPSType" OnSelectedIndexChanged="ddlSelected" Width="200px" />
      </EditItemTemplate>
      <FooterTemplate><asp:DropDownList ID="ddlType" runat="server" AutoPostBack="true" DataSourceID="odsTypeList" DataValueField="HID" DataTextField="OPSType" OnSelectedIndexChanged="ddlSelected" Width="200px" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Spec #" SortExpression="Spec" InsertVisible="false">
      <ItemTemplate><asp:Literal ID="litSpec" runat="server" Text='<%# Eval("OPSSpec") %>' /></ItemTemplate>
      <EditItemTemplate>
       <asp:HiddenField ID="hfSpecID" runat="server" Value='<%# Eval("OPSSpecID") %>' />
       <asp:DropDownList ID="ddlSpec" runat="server" AutoPostBack="true" DataSourceID="odsSpecList" DataValueField="HID" DataTextField="OPSSpec" Width="200px" />
       <asp:ObjectDataSource ID="odsSpecList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Spec_S">
        <SelectParameters>
         <asp:ControlParameter Name="OPSTypeID" Type="Int32" ControlID="ddlType" PropertyName="SelectedValue" />
         <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
        </SelectParameters>
       </asp:ObjectDataSource>
      </EditItemTemplate>
      <FooterTemplate>
       <asp:DropDownList ID="ddlSpec" runat="server" AutoPostBack="true" DataSourceID="odsSpecList" DataValueField="HID" DataTextField="OPSSpec" Width="200px" />
       <asp:ObjectDataSource ID="odsSpecList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Spec_S">
        <SelectParameters>
         <asp:ControlParameter Name="OPSTypeID" Type="Int32" ControlID="ddlType" PropertyName="SelectedValue" />
         <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
        </SelectParameters>
       </asp:ObjectDataSource>
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Spec Desc" SortExpression="OPSDesc" InsertVisible="false">
      <ItemTemplate><asp:Literal ID="litDesc" runat="server" Text='<%# Eval("OPSDesc") %>' /></ItemTemplate>
      <EditItemTemplate>
       <asp:HiddenField ID="hfDescID" runat="server" Value='<%# Eval("OPSDescID") %>' />
       <asp:DropDownList ID="ddlDesc" runat="server" DataSourceID="odsDescList" DataValueField="HID" DataTextField="OPSDesc" Width="200px" />
       <asp:ObjectDataSource ID="odsDescList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Desc_S">
        <SelectParameters>
         <asp:ControlParameter Name="OPSSpecID" Type="Int32" ControlID="ddlSpec" PropertyName="SelectedValue" />
         <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
        </SelectParameters>
       </asp:ObjectDataSource>
      </EditItemTemplate>
      <FooterTemplate>
       <asp:DropDownList ID="ddlDesc" runat="server" DataSourceID="odsDescList" DataValueField="HID" DataTextField="OPSDesc" Width="200px" />
       <asp:ObjectDataSource ID="odsDescList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Desc_S">
        <SelectParameters>
         <asp:ControlParameter Name="OPSSpecID" Type="Int32" ControlID="ddlSpec" PropertyName="SelectedValue" />
         <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
        </SelectParameters>
       </asp:ObjectDataSource>
      </FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Description" SortExpression="Description" InsertVisible="false">
      <ItemTemplate><asp:Label ID="lblDescription" runat="server" Text='<%# Eval("viewDescription") %>' Width="400px" /></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine" Width="350px" Height="100px"></asp:TextBox></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Width="350px" Height="100px"></asp:TextBox></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Qty" SortExpression="Qty" InsertVisible="false" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><%# Eval("Qty") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtQty" runat="server" Text='<%# Bind("Qty") %>' Width="30px" /></EditItemTemplate>
      <FooterTemplate><asp:TextBox ID="txtQty" runat="server" Width="100px" /></FooterTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Unit" SortExpression="Unit" InsertVisible="false" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><%# Eval("Unit") %></ItemTemplate>
      <EditItemTemplate><asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="odsUnit" DataValueField="mValue" DataTextField="mText" SelectedValue='<%# Bind("Unit") %>' Width="100px" /></EditItemTemplate>
      <FooterTemplate><asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="odsUnit" DataValueField="mValue" DataTextField="mText" Width="100px" /></FooterTemplate>
     </asp:TemplateField>
    </Columns>
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#9999CC" />
    <AlternatingRowStyle BackColor="White" />
    <EmptyDataTemplate>
     <table cellpadding="0" cellspacing="0">
     <tr style="background-color:#EEEEEE">
      <td>&nbsp;</td>
      <td><b>Item #</b></td>
      <td><b>Type</b></td>
      <td><b>Spec #</b></td>
      <td><b>Spec Desc</b></td>
      <td><b>Description</b></td>
      <td><b>Qty</b></td>
      <td><b>Unit</b></td>
     </tr>
     <tr>
      <td><asp:Button ID="btnEmpty" Text="Add" runat="server" OnClick="btnAdd_Click" /></td>
      <td>1</td>
      <td><asp:DropDownList ID="ddlType" runat="server" AutoPostBack="true" DataSourceID="odsTypeList" DataValueField="HID" DataTextField="OPSType" OnSelectedIndexChanged="ddlSelected" Width="200px" /></td>
      <td>
       <asp:DropDownList ID="ddlSpec" runat="server" AutoPostBack="true" DataSourceID="odsSpecList" DataValueField="HID" DataTextField="OPSSpec" Width="200px" />
       <asp:ObjectDataSource ID="odsSpecList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Spec_S">
        <SelectParameters>
         <asp:ControlParameter Name="OPSTypeID" Type="Int32" ControlID="ddlType" PropertyName="SelectedValue" />
         <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
        </SelectParameters>
       </asp:ObjectDataSource>
      </td>
      <td>
       <asp:DropDownList ID="ddlDesc" runat="server" DataSourceID="odsDescList" DataValueField="HID" DataTextField="OPSDesc" Width="200px" />
       <asp:ObjectDataSource ID="odsDescList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Desc_S">
        <SelectParameters>
         <asp:ControlParameter Name="OPSSpecID" Type="Int32" ControlID="ddlSpec" PropertyName="SelectedValue" />
         <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
        </SelectParameters>
       </asp:ObjectDataSource>
      </td>
      <td><asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox></td>
      <td><asp:TextBox ID="txtQty" runat="server" Enabled="false" Width="100px"></asp:TextBox></td>
      <td><asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="odsUnit" DataValueField="mValue" DataTextField="mText" Width="100px"></asp:DropDownList></td>
     </tr>
     </table>
    </EmptyDataTemplate>
   </asp:GridView>

 <asp:ImageButton ID="imgSearch" runat="server" ImageUrl="~/App_Themes/search.jpg" Width="20px" OnClientClick="return false;" />
 <asp:Panel ID="pnlSearch" runat="server"><ucMOGT:ucMOGT ID="uMOGT" runat="server" MOGT="OPS" /></asp:Panel>
 <ajax:CollapsiblePanelExtender ID="cpeSearch" runat="server" TargetControlID="pnlSearch" ExpandControlID="imgSearch" CollapseControlID="imgSearch" Collapsed="true" />
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />
<MW:Message ID="iMsg" runat="server" />
<asp:Panel ID="pnlPopup" runat="server" />

<asp:ObjectDataSource ID="odsUnit" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
 <SelectParameters>
  <asp:Parameter Name="Cate" Type="String" DefaultValue="Unit" />
  <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
 </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsItems" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="Select_Items" UpdateMethod="Save_Items" OnUpdated="odsUpdated">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="OPSDescID" Type="Int32" />
  <asp:Parameter Name="Description" Type="String" />
  <asp:Parameter Name="Qty" Type="String" />
  <asp:Parameter Name="Unit" Type="String" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </UpdateParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsOPS" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="Select" UpdateMethod="Save">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </SelectParameters>
 <UpdateParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="PID" Type="Int32" />
 </UpdateParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsProcessType" runat="server" TypeName="myBiz.DAL.clsProcessType" SelectMethod="Select">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
 </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsTypeList" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="OPS_Type_S">
 <SelectParameters><asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" /></SelectParameters>
</asp:ObjectDataSource>
