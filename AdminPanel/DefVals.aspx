<%@ Page Title="" Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" CodeBehind="DefVals.aspx.cs" Inherits="webApp.AdminPanel.DefVals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainArea" runat="server">
 <h3>RFQ Default Values Management</h3>

 <aspx:UpdatePanel ID="uPnlEPT" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
    <fieldset>
     <legend>Engineer Processing Information</legend>
     <b>Time:</b> <asp:TextBox ID="txtEPT" runat="server" Width="50px"></asp:TextBox>
     <asp:DropDownList ID="ddlEPT" runat="server" DataSourceID="odsUnit" DataTextField="mText" DataValueField="mValue" />
     <b>Rate:</b> <asp:TextBox ID="txtRate" runat="server" Width="50px"></asp:TextBox> ($/hr)<br />
     <asp:Button ID="btnEPT" runat="server" Text="Update" OnClick="saveEPT" CssClass="NavBtn" />
     <asp:Literal ID="eMsg" runat="server"></asp:Literal>
   </fieldset>
  </ContentTemplate>
 </aspx:UpdatePanel>

 <br /><br />

 <aspx:UpdatePanel ID="uPnlDefVals" runat="server" UpdateMode="Conditional">
  <ContentTemplate>
   <b>Step Name:</b>
   <asp:DropDownList ID="ddlStepName" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChanged">
    <asp:ListItem Text="RIM" Value="RIM"></asp:ListItem>
    <asp:ListItem Text="SAW" Value="SAW"></asp:ListItem>
    <asp:ListItem Text="LATHE" Value="LATHE"></asp:ListItem>
    <asp:ListItem Text="MILL" Value="MILL"></asp:ListItem>
    <asp:ListItem Text="OPS" Value="OPS"></asp:ListItem>
    <asp:ListItem Text="ASE" Value="ASE"></asp:ListItem>
    <asp:ListItem Text="HF" Value="HF"></asp:ListItem>
    <asp:ListItem Text="FIN" Value="FIN"></asp:ListItem>
    <asp:ListItem Text="SHIP" Value="SHIP"></asp:ListItem>
    <asp:ListItem Text="DEL" Value="DEL"></asp:ListItem>
    <asp:ListItem Text="PAM" Value="PAM"></asp:ListItem>
   </asp:DropDownList><br /><br />
   <asp:GridView ID="gvDefVals" runat="server" SkinID="Default" DataKeyNames="dKey" DataSourceID="odsDefVals">
    <Columns>
     <asp:CommandField ShowEditButton="true" />
     <asp:BoundField HeaderText="Step" ReadOnly="True" DataField="dKey" InsertVisible="false" />
     <asp:TemplateField InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><%# Eval("xT00") %> <%# Eval("xU00") %></ItemTemplate>
      <EditItemTemplate>
       <asp:TextBox ID="txtT00" runat="server" Width="25px" Text='<%# Bind("xT00") %>'></asp:TextBox>
       <asp:DropDownList ID="ddlU00" runat="server" DataSourceID="odsUnit" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("xU00") %>' />
      </EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><%# Eval("xR00","{0:C}") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtR00" runat="server" Width="50px" Text='<%# Bind("xR00") %>'></asp:TextBox></EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><%# Eval("xT01") %> <%# Eval("xU01") %></ItemTemplate>
      <EditItemTemplate>
       <asp:TextBox ID="txtT01" runat="server" Width="25px" Text='<%# Bind("xT01") %>'></asp:TextBox>
       <asp:DropDownList ID="ddlU01" runat="server" DataSourceID="odsUnit" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("xU01") %>' />
      </EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><%# Eval("xR01","{0:C}") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtR01" runat="server" Width="50px" Text='<%# Bind("xR01") %>'></asp:TextBox></EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><%# Eval("xT02") %> <%# Eval("xU02") %></ItemTemplate>
      <EditItemTemplate>
       <asp:TextBox ID="txtT02" runat="server" Width="25px" Text='<%# Bind("xT02") %>'></asp:TextBox>
       <asp:DropDownList ID="ddlU02" runat="server" DataSourceID="odsUnit" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("xU02") %>' />
      </EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><%# Eval("xR02","{0:C}") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtR02" runat="server" Width="50px" Text='<%# Bind("xR02") %>'></asp:TextBox></EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><%# Eval("xT03") %> <%# Eval("xU03") %></ItemTemplate>
      <EditItemTemplate>
       <asp:TextBox ID="txtT03" runat="server" Width="25px" Text='<%# Bind("xT03") %>'></asp:TextBox>
       <asp:DropDownList ID="ddlU03" runat="server" DataSourceID="odsUnit" DataTextField="mText" DataValueField="mValue" SelectedValue='<%# Bind("xU03") %>' />
      </EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><%# Eval("xR03","{0:C}") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtR03" runat="server" Width="50px" Text='<%# Bind("xR03") %>'></asp:TextBox></EditItemTemplate>
     </asp:TemplateField>
     <asp:TemplateField HeaderText="Fixture<br />Material ($)" InsertVisible="false" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
      <ItemTemplate><%# Eval("xA01","{0:C}") %></ItemTemplate>
      <EditItemTemplate><asp:TextBox ID="txtA01" runat="server" Width="50px" Text='<%# Bind("xA01") %>'></asp:TextBox></EditItemTemplate>
     </asp:TemplateField>
    </Columns>
   </asp:GridView>
  </ContentTemplate>
 </aspx:UpdatePanel>
 <asp:ObjectDataSource ID="odsDefVals" runat="server" TypeName="myBiz.DAL.clsDefaultValues" SelectMethod="Select" UpdateMethod="Update">
  <SelectParameters>
   <asp:ControlParameter Name="dKey" Type="String" ControlID="ddlStepName" PropertyName="SelectedValue" />
   <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
  </SelectParameters>
  <UpdateParameters>
   <asp:Parameter Name="dKey" Type="String" />
   <asp:Parameter Name="xT00" Type="Decimal" />
   <asp:Parameter Name="xR00" Type="Decimal" />
   <asp:Parameter Name="xU00" Type="String" />
   <asp:Parameter Name="xT01" Type="Decimal" />
   <asp:Parameter Name="xR01" Type="Decimal" />
   <asp:Parameter Name="xU01" Type="String" />
   <asp:Parameter Name="xT02" Type="Decimal" />
   <asp:Parameter Name="xR02" Type="Decimal" />
   <asp:Parameter Name="xU02" Type="String" />
   <asp:Parameter Name="xT03" Type="Decimal" />
   <asp:Parameter Name="xR03" Type="Decimal" />
   <asp:Parameter Name="xU03" Type="String" />
   <asp:Parameter Name="xA01" Type="Decimal" />
   <asp:QueryStringParameter Name="AppCode" Type="String" QueryStringField="AppCode" />
  </UpdateParameters>
 </asp:ObjectDataSource>
 <asp:ObjectDataSource ID="odsUnit" runat="server" TypeName="myBiz.DAL.clsMisc" SelectMethod="getDDL">
  <SelectParameters>
   <asp:Parameter Name="Cate" Type="String" DefaultValue="EstimatedTimeUnit" />
   <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
  </SelectParameters>
 </asp:ObjectDataSource>
</asp:Content>
