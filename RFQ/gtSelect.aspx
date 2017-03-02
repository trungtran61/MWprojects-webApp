<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="gtSelect.aspx.cs" Inherits="webApp.RFQ.gtSelect" %>
<%@ Register Src="~/_Controls/ucMOGT.ascx" TagName="ucMOGT" TagPrefix="ucMOGT" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <link href="../App_Themes/Default/mwStyle.css" rel="stylesheet" type="text/css" />
    <title></title>
    <script type="text/javascript">
     function doCPE() {
      $find('cpeSearch').set_Collapsed(true);
     }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <aspx:ScriptManager ID="scrGageTool" runat="server" EnablePartialRendering="true"></aspx:ScriptManager>
     <asp:Label ID="lblHeader" runat="server" Font-Bold="true" OnLoad="lblLoad"></asp:Label>
     <aspx:UpdatePanel ID="uPnlGageTool" runat="server">
      <ContentTemplate>
       <asp:GridView ID="gvGageTool" runat="server" SkinID="Default" DataKeyNames="HID" DataSourceID="odsGageTool" OnRowCommand="rwCmd" ShowFooter="true" OnRowDataBound="rwBound">
        <Columns>
         <asp:TemplateField>
          <ItemTemplate>
           <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CssClass="NavBtn" OnClientClick="return confirm('Are you sure you want to delete?');" />
          </ItemTemplate>
          <FooterTemplate>
           <asp:Button ID="btnAdd" runat="server" Text="Add" CommandName="AddNew" CssClass="NavBtn" />
          </FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Item#" SortExpression="ItemNo" InsertVisible="false">
          <ItemTemplate><%# Eval("ItemNo") %></ItemTemplate>
          <FooterTemplate>TBD</FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Category" SortExpression="ProCate" InsertVisible="false">
          <ItemTemplate><asp:Literal ID="litProCate" runat="server" Text='<%# Eval("ProCate") %>' /></ItemTemplate>
          <FooterTemplate><asp:DropDownList ID="ddlProCate" runat="server" DataSourceID="odsProCate" DataValueField="HID" DataTextField="ProCate" /></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Type" SortExpression="GTType" InsertVisible="false">
          <ItemTemplate><asp:Literal ID="litGTType" runat="server" Text='<%# Eval("GTType") %>' /></ItemTemplate>
          <FooterTemplate>
           <asp:DropDownList ID="ddlTType" runat="server" AutoPostBack="true" DataSourceID="odsTTypeList" DataValueField="HID" DataTextField="ToolType" OnSelectedIndexChanged="ddlSelected" />
           <asp:ObjectDataSource ID="odsTTypeList" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Tool_Type_S">
            <SelectParameters><asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" /></SelectParameters>
           </asp:ObjectDataSource>
          </FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Name" SortExpression="GTName" InsertVisible="false">
          <ItemTemplate><asp:Literal ID="litGTName" runat="server" Text='<%# Eval("GTName") %>' /></ItemTemplate>
          <FooterTemplate>
           <asp:DropDownList ID="ddlTName" runat="server" AutoPostBack="true" DataSourceID="odsTNameList" DataValueField="HID" DataTextField="ToolName" />
           <asp:DropDownList ID="ddlGName" runat="server" AutoPostBack="true" DataSourceID="odsGNameList" DataValueField="HID" DataTextField="GageName" />
           <asp:ObjectDataSource ID="odsTNameList" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Tool_Name_S">
            <SelectParameters>
             <asp:ControlParameter Name="ToolTypeID" Type="Int32" ControlID="ddlTType" PropertyName="SelectedValue" />
             <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
            </SelectParameters>
           </asp:ObjectDataSource>
           <asp:ObjectDataSource ID="odsGNameList" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Gage_Name_S">
            <SelectParameters><asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" /></SelectParameters>
           </asp:ObjectDataSource>
          </FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Description" InsertVisible="false">
          <ItemTemplate>
           <asp:HiddenField ID="hfBDID" runat="server" Value='<%# Eval("BDID") %>' />
           <asp:Repeater ID="rptTDmsList" runat="server" DataSourceID="odsTDmsList">
            <HeaderTemplate><table></HeaderTemplate>
            <ItemTemplate>
             <tr><td><%# Eval("ToolDms") %>: <%# Eval("dVal") %><%# Eval("dUnit") %></td></tr>
            </ItemTemplate>
            <FooterTemplate></table></FooterTemplate>
           </asp:Repeater>
           <asp:Repeater ID="rptGDmsList" runat="server" DataSourceID="odsGDmsList">
            <HeaderTemplate><table></HeaderTemplate>
            <ItemTemplate>
             <tr><td><%# Eval("GageDms") %>: <%# Eval("dVal") %><%# Eval("dUnit") %></td></tr>
            </ItemTemplate>
            <FooterTemplate></table></FooterTemplate>
           </asp:Repeater>
           <asp:ObjectDataSource ID="odsTDmsList" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Tool_DmsVal_S">
            <SelectParameters><asp:ControlParameter Name="BDID" Type="Int32" ControlID="hfBDID" PropertyName="Value" /></SelectParameters>
           </asp:ObjectDataSource>
           <asp:ObjectDataSource ID="odsGDmsList" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Gage_DmsVal_S">
            <SelectParameters><asp:ControlParameter Name="BDID" Type="Int32" ControlID="hfBDID" PropertyName="Value" /></SelectParameters>
           </asp:ObjectDataSource>
          </ItemTemplate>
          <FooterTemplate>
           <asp:GridView ID="gvTDmsList" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsTDmsList" ShowHeader="false" PageSize="200">
            <Columns>
             <asp:BoundField DataField="ToolDms" InsertVisible="false" />
             <asp:TemplateField InsertVisible="false">
              <ItemTemplate>
               <asp:HiddenField ID="hfHID" runat="server" Value='<%# Eval("HID") %>' />
               <asp:TextBox ID="txtVal" runat="server" Width="50px"></asp:TextBox>
               <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="odsUnitList" DataTextField="ToolUnitTxt" DataValueField="ToolUnitVal"></asp:DropDownList>    
               <asp:ObjectDataSource ID="odsUnitList" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Tool_Unit_S">
                <SelectParameters>
                 <asp:ControlParameter Name="ToolDmsID" Type="Int32" ControlID="hfHID" PropertyName="Value" />
                 <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
                </SelectParameters>
               </asp:ObjectDataSource>
              </ItemTemplate>
             </asp:TemplateField>
            </Columns>
           </asp:GridView>
           <asp:GridView ID="gvGDmsList" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsGDmsList" ShowHeader="false" PageSize="200">
            <Columns>
             <asp:BoundField DataField="GageDms" InsertVisible="false" />
             <asp:TemplateField InsertVisible="false">
              <ItemTemplate>
               <asp:HiddenField ID="hfHID" runat="server" Value='<%# Eval("HID") %>' />
               <asp:TextBox ID="txtVal" runat="server" Width="50px"></asp:TextBox>
               <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="odsUnitList" DataTextField="GageUnitTxt" DataValueField="GageUnitVal"></asp:DropDownList>    
               <asp:ObjectDataSource ID="odsUnitList" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Gage_Unit_S">
                <SelectParameters>
                 <asp:ControlParameter Name="GageDmsID" Type="Int32" ControlID="hfHID" PropertyName="Value" />
                 <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
                </SelectParameters>
               </asp:ObjectDataSource>
              </ItemTemplate>
             </asp:TemplateField>
            </Columns>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsTDmsList" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Tool_DmsVal_S1">
            <SelectParameters>
             <asp:ControlParameter Name="ToolNameID" Type="Int32" ControlID="ddlTName" PropertyName="SelectedValue" />
             <asp:Parameter Name="BDID" Type="Int32" DefaultValue="0" />
            </SelectParameters>
           </asp:ObjectDataSource>
           <asp:ObjectDataSource ID="odsGDmsList" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Gage_DmsVal_S1">
            <SelectParameters>
             <asp:ControlParameter Name="GageNameID" Type="Int32" ControlID="ddlGName" PropertyName="SelectedValue" />
             <asp:Parameter Name="BDID" Type="Int32" DefaultValue="0" />
            </SelectParameters>
           </asp:ObjectDataSource>
          </FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField HeaderText="Comment" SortExpression="GTDesc" InsertVisible="false">
          <ItemTemplate><%# Eval("GTDesc") %></ItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtGTDesc" runat="server"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
         <asp:TemplateField SortExpression="Qty" InsertVisible="false">
          <HeaderTemplate>
           <asp:LinkButton ID="lnkHeader" runat="server" Text='<%# qHeader() %>' CommandName="Sort" CommandArgument="Qty" ForeColor="White"></asp:LinkButton>
          </HeaderTemplate>
          <ItemTemplate><%# Eval("Qty") %></ItemTemplate>
          <FooterTemplate><asp:TextBox ID="txtQty" runat="server" Width="25px"></asp:TextBox></FooterTemplate>
         </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
         <table cellpadding="5">
          <tr style="background-color:#507CD1; color:White;">
           <td>&nbsp;</td>
           <td align="center" style="white-space:nowrap;"><b>Item#</b></td>
           <td align="center" style="white-space:nowrap;"><b>Category</b></td>
           <td id="tdKType" runat="server" align="center" style="white-space:nowrap;"><b>Type</b></td>
           <td align="center" style="white-space:nowrap;"><b>Name</b></td>
           <td align="center" style="white-space:nowrap;"><b>Dimension</b></td>
           <td align="center" style="white-space:nowrap;"><b>Description</b></td>
           <td align="center" style="white-space:nowrap;"><b>Qty</b></td>
          </tr>
          <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
           <td><asp:Button ID="btnAdd" runat="server" Text="Add" CommandName="InsertNew" /></td>
           <td>TBD</td>
           <td><asp:DropDownList ID="ddlProCate" runat="server" DataSourceID="odsProCate" DataValueField="HID" DataTextField="ProCate" /></td>
           <td id="tdVType" runat="server">
            <asp:DropDownList ID="ddlTType" runat="server" AutoPostBack="true" DataSourceID="odsTTypeList" DataValueField="HID" DataTextField="ToolType" OnSelectedIndexChanged="ddlSelected" />
            <asp:ObjectDataSource ID="odsTTypeList" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Tool_Type_S">
             <SelectParameters><asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" /></SelectParameters>
            </asp:ObjectDataSource>
           </td>
           <td>
           <asp:DropDownList ID="ddlTName" runat="server" AutoPostBack="true" DataSourceID="odsTNameList" DataValueField="HID" DataTextField="ToolName" />
           <asp:DropDownList ID="ddlGName" runat="server" AutoPostBack="true" DataSourceID="odsGNameList" DataValueField="HID" DataTextField="GageName" />
           <asp:ObjectDataSource ID="odsTNameList" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Tool_Name_S">
            <SelectParameters>
             <asp:ControlParameter Name="ToolTypeID" Type="Int32" ControlID="ddlTType" PropertyName="SelectedValue" />
             <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
            </SelectParameters>
           </asp:ObjectDataSource>
           <asp:ObjectDataSource ID="odsGNameList" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Gage_Name_S">
            <SelectParameters><asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" /></SelectParameters>
           </asp:ObjectDataSource>
           </td>
           <td>
           <asp:GridView ID="gvTDmsList" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsTDmsList" ShowHeader="false" PageSize="200">
            <Columns>
             <asp:BoundField DataField="ToolDms" InsertVisible="false" />
             <asp:TemplateField InsertVisible="false">
              <ItemTemplate>
               <asp:HiddenField ID="hfHID" runat="server" Value='<%# Eval("HID") %>' />
               <asp:TextBox ID="txtVal" runat="server" Width="50px"></asp:TextBox>
               <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="odsUnitList" DataTextField="ToolUnitTxt" DataValueField="ToolUnitVal"></asp:DropDownList>    
               <asp:ObjectDataSource ID="odsUnitList" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Tool_Unit_S">
                <SelectParameters>
                 <asp:ControlParameter Name="ToolDmsID" Type="Int32" ControlID="hfHID" PropertyName="Value" />
                 <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
                </SelectParameters>
               </asp:ObjectDataSource>
              </ItemTemplate>
             </asp:TemplateField>
            </Columns>
           </asp:GridView>
           <asp:GridView ID="gvGDmsList" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsGDmsList" ShowHeader="false" PageSize="200">
            <Columns>
             <asp:BoundField DataField="GageDms" InsertVisible="false" />
             <asp:TemplateField InsertVisible="false">
              <ItemTemplate>
               <asp:HiddenField ID="hfHID" runat="server" Value='<%# Eval("HID") %>' />
               <asp:TextBox ID="txtVal" runat="server" Width="50px"></asp:TextBox>
               <asp:DropDownList ID="ddlUnit" runat="server" DataSourceID="odsUnitList" DataTextField="GageUnitTxt" DataValueField="GageUnitVal"></asp:DropDownList>    
               <asp:ObjectDataSource ID="odsUnitList" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Gage_Unit_S">
                <SelectParameters>
                 <asp:ControlParameter Name="GageDmsID" Type="Int32" ControlID="hfHID" PropertyName="Value" />
                 <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
                </SelectParameters>
               </asp:ObjectDataSource>
              </ItemTemplate>
             </asp:TemplateField>
            </Columns>
           </asp:GridView>
           <asp:ObjectDataSource ID="odsTDmsList" runat="server" TypeName="myBiz.DAL.clsTools" SelectMethod="Tool_Dms_S">
            <SelectParameters>
             <asp:ControlParameter Name="ToolNameID" Type="Int32" ControlID="ddlTName" PropertyName="SelectedValue" />
             <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
            </SelectParameters>
           </asp:ObjectDataSource>
           <asp:ObjectDataSource ID="odsGDmsList" runat="server" TypeName="myBiz.DAL.clsGage" SelectMethod="Gage_Dms_S">
            <SelectParameters>
             <asp:ControlParameter Name="GageNameID" Type="Int32" ControlID="ddlGName" PropertyName="SelectedValue" />
             <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
            </SelectParameters>
           </asp:ObjectDataSource>
           
           </td>
           <td><asp:TextBox ID="txtGTDesc" runat="server"></asp:TextBox></td>
           <td><asp:TextBox ID="txtQty" runat="server" Width="25px"></asp:TextBox></td>
          </tr>
         </table>
        </EmptyDataTemplate>
       </asp:GridView>
       
       <asp:ImageButton ID="imgSearch" runat="server" ImageUrl="~/App_Themes/search.jpg" Width="20px" OnClientClick="return false;" />
       <asp:Panel ID="pnlSearch" runat="server"><ucMOGT:ucMOGT ID="uMOGT" runat="server" /></asp:Panel>
       <ajax:CollapsiblePanelExtender ID="cpeSearch" runat="server" TargetControlID="pnlSearch" ExpandControlID="imgSearch" CollapseControlID="imgSearch" Collapsed="true" />

       <MW:Message ID="iMsg" runat="server" />
       <asp:ObjectDataSource ID="odsGageTool" runat="server" TypeName="myBiz.DAL.clsRFQRter_GageTool" SelectMethod="Select" DeleteMethod="Delete" InsertMethod="Insert" OnDeleted="odsDeleted">
        <SelectParameters>
         <asp:QueryStringParameter Name="RterID" Type="Int32" QueryStringField="RterID" />
         <asp:QueryStringParameter Name="GageTool" Type="String" QueryStringField="GageTool" />
        </SelectParameters>
        <DeleteParameters>
         <asp:Parameter Name="HID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
         <asp:QueryStringParameter Name="RterID" Type="Int32" QueryStringField="RterID" />
         <asp:QueryStringParameter Name="GageTool" Type="String" QueryStringField="GageTool" />
         <asp:Parameter Name="GTDesc" Type="String" />
         <asp:Parameter Name="Qty" Type="Int32" />
         <asp:Parameter Name="PID" Type="Int32" />
         <asp:Parameter Name="GTNameID" Type="Int32" />
         <asp:Parameter Name="DmsID" Type="String" />
         <asp:Parameter Name="dVal" Type="String" />
         <asp:Parameter Name="dUnit" Type="String" />
        </InsertParameters>
       </asp:ObjectDataSource>
       <asp:ObjectDataSource ID="odsProCate" runat="server" TypeName="myBiz.DAL.clsProcessType" SelectMethod="SelectByProCate">
        <SelectParameters><asp:QueryStringParameter Name="ProCate" Type="String" QueryStringField="GageTool" /></SelectParameters>
       </asp:ObjectDataSource>
      </ContentTemplate>
     </aspx:UpdatePanel>
    </div>
    </form>
</body>
</html>
