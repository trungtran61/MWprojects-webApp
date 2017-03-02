<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.TravelerCreation" Codebehind="TravelerCreation.ascx.cs" %>
<%@ Register Src="~/_Controls/Component.ascx" TagName="Component" TagPrefix="ucComponent" %>
<%@ Register Src="~/_Controls/CurrentMode.ascx" TagName="CurrentMode" TagPrefix="ucMode" %>

<asp:Panel ID="pnlTask" runat="server">
<h3>Request Information for Traveler</h3>
<asp:GridView ID="gvTraveler" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True"
 AutoGenerateColumns="False" CellPadding="5" CellSpacing="1" DataKeyNames="HID" DataSourceID="odsTraveler" ShowFooter="true"
 ForeColor="#333333" GridLines="None" OnRowUpdating="uTraveler" OnRowDataBound="RwBound"
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
  <asp:TemplateField HeaderText="Process<br>Machine ID" SortExpression="MTPName" InsertVisible="false">
   <ItemTemplate><%# Eval("MTPID") %>: <%# Eval("MTPName") %></ItemTemplate>
   <EditItemTemplate>
    <asp:DropDownList ID="ddlProcessList" runat="server" DataTextField="mText" DataValueField="MPID" />
    <br /><asp:HyperLink ID="lnkMacSel" runat="server">[Manage Machine]</asp:HyperLink>
    <asp:HiddenField ID="hfMIDs" runat="server" Value="NO_SAVE" />
   </EditItemTemplate>
   <FooterTemplate>
    <asp:DropDownList ID="ddlProcessList" runat="server" DataTextField="mText" DataValueField="MPID" />
    <br /><asp:HyperLink ID="lnkMacSel" runat="server">[Manage Machine]</asp:HyperLink>
    <asp:HiddenField ID="hfMIDs" runat="server" />
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
  <asp:TemplateField HeaderText="Estimated<br>Setup Time" SortExpression="ESTime" InsertVisible="false" ItemStyle-Wrap="false" FooterStyle-Wrap="false">
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
  <asp:TemplateField HeaderText="Estimated<br>Cycle Time" SortExpression="ECTime" InsertVisible="false" ItemStyle-Wrap="false" FooterStyle-Wrap="false">
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
    <td align="center" style="white-space:nowrap;"><b>Estimated<br />Setup Time</b></td>
    <td align="center" style="white-space:nowrap;"><b>Estimated<br />Cycle Time</b></td>
    <td align="center"><b>Instruction</b></td>
   </tr>
   <tr style="background-color:#EFF3FB; white-space:nowrap;">
    <td><asp:Literal ID="litStepNo_1" runat="server" Text="1"></asp:Literal></td>
    <td><asp:RadioButtonList ID="rblStepName_1" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" OnDataBound="rblDefault" /></td>
    <td><asp:DropDownList ID="ddlProcessList_1" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_1" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtESTime_1" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_1" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
     <asp:RegularExpressionValidator ID="revESTime_1" runat="server" ControlToValidate="txtESTime_1" Text="*" ErrorMessage="Invalid Estimated Setup Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td style="white-space:nowrap;">
     <asp:TextBox ID="txtECTime_1" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_1" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
     <asp:RegularExpressionValidator ID="revECTime_1" runat="server" ControlToValidate="txtECTime_1" Text="*" ErrorMessage="Invalid Estimated Cycle Time [Number only]" ValidationGroup="iValid" ValidationExpression="^\d+(\.\d+)?$"></asp:RegularExpressionValidator>
    </td>
    <td>
     <asp:LinkButton ID="lCmd_1" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_1" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_1" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_1" runat="server" TargetControlID="pnlInstr_1" ExpandControlID="lCmd_1" CollapseControlID="lCmd_1" Collapsed="false" />
    </td>
   </tr>
   <tr style="background-color:White;">
    <td><asp:Literal ID="litStepNo_2" runat="server" Text="2"></asp:Literal></td>
    <td><asp:RadioButtonList ID="rblStepName_2" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" OnDataBound="rblDefault" /></td>
    <td><asp:DropDownList ID="ddlProcessList_2" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_2" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtESTime_2" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_2" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:TextBox ID="txtECTime_2" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_2" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:LinkButton ID="lCmd_2" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_2" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_2" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_2" runat="server" TargetControlID="pnlInstr_2" ExpandControlID="lCmd_2" CollapseControlID="lCmd_2" Collapsed="false" />
    </td>
   </tr>
   <tr style="background-color:#EFF3FB;">
    <td><asp:Literal ID="litStepNo_3" runat="server" Text="3"></asp:Literal></td>
    <td><asp:RadioButtonList ID="rblStepName_3" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" /></td>
    <td><asp:DropDownList ID="ddlProcessList_3" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_3" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtESTime_3" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_3" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:TextBox ID="txtECTime_3" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_3" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:LinkButton ID="lCmd_3" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_3" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_3" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_3" runat="server" TargetControlID="pnlInstr_3" ExpandControlID="lCmd_3" CollapseControlID="lCmd_3" Collapsed="false" />
    </td>
   </tr>
   <tr style="background-color:White;">
    <td><asp:Literal ID="litStepNo_4" runat="server" Text="4"></asp:Literal></td>
    <td><asp:RadioButtonList ID="rblStepName_4" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" /></td>
    <td><asp:DropDownList ID="ddlProcessList_4" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_4" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtESTime_4" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_4" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:TextBox ID="txtECTime_4" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_4" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:LinkButton ID="lCmd_4" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_4" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_4" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_4" runat="server" TargetControlID="pnlInstr_4" ExpandControlID="lCmd_4" CollapseControlID="lCmd_4" Collapsed="false" />
    </td>
   </tr>
   <tr style="background-color:#EFF3FB;">
    <td><asp:Literal ID="litStepNo_5" runat="server" Text="5"></asp:Literal></td>
    <td><asp:RadioButtonList ID="rblStepName_5" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" /></td>
    <td><asp:DropDownList ID="ddlProcessList_5" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_5" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtESTime_5" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_5" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:TextBox ID="txtECTime_5" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_5" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:LinkButton ID="lCmd_5" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_5" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_5" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_5" runat="server" TargetControlID="pnlInstr_5" ExpandControlID="lCmd_5" CollapseControlID="lCmd_5" Collapsed="false" />
    </td>
   </tr>
   <tr style="background-color:White;">
    <td><asp:Literal ID="litStepNo_6" runat="server" Text="6"></asp:Literal></td>
    <td><asp:RadioButtonList ID="rblStepName_6" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" /></td>
    <td><asp:DropDownList ID="ddlProcessList_6" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_6" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtESTime_6" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_6" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:TextBox ID="txtECTime_6" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_6" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:LinkButton ID="lCmd_6" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_6" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_6" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_6" runat="server" TargetControlID="pnlInstr_6" ExpandControlID="lCmd_6" CollapseControlID="lCmd_6" Collapsed="false" />
    </td>
   </tr>
   <tr style="background-color:#EFF3FB;">
    <td><asp:Literal ID="litStepNo_7" runat="server" Text="7"></asp:Literal></td>
    <td><asp:RadioButtonList ID="rblStepName_7" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" /></td>
    <td><asp:DropDownList ID="ddlProcessList_7" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_7" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtESTime_7" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_7" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:TextBox ID="txtECTime_7" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_7" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:LinkButton ID="lCmd_7" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_7" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_7" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_7" runat="server" TargetControlID="pnlInstr_7" ExpandControlID="lCmd_7" CollapseControlID="lCmd_7" Collapsed="false" />
    </td>
   </tr>
   <tr style="background-color:White;">
    <td><asp:Literal ID="litStepNo_8" runat="server" Text="8"></asp:Literal></td>
    <td><asp:RadioButtonList ID="rblStepName_8" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" /></td>
    <td><asp:DropDownList ID="ddlProcessList_8" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_8" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtESTime_8" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_8" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:TextBox ID="txtECTime_8" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_8" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:LinkButton ID="lCmd_8" runat="server" Text='&#8597;' /><br />
     <asp:Panel ID="pnlInstr_8" runat="server" ScrollBars="Auto">
      <asp:TextBox ID="txtInstruction_8" runat="server" TextMode="MultiLine" Width="150px" Height="50px" />
     </asp:Panel>
     <ajax:CollapsiblePanelExtender ID="CPE_8" runat="server" TargetControlID="pnlInstr_8" ExpandControlID="lCmd_8" CollapseControlID="lCmd_8" Collapsed="false" />
    </td>
   </tr>
   <tr style="background-color:#EFF3FB;">
    <td><asp:Literal ID="litStepNo_9" runat="server" Text="9"></asp:Literal></td>
    <td><asp:RadioButtonList ID="rblStepName_9" runat="server" DataSourceID="odsStepName" DataTextField="Name" DataValueField="HID" OnSelectedIndexChanged="rblSN_Change" RepeatDirection="horizontal" RepeatColumns="5" AutoPostBack="true" /></td>
    <td><asp:DropDownList ID="ddlProcessList_9" runat="server" DataTextField="mText" DataValueField="MPID" /></td>
    <td><asp:DropDownList ID="ddlOpNo_9" runat="server" DataTextField="mText" DataValueField="mValue" AutoPostBack="true" OnSelectedIndexChanged="opSelected" /></td>
    <td>
     <asp:TextBox ID="txtESTime_9" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlESUnit_9" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
    <td>
     <asp:TextBox ID="txtECTime_9" runat="server" Width="25px"></asp:TextBox>
     <asp:DropDownList ID="ddlECUnit_9" runat="server" DataSourceID="odsEUnit" DataTextField="mText" DataValueField="mValue" OnDataBound="ddlDefault" />
    </td>
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
 <br /><br />
 <b>Customer PKG Spec:</b> <asp:DropDownList ID="ddlPackage" runat="server" DataTextField="PackageName" DataValueField="HID" OnLoad="LoadCustPackSpec"></asp:DropDownList>
 <asp:Button ID="btnSavePackage" runat="server" Text="Save Package" OnClick="SaveCustPackSpec" CssClass="NavBtn" />
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
   <td valign="bottom"><asp:Button ID="btnGo" runat="server" Text="Go" OnClick="btn_Click" /></td>
  </tr>
 </table>
