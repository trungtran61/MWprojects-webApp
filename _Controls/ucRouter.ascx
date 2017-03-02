<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucRouter.ascx.cs" Inherits="webApp._Controls.ucRouter" %>
<%@ Register Src="~/_Controls/Component.ascx" TagName="Component" TagPrefix="ucComponent" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<asp:Panel ID="pnlTask" runat="server">
<h3>Request Information for Router</h3>

<b>Engineer Processing Time:</b>
<asp:TextBox ID="txtEPT" runat="server" Width="25px"></asp:TextBox>
<asp:DropDownList ID="ddlEPT" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
<asp:Button ID="btnEPT" runat="server" Text="Update" OnClick="saveEPT" CssClass="NavBtn" />
<asp:Literal ID="eMsg" runat="server"></asp:Literal>
<br />

<asp:GridView ID="gvRouter" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True"
 AutoGenerateColumns="False" CellPadding="5" CellSpacing="1" DataKeyNames="HID,StepNo" DataSourceID="odsRouter" ShowFooter="true"
 ForeColor="#333333" GridLines="Both" BorderStyle="Double" BorderWidth="5px" BorderColor="White" OnRowUpdating="uRouter" OnRowDataBound="RwBound"
 OnDataBound="gvBound">
 <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
 <RowStyle BackColor="#EFF3FB" />
 <Columns>
  <asp:TemplateField>
   <ItemTemplate>
    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" Visible='<%# Eval("allowEdit") %>' />
   </ItemTemplate>
   <EditItemTemplate>
    <asp:LinkButton ID="lnkUpdate" runat="server" Text="Update" CommandName="Update" ValidationGroup="uValid" />
    <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel" />
   </EditItemTemplate>
   <FooterTemplate><asp:Button ID="btnAddRemove" Text="Add" runat="server" OnClick="btnAdd_Click" ValidationGroup="nValid" /></FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Step#" SortExpression="StepNo" InsertVisible="false">
   <ItemTemplate><%# Eval("StepNo") %></ItemTemplate>
   <EditItemTemplate><%# Eval("StepNo") %></EditItemTemplate>
   <FooterTemplate><asp:TextBox ID="txtStepNo" runat="server" Width="25px"></asp:TextBox></FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="StepID: StepName" SortExpression="StepName" InsertVisible="false">
   <ItemTemplate><%# Eval("StepName") %>: <%# Eval("StepDesc") %></ItemTemplate>
   <EditItemTemplate>
    <asp:RadioButtonList ID="rblStepName" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" runat="server" SelectedValue='<%# Eval("StepID") %>' OnSelectedIndexChanged="rblStepName_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" />
    <asp:HiddenField ID="hfMPID" runat="server" Value='<%# Eval("MPID") %>' />
   </EditItemTemplate>
   <FooterTemplate><asp:RadioButtonList ID="rblStepName" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblStepName_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" /></FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Process<br>/Mac. ID" SortExpression="MTPName" InsertVisible="false">
   <ItemTemplate><%# Eval("MTPID") %>: <%# Eval("MTPName") %></ItemTemplate>
   <EditItemTemplate>
    <asp:DropDownList ID="ddlProcessList" runat="server" DataTextField="mText" DataValueField="MPID" />
   </EditItemTemplate>
   <FooterTemplate>
    <asp:DropDownList ID="ddlProcessList" runat="server" DataTextField="mText" DataValueField="MPID" />
   </FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="M.O.T<br>OP#" SortExpression="OpNo" InsertVisible="false">
   <ItemTemplate><%# Eval("OpNo") %></ItemTemplate>
   <EditItemTemplate>
    <asp:DropDownList ID="ddlOpNo1" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelectedEdit" />
    <asp:HiddenField ID="hfOpNo" runat="server" Value='<%# Bind("OpNo") %>' />
   </EditItemTemplate>
   <FooterTemplate><asp:DropDownList ID="ddlOpNo" runat="server" DataTextField="mText" DataValueField="mValue" /></FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Program<br>Time" SortExpression="EPTime" InsertVisible="false" ItemStyle-Wrap="false" FooterStyle-Wrap="false">
   <ItemTemplate><%# Eval("EPTime") %> <%# Eval("EPUnit") %></ItemTemplate>
   <EditItemTemplate>
    <asp:TextBox ID="txtEPTime" runat="server" Width="25px" Text='<%# Bind("EPTime") %>'></asp:TextBox>
    <asp:DropDownList ID="ddlEPUnit" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("EPUnit") %>' />
    <asp:RegularExpressionValidator ID="revEPTime" runat="server" ControlToValidate="txtEPTime" Text="*" ErrorMessage="Invalid Program Time [Number only]" ValidationGroup="uValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
   </EditItemTemplate>
   <FooterTemplate>
    <asp:TextBox ID="txtEPTime" runat="server" Width="25px"></asp:TextBox>
    <asp:DropDownList ID="ddlEPUnit" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
    <asp:RegularExpressionValidator ID="revEPTime" runat="server" ControlToValidate="txtEPTime" Text="*" ErrorMessage="Invalid Program Time [Number only]" ValidationGroup="nValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
   </FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Est.<br>Setup Time" SortExpression="ESTime" InsertVisible="false" ItemStyle-Wrap="false" FooterStyle-Wrap="false">
   <ItemTemplate><%# Eval("ESTime") %> <%# Eval("ESUnit") %></ItemTemplate>
   <EditItemTemplate>
    <asp:TextBox ID="txtESTime" runat="server" Width="25px" Text='<%# Bind("ESTime") %>'></asp:TextBox>
    <asp:DropDownList ID="ddlESUnit" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("ESUnit") %>' />
    <asp:RegularExpressionValidator ID="revESTime" runat="server" ControlToValidate="txtESTime" Text="*" ErrorMessage="Invalid Estimated Setup Time [Number only]" ValidationGroup="uValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
   </EditItemTemplate>
   <FooterTemplate>
    <asp:TextBox ID="txtESTime" runat="server" Width="25px"></asp:TextBox>
    <asp:DropDownList ID="ddlESUnit" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
    <asp:RegularExpressionValidator ID="revESTime" runat="server" ControlToValidate="txtESTime" Text="*" ErrorMessage="Invalid Estimated Setup Time [Number only]" ValidationGroup="nValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
   </FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Est.<br>Cycle Time" SortExpression="ECTime" InsertVisible="false" ItemStyle-Wrap="false" FooterStyle-Wrap="false">
   <ItemTemplate><%# Eval("ECTime") %> <%# Eval("ECUnit") %></ItemTemplate>
   <EditItemTemplate>
    <asp:TextBox ID="txtECTime" runat="server" Width="25px" Text='<%# Bind("ECTime") %>'></asp:TextBox>
    <asp:DropDownList ID="ddlECUnit" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("ECUnit") %>' />
    <asp:RegularExpressionValidator ID="revECTime" runat="server" ControlToValidate="txtECTime" Text="*" ErrorMessage="Invalid Estimated Cycle Time [Number only]" ValidationGroup="uValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
   </EditItemTemplate>
   <FooterTemplate>
    <asp:TextBox ID="txtECTime" runat="server" Width="25px"></asp:TextBox>
    <asp:DropDownList ID="ddlECUnit" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
    <asp:RegularExpressionValidator ID="revECTime" runat="server" ControlToValidate="txtECTime" Text="*" ErrorMessage="Invalid Estimated Cycle Time [Number only]" ValidationGroup="nValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
   </FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Est.<br>Fixture Time" SortExpression="EFTime" InsertVisible="false" ItemStyle-Wrap="false" FooterStyle-Wrap="false">
   <ItemTemplate><%# Eval("EFTime") %> <%# Eval("EFUnit") %></ItemTemplate>
   <EditItemTemplate>
    <asp:TextBox ID="txtEFTime" runat="server" Width="25px" Text='<%# Bind("EFTime") %>'></asp:TextBox>
    <asp:DropDownList ID="ddlEFUnit" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("EFUnit") %>' />
    <asp:RegularExpressionValidator ID="revEFTime" runat="server" ControlToValidate="txtEFTime" Text="*" ErrorMessage="Invalid Estimated Fixture Time [Number only]" ValidationGroup="uValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
   </EditItemTemplate>
   <FooterTemplate>
    <asp:TextBox ID="txtEFTime" runat="server" Width="25px"></asp:TextBox>
    <asp:DropDownList ID="ddlEFUnit" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
    <asp:RegularExpressionValidator ID="revEFTime" runat="server" ControlToValidate="txtEFTime" Text="*" ErrorMessage="Invalid Estimated Fixture Time [Number only]" ValidationGroup="nValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
   </FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Fixture<br>Matl. ($)" SortExpression="FixMatl" InsertVisible="false" ItemStyle-Wrap="false" FooterStyle-Wrap="false">
   <ItemTemplate><%# Eval("FixMatl", "{0:C}") %></ItemTemplate>
   <EditItemTemplate>
    <asp:TextBox ID="txtFixMatl" runat="server" Width="50px" Text='<%# Bind("FixMatl", "{0:0.00}") %>'></asp:TextBox>
    <asp:RegularExpressionValidator ID="revFixMatl" runat="server" ControlToValidate="txtFixMatl" Text="*" ErrorMessage="Invalid Estimated Fixture Material [Currency only]" ValidationGroup="uValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
   </EditItemTemplate>
   <FooterTemplate>
    <asp:TextBox ID="txtFixMatl" runat="server" Width="50px"></asp:TextBox>
    <asp:RegularExpressionValidator ID="revFixMatl" runat="server" ControlToValidate="txtFixMatl" Text="*" ErrorMessage="Invalid Estimated Fixture Material [Currency only]" ValidationGroup="nValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
   </FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Parts<br>/Tool" InsertVisible="false" ItemStyle-Wrap="false" FooterStyle-Wrap="false">
   <ItemTemplate><%# GTLnk("Tool") %></ItemTemplate>
   <EditItemTemplate>
    <asp:HyperLink ID="lnkTool" runat="server" Text="&diams;"></asp:HyperLink>
   </EditItemTemplate>
   <FooterTemplate>N/A</FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Gage" InsertVisible="false" ItemStyle-Wrap="false" FooterStyle-Wrap="false">
   <ItemTemplate><%# GTLnk("Gage") %></ItemTemplate>
   <EditItemTemplate>
    <asp:HyperLink ID="lnkGage" runat="server" Text="&diams;"></asp:HyperLink>
   </EditItemTemplate>
   <FooterTemplate>N/A</FooterTemplate>
  </asp:TemplateField>
  <asp:TemplateField HeaderText="Instruction" SortExpression="Instruction" InsertVisible="false">
   <ItemTemplate><%# Eval("Instruction") %></ItemTemplate>
   <EditItemTemplate>
    <asp:LinkButton ID="lCmd" runat="server" Text='<%# gInstr() %>' /><br />
    <asp:Panel ID="pnlInstr" runat="server" ScrollBars="Auto">
     <asp:TextBox ID="txtInstruction" runat="server" Text='<%# Bind("Instruction") %>' TextMode="MultiLine" Width="150px" Height="50px" />
    </asp:Panel>
    <ajax:CollapsiblePanelExtender ID="CPE" runat="server" TargetControlID="pnlInstr" ExpandControlID="lCmd" CollapseControlID="lCmd" Collapsed="true" />
   </EditItemTemplate>
   <FooterTemplate>
    <asp:LinkButton ID="lCmd" runat="server" Text='&#8597;' /><br />
    <asp:Panel ID="pnlInstr" runat="server" ScrollBars="Auto">
     <asp:TextBox ID="txtInstruction" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
    </asp:Panel>
    <ajax:CollapsiblePanelExtender ID="CPE" runat="server" TargetControlID="pnlInstr" ExpandControlID="lCmd" CollapseControlID="lCmd" Collapsed="true" />
   </FooterTemplate>
  </asp:TemplateField>
 </Columns>
 <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
 <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
 <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
 <EditRowStyle BackColor="#9999CC" />
 <AlternatingRowStyle BackColor="White" />
 <EmptyDataTemplate>
  <table cellpadding="5">
   <tr style="background-color:#507CD1; color:White;">
    <td align="center"><b>Step<br />No</b></td>
    <td align="center"><b>StepID: Step Description</b></td>
    <td align="center"><b>Process/<br />MachineID</b></td>
    <td align="center"><b>M.O.T<br />OP#</b></td>
    <td align="center" style="white-space:nowrap;"><b>Program<br />Time</b></td>
    <td align="center" style="white-space:nowrap;"><b>Estimated<br />Setup Time</b></td>
    <td align="center" style="white-space:nowrap;"><b>Estimated<br />Cycle Time</b></td>
    <td align="center" style="white-space:nowrap;"><b>Estimated<br />Fixture Time</b></td>
    <td align="center" style="white-space:nowrap;"><b>Fixture<br />Matl($)</b></td>
    <td align="center" style="white-space:nowrap;"><b>Parts/<br />Tool</b></td>
    <td align="center" style="white-space:nowrap;"><b>Gage</b></td>
    <td align="center"><b>Instruction</b></td>
   </tr>
   <tr align="center" style="background-color:#EFF3FB; white-space:nowrap;">
    <td><asp:Literal ID="litStepNo_1" runat="server" Text="1"></asp:Literal></td>
    <td>
     <asp:RadioButtonList ID="rblStepName_1" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" OnDataBound="rblDefault" />
     <span style="float:left; color:Red;"><asp:Literal ID="litRIT_1" runat="server" Text="Receiving Inspection Time" Visible="false"></asp:Literal></span>
    </td>
    <td><asp:DropDownList ID="ddlProcessList_1" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_1" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtEPTime_1" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEPUnit_1" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEPTime_1" runat="server" ControlToValidate="txtEPTime_1" Text="*" ErrorMessage="Invalid Program Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtESTime_1" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_1" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revESTime_1" runat="server" ControlToValidate="txtESTime_1" Text="*" ErrorMessage="Invalid Estimated Setup Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtECTime_1" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_1" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revECTime_1" runat="server" ControlToValidate="txtECTime_1" Text="*" ErrorMessage="Invalid Estimated Cycle Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtEFTime_1" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEFUnit_1" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEFTime_1" runat="server" ControlToValidate="txtEFTime_1" Text="*" ErrorMessage="Invalid Estimated Fixture Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtFixMatl_1" runat="server" Width="40px"></asp:TextBox>
     <asp:RegularExpressionValidator ID="revFixMatl_1" runat="server" ControlToValidate="txtFixMatl_1" Text="*" ErrorMessage="Invalid Estimated Fixture Material [Currency only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">Link Tool</td>
    <td style="white-space:nowrap;">Link Gage</td>
    <td>
     <asp:LinkButton ID="lCmd_1" runat="server" Text='&#8597;' Font-Bold="true" Font-Underline="false" /><br />
     <asp:Panel ID="pnlInstr_1" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_1" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_1" runat="server" TargetControlID="pnlInstr_1" ExpandControlID="lCmd_1" CollapseControlID="lCmd_1" Collapsed="false" />
    </td>
   </tr>
   <tr align="center" style="background-color:White;">
    <td><asp:Literal ID="litStepNo_2" runat="server" Text="2"></asp:Literal></td>
    <td>
     <asp:RadioButtonList ID="rblStepName_2" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" OnDataBound="rblDefault" />
     <span style="float:left; color:Red;"><asp:Literal ID="litRIT_2" runat="server" Text="Receiving Inspection Time" Visible="false"></asp:Literal></span>
    </td>
    <td><asp:DropDownList ID="ddlProcessList_2" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_2" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtEPTime_2" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEPUnit_2" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEPTime_2" runat="server" ControlToValidate="txtEPTime_2" Text="*" ErrorMessage="Invalid Program Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtESTime_2" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_2" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revESTime_2" runat="server" ControlToValidate="txtESTime_2" Text="*" ErrorMessage="Invalid Estimated Setup Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtECTime_2" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_2" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revECTime_2" runat="server" ControlToValidate="txtECTime_2" Text="*" ErrorMessage="Invalid Estimated Cycle Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtEFTime_2" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEFUnit_2" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEFTime_2" runat="server" ControlToValidate="txtEFTime_2" Text="*" ErrorMessage="Invalid Estimated Fixture Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtFixMatl_2" runat="server" Width="40px"></asp:TextBox>
     <asp:RegularExpressionValidator ID="revFixMatl_2" runat="server" ControlToValidate="txtFixMatl_2" Text="*" ErrorMessage="Invalid Estimated Fixture Material [Currency only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">Link Tool</td>
    <td style="white-space:nowrap;">Link Gage</td>
    <td>
     <asp:LinkButton ID="lCmd_2" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_2" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_2" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_2" runat="server" TargetControlID="pnlInstr_2" ExpandControlID="lCmd_2" CollapseControlID="lCmd_2" Collapsed="false" />
    </td>
   </tr>
   <tr align="center" style="background-color:#EFF3FB;">
    <td><asp:Literal ID="litStepNo_3" runat="server" Text="3"></asp:Literal></td>
    <td>
     <asp:RadioButtonList ID="rblStepName_3" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" />
     <span style="float:left; color:Red;"><asp:Literal ID="litRIT_3" runat="server" Text="Receiving Inspection Time" Visible="false"></asp:Literal></span>
    </td>
    <td><asp:DropDownList ID="ddlProcessList_3" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_3" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtEPTime_3" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEPUnit_3" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEPTime_3" runat="server" ControlToValidate="txtEPTime_3" Text="*" ErrorMessage="Invalid Program Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtESTime_3" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_3" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revESTime_3" runat="server" ControlToValidate="txtESTime_3" Text="*" ErrorMessage="Invalid Estimated Setup Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtECTime_3" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_3" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revECTime_3" runat="server" ControlToValidate="txtECTime_3" Text="*" ErrorMessage="Invalid Estimated Cycle Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtEFTime_3" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEFUnit_3" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEFTime_3" runat="server" ControlToValidate="txtEFTime_3" Text="*" ErrorMessage="Invalid Estimated Fixture Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtFixMatl_3" runat="server" Width="40px"></asp:TextBox>
     <asp:RegularExpressionValidator ID="revFixMatl_3" runat="server" ControlToValidate="txtFixMatl_3" Text="*" ErrorMessage="Invalid Estimated Fixture Material [Currency only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">Link Tool</td>
    <td style="white-space:nowrap;">Link Gage</td>
    <td>
     <asp:LinkButton ID="lCmd_3" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_3" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_3" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_3" runat="server" TargetControlID="pnlInstr_3" ExpandControlID="lCmd_3" CollapseControlID="lCmd_3" Collapsed="false" />
    </td>
   </tr>
   <tr align="center" style="background-color:White;">
    <td><asp:Literal ID="litStepNo_4" runat="server" Text="4"></asp:Literal></td>
    <td>
     <asp:RadioButtonList ID="rblStepName_4" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" />
     <span style="float:left; color:Red;"><asp:Literal ID="litRIT_4" runat="server" Text="Receiving Inspection Time" Visible="false"></asp:Literal></span>
    </td>
    <td><asp:DropDownList ID="ddlProcessList_4" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_4" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtEPTime_4" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEPUnit_4" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEPTime_4" runat="server" ControlToValidate="txtEPTime_4" Text="*" ErrorMessage="Invalid Program Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtESTime_4" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_4" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revESTime_4" runat="server" ControlToValidate="txtESTime_4" Text="*" ErrorMessage="Invalid Estimated Setup Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtECTime_4" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_4" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revECTime_4" runat="server" ControlToValidate="txtECTime_4" Text="*" ErrorMessage="Invalid Estimated Cycle Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtEFTime_4" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEFUnit_4" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEFTime_4" runat="server" ControlToValidate="txtEFTime_4" Text="*" ErrorMessage="Invalid Estimated Fixture Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtFixMatl_4" runat="server" Width="40px"></asp:TextBox>
     <asp:RegularExpressionValidator ID="revFixMatl_4" runat="server" ControlToValidate="txtFixMatl_4" Text="*" ErrorMessage="Invalid Estimated Fixture Material [Currency only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">Link Tool</td>
    <td style="white-space:nowrap;">Link Gage</td>
    <td>
     <asp:LinkButton ID="lCmd_4" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_4" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_4" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_4" runat="server" TargetControlID="pnlInstr_4" ExpandControlID="lCmd_4" CollapseControlID="lCmd_4" Collapsed="false" />
    </td>
   </tr>
   <tr align="center" style="background-color:#EFF3FB;">
    <td><asp:Literal ID="litStepNo_5" runat="server" Text="5"></asp:Literal></td>
    <td>
     <asp:RadioButtonList ID="rblStepName_5" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" />
     <span style="float:left; color:Red;"><asp:Literal ID="litRIT_5" runat="server" Text="Receiving Inspection Time" Visible="false"></asp:Literal></span>
    </td>
    <td><asp:DropDownList ID="ddlProcessList_5" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_5" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtEPTime_5" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEPUnit_5" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEPTime_5" runat="server" ControlToValidate="txtEPTime_5" Text="*" ErrorMessage="Invalid Program Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtESTime_5" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_5" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revESTime_5" runat="server" ControlToValidate="txtESTime_5" Text="*" ErrorMessage="Invalid Estimated Setup Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtECTime_5" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_5" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revECTime_5" runat="server" ControlToValidate="txtECTime_5" Text="*" ErrorMessage="Invalid Estimated Cycle Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtEFTime_5" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEFUnit_5" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEFTime_5" runat="server" ControlToValidate="txtEFTime_5" Text="*" ErrorMessage="Invalid Estimated Fixture Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtFixMatl_5" runat="server" Width="40px"></asp:TextBox>
     <asp:RegularExpressionValidator ID="revFixMatl_5" runat="server" ControlToValidate="txtFixMatl_5" Text="*" ErrorMessage="Invalid Estimated Fixture Material [Currency only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">Link Tool</td>
    <td style="white-space:nowrap;">Link Gage</td>
    <td>
     <asp:LinkButton ID="lCmd_5" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_5" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_5" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_5" runat="server" TargetControlID="pnlInstr_5" ExpandControlID="lCmd_5" CollapseControlID="lCmd_5" Collapsed="false" />
    </td>
   </tr>
   <tr align="center" style="background-color:White;">
    <td><asp:Literal ID="litStepNo_6" runat="server" Text="6"></asp:Literal></td>
    <td>
     <asp:RadioButtonList ID="rblStepName_6" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" />
     <span style="float:left; color:Red;"><asp:Literal ID="litRIT_6" runat="server" Text="Receiving Inspection Time" Visible="false"></asp:Literal></span>
    </td>
    <td><asp:DropDownList ID="ddlProcessList_6" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_6" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtEPTime_6" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEPUnit_6" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEPTime_6" runat="server" ControlToValidate="txtEPTime_6" Text="*" ErrorMessage="Invalid Program Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtESTime_6" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_6" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revESTime_6" runat="server" ControlToValidate="txtESTime_6" Text="*" ErrorMessage="Invalid Estimated Setup Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtECTime_6" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_6" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revECTime_6" runat="server" ControlToValidate="txtECTime_6" Text="*" ErrorMessage="Invalid Estimated Cycle Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtEFTime_6" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEFUnit_6" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEFTime_6" runat="server" ControlToValidate="txtEFTime_6" Text="*" ErrorMessage="Invalid Estimated Fixture Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtFixMatl_6" runat="server" Width="40px"></asp:TextBox>
     <asp:RegularExpressionValidator ID="revFixMatl_6" runat="server" ControlToValidate="txtFixMatl_6" Text="*" ErrorMessage="Invalid Estimated Fixture Material [Currency only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">Link Tool</td>
    <td style="white-space:nowrap;">Link Gage</td>
    <td>
     <asp:LinkButton ID="lCmd_6" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_6" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_6" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_6" runat="server" TargetControlID="pnlInstr_6" ExpandControlID="lCmd_6" CollapseControlID="lCmd_6" Collapsed="false" />
    </td>
   </tr>
   <tr align="center" style="background-color:#EFF3FB;">
    <td><asp:Literal ID="litStepNo_7" runat="server" Text="7"></asp:Literal></td>
    <td>
     <asp:RadioButtonList ID="rblStepName_7" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" />
     <span style="float:left; color:Red;"><asp:Literal ID="litRIT_7" runat="server" Text="Receiving Inspection Time" Visible="false"></asp:Literal></span>
    </td>
    <td><asp:DropDownList ID="ddlProcessList_7" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_7" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtEPTime_7" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEPUnit_7" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEPTime_7" runat="server" ControlToValidate="txtEPTime_7" Text="*" ErrorMessage="Invalid Program Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtESTime_7" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_7" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revESTime_7" runat="server" ControlToValidate="txtESTime_7" Text="*" ErrorMessage="Invalid Estimated Setup Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtECTime_7" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_7" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revECTime_7" runat="server" ControlToValidate="txtECTime_7" Text="*" ErrorMessage="Invalid Estimated Cycle Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtEFTime_7" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEFUnit_7" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEFTime_7" runat="server" ControlToValidate="txtEFTime_7" Text="*" ErrorMessage="Invalid Estimated Fixture Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtFixMatl_7" runat="server" Width="40px"></asp:TextBox>
     <asp:RegularExpressionValidator ID="revFixMatl_7" runat="server" ControlToValidate="txtFixMatl_7" Text="*" ErrorMessage="Invalid Estimated Fixture Material [Currency only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">Link Tool</td>
    <td style="white-space:nowrap;">Link Gage</td>
    <td>
     <asp:LinkButton ID="lCmd_7" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_7" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_7" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_7" runat="server" TargetControlID="pnlInstr_7" ExpandControlID="lCmd_7" CollapseControlID="lCmd_7" Collapsed="false" />
    </td>
   </tr>
   <tr align="center" style="background-color:White;">
    <td><asp:Literal ID="litStepNo_8" runat="server" Text="8"></asp:Literal></td>
    <td>
     <asp:RadioButtonList ID="rblStepName_8" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" />
     <span style="float:left; color:Red;"><asp:Literal ID="litRIT_8" runat="server" Text="Receiving Inspection Time" Visible="false"></asp:Literal></span>
    </td>
    <td><asp:DropDownList ID="ddlProcessList_8" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_8" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtEPTime_8" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEPUnit_8" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEPTime_8" runat="server" ControlToValidate="txtEPTime_8" Text="*" ErrorMessage="Invalid Program Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtESTime_8" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_8" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revESTime_8" runat="server" ControlToValidate="txtESTime_8" Text="*" ErrorMessage="Invalid Estimated Setup Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtECTime_8" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_8" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revECTime_8" runat="server" ControlToValidate="txtECTime_8" Text="*" ErrorMessage="Invalid Estimated Cycle Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtEFTime_8" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEFUnit_8" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEFTime_8" runat="server" ControlToValidate="txtEFTime_8" Text="*" ErrorMessage="Invalid Estimated Fixture Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtFixMatl_8" runat="server" Width="40px"></asp:TextBox>
     <asp:RegularExpressionValidator ID="revFixMatl_8" runat="server" ControlToValidate="txtFixMatl_8" Text="*" ErrorMessage="Invalid Estimated Fixture Material [Currency only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">Link Tool</td>
    <td style="white-space:nowrap;">Link Gage</td>
    <td>
     <asp:LinkButton ID="lCmd_8" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_8" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_8" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_8" runat="server" TargetControlID="pnlInstr_8" ExpandControlID="lCmd_8" CollapseControlID="lCmd_8" Collapsed="false" />
    </td>
   </tr>
   <tr align="center" style="background-color:#EFF3FB;">
    <td><asp:Literal ID="litStepNo_9" runat="server" Text="9"></asp:Literal></td>
    <td>
     <asp:RadioButtonList ID="rblStepName_9" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" />
     <span style="float:left; color:Red;"><asp:Literal ID="litRIT_9" runat="server" Text="Receiving Inspection Time" Visible="false"></asp:Literal></span>
    </td>
    <td><asp:DropDownList ID="ddlProcessList_9" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_9" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtEPTime_9" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEPUnit_9" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEPTime_9" runat="server" ControlToValidate="txtEPTime_9" Text="*" ErrorMessage="Invalid Program Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtESTime_9" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_9" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revESTime_9" runat="server" ControlToValidate="txtESTime_9" Text="*" ErrorMessage="Invalid Estimated Setup Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:TextBox ID="txtECTime_9" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_9" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revECTime_9" runat="server" ControlToValidate="txtECTime_9" Text="*" ErrorMessage="Invalid Estimated Cycle Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtEFTime_9" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlEFUnit_9" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" />
     <asp:RegularExpressionValidator ID="revEFTime_9" runat="server" ControlToValidate="txtEFTime_9" Text="*" ErrorMessage="Invalid Estimated Fixture Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtFixMatl_9" runat="server" Width="40px"></asp:TextBox>
     <asp:RegularExpressionValidator ID="revFixMatl_9" runat="server" ControlToValidate="txtFixMatl_9" Text="*" ErrorMessage="Invalid Estimated Fixture Material [Currency only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">Link Tool</td>
    <td style="white-space:nowrap;">Link Gage</td>
    <td>
     <asp:LinkButton ID="lCmd_9" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_9" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_9" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_9" runat="server" TargetControlID="pnlInstr_9" ExpandControlID="lCmd_9" CollapseControlID="lCmd_9" Collapsed="false" />
    </td>
   </tr>
   <tr><td colspan="4"><asp:Button ID="btnNew" Text="Add New" runat="server" OnClick="btnAddDefault_Click" ValidationGroup="iValid" /></td></tr>
  </table>
 </EmptyDataTemplate>
