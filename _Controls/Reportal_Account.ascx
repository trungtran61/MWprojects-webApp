﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Reportal_Account.ascx.cs" Inherits="webApp._Controls.Reportal_Account" %>

<table>
 <tr>
  <td>
      <telerik:RadChart ID="rChart" runat="server" AutoLayout="true" Height="300px" Width="480px">
       <ChartTitle><TextBlock Text="Income/Expense Report"></TextBlock></ChartTitle>
       <PlotArea>
        <EmptySeriesMessage TextBlock-Text="No records to display!"></EmptySeriesMessage>
        <Appearance FillStyle-FillType="Solid" FillStyle-MainColor="White"></Appearance>
        <YAxis Appearance-MajorGridLines-Visible="false" Appearance-MinorGridLines-Visible="false" Appearance-TextAppearance-TextProperties-Color="Black" Appearance-ValueFormat="General" AxisLabel-Visible="true" AxisLabel-TextBlock-Text="Thousands ($)"></YAxis>
        <XAxis Appearance-MajorGridLines-Visible="false" Appearance-MinorGridLines-Visible="false" Appearance-TextAppearance-TextProperties-Color="Black" DataLabelsColumn="dName" Appearance-LabelAppearance-RotationAngle="300"></XAxis>
       </PlotArea>
      </telerik:RadChart>
   </td>
  </tr>
 </table>