</asp:Panel>
<br /><br />
<ucComponent:Component ID="myCmp" runat="server" />
</asp:Panel>

<ucMode:CurrentMode ID="myMode" runat="server" />

<telerik:RadWindowManager ID="radWindow" runat="server" Skin="Vista" Title="Form Preview">
 <Windows>
  <telerik:RadWindow ID="preview" runat="server" Title="Form Preview" Height="500px" 
  Width="500px" Left="150px" ReloadOnShow="true" VisibleStatusbar="false" ShowContentDuringLoad="false" Modal="true" Skin="Vista" VisibleTitlebar="true" />
  <telerik:RadWindow ID="mSelect" runat="server" Title="Modal Popup" Height="445px"
   Width="820px" Left="150px" ReloadOnShow="true" VisibleStatusbar="false" ShowContentDuringLoad="false" Modal="true" Skin="Vista" VisibleTitlebar="false" />
 </Windows>
</telerik:RadWindowManager>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
 <script type="text/javascript">
  function loadPreview(id)
  {
   window.radopen("File/Preview.aspx?FID=JobTraveler&Code=Traveler&HID=" + id, "preview").maximize();
  }
  function openMacSel(TrvlrID, sID, cID) {
   var StepID = $('#' + sID + ' input[type=radio]:checked').val();
   window.radopen('WIP/MacSelect.aspx?TrvlrID=' + TrvlrID + '&StepID=' + StepID + '&cID=' + cID, "mSelect");
  }
  function callMe(args,cID,isOk){
   if (isOk == 1) document.getElementById(cID).value = args;
   else document.getElementById(cID).value = 'NO_SAVE';
  }
 </script>
