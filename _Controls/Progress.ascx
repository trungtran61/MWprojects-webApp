<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Progress.ascx.cs" Inherits="webApp._Controls.Progress" %>

 <aspx:UpdateProgress ID="uProgress" runat="server" DisplayAfter="500">
  <ProgressTemplate>
   <div id="progressData"><asp:Image ID="sdf" runat="server" ImageUrl="~/App_Themes/indicator.gif" /> Please wait ...</div>
   <asp:HiddenField ID="hfID" runat="server" />
   <ajax:ModalPopupExtender ID="MPE" runat="server" TargetControlID="hfID" PopupControlID="progressData" BackgroundCssClass="modalBackground" DropShadow="false" RepositionMode="RepositionOnWindowResize" OnLoad="mLoad" />
  </ProgressTemplate>
 </aspx:UpdateProgress>