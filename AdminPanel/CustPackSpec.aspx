<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="CustPackSpec.aspx.cs" Inherits="webApp.AdminPanel.CustPackSpec" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
 <script language="javascript" type="text/javascript">
  function doChkAll(chk, dv) {
   $('#' + dv + ' input[type="checkbox"]').each(function () { $(this).prop('checked', chk.checked); });
  }
 </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <aspx:UpdatePanel ID="uPnlCustPackSpec" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <asp:DropDownList ID="ddlCust" runat="server" DataSourceID="odsCust" DataTextField="CompanyName" DataValueField="HID" AutoPostBack="true" OnSelectedIndexChanged="doChange"></asp:DropDownList>
   <asp:Button ID="btnSaveCustPackSpec" runat="server" Text="Save" OnClick="doSave" CssClass="NavBtn" /> <input type="checkbox" id="chkSelect" onclick="doChkAll(this, 'dvChkAllSelect');" />  Check All
   <br /><MW:Message ID="iMsg" runat="server" />
   <br />
   <div id="dvChkAllSelect"><MW:ChkBoxList ID="cblPackage" runat="server" DataSourceID="odsPackage" DataCheckedField="isSelected" DataTextField="PackageName" DataValueField="HID" RepeatColumns="5"></MW:ChkBoxList></div>
  </ContentTemplate>
 </aspx:UpdatePanel>

 <asp:ObjectDataSource ID="odsCust" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="getCompanyList">
  <SelectParameters>
   <asp:Parameter Name="ClassName" Type="String" DefaultValue="Customer" />
   <asp:Parameter Name="TypeName" Type="String" DefaultValue="Customer" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
  </SelectParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsPackage" runat="server" TypeName="myBiz.DAL.clsCustPackSpec" SelectMethod="Select" UpdateMethod="Save">
  <SelectParameters>
   <asp:ControlParameter Name="CID" Type="Int32" ControlID="ddlCust" PropertyName="SelectedValue" />
  </SelectParameters>
  <UpdateParameters>
   <asp:ControlParameter Name="CID" Type="Int32" ControlID="ddlCust" PropertyName="SelectedValue" />
   <asp:ControlParameter Name="CPS" Type="String" ControlID="cblPackage" PropertyName="SelectedValues" />
  </UpdateParameters>
 </asp:ObjectDataSource>
</asp:Content>
