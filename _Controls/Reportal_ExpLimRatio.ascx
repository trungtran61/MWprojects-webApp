﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Reportal_ExpLimRatio.ascx.cs" Inherits="webApp._Controls.Reportal_ExpLimRatio" %>

<table>
 <tr>
  <td>
      <telerik:RadChart ID="rChart" runat="server" DefaultType="Line" AutoLayout="true" Height="300px" Width="480px">
       <ChartTitle><TextBlock Text="Expense-Limit Ratio"></TextBlock></ChartTitle>
       <PlotArea>
        <EmptySeriesMessage TextBlock-Text="No records to display!"></EmptySeriesMessage>
        <Appearance FillStyle-FillType="Solid" FillStyle-MainColor="White"></Appearance>
        <YAxis Appearance-MajorGridLines-Visible="false" Appearance-MinorGridLines-Visible="false" Appearance-TextAppearance-TextProperties-Color="Black"></YAxis>
        <XAxis Appearance-MajorGridLines-Visible="false" Appearance-MinorGridLines-Visible="false" Appearance-TextAppearance-TextProperties-Color="Black" DataLabelsColumn="dName" Appearance-LabelAppearance-RotationAngle="300"></XAxis>
       </PlotArea>
      </telerik:RadChart>
  </td>
  <td>
      <telerik:RadChart ID="chtBD" runat="server" DefaultType="Line" AutoLayout="true" Height="300px" Width="480px">
       <ChartTitle><TextBlock Text="Different"></TextBlock></ChartTitle>
       <PlotArea>
        <EmptySeriesMessage TextBlock-Text="No records to display!"></EmptySeriesMessage>
        <Appearance FillStyle-FillType="Solid" FillStyle-MainColor="White"></Appearance>
        <YAxis Appearance-MajorGridLines-Visible="false" Appearance-MinorGridLines-Visible="false" Appearance-TextAppearance-TextProperties-Color="Black"></YAxis>
        <XAxis Appearance-MajorGridLines-Visible="false" Appearance-MinorGridLines-Visible="false" Appearance-TextAppearance-TextProperties-Color="Black" DataLabelsColumn="dName" Appearance-LabelAppearance-RotationAngle="300"></XAxis>
       </PlotArea>
      </telerik:RadChart>
  </td>
 </tr>
</table>