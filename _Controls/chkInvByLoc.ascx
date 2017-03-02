<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.chkInvByLoc" Codebehind="chkInvByLoc.ascx.cs" %>

<table cellpadding="0" cellspacing="0" style="border:solid 1px black">
 <tr style="background-color:#330099; color:White">
  <td align="center"><b>Check Part Inventory By Location</b></td>
 </tr>
 <tr>
  <td>
   <asp:GridView ID="gvByLoc" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="WOID" DataSourceID="odsByLoc">
    <Columns>
     <asp:TemplateField HeaderText="WO#" SortExpression="WorkOrder">
      <ItemTemplate>
       <a onclick="javascript:xPopup('../Note/Note.aspx?lDB=WorkOrder&lID=<%# Eval("WOID") %>');" class="Finger"><img src="../App_Themes/<%# Eval("NoteImg") %>" alt="Note" /></a>
       <%# Eval("WorkOrder") %>
      </ItemTemplate>
     </asp:TemplateField>
     <asp:BoundField HeaderText="Part Number" DataField="PN" SortExpression="PN" />
     <asp:BoundField HeaderText="On Hand" DataField="OnHand" SortExpression="OnHand" />
     <asp:BoundField HeaderText="Incomplete" DataField="InCmp" SortExpression="InCmp" />
    </Columns>
   </asp:GridView>
  </td>
 </tr>
</table>

<asp:ObjectDataSource ID="odsByLoc" runat="server" TypeName="myBiz.DAL.clsPartInv" SelectMethod="Check_ByLoc">
 <SelectParameters>
  <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
  <asp:ControlParameter Name="WO" Type="String" ControlID="hfWO" PropertyName="Value" />
  <asp:ControlParameter Name="PN" Type="String" ControlID="hfPN" PropertyName="Value" />
  <asp:ControlParameter Name="RV" Type="String" ControlID="hfRV" PropertyName="Value" />
  <asp:ControlParameter Name="LocID" Type="Int32" ControlID="hfLocID" PropertyName="Value" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:HiddenField ID="hfUID" runat="server" />
<asp:HiddenField ID="hfWO" runat="server" />
<asp:HiddenField ID="hfPN" runat="server" />
<asp:HiddenField ID="hfRV" runat="server" />
<asp:HiddenField ID="hfLocID" runat="server" Value="-1" />