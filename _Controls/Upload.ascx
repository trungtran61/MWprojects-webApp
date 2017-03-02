<%@ Control Language="C#" AutoEventWireup="true" Inherits="webApp._Controls.Upload" Codebehind="Upload.ascx.cs" %>
<asp:Panel ID="pnlUpload" runat="server" BackColor="#FEFAED">
 Please browse for a file that you wish to upload.<br />
 Then click on the <b>Upload File</b> button below to upload file.<br />
 <br />
 If you wish to upload more than one file at a time,<br />
 please click <a onclick="javascript:addFile(); return false;" style="cursor: pointer; color: Blue; text-decoration: underline;">more file</a>.
 <p id="uploadBox"><input id="inFile" type="file" size="30" runat="server" /></p>
 <asp:Button ID="btnUpload" runat="server" Text="Upload File" OnClick="btn_Click" /><br />
 <asp:Literal ID="litMsg" runat="server"></asp:Literal>
</asp:Panel>

<script type="text/javascript">
  function addFile() {
   if (!document.getElementById || !document.createElement) return false;
   var uploadBox = document.getElementById("uploadBox");
   if (!uploadBox) return;

   uploadBox.appendChild(document.createElement("br"));
   var newUploadBox = document.createElement("input"); newUploadBox.type = "file";

   // The new box needs a name and an ID
   if (!addFile.lastAssignedId) addFile.lastAssignedId = 1;
   newUploadBox.setAttribute("id", "myFile" + addFile.lastAssignedId);
   newUploadBox.setAttribute("name", "mFile" + addFile.lastAssignedId);
   newUploadBox.setAttribute("size", 30);
   addFile.lastAssignedId++; uploadBox.appendChild(newUploadBox);
  }
 </script>