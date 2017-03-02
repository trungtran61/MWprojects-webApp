<%@ Page Language="C#" AutoEventWireup="true" Inherits="webApp.Note.Note" Codebehind="Note.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
 <link href="../App_Themes/mwStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
 <form id="form1" runat="server">
  <aspx:ScriptManager ID="myScriptManager" runat="server" EnablePartialRendering="true" EnablePageMethods="true" />
  <aspx:UpdatePanel ID="uPnlNote" runat="server">
   <ContentTemplate>
     <asp:FormView ID="fvChatLog" runat="server" DataSourceID="odsChatLog" DefaultMode="Insert" DataKeyNames="HID"
      OnItemUpdating="fvUpdating" OnItemUpdated="fvUpdated" OnItemInserted="fvInserted" OnItemInserting="fvInserting" OnItemCommand="fvCmd">
      <InsertItemTemplate>
       <table>
        <tr valign="top">
         <td>
          <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" Width="500px" Height="50px" Text='<%# Bind("Note") %>'></asp:TextBox>
          <asp:RequiredFieldValidator ID="rfvNote" runat="server" ControlToValidate="txtNote" ErrorMessage="Note is required!" ValidationGroup="iReq"></asp:RequiredFieldValidator>
         </td>
        </tr><tr valign="top">
         <td>
          <MW:ChkBoxList ID="cblGrpIDs" runat="server" RepeatColumns="5" DataSourceID="odsChatGroup" DataTextField="gName" DataValueField="HID" DataCheckedField="isSelected"></MW:ChkBoxList><br />
          <asp:Button ID="btnSave" runat="server" Text="Save" CommandName="Insert" CssClass="NavBtn" ValidationGroup="iReq" />
         </td>
        </tr>
       </table>
      </InsertItemTemplate>
      <EditItemTemplate>
       <table>
        <tr valign="top">
        <td>
         <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" Width="500px" Height="50px" Text='<%# Bind("Note") %>'></asp:TextBox>
         <asp:RequiredFieldValidator ID="rfvNote" runat="server" ControlToValidate="txtNote" ErrorMessage="Note is required!" ValidationGroup="eReq"></asp:RequiredFieldValidator>
        </td>
        </tr><tr valign="top">
         <td>
          <MW:ChkBoxList ID="cblGrpIDs" runat="server" RepeatColumns="5" DataSourceID="odsChatGroup" DataTextField="gName" DataValueField="HID" DataCheckedField="isSelected"></MW:ChkBoxList><br />
          <asp:Button ID="btnSave" runat="server" Text="Save" CommandName="Update" CssClass="NavBtn" ValidationGroup="eReq" />
          <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" CssClass="NavBtn" />
         </td>
        </tr>
       </table>
      </EditItemTemplate>
     </asp:FormView><br />
     <asp:GridView ID="gvChatLog" Width="100%" runat="server" SkinID="GrayHeader" DataKeyNames="HID" DataSourceID="odsChatLogs" OnRowCommand="gvCmd">
      <Columns>
       <asp:TemplateField ItemStyle-Width="150px" HeaderStyle-Width="150px" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="By" SortExpression="ChatBy" InsertVisible="false">
        <ItemTemplate>
         <asp:ImageButton ID="lnkEdit" runat="server" ImageUrl="~/App_Themes/Edit.jpg" ImageAlign="Middle" ToolTip="Edit" CommandName="Select" Visible='<%# Eval("isEdit") %>' />
         <asp:ImageButton ID="lnkDelete" runat="server" ImageUrl="~/App_Themes/Close.jpg" ImageAlign="Middle" ToolTip="Delete" CommandName="Delete" Visible='<%# Eval("isEdit") %>' OnClientClick="return confirm('Are you sure you want to delete?');" />
         <%# Eval("ChatBy") %>
        </ItemTemplate>
       </asp:TemplateField>
       <asp:BoundField ItemStyle-Width="150px" HeaderStyle-Width="150px" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="Date" DataField="ChatDate" SortExpression="ChatDate" HtmlEncode="false" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" InsertVisible="false" />
       <asp:TemplateField HeaderStyle-Wrap="false" HeaderText="Note" SortExpression="Note" InsertVisible="false">
        <ItemTemplate><%# Eval("Note").ToString().Replace("\n","<br>") %>
        </ItemTemplate>
       </asp:TemplateField>
      </Columns>
     </asp:GridView>
     <asp:HiddenField ID="hfUID" runat="server" />
     <asp:ObjectDataSource ID="odsChatLogs" runat="server" TypeName="myBiz.DAL.clsChatLog" SelectMethod="ChatLog_S" DeleteMethod="ChatLog_D">
      <SelectParameters>
       <asp:ControlParameter Name="UN" Type="String" ControlID="hfUID" PropertyName="Value" />
       <asp:QueryStringParameter Name="LnkDB" Type="String" QueryStringField="lDB" />
       <asp:QueryStringParameter Name="LnkID" Type="Int32" QueryStringField="lID" />
      </SelectParameters>
      <DeleteParameters><asp:Parameter Name="HID" /></DeleteParameters>
     </asp:ObjectDataSource>
     <asp:ObjectDataSource ID="odsChatLog" runat="server" TypeName="myBiz.DAL.clsChatLog" SelectMethod="ChatLog_S1" UpdateMethod="ChatLog_Save" InsertMethod="ChatLog_Save">
      <SelectParameters>
       <asp:ControlParameter Name="HID" Type="Int32" ControlID="gvChatLog" PropertyName="SelectedValue" />
      </SelectParameters>
      <InsertParameters>
       <asp:Parameter Name="HID" Type="Int32" />
       <asp:Parameter Name="GrpIDs" Type="String" />
       <asp:QueryStringParameter Name="LnkDB" Type="String" QueryStringField="lDB" />
       <asp:QueryStringParameter Name="LnkID" Type="Int32" QueryStringField="lID" />
       <asp:ControlParameter Name="ChatBy" Type="String" ControlID="hfUID" PropertyName="Value" />
       <asp:Parameter Name="Note" Type="String" />
      </InsertParameters>
      <UpdateParameters>
       <asp:Parameter Name="HID" Type="Int32" />
       <asp:Parameter Name="GrpIDs" Type="String" />
       <asp:QueryStringParameter Name="LnkDB" Type="String" QueryStringField="lDB" />
       <asp:QueryStringParameter Name="LnkID" Type="Int32" QueryStringField="lID" />
       <asp:ControlParameter Name="ChatBy" Type="String" ControlID="hfUID" PropertyName="Value" />
       <asp:Parameter Name="Note" Type="String" />
      </UpdateParameters>
     </asp:ObjectDataSource>
     <asp:ObjectDataSource ID="odsChatGroup" runat="server" TypeName="myBiz.DAL.clsChatLog" SelectMethod="ChatGroup_S1">
      <SelectParameters><asp:ControlParameter Name="HID" Type="Int32" ControlID="gvChatLog" PropertyName="SelectedValue" /></SelectParameters>
     </asp:ObjectDataSource>
   </ContentTemplate>
  </aspx:UpdatePanel>
 </form>
</body>
</html>
