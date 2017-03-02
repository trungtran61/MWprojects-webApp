<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.PartInfo" Codebehind="PartInfo.ascx.cs" %>

<b>Part Name:</b> <asp:Literal ID="litPartName" runat="server"></asp:Literal><br />
<b>Part Number:</b> <asp:Literal ID="litPN" runat="server"></asp:Literal>
Rev. <asp:Literal ID="litRV" runat="server"></asp:Literal>
<asp:Button ID="btnUpload" runat="server" OnClick="doUpload" Text="Upload Picture" CssClass="NavBtn" />
<asp:Button ID="btnCopyImg" runat="server" OnClick="doCopy" Text="Transfer" CssClass="NavBtn" />
<br /><br />

<asp:DataList ID="dlPartInfo" runat="server" DataSourceID="odsFiles" DataKeyField="HID" RepeatDirection="Horizontal" OnItemCommand="dlCmd">
 <ItemTemplate>
  <asp:Image ID="imgFile" runat="server" Width="200px" ImageUrl='<%# showImage() %>' />
  <asp:LinkButton ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# string.Format("{0}:{1}", Eval("HID"), Eval("Ext")) %>' OnClientClick='return confirm("Are you sure you want to delete?");' Visible='<%# this.isDelete %>'></asp:LinkButton>
 </ItemTemplate>
</asp:DataList>
<MW:Message ID="iMsg" runat="server" />

<asp:Panel ID="pnlPopup" runat="server" />
<asp:HiddenField ID="hfIsDelete" runat="server" Value="False" />

<asp:ObjectDataSource ID="odsFiles" runat="server" TypeName="myBiz.DAL.clsFile" SelectMethod="Select" DeleteMethod="Delete1" OnInit="iniFiles">
 <SelectParameters>
  <asp:Parameter Name="GrpID" Type="Int32" />
  <asp:ControlParameter Name="LnkID" Type="Int32" ControlID="hfPartID" PropertyName="Value" />
 </SelectParameters>
 <DeleteParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="Ext" Type="String" />
 </DeleteParameters>
</asp:ObjectDataSource>

<asp:HiddenField ID="hfPartID" runat="server" Value="0" />