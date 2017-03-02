<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MaterialDms.ascx.cs" Inherits="webApp._Controls.MaterialDms" %>


<asp:GridView ID="gvDmsList" runat="server" SkinID="Default" DataKeyNames="HID" OnRowDataBound="rwBound">
 <Columns>
  <asp:TemplateField InsertVisible="false">
   <ItemTemplate>
    <asp:HiddenField ID="hfHID" runat="server" Value='<%# Eval("HID") %>' />
    <asp:Literal ID="litVal" runat="server" Text='<%# dVal() %>'></asp:Literal>
    <asp:TextBox ID="txtVal" runat="server" Width="50px"></asp:TextBox>
    <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="odsUnitList" DataTextField="MatlUnitTxt" DataValueField="MatlUnitVal"></asp:DropDownList>    
    <asp:ObjectDataSource ID="odsUnitList" runat="server" TypeName="myBiz.DAL.clsMaterial" SelectMethod="Material_Unit_S">
     <SelectParameters><asp:ControlParameter Name="MatlDmsID" Type="Int32" ControlID="hfHID" PropertyName="Value" /></SelectParameters>
    </asp:ObjectDataSource>
   </ItemTemplate>
  </asp:TemplateField>
 </Columns>
</asp:GridView>

<asp:HiddenField ID="hfCurrentMode" runat="server" />