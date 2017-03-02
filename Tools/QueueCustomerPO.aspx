<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="QueueCustomerPO.aspx.cs" Inherits="webApp.Tools.QueueCustomerPO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlCustomerPO" runat="server">
  <ContentTemplate>
   <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
    <tr style="background-color:#330099; color:White">
     <td align="center" style="font-weight:bold;">NEW CUSTOMER POs NEED TO BE ENTERED</td>
    </tr>
    <tr>
     <td>
      <asp:GridView ID="gvReviewed" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID,Code" DataSourceID="odsReviewed" OnRowDataBound="rwBound" OnRowCommand="rwCmd" PageSize="10">
       <Columns>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
         <HeaderTemplate>
          <asp:DropDownList ID="ddlReviewedDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
           <asp:ListItem Text="10" Value="10"></asp:ListItem>
           <asp:ListItem Text="20" Value="20"></asp:ListItem>
           <asp:ListItem Text="30" Value="30"></asp:ListItem>
           <asp:ListItem Text="All" Value="5000"></asp:ListItem>
          </asp:DropDownList>
         </HeaderTemplate>
         <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="#" DataField="HID" SortExpression="HID" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer PO#" DataField="CustomerPO" SortExpression="CustomerPO" />
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="File Name" SortExpression="FName">
         <ItemTemplate>
          <asp:LinkButton ID="lnkFName" runat="server" Text='<%# Eval("FName") %>' CommandName="viewCustomerPO" CommandArgument='<%# Eval("HID") %>'></asp:LinkButton>
         </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Reviewed By" DataField="ReviewedBy" SortExpression="ReviewedBy" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Reviewed Date" DataField="ReviewedDate" SortExpression="ReviewedDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" />
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Order Entry Due Date" SortExpression="DueDate">
         <ItemTemplate><%# gDD("DueDate") %></ItemTemplate>
        </asp:TemplateField>
       </Columns>
       <EmptyDataTemplate>No Customer PO is available!</EmptyDataTemplate>
      </asp:GridView>
     </td>
    </tr>
   </table>

   <br />
   <asp:Button ID="btnEnter" runat="server" Text="Complete" OnClick="doEntering" CssClass="NavBtn" />
   <hr /><br />

   <b>Customer PO:</b> <asp:TextBox ID="txtCustomerPO" runat="server"></asp:TextBox>
   <b>Customer Name:</b> <asp:TextBox ID="txtCustomerName" runat="server"></asp:TextBox>
   <b>Entered Date Range:</b> <asp:DropDownList ID="ddlMonth" runat="server"><asp:ListItem Value="This" Text="Current Month" /><asp:ListItem Value="Last" Text="Previous Month" /><asp:ListItem Value="All" Text="" /></asp:DropDownList>
   <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="NavBtn" /><br /><br />

   <table cellpadding="0" cellspacing="0" style="border:solid 1px black">
    <tr style="background-color:#330099; color:White">
     <td align="center" style="font-weight:bold;"><span id="lblPoCnt" style="float:left;">0</span>CUSTOMER POs HAD BEEN ENTERED</td>
    </tr>
    <tr>
     <td>
      <asp:GridView ID="gvEntered" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID,Code" DataSourceID="odsEntered" OnRowDataBound="rwBound" OnRowCommand="rwCmd" PageSize="10" OnDataBound="gvEntered_DataBound">
       <Columns>
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
         <HeaderTemplate>
          <input id="chkAlls" type="checkbox" name="chkAlls" onclick="javascript: dCnt(this, -99, true);" />
          <asp:DropDownList ID="ddlEnteredDisplay" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
           <asp:ListItem Text="10" Value="10"></asp:ListItem>
           <asp:ListItem Text="20" Value="20"></asp:ListItem>
           <asp:ListItem Text="30" Value="30"></asp:ListItem>
           <asp:ListItem Text="All" Value="5000"></asp:ListItem>
          </asp:DropDownList>
         </HeaderTemplate>
         <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" />
          <asp:HiddenField ID="hfDollar" runat="server" Value='<%# Eval("Total") %>' />
         </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="#" DataField="HID" SortExpression="HID" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer PO#" DataField="CustomerPO" SortExpression="CustomerPO" />
        <asp:TemplateField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="File Name" SortExpression="FName">
         <ItemTemplate>
          <asp:LinkButton ID="lnkFName" runat="server" Text='<%# Eval("FName") %>' CommandName="viewCustomerPO" CommandArgument='<%# Eval("HID") %>'></asp:LinkButton>
         </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Entered By" DataField="EnteredBy" SortExpression="EnteredBy" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Entered Date" DataField="EnteredDate" SortExpression="EnteredDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="# Orders" DataField="orderCount" SortExpression="orderCount" InsertVisible="false" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Right" HeaderText="Total ($)" DataField="Total" SortExpression="Total" InsertVisible="false" HtmlEncode="false" DataFormatString="{0:C}" />
        <asp:BoundField HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Customer" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" />
       </Columns>
       <EmptyDataTemplate>No Customer PO has been entered!</EmptyDataTemplate>
      </asp:GridView>
     </td>
    </tr>
   </table>
   <br />
   <asp:Button ID="btnUndoEnter" runat="server" Text="Undo Complete" OnClick="doEntering" CssClass="NavBtn" />
   <asp:Panel ID="pnlPopup" runat="server" />
   <asp:HiddenField ID="hfChkBox" runat="server" />
   <asp:HiddenField ID="hfTotalVal" runat="server" Value="0" />
  </ContentTemplate>
 </aspx:UpdatePanel>
 <telerik:RadCodeBlock id="rcbScript" runat="server">
  <script type="text/javascript">
   function dCnt(chk, val, isAll) {
    var myBoxes = document.getElementById('<%= hfChkBox.ClientID %>').value.split(':');
    var len = myBoxes.length;
    var lbl = document.getElementById('lblPoCnt');
    var totalVal = document.getElementById('<%= hfTotalVal.ClientID %>').value;

    if (chk.checked) {
     if (isAll) lbl.innerHTML = Number(totalVal).toFixed(2);
     else lbl.innerHTML = (Number(lbl.innerHTML) + Number(val)).toFixed(2);
    }
    else {
     if (isAll) lbl.innerHTML = '0';
     else lbl.innerHTML = (Number(lbl.innerHTML) - Number(val)).toFixed(2);
    }

    var Cnt = 0;
    for (var i = 0; i < len; i++) {
     if (isAll) document.getElementById(myBoxes[i]).checked = chk.checked;
     else if (document.getElementById(myBoxes[i]).checked) Cnt++;
    }

    if (!isAll) document.getElementById('chkAlls').checked = Cnt == len;
   }
  </script>
 </telerik:RadCodeBlock>
 <asp:ObjectDataSource ID="odsReviewed" runat="server" TypeName="myBiz.DAL.clsFile" SelectMethod="CustomerPO_S">
  <SelectParameters>
   <asp:Parameter Name="Status" Type="String" DefaultValue="Reviewed" />
   <asp:QueryStringParameter Name="lMode" Type="String" QueryStringField="lMode" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsEntered" runat="server" TypeName="myBiz.DAL.clsFile" SelectMethod="CustomerPO_S1">
  <SelectParameters>
   <asp:ControlParameter Name="CustomerPO" Type="String" ControlID="txtCustomerPO" PropertyName="Text" />
   <asp:ControlParameter Name="CustomerName" Type="String" ControlID="txtCustomerName" PropertyName="Text" />
   <asp:ControlParameter Name="Month" Type="String" ControlID="ddlMonth" PropertyName="SelectedValue" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>