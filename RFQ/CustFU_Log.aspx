<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustFU_Log.aspx.cs" Inherits="webApp.RFQ.CustFU_Log" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
  <aspx:ScriptManager ID="xScript" runat="server" EnablePartialRendering="true" />
  <aspx:UpdatePanel ID="uPnlLog" runat="server" UpdateMode="Conditional">
   <ContentTemplate>
    <table cellpadding="5" cellspacing="5">
     <tr style="background-color:Navy; color:White; font-weight:bold;">
      <td>Customer Name: <asp:Literal ID="litCustomerName" runat="server"></asp:Literal></td>
      <td>Current Status: <asp:Literal ID="litCurStatus" runat="server"></asp:Literal></td>
     </tr>
     <tr>
      <td><b>Contact Name:</b></td>
      <td><asp:TextBox ID="txtConNm" runat="server"></asp:TextBox>
       <asp:RequiredFieldValidator ID="rfvConNm" runat="server" ErrorMessage="Contact Name is Required!" ControlToValidate="txtConNm" ValidationGroup="vSave"></asp:RequiredFieldValidator>
      </td>
     </tr>
     <tr>
      <td><b>By:</b></td>
      <td><asp:DropDownList ID="ddlConBy" runat="server" DataSourceID="odsConBy" DataValueField="mValue" DataTextField="mText"></asp:DropDownList></td>
     </tr>
     <tr>
      <td><b>Result:</b></td>
      <td>
       <asp:DropDownList ID="ddlResult" runat="server" DataSourceID="odsResult" DataValueField="HID" DataTextField="mText" AutoPostBack="true" OnSelectedIndexChanged="ddlSelected" AppendDataBoundItems="true">
        <asp:ListItem Text="Please select a result!" Value=""></asp:ListItem>
       </asp:DropDownList>
       <asp:RequiredFieldValidator ID="rfvResult" runat="server" ErrorMessage="Result is Required!" ControlToValidate="ddlResult" ValidationGroup="vSave"></asp:RequiredFieldValidator>
      </td>
     </tr>
     <tr>
      <td><b>Comment:</b></td>
      <td><asp:TextBox ID="txtCmt" runat="server" Width="350px" Height="75px" TextMode="MultiLine"></asp:TextBox></td>
     </tr>
     <tr>
      <td><b>Next Call Date:</b></td>
      <td>
       <telerik:RadDateTimePicker ID="txtDate" runat="server" TimeView-Interval="00:30:00" DateInput-DateFormat="MM/dd/yy h:mm tt" Width="150px" />
       <asp:RequiredFieldValidator ID="rfvDate" runat="server" ErrorMessage="Next Date is Required!" ControlToValidate="txtDate" ValidationGroup="vSave"></asp:RequiredFieldValidator>
      </td>
     </tr>
     <tr><td colspan="2"><asp:Button ID="btnSave" runat="server" Text="Save" OnClick="doSave" ValidationGroup="vSave" /></td></tr>
    </table>
    <MW:Message ID="iMsg" runat="server" />
    <asp:ObjectDataSource ID="odsConBy" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
     <SelectParameters>
      <asp:Parameter Name="Cate" Type="String" DefaultValue="FollowUpContactBy" />
      <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="0" />
     </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsResult" runat="server" TypeName="myBiz.DAL.clsCustFU" SelectMethod="Result_S">
     <SelectParameters>
      <asp:ControlParameter Name="curStatus" Type="String" ControlID="litCurStatus" PropertyName="Text" />
     </SelectParameters>
    </asp:ObjectDataSource>
   </ContentTemplate>
  </aspx:UpdatePanel>
  <aspx:UpdatePanel ID="uPnlViewLog" runat="server" UpdateMode="Conditional">
   <ContentTemplate>
    <h3><span style="background-color:Navy; color:White; font-weight:bold;">FOLLOW UP LOGS FOR: <%= Request.QueryString["cNm"] %></span></h3>
    <asp:Repeater ID="rptViewLog" runat="server" DataSourceID="odsViewLog">
     <HeaderTemplate><table></HeaderTemplate>
     <ItemTemplate>
      <tr style="background:#EEEEEE;">
       <td>
      <b><%# Eval("EnteredDate", "{0:MM/dd/yy ddd h:mm tt}") %></b>. <%# Eval("EnteredBy")%> <%# Eval("curStatus") %> with <%# Eval("ContactName") %> by <%# Eval("ContactBy") %>
      <br />Result: <%# Eval("Result") %>; <%# Eval("Comment") %>
       </td>
      </tr>
     </ItemTemplate>
     <AlternatingItemTemplate>
      <tr style="background:#EEFFEE;">
       <td>
      <b><%# Eval("EnteredDate", "{0:MM/dd/yy ddd h:mm tt}")%></b>. <%# Eval("EnteredBy")%> <%# Eval("curStatus") %> with <%# Eval("ContactName") %> by <%# Eval("ContactBy") %>
      <br />Result: <%# Eval("Result") %>; <%# Eval("Comment") %>
       </td>
      </tr>
     </AlternatingItemTemplate>
     <SeparatorTemplate><tr><td>&nbsp;</td></tr></SeparatorTemplate>
     <FooterTemplate></table></FooterTemplate>
    </asp:Repeater>
    <asp:ObjectDataSource ID="odsViewLog" runat="server" TypeName="myBiz.DAL.clsCustFU" SelectMethod="FollowUp_Log_S">
     <SelectParameters>
      <asp:QueryStringParameter Name="CustFUID" Type="Int32" QueryStringField="HID" />
     </SelectParameters>
    </asp:ObjectDataSource>
   </ContentTemplate>
  </aspx:UpdatePanel>
    </div>
    </form>
</body>
</html>