</telerik:RadCodeBlock>

<asp:ObjectDataSource ID="odsTraveler" runat="server" TypeName="myBiz.DAL.clsTraveler" SelectMethod="Select" UpdateMethod="Update" InsertMethod="Insert" DeleteMethod="Delete">
 <SelectParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
 </SelectParameters>
 <UpdateParameters>
  <asp:Parameter Name="HID" Type="int32" />
  <asp:Parameter Name="MPID" Type="String" />
  <asp:Parameter Name="OpNo" Type="String" />
  <asp:Parameter Name="ESTime" Type="Decimal" />
  <asp:Parameter Name="ESUnit" Type="String" />
  <asp:Parameter Name="ECTime" Type="Decimal" />
  <asp:Parameter Name="ECUnit" Type="String" />
  <asp:Parameter Name="MIDs" Type="String" />
  <asp:Parameter Name="Instruction" Type="String" />
 </UpdateParameters>
 <InsertParameters>
  <asp:QueryStringParameter Name="IDs" Type="String" QueryStringField="IDs" />
  <asp:Parameter Name="MPID" Type="String" />
  <asp:Parameter Name="OpNo" Type="String" />
  <asp:Parameter Name="ESTime" Type="Decimal" />
  <asp:Parameter Name="ESUnit" Type="String" />
  <asp:Parameter Name="ECTime" Type="Decimal" />
  <asp:Parameter Name="ECUnit" Type="String" />
  <asp:Parameter Name="MIDs" Type="String" />
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