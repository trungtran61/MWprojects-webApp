<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.WIP.DataEntry" Title="Data Entry" CodeBehind="DataEntry.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" runat="Server">
    <style>
       .rowbtn {
    margin-top: 23px;
}
        .table-nonfluid {
      width: 800px!important;
    }
       
    </style>

    
    <aspx:UpdatePanel ID="uPnlSearch" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                <div style="margin: 10px 0 0 10px;">
                 <div style="width:200px;float:left">
                    <label for="txtPN" class="control-label">Part Number</label>
                    <asp:TextBox ID="txtPN" runat="server" CssClass="form-control input-sm" ClientIDMode="Static"></asp:TextBox>
                    <ajax:AutoCompleteExtender ID="acePartNumber" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="PartNumber" TargetControlID="txtPN">
                    </ajax:AutoCompleteExtender>
                </div>
                <div style="width:200px;float:left;margin-left:10px;">
                    <label for="name" class="control-label">Work Order</label>
                    <asp:TextBox ID="txtWO" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                    <ajax:AutoCompleteExtender ID="aceWorkOrder" runat="server" MinimumPrefixLength="1" ServicePath="../Search.asmx" ServiceMethod="GetWorkOrder" TargetControlID="txtWO" />
                </div>
                 <div style="width:200px;float:left;margin-left:10px;">
                    <label for="ddlCustomerName" class="control-label">Customer</label>
                    <asp:DropDownList ID="ddlCustomerName" CssClass="form-control input-sm" runat="server" DataSourceID="odsCompanyList" DataTextField="CompanyName" DataValueField="HID" ClientIDMode="Static" />
                </div>

                 <div style="width:200px;float:left;margin-left:10px;">
                    <label for="txtCustomerPO" class="control-label">PO Number</label>
                    <asp:TextBox ID="txtCustomerPO" runat="server" CssClass="form-control input-sm" ClientIDMode="Static" />
                </div>

                 <div style="width:200px;float:left;margin-left:10px;">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-primary input-sm inline rowbtn" ClientIDMode="Static" />
                    <asp:Button ID="btnNew" runat="server" Text="Add New" Enabled="false" OnClick="btnNew_Click" CssClass="btn btn-primary input-sm rowbtn" ClientIDMode="Static" />
                </div>                
                    </div>

                <div style="clear:left">
                    Next WO#: <%= (new clsWorkOrder()).NextWO %>
                </div>
                <asp:GridView ID="gvSearch" runat="server" AllowPaging="True" PageSize="50" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4"
                     DataKeyNames="HID" DataSourceID="odsSearch" ForeColor="#333333" GridLines="None" OnPreRender="gv_PreRender" OnSelectedIndexChanged="gv_Changed" OnRowDataBound="Rw_Bound"
                     CssClass="table table-hover table-nonfluid table-condensed">
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#EFF3FB" />
                    <Columns>
                        <asp:TemplateField HeaderText="Work Order" SortExpression="WorkOrder">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" Text='<%# Eval("WorkOrder") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Part Number" DataField="PartNumber" SortExpression="PartNumber" InsertVisible="false" />
                        <asp:BoundField HeaderText="Revision" DataField="Revision" SortExpression="Revision" InsertVisible="false" />
                        <asp:BoundField HeaderText="UnitPrice" DataField="UnitPrice" SortExpression="UnitPrice" DataFormatString="{0:C}" InsertVisible="false" />
                        <asp:BoundField HeaderText="CustomerName" DataField="CompanyName" SortExpression="CompanyName" InsertVisible="false" />
                        <asp:BoundField HeaderText="CustomerPO#" DataField="CustomerPO" SortExpression="CustomerPO" InsertVisible="false" />
                    </Columns>
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#9999CC" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </asp:Panel>
            <asp:ObjectDataSource ID="odsSearch" runat="server" TypeName="myBiz.DAL.clsWorkOrder" SelectMethod="Select3">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtWO" PropertyName="Text" Name="WorkOrder" Type="String" />
                    <asp:ControlParameter ControlID="txtPN" PropertyName="Text" Name="PartNumber" Type="String" />
                    <asp:ControlParameter ControlID="ddlCustomerName" PropertyName="SelectedValue" Name="CustID" Type="Int32" />
                    <asp:ControlParameter ControlID="txtCustomerPO" PropertyName="Text" Name="CustomerPO" Type="String" />
                    <asp:Parameter Name="isPB" Type="Boolean" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </ContentTemplate>
    </aspx:UpdatePanel>
    <aspx:UpdatePanel ID="uPnlAddNew" runat="server">
        <ContentTemplate>
            <div style="margin: 10px 0 0 10px;">
            <asp:Panel ID="pnlAddNew" runat="server" Visible="false">
                Next WO#: <%= (new clsWorkOrder()).NextWO %><br />
                <table style="background-color: Silver">
                    <tr>
                        <td><b>Work Order:</b><br />
                            <asp:TextBox ID="txtWorkOrder" runat="server" CssClass="form-control input-sm" /></td>
                        <td><b>Customer Job#:</b><br />
                            <asp:TextBox ID="txtCustJob" runat="server" CssClass="form-control input-sm" /></td>
                        <td><b>Customer Name:</b><br />
                            <asp:DropDownList ID="ddlCustomerID" runat="server" DataSourceID="odsCompanyList" DataTextField="CompanyName" DataValueField="HID" CssClass="form-control input-sm"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td><b>Customer PO#:</b><br />
                            <asp:DropDownList ID="ddlCustomerPO" runat="server" DataSourceID="odsCustomerPO" DataTextField="CustomerPO" DataValueField="CustomerPO" CssClass="form-control input-sm"></asp:DropDownList>
                        </td>
                        <td><b>Line#:</b><br />
                            <asp:TextBox ID="txtLine" runat="server" CssClass="form-control input-sm" /></td>
                        <td>
                            <table>
                                <tr>
                                    <td><b>Part Number:</b><br />
                                        <asp:TextBox ID="txtPartNumber" runat="server" CssClass="form-control input-sm" /></td>
                                    <td><b>Rev:</b><br />
                                        <asp:TextBox ID="txtRevision" runat="server" CssClass="form-control input-sm" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td><b>Order Qty:</b><br />
                            <asp:TextBox ID="txtoQty" runat="server" CssClass="form-control input-sm" /></td>
                        <td><b>Unit Price:</b><br />
                            <asp:TextBox ID="txtUnitPrice" runat="server" CssClass="form-control input-sm" /></td>
                        <td><b>Due Date:</b><br />
                            <asp:TextBox ID="txtDueDate" runat="server" CssClass="form-control input-sm" />
                            <ajax:CalendarExtender ID="calDueDate" runat="server" TargetControlID="txtDueDate" Format="MM/dd/yy hh:mm tt" OnClientDateSelectionChanged="setDate" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3"><b>Description:</b><br />
                            <asp:TextBox ID="txtDescription" runat="server" TextMode="multiLine" CssClass="form-control" Height="200" ></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="4"><b>Description for Traveler:</b><br />
                            <asp:TextBox ID="txtTravelDesc" runat="server" TextMode="multiLine" CssClass="form-control" Height="200" ></asp:TextBox></td>
                    </tr>
                </table>
                <br />
                <br />
                <asp:Button ID="btnSave" runat="server" Text="Save New Work Order" OnClick="btnSave_Click" CssClass="btn btn-primary input-sm"/>
                <asp:Button ID="btnBack" runat="server" Text="Back to Search" OnClick="btnBack_Click" CssClass="btn btn-primary input-sm"/>
                <br />
                <MW:Message ID="iMsg" runat="server" />
            </asp:Panel>
                </div>
            <asp:ObjectDataSource ID="odsCustomerPO" runat="server" TypeName="myBiz.DAL.clsFile" SelectMethod="CustomerPO_S2"></asp:ObjectDataSource>
        </ContentTemplate>
    </aspx:UpdatePanel>
    <asp:ObjectDataSource ID="odsCompanyList" runat="server" TypeName="myBiz.DAL.clsCommunication" SelectMethod="getCompanyList">
        <SelectParameters>
            <asp:Parameter Name="ClassName" Type="String" DefaultValue="Customer" />
            <asp:Parameter Name="TypeName" Type="String" DefaultValue="Customer" />
            <asp:Parameter Name="iBlank" Type="Int32" DefaultValue="1" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
