<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucMOGT.ascx.cs" Inherits="webApp._Controls.ucMOGT" %>

<aspx:UpdatePanel ID="uPnlMatl" runat="server" UpdateMode="Conditional" Visible="false">
 <ContentTemplate>
 <table>
  <tr>
   <td><b>Part Number:</b></td>
   <td><b>Description:</b></td>
   <td><b>PO Number:</b></td>
   <td><b>RFQ Number:</b></td>
   <td><b>Vendor:</b></td>
   <td>&nbsp;</td>
  </tr>
  <tr>
   <td>
    <asp:TextBox ID="txtPartNumber" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="acePartNumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtPartNumber">
    </ajax:AutoCompleteExtender>
   </td>
   <td><asp:TextBox ID="txtDesc" runat="server"></asp:TextBox></td>
   <td>
    <asp:TextBox ID="txtPONumber" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="acePONumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtPONumber" UseContextKey="true" />
   </td>
   <td>
    <asp:TextBox ID="txtRFQNumber" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="aceRFQNumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetRFQNumber" TargetControlID="txtRFQNumber" UseContextKey="true" />
   </td>
   <td><asp:TextBox ID="txtVendorName" runat="server"></asp:TextBox></td>
   <td valign="bottom">
    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="mSearch" CssClass="NavBtn" />
    <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="mReset" CssClass="NavBtn" />
   </td>
  </tr>
 </table><br />
 <asp:GridView ID="gvMatl" runat="server" SkinID="Default" DataKeyNames="MatlTypeID,MatlAmsID,MatlFormID,BDID" DataSourceID="odsMatl" OnRowDataBound="gvBound" OnRowCommand="gvCmd">
  <Columns>
   <asp:TemplateField HeaderText="Select">
    <ItemTemplate>
     <asp:LinkButton ID="lnkSelect" runat="server" CommandName="useThis" Text='&#9679;' Font-Size="XX-Large" ForeColor="Green" Font-Underline="false" />
    </ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Type" DataField="MatlType" SortExpression="MatlType" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Ams" DataField="MatlAms" SortExpression="MatlAms" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Form" DataField="MatlForm" SortExpression="MatlForm" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Part Number" DataField="PartNumber" SortExpression="PartNumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Description" DataField="Description" SortExpression="Description" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="RFQ Number" DataField="RFQNumber" SortExpression="RFQNumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="PO Number" DataField="PONumber" SortExpression="PONumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Vendor" DataField="VendorName" SortExpression="VendorName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
  </Columns>
 </asp:GridView>
 <asp:ObjectDataSource ID="odsMatl" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Search">
  <SelectParameters>
   <asp:ControlParameter Name="PN" Type="String" ControlID="txtPartNumber" PropertyName="Text" />
   <asp:ControlParameter Name="Desc" Type="String" ControlID="txtDesc" PropertyName="Text" />
   <asp:ControlParameter Name="PO" Type="String" ControlID="txtPONumber" PropertyName="Text" />
   <asp:ControlParameter Name="RFQ" Type="String" ControlID="txtRFQNumber" PropertyName="Text" />
   <asp:ControlParameter Name="VendorName" Type="String" ControlID="txtVendorName" PropertyName="Text" />
   <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
  </SelectParameters>
 </asp:ObjectDataSource>
 </ContentTemplate>
</aspx:UpdatePanel>

