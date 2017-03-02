<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucSurvey_Question.ascx.cs" Inherits="webApp._Controls.ucSurvey_Question" %>

<asp:Repeater ID="rptSection" runat="server" DataSourceID="odsSection">
 <ItemTemplate>
  <br /><br />
  <table border="1" cellpadding="0" cellspacing="0" style="border-color:Gray; width:90%">
   <tr align="left"><td><b><%# Eval("SurveySection") %></b></td></tr>
   <asp:Repeater ID="rptQuestion" runat="server" DataSourceID="odsQuestion" OnItemDataBound="rptBound">
    <ItemTemplate>
     <tr align="left">
      <td>
       <%# Eval("SurveyQuestion") %><br />
       <asp:RadioButtonList ID="rdoAnswer" runat="server" RepeatColumns="5" RepeatDirection="Horizontal">
        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
        <asp:ListItem Value="No" Text="No"></asp:ListItem>
        <asp:ListItem Value="Na" Text="N/A"></asp:ListItem>
       </asp:RadioButtonList>
       <asp:RequiredFieldValidator ID="rfvAnswer_NoCert" runat="server" Text="This question is required" ControlToValidate="rdoAnswer" ValidationGroup="vInActive" />
       <asp:TextBox ID="txtAnswer" runat="server" TextMode="MultiLine" Width="700px" Height="50px" Text='<%# Eval("SurveyAnswer") %>'></asp:TextBox>
       <asp:HiddenField ID="hfQuestionID" runat="server" Value='<%# Eval("HID") %>' />
       <asp:HiddenField ID="hfAnswerType" runat="server" Value='<%# Eval("AnswerType") %>' />
      </td>
     </tr>
    </ItemTemplate>
   </asp:Repeater>
   <asp:HiddenField ID="hfSectionID" runat="server" Value='<%# Eval("HID") %>' />
   <asp:ObjectDataSource ID="odsQuestion" runat="server" TypeName="myBiz.DAL.clsSurvey" SelectMethod="getQuestion">
    <SelectParameters>
     <asp:ControlParameter Name="CertInfoID" ControlID="hfCertInfoID" Type="Int32" PropertyName="Value" />
     <asp:ControlParameter Name="SectionID" ControlID="hfSectionID" Type="Int32" PropertyName="Value" />
    </SelectParameters>
   </asp:ObjectDataSource>

  </table>
 </ItemTemplate>
</asp:Repeater>

<asp:HiddenField ID="hfTemplateID" runat="server" />
<asp:HiddenField ID="hfCertInfoID" runat="server" />

<asp:ObjectDataSource ID="odsSection" runat="server" TypeName="myBiz.DAL.clsSurvey" SelectMethod="getSection">
 <SelectParameters>
  <asp:ControlParameter Name="TemplateID" ControlID="hfTemplateID" Type="Int32" PropertyName="Value" />
 </SelectParameters>
</asp:ObjectDataSource>