</asp:GridView>
<br /><MW:Message ID="iMsg" runat="server" />
<br /><br />
<b>Part Name:</b> <asp:TextBox ID="txtPartName" runat="server" OnLoad="loadPartName"></asp:TextBox>
<asp:Button ID="btnSavePartName" runat="server" Text="Update" OnClick="savePartName" CssClass="NavBtn" />
<asp:Literal ID="litMsg" runat="server"></asp:Literal>
<br /><br />
<asp:Button ID="btnPrtForm" runat="server" Text='Print Preview' CssClass="NavBtn"></asp:Button>
<asp:ValidationSummary ID="vsValid" runat="server" ShowMessageBox="true" ShowSummary="false" ValidationGroup="uValid" />
<br />
<asp:Panel ID="pnlMoveSwap" runat="server" BackColor="aliceblue">
 <table>
  <tr>
   <td><b>From:</b><br /><asp:TextBox ID="txtoSN" runat="server" Width="30px"></asp:TextBox></td>
   <td><b>To:</b><br /><asp:TextBox ID="txtnSN" runat="server" Width="30px"></asp:TextBox></td>
   <td><b>Swap?</b><br /><asp:DropDownList ID="ddlSwap" runat="server"><asp:ListItem>No</asp:ListItem><asp:ListItem>Yes</asp:ListItem></asp:DropDownList></td>
   <td valign="bottom"><asp:Button ID="btnGo" runat="server" Text="Go" OnClick="btn_Click" CssClass="NavBtn" /></td>
  </tr>
 </table>
