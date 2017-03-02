<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerReturnCar.aspx.cs" Inherits="webApp.WIP.CustomerReturnCar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title></title>
</head>
<body>
 <form id="form1" runat="server">
  <div>
   <b>Machine Works Internal Corrective and Preventive Action Request</b>

   <aspx:ScriptManager ID="scrCar" runat="server" EnablePartialRendering="true" EnablePageMethods="true" />
   <aspx:UpdatePanel ID="uPnlCar" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
     <asp:FormView ID="fvCar" runat="server" DataKeyNames="HID" DataSourceID="odsCar" DefaultMode="ReadOnly" OnDataBound="fvBound" OnItemCommand="fvCmd">
      <ItemTemplate>
       <table style="border: solid 2px black; font-size: 14px;">
        <tr>
         <td style="border: solid 1px black;"><b>MWCar#:</b><br /><%# Eval("CarNum") %></td>
         <td style="border: solid 1px black;"><b>WO#.</b><br /><%# Eval("WorkOrder") %></td>
         <td style="border: solid 1px black;"><b>Part No.</b><br /><%# Eval("PartNumber") %></td>
         <td style="border: solid 1px black;"><b>Rev.</b><br /><%# Eval("Revision") %></td>
        </tr>
        <tr>
         <td colspan="2" style="border: solid 1px black;"><b>Requested From:</b><br /><%# Eval("CreatedBy") %></td>
         <td style="border: solid 1px black;"><b>Date Issued:</b><br /><%# Eval("CreatedDate","{0:MM/dd/yyyy}") %></td>
         <td style="border: solid 1px black;"><b>Response Due Date:</b><br /><%# Eval("ResponseDate","{0:MM/dd/yyyy}") %></td>
        </tr>
        <tr>
         <td style="border: solid 1px black;"><b>Total Qty:</b><br /><%# Eval("ShipQty") %></td>
         <td style="border: solid 1px black;"><b>Reject Qty:</b><br /><%# Eval("ReturnedQty") %></td>
         <td colspan="2" style="border: solid 1px black;"><b>Part Description:</b><br /><%# Eval("Description") %></td>
        </tr>
       </table>
       <br />
       <b>Description of Problem:</b><br /><%# Eval("NonConform") %><br /><br />
       <b>Problem Analysis:</b><br /><%# Eval("ProblemAnalysis") %><br /><br />
       <b>Direct Cause of Problem:</b><br /><%# Eval("DirectCause") %><br /><br />
       <b>Contributing Factors:</b><br /><%# Eval("ConFactor") %><br /><br />
       <b>Root Cause of Problem:</b><br /><%# Eval("RootCause") %><br /><br />
       <b>Specific Corrections:</b><br /><%# Eval("SpecificCorrection") %><br /><br />
       <b>Action to Prevent:</b><br /><%# Eval("ActionPrevent") %><br /><br />
       <b>Plant-Wide Corrective Actions:</b><br /><%# Eval("PlantWide") %><br /><br />
       <b>Similar Jobs:</b><br /><%# Eval("SimilarJob") %><br /><br />
       <b>Implementation Plan:</b><br /><%# Eval("ImplementationPlan") %><br />
       [<b>Acknowledgement By:</b> <%# Eval("AcknowledgedBy") %>]
       [<b>Name:</b> <%# Eval("AcknowledgedName") %>]
       [<b>Date:</b> <%# Eval("AcknowledgedDate","{0:MM/dd/yyyy}") %>]
       <br /><br />
       <b>Verification Evidence:</b><br /><%# Eval("VerificationEvidence") %><br />
       [<b>Verification By:</b> <%# Eval("VerifiedBy") %>]
       [<b>Name:</b> <%# Eval("VerifiedName") %>]
       [<b>Date:</b> <%# Eval("VerifiedDate","{0:MM/dd/yyyy}") %>]
       <br /><br />
       <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="NavBtn" />
      </ItemTemplate>
      <EditItemTemplate>
       <table style="border: solid 2px black; font-size: 14px;">
        <tr>
         <td style="border: solid 1px black;"><b>MWCar#:</b><br /><%# Eval("CarNum") %></td>
         <td style="border: solid 1px black;"><b>WO#.</b><br /><%# Eval("WorkOrder") %></td>
         <td style="border: solid 1px black;"><b>Part No.</b><br /><%# Eval("PartNumber") %></td>
         <td style="border: solid 1px black;"><b>Rev.</b><br /><%# Eval("Revision") %></td>
        </tr>
        <tr>
         <td colspan="2" style="border: solid 1px black;"><b>Requested From:</b><br /><%# Eval("CreatedBy") %></td>
         <td style="border: solid 1px black;"><b>Date Issued:</b><br /><%# Eval("CreatedDate","{0:MM/dd/yyyy}") %></td>
         <td style="border: solid 1px black;"><b>Response Due Date:</b><br /><%# Eval("ResponseDate","{0:MM/dd/yyyy}") %></td>
        </tr>
        <tr>
         <td style="border: solid 1px black;"><b>Total Qty:</b><br /><%# Eval("ShipQty") %></td>
         <td style="border: solid 1px black;"><b>Reject Qty:</b><br /><%# Eval("ReturnedQty") %></td>
         <td colspan="2" style="border: solid 1px black;"><b>Part Description:</b><br /><%# Eval("Description") %></td>
        </tr>
       </table>
       <br />
       <b>Description of Problem:</b><br /><%# Eval("NonConform") %><br /><br />
       <b>Probem Analysis:</b><br />
       <asp:TextBox ID="txtProblemAnalysis" runat="server" Text='<%# Bind("ProblemAnalysis") %>' TextMode="MultiLine" Width="650px" Height="100px"></asp:TextBox><br /><br />
       <b>Direct Cause of Problem:</b><br />
       <asp:TextBox ID="txtDirectCause" runat="server" Text='<%# Bind("DirectCause") %>' TextMode="MultiLine" Width="650px" Height="100px"></asp:TextBox><br /><br />
       <b>Contributing Factors:</b><br /><%# Eval("ConFactor") %><br /><br />
       <b>Root Cause of Problem:</b><br /><%# Eval("RootCause") %><br /><br />
       <b>Specific Corrections:</b><br />
       <asp:TextBox ID="txtSpecificCorrection" runat="server" Text='<%# Bind("SpecificCorrection") %>' TextMode="MultiLine" Width="650px" Height="100px"></asp:TextBox><br /><br />
       <b>Action to Prevent:</b><br />
       <asp:TextBox ID="txtActionPrevent" runat="server" Text='<%# Bind("ActionPrevent") %>' TextMode="MultiLine" Width="650px" Height="100px"></asp:TextBox><br /><br />
       <b>Plant-Wide Corrective Actions::</b><br />
       <asp:TextBox ID="txtPlantWide" runat="server" Text='<%# Bind("PlantWide") %>' TextMode="MultiLine" Width="650px" Height="100px"></asp:TextBox><br /><br />
       <b>Similar Jobs:</b><br />
       <asp:TextBox ID="txtSimilarJob" runat="server" Text='<%# Bind("SimilarJob") %>' TextMode="MultiLine" Width="650px" Height="100px"></asp:TextBox><br /><br />
       <b>Implementation Plan:</b><br />
       <asp:TextBox ID="txtImplementationPlan" runat="server" Text='<%# Bind("ImplementationPlan") %>' TextMode="MultiLine" Width="650px" Height="100px"></asp:TextBox><br /><br />
       [<b>Acknowledgement By:</b> <asp:TextBox ID="txtAcknowledgedBy" runat="server" Text='<%# Bind("AcknowledgedBy") %>'></asp:TextBox>]
       [<b>Name:</b> <asp:TextBox ID="txtAcknowledgedName" runat="server" Text='<%# Bind("AcknowledgedName") %>'></asp:TextBox>]
       [<b>Date:</b> <asp:TextBox ID="txtAcknowledgedDate" runat="server" Text='<%# Bind("AcknowledgedDate") %>'></asp:TextBox>]
       <ajax:CalendarExtender ID="calAcknowledgedDate" runat="server" TargetControlID="txtAcknowledgedDate" Format="MM/dd/yyyy" />
       <br /><br />
       <b>Verification Evidence:</b><br />
       <asp:TextBox ID="txtVerificationEvidence" runat="server" Text='<%# Bind("VerificationEvidence") %>' TextMode="MultiLine" Width="650px" Height="100px"></asp:TextBox><br /><br />
       [<b>Verification By:</b> <asp:TextBox ID="txtVerifiedBy" runat="server" Text='<%# Bind("VerifiedBy") %>'></asp:TextBox>]
       [<b>Name:</b> <asp:TextBox ID="txtVerifiedName" runat="server" Text='<%# Bind("VerifiedName") %>'></asp:TextBox>]
       [<b>Date:</b> <asp:TextBox ID="txtVerifiedDate" runat="server" Text='<%# Bind("VerifiedDate") %>'></asp:TextBox>]
       <ajax:CalendarExtender ID="calVerifiedDate" runat="server" TargetControlID="txtVerifiedDate" Format="MM/dd/yyyy" />
       <br /><br />
       <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="Save" CssClass="NavBtn" />
       <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="NavBtn" />
      </EditItemTemplate>
     </asp:FormView>
     <MW:Message ID="iMsg" runat="server" />
    </ContentTemplate>
   </aspx:UpdatePanel>
   <asp:ObjectDataSource ID="odsCar" runat="server" TypeName="myBiz.DAL.clsCustomerReturnLog" SelectMethod="GetCar" UpdateMethod="SaveCar">
    <SelectParameters><asp:QueryStringParameter Name="HID" Type="Int32" QueryStringField="HID" /></SelectParameters>
    <UpdateParameters>
     <asp:Parameter Name="HID" Type="Int32" />
     <asp:Parameter Name="ProblemAnalysis" Type="String" />
     <asp:Parameter Name="DirectCause" Type="String" />
     <asp:Parameter Name="SpecificCorrection" Type="String" />
     <asp:Parameter Name="ActionPrevent" Type="String" />
     <asp:Parameter Name="PlantWide" Type="String" />
     <asp:Parameter Name="SimilarJob" Type="String" />
     <asp:Parameter Name="ImplementationPlan" Type="String" />
     <asp:Parameter Name="VerificationEvidence" Type="String" />
     <asp:Parameter Name="AcknowledgedBy" Type="String" />
     <asp:Parameter Name="AcknowledgedName" Type="String" />
     <asp:Parameter Name="AcknowledgedDate" Type="DateTime" />
     <asp:Parameter Name="VerifiedBy" Type="String" />
     <asp:Parameter Name="VerifiedName" Type="String" />
     <asp:Parameter Name="VerifiedDate" Type="DateTime" />
    </UpdateParameters>
   </asp:ObjectDataSource>
  </div>
 </form>
</body>
</html>