<aspx:UpdatePanel ID="uPnlOPS" runat="server" UpdateMode="Conditional" Visible="false">
 <ContentTemplate>
 <table>
  <tr>
   <td><b>Part Number:</b></td>
   <td><b>Description:</b></td>
   <td><b>PO Number:</b></td>
   <td><b>RFQ Number:</b></td>
   <td><b>Vendor:</b></td>
   <td>&nbsp;</td>
  </tr>
  <tr>
   <td>
    <asp:TextBox ID="txtOPSPN" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="aceOPSPN" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtOPSPN">
    </ajax:AutoCompleteExtender>
   </td>
   <td><asp:TextBox ID="txtOPSDesc" runat="server"></asp:TextBox></td>
   <td>
    <asp:TextBox ID="txtOPSPONum" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="aceOPSPONum" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtOPSPONum" UseContextKey="true" />
   </td>
   <td>
    <asp:TextBox ID="txtOPSRFQNum" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="aceOPSRFQNum" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetRFQNumber" TargetControlID="txtOPSRFQNum" UseContextKey="true" />
   </td>
   <td><asp:TextBox ID="txtOPSVendor" runat="server"></asp:TextBox></td>
   <td valign="bottom">
    <asp:Button ID="btnOPSSearch" runat="server" Text="Search" OnClick="oSearch" CssClass="NavBtn" />
    <asp:Button ID="btnOPSReset" runat="server" Text="Reset" OnClick="oReset" CssClass="NavBtn" />
   </td>
  </tr>
 </table><br />
 <asp:GridView ID="gvOPS" runat="server" SkinID="Default" DataKeyNames="OPSTypeID,OPSSpecID,OPSDescID,BDID" DataSourceID="odsOPS" OnRowDataBound="gvBound" OnRowCommand="gvCmd">
  <Columns>
   <asp:TemplateField HeaderText="Select">
    <ItemTemplate>
     <asp:LinkButton ID="lnkSelect" runat="server" CommandName="useThis" Text='&#9679;' Font-Size="XX-Large" ForeColor="Green" Font-Underline="false" />
    </ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Type" DataField="OPSType" SortExpression="OPSType" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Spec" DataField="OPSSpec" SortExpression="OPSSpec" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Spec Desc" DataField="OPSDesc" SortExpression="OPSDesc" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Part Number" DataField="PartNumber" SortExpression="PartNumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Description" DataField="Description" SortExpression="Description" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="RFQ Number" DataField="RFQNumber" SortExpression="RFQNumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="PO Number" DataField="PONumber" SortExpression="PONumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Vendor" DataField="VendorName" SortExpression="VendorName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
  </Columns>
 </asp:GridView>
 <asp:ObjectDataSource ID="odsOPS" runat="server" TypeName="myBiz.DAL.clsOPS" SelectMethod="Search">
  <SelectParameters>
   <asp:ControlParameter Name="PN" Type="String" ControlID="txtOPSPN" PropertyName="Text" />
   <asp:ControlParameter Name="Desc" Type="String" ControlID="txtOPSDesc" PropertyName="Text" />
   <asp:ControlParameter Name="PO" Type="String" ControlID="txtOPSPONum" PropertyName="Text" />
   <asp:ControlParameter Name="RFQ" Type="String" ControlID="txtOPSRFQNum" PropertyName="Text" />
   <asp:ControlParameter Name="VendorName" Type="String" ControlID="txtOPSVendor" PropertyName="Text" />
   <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
  </SelectParameters>
 </asp:ObjectDataSource>
 </ContentTemplate>
</aspx:UpdatePanel>

<aspx:UpdatePanel ID="uPnlGage" runat="server" UpdateMode="Conditional" Visible="false">
 <ContentTemplate>
 <table>
  <tr>
   <td><b>Part Number:</b></td>
   <td><b>Description:</b></td>
   <td><b>PO Number:</b></td>
   <td><b>RFQ Number:</b></td>
   <td><b>Vendor:</b></td>
   <td>&nbsp;</td>
  </tr>
  <tr>
   <td>
    <asp:TextBox ID="txtGagePN" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="aceGagePN" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtGagePN">
    </ajax:AutoCompleteExtender>
   </td>
   <td><asp:TextBox ID="txtGageDesc" runat="server"></asp:TextBox></td>
   <td>
    <asp:TextBox ID="txtGagePONum" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="aceGagePONum" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtGagePONum" UseContextKey="true" />
   </td>
   <td>
    <asp:TextBox ID="txtGageRFQNum" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="aceGageRFQNum" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetRFQNumber" TargetControlID="txtGageRFQNum" UseContextKey="true" />
   </td>
   <td><asp:TextBox ID="txtGageVendor" runat="server"></asp:TextBox></td>
   <td valign="bottom">
    <asp:Button ID="btnGageSearch" runat="server" Text="Search" OnClick="gSearch" CssClass="NavBtn" />
    <asp:Button ID="btnGageReset" runat="server" Text="Reset" OnClick="gReset" CssClass="NavBtn" />
   </td>
  </tr>
 </table><br />
 <asp:GridView ID="gvGage" runat="server" SkinID="Default" DataKeyNames="GTNameID,BDID" DataSourceID="odsGage" OnRowDataBound="gvBound" OnRowCommand="gvCmd">
  <Columns>
   <asp:TemplateField HeaderText="Select">
    <ItemTemplate>
     <asp:LinkButton ID="lnkSelect" runat="server" CommandName="useThis" Text='&#9679;' OnClientClick="javascript:doCPE();" Font-Size="XX-Large" ForeColor="Green" Font-Underline="false" />
    </ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Name" DataField="GTName" SortExpression="GTName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Part Number" DataField="PartNumber" SortExpression="PartNumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Description" DataField="Description" SortExpression="Description" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="RFQ Number" DataField="RFQNumber" SortExpression="RFQNumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="PO Number" DataField="PONumber" SortExpression="PONumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Vendor" DataField="VendorName" SortExpression="VendorName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
  </Columns>
 </asp:GridView>
 <asp:ObjectDataSource ID="odsGage" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Search">
  <SelectParameters>
   <asp:ControlParameter Name="PN" Type="String" ControlID="txtGagePN" PropertyName="Text" />
   <asp:ControlParameter Name="Desc" Type="String" ControlID="txtGageDesc" PropertyName="Text" />
   <asp:ControlParameter Name="PO" Type="String" ControlID="txtGagePONum" PropertyName="Text" />
   <asp:ControlParameter Name="RFQ" Type="String" ControlID="txtGageRFQNum" PropertyName="Text" />
   <asp:ControlParameter Name="VendorName" Type="String" ControlID="txtGageVendor" PropertyName="Text" />
   <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
  </SelectParameters>
 </asp:ObjectDataSource>
 </ContentTemplate>
