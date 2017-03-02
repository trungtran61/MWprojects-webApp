<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.TransferImage" Codebehind="TransferImage.ascx.cs" %>

<asp:Literal ID="litNoRecord" runat="server" Text="No image available for transfer." Visible="false"></asp:Literal>
<asp:DataList ID="dlTrImg" runat="server" DataSourceID="odsTrImg" DataKeyField="mwName" RepeatDirection="Horizontal">
 <ItemTemplate>
  <asp:CheckBox ID="chkItem" runat="server" /><br />
  <asp:Image ID="imgFile" runat="server" Width="200px" ImageUrl='<%# string.Format("http://pmw-server/imgLibrary/{0}",Eval("FN")) %>' /><br />
  <%# Eval("mwName") %>
  <asp:HiddenField ID="hfFN" runat="server" Value='<%# string.Format(@"C:\iData\PROGRAMS\MWSoftwares\webApps\public\imgLibrary\{0}",Eval("FN")) %>' />
 </ItemTemplate>
</asp:DataList><br />
<asp:Button ID="btnTransfer" runat="server" OnClick="doTransfer" Text="Transfer Selected Image" CssClass="NavBtn" Visible='false' /><br />
<MW:Message ID="iMsg" runat="server" />

<asp:ObjectDataSource ID="odsTrImg" runat="server" TypeName="myBiz.DAL.clsPartInv" SelectMethod="Select_OldImg">
 <SelectParameters>
  <asp:ControlParameter Name="PN" Type="String" ControlID="hfPN" PropertyName="Value" />
  <asp:ControlParameter Name="RV" Type="String" ControlID="hfRV" PropertyName="Value" />
 </SelectParameters>
</asp:ObjectDataSource>

<asp:HiddenField ID="hfPN" runat="server" />
<asp:HiddenField ID="hfRV" runat="server" />