</asp:Panel>
<br /><br />
<%--<ucComponent:Component ID="myCmp" runat="server" />--%>
 <asp:Button ID="btnDone" runat="server" Text="Done" OnClick="MarkDone" CssClass="NavBtn" />
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />

<telerik:RadWindowManager ID="radWindow" runat="server" Skin="Vista" Title="Form Preview">
 <Windows>
  <telerik:RadWindow ID="preview" runat="server" Title="Form Preview" Height="500px" 
  Width="700px" Left="150px" ReloadOnShow="true" VisibleStatusbar="false" ShowContentDuringLoad="false" Modal="true" Skin="Vista" VisibleTitlebar="true" />
  <telerik:RadWindow ID="gtSelect" runat="server" Title="Modal Popup" Height="445px"
   Width="820px" Left="150px" ReloadOnShow="true" VisibleStatusbar="false" ShowContentDuringLoad="false" Modal="true" Skin="Vista" VisibleTitlebar="false" />
 </Windows>
</telerik:RadWindowManager>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadPreview(id) {
   window.radopen("File/Preview.aspx?FID=JobRouter&Code=Router&HID=" + id, "preview").maximize();
  }
  function loadGT1(RterID, sNo, sNm, GageTool, vW) {
   if (vW !== '') {
    var btn = document.getElementById('<%= btnEPT.ClientID %>');
    if (btn.disabled) vW = '&vW=1';
    else vW = '';
   }
   window.radopen('RFQ/gtSelect.aspx?AppCode=RFQ&RterID=' + RterID + '&sNo=' + sNo + '&sNm=' + sNm + '&GageTool=' + GageTool + vW, "preview");
  }
  function loadGT(RterID, sNo, GageTool) {
   loadGT1(RterID, sNo, document.getElementById('<%= hfCurSNm.ClientID %>').value, GageTool, '');
  }
 </script>
