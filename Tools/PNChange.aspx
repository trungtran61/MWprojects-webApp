<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="PNChange.aspx.cs" Inherits="webApp.Tools.PNChange" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlChangeAction" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <table cellspacing="5" width="700px">
    <tr>
     <td>
      <b>First Part#:</b><br />
      <asp:TextBox ID="txtFirstPNN" runat="server"></asp:TextBox>
      <asp:RequiredFieldValidator ID="rfvFirstPNN" runat="server" Text="First Part# is required!" ControlToValidate="txtFirstPNN" ValidationGroup="vNewPair"></asp:RequiredFieldValidator>
      <ajax:AutoCompleteExtender ID="aceFirstPNN" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtFirstPNN">
      </ajax:AutoCompleteExtender>
     </td>
     <td>
      <b>Second Part#:</b><br />
      <asp:TextBox ID="txtSecondPNN" runat="server"></asp:TextBox>
      <asp:RequiredFieldValidator ID="rfvSecondPNN" runat="server" Text="Second Part# is required!" ControlToValidate="txtSecondPNN" ValidationGroup="vNewPair"></asp:RequiredFieldValidator>
      <ajax:AutoCompleteExtender ID="aceSecondPNN" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtSecondPNN">
      </ajax:AutoCompleteExtender>
     </td>
    </tr>
    <tr>
     <td colspan="2">
      <b>Note:</b><br />
      <asp:TextBox ID="txtNoteN" runat="server" TextMode="MultiLine" Width="650px" Height="150px"></asp:TextBox><br />
      <asp:RequiredFieldValidator ID="rfvNoteN" runat="server" Text="Note is required!" ControlToValidate="txtNoteN" ValidationGroup="vNewPair"></asp:RequiredFieldValidator>
     </td>
    </tr>
    <tr>
     <td colspan="2">
      <asp:Button ID="btnApprove" runat="server" Text="Approve" CssClass="NavBtn" OnClick="doApprove" ValidationGroup="vNewPair" />
      <MW:Message ID="iMsg" runat="server" />
     </td>
    </tr>
   </table>
  </ContentTemplate>
 </aspx:UpdatePanel>
 <br />
 <aspx:UpdatePanel ID="uPnlChangeView" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
    <tr style="background-color:#330099; color:White">
     <td align="center" style="font-weight:bold;">SAME PHYSICAL PARTS WITH DIFFERENT PART #  OR REVISION</td>
    </tr>
    <tr>
     <td>
      <asp:GridView ID="gvChange" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsChange" OnRowCommand="rwCmd" PageSize="50">
       <Columns>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="First Part#" DataField="FirstPN" SortExpression="FirstPN" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Second Part#" DataField="SecondPN" SortExpression="SecondPN" />
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="By" SortExpression="PairBy">
         <ItemTemplate>
          <asp:LinkButton ID="lnkView" runat="server" Text='<%# Eval("PairBy") %>' CommandName="viewPair" CommandArgument='<%# Eval("HID") %>'></asp:LinkButton>
         </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="PairDate" SortExpression="PairDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Status" DataField="Action" SortExpression="Action" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="true" HeaderText="Note" DataField="Note" SortExpression="Note" ItemStyle-Width="550" />
       </Columns>
       <EmptyDataTemplate>No Part Numbers have been paired!</EmptyDataTemplate>
      </asp:GridView>
     </td>
    </tr>
   </table>
   <table id="tblView" runat="server" class="mdlPopup" width="700px" cellspacing="5">
    <tr>
     <td style="text-align:right"><b>First Part#:</b></td><td><asp:Literal ID="litFirstPN" runat="server"></asp:Literal></td>
     <td style="text-align:right"><b>Second Part#:</b></td><td><asp:Literal ID="litSecondPN" runat="server"></asp:Literal></td>
    </tr>
    <tr>
     <td style="text-align:right"><b><asp:Literal ID="litActionBy" runat="server"></asp:Literal></b></td><td><asp:Literal ID="litPairBy" runat="server"></asp:Literal></td>
     <td style="text-align:right"><b><asp:Literal ID="litActionDate" runat="server"></asp:Literal></b></td><td><asp:Literal ID="litPairDate" runat="server"></asp:Literal></td>
    </tr>
    <tr>
     <td colspan="4">
      <asp:Literal ID="litActionNote" runat="server"></asp:Literal>
      <asp:Label ID="lblNote" runat="server" Width="650px"></asp:Label>
     </td>
    </tr>
    <tr>
     <td colspan="4">
      <asp:Literal ID="litNewNote" runat="server"></asp:Literal>
      <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" Width="650px" Height="150px"></asp:TextBox>
      <asp:RequiredFieldValidator ID="rfvNote" runat="server" Text="Note is required!" ControlToValidate="txtNote" ValidationGroup="vNew"></asp:RequiredFieldValidator>
      <MW:Message ID="jMsg" runat="server" />
     </td>
    </tr>
    <tr>
     <td colspan="4" style="text-align:right">
      <asp:Button ID="btnDisAction" runat="server" OnClick="disAction" CssClass="NavBtn" ValidationGroup="vNew" />
      <asp:Button ID="btnCloseView" runat="server" Text="Close Window" CssClass="NavBtn" />
      <asp:HiddenField ID="hfView" runat="server" />
     </td>
    </tr>
   </table>
   <ajax:ModalPopupExtender ID="mpeView" runat="server" TargetControlID="hfView" PopupControlID="tblView" BackgroundCssClass="mdlBackground"
    OkControlID="btnCloseView" DropShadow="false" RepositionMode="RepositionOnWindowResize" />
  </ContentTemplate>
  <Triggers><aspx:AsyncPostBackTrigger ControlID="btnApprove" EventName="Click" /></Triggers>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsChange" runat="server" TypeName="myBiz.DAL.clsPartNumber" SelectMethod="Pair_Logs_S">
  <SelectParameters>
   <asp:Parameter Name="LogID" Type="Int32" DefaultValue="-1" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>