</aspx:UpdatePanel>

<aspx:UpdatePanel ID="uPnlTool" runat="server" UpdateMode="Conditional" Visible="false">
 <ContentTemplate>
 <table>
  <tr>
   <td><b>Part Number:</b></td>
   <td><b>Description:</b></td>
   <td><b>PO Number:</b></td>
   <td><b>RFQ Number:</b></td>
   <td><b>Vendor:</b></td>
   <td>&nbsp;</td>
  </tr>
  <tr>
   <td>
    <asp:TextBox ID="txtToolPN" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="aceToolPN" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtToolPN">
    </ajax:AutoCompleteExtender>
   </td>
   <td><asp:TextBox ID="txtToolDesc" runat="server"></asp:TextBox></td>
   <td>
    <asp:TextBox ID="txtToolPONum" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="aceToolPONum" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetPONumber" TargetControlID="txtToolPONum" UseContextKey="true" />
   </td>
   <td>
    <asp:TextBox ID="txtToolRFQNum" runat="server"></asp:TextBox>
    <ajax:AutoCompleteExtender ID="aceToolRFQNum" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetRFQNumber" TargetControlID="txtToolRFQNum" UseContextKey="true" />
   </td>
   <td><asp:TextBox ID="txtToolVendor" runat="server"></asp:TextBox></td>
   <td valign="bottom">
    <asp:Button ID="btnToolSearch" runat="server" Text="Search" OnClick="tSearch" CssClass="NavBtn" />
    <asp:Button ID="btnToolReset" runat="server" Text="Reset" OnClick="tReset" CssClass="NavBtn" />
   </td>
  </tr>
 </table><br />
 <asp:GridView ID="gvTool" runat="server" SkinID="Default" DataKeyNames="GTTypeID,GTNameID,BDID" DataSourceID="odsTool" OnRowDataBound="gvBound" OnRowCommand="gvCmd">
  <Columns>
   <asp:TemplateField HeaderText="Select">
    <ItemTemplate>
     <asp:LinkButton ID="lnkSelect" runat="server" CommandName="useThis" Text='&#9679;' OnClientClick="javascript:doCPE();" Font-Size="XX-Large" ForeColor="Green" Font-Underline="false" />
    </ItemTemplate>
   </asp:TemplateField>
   <asp:BoundField HeaderText="Type" DataField="GTType" SortExpression="GTType" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Name" DataField="GTName" SortExpression="GTName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Part Number" DataField="PartNumber" SortExpression="PartNumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Description" DataField="Description" SortExpression="Description" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="RFQ Number" DataField="RFQNumber" SortExpression="RFQNumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="PO Number" DataField="PONumber" SortExpression="PONumber" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
   <asp:BoundField HeaderText="Vendor" DataField="VendorName" SortExpression="VendorName" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" />
  </Columns>
 </asp:GridView>
 <asp:ObjectDataSource ID="odsTool" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Search">
  <SelectParameters>
   <asp:ControlParameter Name="PN" Type="String" ControlID="txtToolPN" PropertyName="Text" />
   <asp:ControlParameter Name="Desc" Type="String" ControlID="txtToolDesc" PropertyName="Text" />
   <asp:ControlParameter Name="PO" Type="String" ControlID="txtToolPONum" PropertyName="Text" />
   <asp:ControlParameter Name="RFQ" Type="String" ControlID="txtToolRFQNum" PropertyName="Text" />
   <asp:ControlParameter Name="VendorName" Type="String" ControlID="txtToolVendor" PropertyName="Text" />
   <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
  </SelectParameters>
 </asp:ObjectDataSource>
 </ContentTemplate>
</aspx:UpdatePanel>

<asp:HiddenField ID="hfMOGT" runat="server" />