</telerik:RadCodeBlock>

<asp:HiddenField ID="hfCurSNm" runat="server" Value="Hello here" />
<asp:ObjectDataSource ID="odsRouter" runat="server" TypeName="myBiz.DAL.clsRouter" SelectMethod="Select" UpdateMethod="Update" InsertMethod="Insert" DeleteMethod="Delete">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="Int32" />
  <asp:Parameter Name="StepNo" Type="Int32" />
  <asp:Parameter Name="MPID" Type="String" />
  <asp:Parameter Name="OpNo" Type="String" />
  <asp:Parameter Name="EPTime" Type="Decimal" />
  <asp:Parameter Name="EPUnit" Type="String" />
  <asp:Parameter Name="ESTime" Type="Decimal" />
  <asp:Parameter Name="ESUnit" Type="String" />
  <asp:Parameter Name="ECTime" Type="Decimal" />
  <asp:Parameter Name="ECUnit" Type="String" />
  <asp:Parameter Name="EFTime" Type="Decimal" />
  <asp:Parameter Name="EFUnit" Type="String" />
  <asp:Parameter Name="FixMatl" Type="Decimal" />
  <asp:Parameter Name="Instruction" Type="String" />
 </UpdateParameters>
 <InsertParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="MPID" Type="String" />
  <asp:Parameter Name="OpNo" Type="String" />
  <asp:Parameter Name="EPTime" Type="Decimal" />
  <asp:Parameter Name="EPUnit" Type="String" />
  <asp:Parameter Name="ESTime" Type="Decimal" />
  <asp:Parameter Name="ESUnit" Type="String" />
  <asp:Parameter Name="ECTime" Type="Decimal" />
  <asp:Parameter Name="ECUnit" Type="String" />
  <asp:Parameter Name="EFTime" Type="Decimal" />
  <asp:Parameter Name="EFUnit" Type="String" />
  <asp:Parameter Name="FixMatl" Type="Decimal" />
  <asp:Parameter Name="Instruction" Type="String" />
  <asp:Parameter Name="StepNo" Type="int32" />
 </InsertParameters>
 <DeleteParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="StepNo" Type="int32" />
 </DeleteParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsStepName" runat="server" TypeName="myBiz.DAL.clsStepName" SelectMethod="Select">
 <SelectParameters>
  <asp:Parameter Name="isActive" Type="Int32" DefaultValue="1" />
 </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsOpNo" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
 <SelectParameters>
  <asp:Parameter Name="Cate" Type="String" DefaultValue="OpNo" />
  <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
 </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsEUnit" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
 <SelectParameters>
  <asp:Parameter Name="Cate" Type="String" DefaultValue="EstimatedTimeUnit" />
  <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
 </SelectParameters>
</asp:ObjectDataSource>