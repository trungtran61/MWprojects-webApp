<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="VendorMgmnt.aspx.cs" Inherits="webApp.AdminPanel.VendorMgmnt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
 <script language="javascript" type="text/javascript" src="../App_Themes/jquery-1.6.4.min.js"></script>
 <script language="javascript" type="text/javascript" src="../App_Themes/placeholders.min.js"></script>
 <script language="javascript" type="text/javascript">
  function doChkAll(chk,dv) {
   $('#' + dv + ' input[type="checkbox"]').each(function () { $(this).prop('checked', chk.checked); });
  }
  function doSendEmail() {
   var IDs = $('#<%= hfSelIDs.ClientID %>').val();
   var PID = $('#<%= ddlCertProType.ClientID %>').val();
   lPopup('../File/sendEmail.aspx?Code=Survey&FID=Survey&AppCode=' + PID + '&HID=' + IDs);
  }
  function doSendEmailAvl() {
   var IDs = $('#<%= hfSelAvlIDs.ClientID %>').val();
   var PID = $('#<%= ddlAvlProType.ClientID %>').val();
   if (PID > 0) lPopup('../File/sendEmail.aspx?Code=Survey&FID=Survey&AppCode=' + PID + '&HID=' + IDs);
   else alert("Please select Process Type before sending email.");
  }
  function loadSurvey(VID, VNM) {
   var PID = $('#<%= ddlCertProType.ClientID %>').val();
   var PNM = $('#<%= ddlCertProType.ClientID %> option:selected').text();
   lPopup('../File/vSurvey.aspx?VID=' + VID + '&PID=' + PID + '&VNM=' + VNM.replace("&", "%26") + '&PNM=' + PNM.replace("&", "%26"));
  }
  function loadAvlSurvey(VID, VNM) {
   var PID = $('#<%= ddlAvlProType.ClientID %>').val();
   var PNM = $('#<%= ddlAvlProType.ClientID %> option:selected').text();
   lPopup('../File/vSurvey.aspx?VID=' + VID + '&PID=' + PID + '&VNM=' + VNM.replace("&", "%26") + '&PNM=' + PNM.replace("&", "%26"));
  }
  function loadHisSurvey(CID, VID, VNM) {
   var PID = $('#<%= ddlHisProType.ClientID %>').val();
   var PNM = $('#<%= ddlHisProType.ClientID %> option:selected').text();
   lPopup('../File/vSurvey.aspx?CID=' + CID + '&VID=' + VID + '&PID=' + PID + '&VNM=' + VNM.replace("&", "%26") + '&PNM=' + PNM.replace("&", "%26"));
  }
 </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlVendorMgmnt" runat="server">
  <ContentTemplate>
   <ajax:TabContainer ID="tabVendor" runat="server" ActiveTabIndex="0">
    <ajax:TabPanel ID="tabCtrlVendor" runat="server" HeaderText="Controled Vendors">
     <ContentTemplate>
      <aspx:UpdatePanel ID="uPnlCtrlVendor" runat="server" UpdateMode="Conditional">
       <ContentTemplate>
        <table>
         <tr>
          <td><b>Process Type</b></td>
          <td>&nbsp;</td>
         </tr>
         <tr>
          <td colspan="2">
           <asp:DropDownList ID="ddlCtrlType" runat="server" DataSourceID="odsType" DataTextField="TypeName" DataValueField="HID" AutoPostBack="true"></asp:DropDownList>
           <asp:Button ID="btnCtrlVendor" runat="server" Text="Save" OnClick="doSave" CssClass="NavBtn" /> <input type="checkbox" id="chkCtrl" onclick="doChkAll(this,'dvChkAllCtrl');" /> Check All
          </td>
         </tr>
         <tr>
          <td colspan="2"><MW:Message ID="iCtrlVendorMsg" runat="server" /></td>
         </tr>
        </table><br />
        <div id="dvChkAllCtrl"><MW:ChkBoxList ID="cblCtrlVendor" runat="server" DataSourceID="odsCtrlVendor" DataCheckedField="isSelected" DataTextField="CompanyName" DataValueField="HID" RepeatColumns="5"></MW:ChkBoxList></div>
        <asp:ObjectDataSource ID="odsCtrlVendor" runat="server" TypeName="myBiz.DAL.clsVendor" SelectMethod="Vendor_Ctrl_S" UpdateMethod="Vendor_Ctrl_Save">
         <SelectParameters>
          <asp:ControlParameter Name="PID" Type="Int32" ControlID="ddlCtrlType" PropertyName="SelectedValue" />
         </SelectParameters>
         <UpdateParameters>
          <asp:ControlParameter Name="PID" Type="Int32" ControlID="ddlCtrlType" PropertyName="SelectedValue" />
          <asp:ControlParameter Name="VID" Type="String" ControlID="cblCtrlVendor" PropertyName="SelectedValues" />
         </UpdateParameters>
        </asp:ObjectDataSource>
       </ContentTemplate>
      </aspx:UpdatePanel>
     </ContentTemplate>
    </ajax:TabPanel>
    <ajax:TabPanel ID="tabCustLink" runat="server" HeaderText="Approved Vendors">
     <ContentTemplate>
      <aspx:UpdatePanel ID="uPnlCustLink" runat="server" UpdateMode="Conditional">
       <ContentTemplate>
        <table>
         <tr>
          <td><b>By Customer</b></td>
          <td><b>Process Type</b></td>
          <td>&nbsp;</td>
         </tr>
         <tr>
          <td><asp:DropDownList ID="ddlCust" runat="server" DataSourceID="odsCust" DataTextField="CompanyName" DataValueField="HID" AutoPostBack="true"></asp:DropDownList></td>
          <td><asp:DropDownList ID="ddlType" runat="server" DataSourceID="odsType" DataTextField="TypeName" DataValueField="HID" AutoPostBack="true"></asp:DropDownList></td>
          <td><asp:Button ID="btnSaveVendorCust" runat="server" Text="Save" OnClick="doSave" CssClass="NavBtn" /> <input type="checkbox" id="chkApprove" onclick="doChkAll(this,'dvChkAllLink');" />  Check All</td>
         </tr>
         <tr>
          <td colspan="3"><MW:Message ID="iMsg" runat="server" /></td>
         </tr>
        </table><br />        
        <div id="dvChkAllLink"><MW:ChkBoxList ID="cblVendor" runat="server" DataSourceID="odsVendor" DataCheckedField="isSelected" DataTextField="CompanyName" DataValueField="HID" RepeatColumns="5"></MW:ChkBoxList></div>
        <asp:ObjectDataSource ID="odsCust" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="getCompanyList">
         <SelectParameters>
          <asp:Parameter Name="ClassName" Type="String" DefaultValue="Customer" />
          <asp:Parameter Name="TypeName" Type="String" DefaultValue="Customer" />
          <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
         </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsVendor" runat="server" TypeName="myBiz.DAL.clsVendor" SelectMethod="Vendor_Cust_S" UpdateMethod="Vendor_Cust_Save">
         <SelectParameters>
          <asp:ControlParameter Name="CustID" Type="Int32" ControlID="ddlCust" PropertyName="SelectedValue" />
          <asp:ControlParameter Name="PID" Type="Int32" ControlID="ddlType" PropertyName="SelectedValue" />
         </SelectParameters>
         <UpdateParameters>
          <asp:ControlParameter Name="CustID" Type="Int32" ControlID="ddlCust" PropertyName="SelectedValue" />
          <asp:ControlParameter Name="PID" Type="Int32" ControlID="ddlType" PropertyName="SelectedValue" />
          <asp:ControlParameter Name="VID" Type="String" ControlID="cblVendor" PropertyName="SelectedValues" />
         </UpdateParameters>
        </asp:ObjectDataSource>
       </ContentTemplate>
      </aspx:UpdatePanel>
     </ContentTemplate>
    </ajax:TabPanel>
    <ajax:TabPanel ID="tabProfile" runat="server" HeaderText="Vendor Profile">
     <ContentTemplate>
      <aspx:UpdatePanel ID="uPnlProfile" runat="server" UpdateMode="Conditional">
       <ContentTemplate>
        Show Active? <asp:DropDownList ID="ddlMAL" runat="server" AutoPostBack="true" DataSourceID="odsActiveList" DataValueField="mValue" DataTextField="mText" />
        <asp:DropDownList ID="ddlProType" runat="server" DataSourceID="odsType" DataTextField="TypeName" DataValueField="HID" AutoPostBack="true"></asp:DropDownList>
        <asp:GridView ID="gvProfile" runat="server" SkinID="Default" DataSourceID="odsProfile" DataKeyNames="HID" OnRowUpdating="rwUpdating">
         <Columns>
          <asp:CommandField ShowEditButton="true" ShowCancelButton="true" />
          <asp:BoundField HeaderText="Vendor" ReadOnly="true" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" />
          <asp:TemplateField HeaderText="Term" SortExpression="Term" InsertVisible="false">
           <ItemTemplate>&nbsp;<%# Eval("Term") %></ItemTemplate>
           <EditItemTemplate><asp:TextBox ID="txtTerm" runat="server" Text='<%# Eval("Term") %>' Width="50px"></asp:TextBox></EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="CCR?" SortExpression="CCR" InsertVisible="false">
           <ItemTemplate>&nbsp;<%# Eval("CCR") %></ItemTemplate>
           <EditItemTemplate>
            <asp:DropDownList ID="ddlCCR" runat="server" SelectedValue='<%# Bind("CCR") %>'>
             <asp:ListItem Text="" Value=""></asp:ListItem>
             <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
             <asp:ListItem Text="No" Value="No"></asp:ListItem>
            </asp:DropDownList>
           </EditItemTemplate>
          </asp:TemplateField>
          <asp:BoundField HeaderText="MW Acct#" DataField="MWAccNum" SortExpression="MWAccNum" InsertVisible="false" />
          <asp:BoundField HeaderText="Tax ID" DataField="TaxID" SortExpression="TaxID" InsertVisible="false" />
          <asp:BoundField HeaderText="LLC Type" DataField="LLCType" SortExpression="LLCType" InsertVisible="false" />
          <asp:CheckBoxField HeaderText="Active?" DataField="isActive" SortExpression="isActive" InsertVisible="false" />
         </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="odsProfile" runat="server" TypeName="myBiz.DAL.clsVendor" SelectMethod="Vendors_S" UpdateMethod="Vendors_Save">
         <SelectParameters>
          <asp:ControlParameter Name="TypeID" Type="Int32" ControlID="ddlProType" PropertyName="SelectedValue" />
          <asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlMAL" PropertyName="SelectedValue" />
         </SelectParameters>
         <UpdateParameters>
          <asp:Parameter Name="HID" Type="Int32" />
          <asp:Parameter Name="Term" Type="Int32" />
          <asp:Parameter Name="CCR" Type="String" />
          <asp:Parameter Name="MWAccNum" Type="String" />
          <asp:Parameter Name="TaxID" Type="String" />
          <asp:Parameter Name="LLCType" Type="String" />
          <asp:Parameter Name="isActive" Type="Boolean" />
         </UpdateParameters>
        </asp:ObjectDataSource>
       </ContentTemplate>
      </aspx:UpdatePanel>
     </ContentTemplate>
    </ajax:TabPanel>
    <ajax:TabPanel ID="tabCert" runat="server" HeaderText="Certificate">
     <ContentTemplate>
      <aspx:UpdatePanel ID="uPnlCert" runat="server" UpdateMode="Conditional">
       <ContentTemplate>
        Show Active? <asp:DropDownList ID="ddlCertAL" runat="server" AutoPostBack="true" DataSourceID="odsActiveList" DataValueField="mValue" DataTextField="mText" />
        <asp:DropDownList ID="ddlCertProType" runat="server" DataSourceID="odsType" DataTextField="TypeName" DataValueField="HID" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged"></asp:DropDownList>
        <asp:GridView ID="gvCertSurvey" runat="server" SkinID="Default" DataSourceID="odsCertSurvey" DataKeyNames="HID" OnRowDataBound="rwBound" OnDataBound="gvBound" OnRowCommand="rwCmd">
         <Columns>
          <asp:TemplateField>
           <HeaderTemplate><asp:CheckBox ID="chkItem" runat="server" /></HeaderTemplate>
           <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /></ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Vendor" SortExpression="CompanyName">
           <ItemTemplate><%# gLink("") %></ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Cert No" SortExpression="CertNo" InsertVisible="false">
           <ItemTemplate>
            <asp:LinkButton ID="lnkCertNo" runat="server" Text='<%# Eval("CertNo") %>' CommandName="LoadCert" CommandArgument='<%# Eval("CertInfoID") %>'></asp:LinkButton>
            <asp:Literal ID="litCertNo" runat="server" Text='N/A'></asp:Literal>
           </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField HeaderText="Expire" DataFormatString="{0:MM/dd/yy}" DataField="ExpDate" SortExpression="ExpDate" InsertVisible="false" />
          <asp:CheckBoxField HeaderText="Active?" DataField="isActive" SortExpression="isActive" InsertVisible="false" />
         </Columns>
        </asp:GridView><br />
        <asp:Button ID="btnGenerate" runat="server" Text="Generate Links" CssClass="NavBtn" OnClick="doGenerate" Visible="false" />
        <asp:Button ID="btnSendEmail" runat="server" Text="Send Email" CssClass="NavBtn" Visible="false" OnClientClick="javascript:doSendEmail();return false;" />
        <asp:HiddenField ID="hfChkBox" runat="server" />
        <asp:HiddenField ID="hfSelIDs" runat="server" />
        <asp:ObjectDataSource ID="odsCertSurvey" runat="server" TypeName="myBiz.DAL.clsSurvey" SelectMethod="Vendor_Cert_S">
         <SelectParameters>
          <asp:ControlParameter Name="TypeID" Type="Int32" ControlID="ddlCertProType" PropertyName="SelectedValue" />
          <asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlCertAL" PropertyName="SelectedValue" />
         </SelectParameters>
        </asp:ObjectDataSource>
        <asp:Panel ID="pnlPopup" runat="server" />
       </ContentTemplate>
      </aspx:UpdatePanel>
     </ContentTemplate>
    </ajax:TabPanel>
    <ajax:TabPanel ID="tabAvl" runat="server" HeaderText="<span title='Approved Vendor List'>AVL</span>">
     <ContentTemplate>
      <aspx:UpdatePanel ID="uPnlAvl" runat="server" UpdateMode="Conditional">
       <ContentTemplate>
        Show Active? <asp:DropDownList ID="ddlAvlAL" runat="server" AutoPostBack="true" DataSourceID="odsActiveList" DataValueField="mValue" DataTextField="mText" />&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
        Status? <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="true"><asp:ListItem Value="Current" Text="Current"></asp:ListItem><asp:ListItem Value="Expired" Text="Expired"></asp:ListItem><asp:ListItem Value="Both" Text="Both"></asp:ListItem></asp:DropDownList>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="ddlAvlProType" runat="server" DataSourceID="odsType2" DataTextField="TypeName" DataValueField="HID" AutoPostBack="true" OnSelectedIndexChanged="ddlChangedAvl" Width="250px"></asp:DropDownList>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtAvlCompanyName" runat="server" placeholder="Vendor Name"></asp:TextBox>
        <asp:Button ID="btnAvlGo" runat="server" Text="Go" CssClass="NavBtn" />
        <asp:GridView ID="gvAvlSurvey" runat="server" SkinID="Default" DataSourceID="odsAvlSurvey" DataKeyNames="HID" OnRowDataBound="rwBound" OnDataBound="gvBound" OnRowCommand="rwCmd">
         <Columns>
          <asp:TemplateField>
           <HeaderTemplate><asp:CheckBox ID="chkItem" runat="server" /></HeaderTemplate>
           <ItemTemplate><asp:CheckBox ID="chkItem" runat="server" /></ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Vendor" SortExpression="CompanyName">
           <ItemTemplate><%# gLink("Avl") %></ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField HeaderText="Process Type" DataField="ProType" SortExpression="ProType" InsertVisible="false" />
          <asp:BoundField HeaderText="Survey Date" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" DataField="SurveyDate" SortExpression="SurveyDate" InsertVisible="false" />
          <asp:TemplateField HeaderText="Cert No" SortExpression="CertNo" InsertVisible="false">
           <ItemTemplate>
            <asp:LinkButton ID="lnkCertNo" runat="server" Text='<%# Eval("CertNo") %>' CommandName="LoadCert" CommandArgument='<%# Eval("CertInfoID") %>'></asp:LinkButton>
            <asp:Literal ID="litCertNo" runat="server" Text='N/A'></asp:Literal>
           </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Cert. Expiration Date" SortExpression="ExpDate" InsertVisible="false">
           <ItemTemplate><%# gDD("ExpDate") %></ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Approved Expiration Date" SortExpression="AppDate" InsertVisible="false">
           <ItemTemplate><%# gDD("AppDate") %></ItemTemplate>
          </asp:TemplateField>
          <asp:CheckBoxField HeaderText="Active?" DataField="isActive" SortExpression="isActive" InsertVisible="false" />
         </Columns>
        </asp:GridView><br />
        <asp:Button ID="btnGenerateAvl" runat="server" Text="Generate Links Avl" CssClass="NavBtn" OnClick="doGenerateAvl" Visible="false" />
        <asp:Button ID="btnSendEmailAvl" runat="server" Text="Send Email Avl" CssClass="NavBtn" Visible="false" OnClientClick="javascript:doSendEmailAvl();return false;" />
        <asp:HiddenField ID="hfChkBoxAvl" runat="server" />
        <asp:HiddenField ID="hfSelAvlIDs" runat="server" />
        <asp:ObjectDataSource ID="odsAvlSurvey" runat="server" TypeName="myBiz.DAL.clsSurvey" SelectMethod="Vendor_Avl_S">
         <SelectParameters>
          <asp:ControlParameter Name="TypeID" Type="Int32" ControlID="ddlAvlProType" PropertyName="SelectedValue" />
          <asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlAvlAL" PropertyName="SelectedValue" />
          <asp:ControlParameter Name="CompanyName" Type="String" ControlID="txtAvlCompanyName" PropertyName="Text" />
          <asp:ControlParameter Name="Status" Type="String" ControlID="ddlStatus" PropertyName="SelectedValue" />
         </SelectParameters>
        </asp:ObjectDataSource>
        <asp:Panel ID="pnlPopupAvl" runat="server" />
       </ContentTemplate>
      </aspx:UpdatePanel>
     </ContentTemplate>
    </ajax:TabPanel>
    <ajax:TabPanel ID="tabHis" runat="server" HeaderText="Vendor History">
     <ContentTemplate>
      <aspx:UpdatePanel ID="uPnlHis" runat="server" UpdateMode="Conditional">
       <ContentTemplate>
        Show Active? <asp:DropDownList ID="ddlHisAL" runat="server" AutoPostBack="true" DataSourceID="odsActiveList" DataValueField="mValue" DataTextField="mText" />
        <asp:DropDownList ID="ddlHisProType" runat="server" DataSourceID="odsType2" DataTextField="TypeName" DataValueField="HID" AutoPostBack="False"></asp:DropDownList>
        <asp:TextBox ID="txtHisCompanyName" runat="server" placeholder="Vendor Name"></asp:TextBox>
        <asp:Button ID="btnHisGo" runat="server" Text="Go" CssClass="NavBtn" />
        <asp:GridView ID="gvHisSurvey" runat="server" SkinID="Default" DataSourceID="odsHisSurvey" DataKeyNames="CertID,CertInfoID" OnRowDataBound="rwBoundHis" OnRowCommand="rwCmdHis">
         <Columns>
          <asp:TemplateField>
           <ItemTemplate>
            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="NavBtn" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete?');" />
           </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Vendor" SortExpression="CompanyName">
           <ItemTemplate><%# gLink("His") %></ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField HeaderText="Process Type" DataField="ProType" SortExpression="ProType" InsertVisible="false" />
          <asp:BoundField HeaderText="Survey Date" DataFormatString="{0:MM/dd/yy ddd h:mm tt}" DataField="SurveyDate" SortExpression="SurveyDate" InsertVisible="false" />
          <asp:TemplateField HeaderText="Cert No" SortExpression="CertNo" InsertVisible="false">
           <ItemTemplate>
            <asp:LinkButton ID="lnkCertNo" runat="server" Text='<%# Eval("CertNo") %>' CommandName="LoadCert" CommandArgument='<%# Eval("CertInfoID") %>'></asp:LinkButton>
            <asp:Literal ID="litCertNo" runat="server" Text='N/A'></asp:Literal>
           </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Expire" SortExpression="ExpDate" InsertVisible="false">
           <ItemTemplate><%# gDD("ExpDate") %></ItemTemplate>
          </asp:TemplateField>
          <asp:CheckBoxField HeaderText="Active?" DataField="isActive" SortExpression="isActive" InsertVisible="false" />
         </Columns>
         <EmptyDataTemplate>No Record Found!</EmptyDataTemplate>
        </asp:GridView><br />
        <asp:ObjectDataSource ID="odsHisSurvey" runat="server" TypeName="myBiz.DAL.clsSurvey" SelectMethod="Vendor_His_S" DeleteMethod="deleteSurvey">
         <SelectParameters>
          <asp:ControlParameter Name="TypeID" Type="Int32" ControlID="ddlHisProType" PropertyName="SelectedValue" />
          <asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlHisAL" PropertyName="SelectedValue" />
          <asp:ControlParameter Name="CompanyName" Type="String" ControlID="txtHisCompanyName" PropertyName="Text" />
         </SelectParameters>
         <DeleteParameters>
          <asp:Parameter Name="CertID" Type="Int32" />
          <asp:Parameter Name="CertInfoID" Type="Int32" />
         </DeleteParameters>
        </asp:ObjectDataSource>
        <asp:Panel ID="pnlPopupHis" runat="server" />
       </ContentTemplate>
      </aspx:UpdatePanel>
     </ContentTemplate>
    </ajax:TabPanel>
    <ajax:TabPanel ID="tabApp" runat="server" HeaderText="Approved Dates">
     <ContentTemplate>
      <aspx:UpdatePanel ID="uPnlApp" runat="server" UpdateMode="Conditional">
       <ContentTemplate>
        Show Active? <asp:DropDownList ID="ddlAppAL" runat="server" AutoPostBack="true" DataSourceID="odsActiveList" DataValueField="mValue" DataTextField="mText" />&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="ddlAppProType" runat="server" DataSourceID="odsType2" DataTextField="TypeName" DataValueField="HID" Width="250px"></asp:DropDownList>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtAppVendorName" runat="server" placeholder="Vendor Name"></asp:TextBox>
        <asp:Button ID="btnAppGo" runat="server" Text="Go" CssClass="NavBtn" />
        <asp:GridView ID="gvAppSurvey" runat="server" SkinID="Default" DataSourceID="odsAppSurvey" DataKeyNames="HID,VID,PID">
         <Columns>
          <asp:TemplateField>
           <ItemTemplate>
            <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CssClass="NavBtn" />
           </ItemTemplate>
           <EditItemTemplate>
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandName="Update" CssClass="NavBtn" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" CssClass="NavBtn" />
           </EditItemTemplate>
          </asp:TemplateField>
          <asp:BoundField HeaderText="Vendor" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" ReadOnly="true" />
          <asp:BoundField HeaderText="Process Type" DataField="ProType" SortExpression="ProType" InsertVisible="false" ReadOnly="true" />
          <asp:TemplateField HeaderText="Reason" SortExpression="AppReason">
           <ItemTemplate><%# Eval("AppReason") %></ItemTemplate>
           <EditItemTemplate><asp:DropDownList ID="ddlAppReason" runat="server" DataTextField="mText" DataValueField="mValue" DataSourceID="odsAppReason" SelectedValue='<%# Bind("AppReason") %>' /></EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Approved Expiration Date" SortExpression="AppDate" InsertVisible="false">
           <ItemTemplate><%# gDD("AppDate") %></ItemTemplate>
           <EditItemTemplate>
            <asp:TextBox ID="txtAppDate" runat="server" Text='<%# Bind("AppDate") %>'></asp:TextBox>
            <ajax:CalendarExtender ID="calAppDate" runat="server" TargetControlID="txtAppDate" Format="MM/dd/yy" />
           </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Note" SortExpression="AppNote">
           <ItemTemplate><%# Eval("AppNote") %></ItemTemplate>
           <EditItemTemplate>
            <asp:TextBox ID="txtAppNote" runat="server" Text='<%# Bind("AppNote") %>'></asp:TextBox>
           </EditItemTemplate>
          </asp:TemplateField>
          <asp:CheckBoxField HeaderText="Active?" DataField="isActive" SortExpression="isActive" InsertVisible="false" ReadOnly="true" />
         </Columns>
        </asp:GridView><br />
        <asp:ObjectDataSource ID="odsAppSurvey" runat="server" TypeName="myBiz.DAL.clsSurvey" SelectMethod="Vendor_AppDate_S" UpdateMethod="Vendor_AppDate_U">
         <SelectParameters>
          <asp:ControlParameter Name="TypeID" Type="Int32" ControlID="ddlAppProType" PropertyName="SelectedValue" />
          <asp:ControlParameter Name="VendorName" Type="String" ControlID="txtAppVendorName" PropertyName="Text" />
          <asp:ControlParameter Name="isActive" Type="Int32" ControlID="ddlAppAL" PropertyName="SelectedValue" />
         </SelectParameters>
         <UpdateParameters>
          <asp:Parameter Name="HID" Type="Int32" />
          <asp:Parameter Name="VID" Type="Int32" />
          <asp:Parameter Name="PID" Type="Int32" />
          <asp:Parameter Name="AppReason" Type="String" />
          <asp:Parameter Name="AppDate" Type="DateTime" />
          <asp:Parameter Name="AppNote" Type="String" />
         </UpdateParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsAppReason" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
         <SelectParameters>
          <asp:Parameter Name="Cate" Type="String" DefaultValue="ApproveReason" />
          <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
         </SelectParameters>
        </asp:ObjectDataSource>
       </ContentTemplate>
      </aspx:UpdatePanel>
     </ContentTemplate>
    </ajax:TabPanel>
   </ajax:TabContainer>
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsActiveList" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="ActiveList" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="0" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsType" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="Type_S1">
  <SelectParameters><asp:Parameter Name="mTxt" Type="String" DefaultValue="Select One" /></SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsType2" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="Type_S2">
  <SelectParameters><asp:Parameter Name="mTxt" Type="String" DefaultValue="Select Process Type" /></SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>
