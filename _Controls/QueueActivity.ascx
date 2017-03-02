<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.QueueActivity" Codebehind="QueueActivity.ascx.cs" %>
<style>
    .table-nonfluid {
      width: 400px!important;
    }
    .container-fluid .row
    {
        height: 10px;
    }
</style>
<div>
<asp:GridView ID="gvQueue" runat="server" SkinID="GrayHeader" PageSize="50" DataKeyNames="DeptID,StepID,Name,AppCode" DataSourceID="odsQueue" OnRowCommand="Rw_Cmd" OnRowDataBound="Rw_Bound"
    CssClass="table table-hover table-nonfluid table-condensed" GridLines="None" useaccessibleheader="true">  
      <RowStyle BackColor="white"></RowStyle>
    <AlternatingRowStyle BackColor="white"></AlternatingRowStyle>
 <Columns>
  <asp:BoundField HeaderStyle-HorizontalAlign="Left" HeaderText="Name" DataField="Name" SortExpression="Name"/>
  <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Total" SortExpression="Total" HeaderStyle-HorizontalAlign="Right">
   <ItemTemplate>
    <asp:LinkButton ID="lnkTotal" runat="server" Text='<%# Eval("Total") %>' CommandName="cmdTotal" CommandArgument='<%# ((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
   </ItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Due" SortExpression="bLate" HeaderStyle-HorizontalAlign="Right">
   <ItemTemplate>
    <asp:LinkButton ID="lnkBeLate" runat="server" Text='<%# Eval("bLate") %>' ForeColor="Brown" CommandName="cmdBeLate" CommandArgument='<%# ((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
   </ItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Overdue" SortExpression="Late" HeaderStyle-HorizontalAlign="Right">
   <ItemTemplate>
    <asp:LinkButton ID="lnkLate" runat="server" Text='<%# Eval("Late") %>' ForeColor="Red" CommandName="cmdLate" CommandArgument='<%# ((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
   </ItemTemplate>
  </asp:TemplateField>
 </Columns>
</asp:GridView>
</div>
<div style="float:left">
<asp:GridView ID="gvQueue2" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsQueue2" PageSize="20">
 <Columns>
  <asp:TemplateField HeaderImageUrl="~/App_Themes/thumbsUp.png" HeaderStyle-Font-Size="Large" SortExpression="isThumbUp" ItemStyle-HorizontalAlign="Center">
   <ItemTemplate>
    <%# Eval("pMacID") %>
    <asp:Image ID="imgGreenLight" runat="server" ImageUrl="~/App_Themes/GreenLight.jpg" Visible='<%# Convert.ToBoolean(Eval("isGreenLight")) %>' />
    <asp:Image ID="imgThumbUp" runat="server" ImageUrl="~/App_Themes/thumbsUp.png" Visible='<%# Convert.ToBoolean(Eval("isThumbUp")) %>' />
    <%# Eval("allPart") %>
   </ItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="WO#" SortExpression="WO_QTE">
   <ItemTemplate>
    <a class="statusLnk" href="javascript:void(0)" onclick="<%# gLink() %>"><%# Eval("WO_QTE") %></a>
   </ItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="P/N" SortExpression="PartNumber">
   <ItemTemplate><%# gPN() %></ItemTemplate>
  </asp:TemplateField>
  <asp:BoundField HeaderText="Rev." DataField="Revision" SortExpression="Revision" />
  <asp:BoundField HeaderText="Qty" DataField="oQty" SortExpression="oQty" />
  <asp:BoundField HeaderText="St/Op" DataField="St_Op" SortExpression="St_Op" />
  <asp:BoundField HeaderText="Router Creator" DataField="RouterCreator" SortExpression="RouterCreator" />
  <asp:TemplateField HeaderText="Due Date" SortExpression="DueDate">
   <ItemTemplate><%# gDD() %></ItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Current Status" SortExpression="curStatus">
   <ItemTemplate><%# cStatus() %></ItemTemplate>
  </asp:TemplateField>
  <asp:BoundField HeaderText="Current Location" DataField="curLocation" SortExpression="curLocation" />
  <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Note">
   <ItemTemplate>
    <a onclick="javascript:xPopup('Note/Note.aspx?lDB=WorkOrder&lID=<%# Eval("HID") %>');" class="Finger"><img src="App_Themes/<%# Eval("NoteImg") %>" alt="Note" /></a>
   </ItemTemplate>
  </asp:TemplateField>
 </Columns>
</asp:GridView>
</div>

<asp:Panel ID="pnlPopup" runat="server"></asp:Panel>
<asp:HiddenField ID="hfUID" runat="server" />
<asp:ObjectDataSource ID="odsQueue" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="QueueActivity_S">
 <SelectParameters>
  <asp:Parameter Name="uID" Type="String" DefaultValue="" />
 </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsQueue2" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="Queue2_S">
 <SelectParameters>
  <asp:Parameter Name="mID" Type="Int32" DefaultValue="-1" />
  <asp:Parameter Name="isD" Type="Int32" />
  <asp:Parameter Name="LateMode" Type="String" />
  <asp:Parameter Name="UN" Type="String" />
  <asp:Parameter Name="AppCode" Type="String" />
 </SelectParameters>
</asp:ObjectDataSource>