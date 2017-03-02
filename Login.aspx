<%@ Page Language="C#" MasterPageFile="~/_MasterPage/MasterPage.master" AutoEventWireup="true" Inherits="webApp.Login" Title="Please Login!" Codebehind="Login.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainArea" runat="Server">
    <style type="text/css">
        body {
    padding-top: 0px;
}
.panel-login {
	border-color: #ccc;
	-webkit-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
	-moz-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
	box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
}
.panel-login>.panel-heading {
	color: #00415d;
	background-color: #fff;
	border-color: #fff;
	text-align:center;
}
.panel-login>.panel-heading a{
	text-decoration: none;
	color: #666;
	font-weight: bold;
	font-size: 15px;
	-webkit-transition: all 0.1s linear;
	-moz-transition: all 0.1s linear;
	transition: all 0.1s linear;
}
.panel-login>.panel-heading a.active{
	color: #029f5b;
	font-size: 18px;
}
.panel-login>.panel-heading hr{
	margin-top: 10px;
	margin-bottom: 0px;
	clear: both;
	border: 0;
	height: 1px;
	background-image: -webkit-linear-gradient(left,rgba(0, 0, 0, 0),rgba(0, 0, 0, 0.15),rgba(0, 0, 0, 0));
	background-image: -moz-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
	background-image: -ms-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
	background-image: -o-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
}
.panel-login input[type="text"],.panel-login input[type="email"],.panel-login input[type="password"] {
	height: 45px;
	border: 1px solid #ddd;
	font-size: 16px;
	-webkit-transition: all 0.1s linear;
	-moz-transition: all 0.1s linear;
	transition: all 0.1s linear;
}
.panel-login input:hover,
.panel-login input:focus {
	outline:none;
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
	box-shadow: none;
	border-color: #ccc;
}
.btn-login {
	background-color: #59B2E0;
	outline: none;
	color: #fff;
	font-size: 14px;
	height: auto;
	font-weight: normal;
	padding: 14px 0;
	text-transform: uppercase;
	border-color: #59B2E6;
}
.btn-login:hover,
.btn-login:focus {
	color: #fff;
	background-color: #53A3CD;
	border-color: #53A3CD;
}
.forgot-password {
	text-decoration: underline;
	color: #888;
}
.forgot-password:hover,
.forgot-password:focus {
	text-decoration: underline;
	color: #666;
}

.btn-register {
	background-color: #1CB94E;
	outline: none;
	color: #fff;
	font-size: 14px;
	height: auto;
	font-weight: normal;
	padding: 14px 0;
	text-transform: uppercase;
	border-color: #1CB94A;
}
.btn-register:hover,
.btn-register:focus {
	color: #fff;
	background-color: #1CA347;
	border-color: #1CA347;
}

    </style>
    <div class="Absolute-Center" id="spinner" style="display: none">
        <img src="images/loader.gif" />
    </div>

    <table id="tblTools" class="table table-borderless">
        <tbody>
            <tr>
                <td>
                    <asp:Image ID="imgLogo" runat="server" ImageUrl="~/App_Themes/MWlogo.jpg" Width="150px" /></td>                
            </tr>
        </tbody>
    </table>
    <aspx:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="container">
                <div class="row">
                    <div class="col-md-6 col-md-offset-3">
                        <div class="panel panel-login">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <a href="#" class="active" id="login-form-link">Login to Machine Works</a>
                                    </div>
                                </div>
                                <hr>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control input-sm" placeholder="UserName" />
                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control input-sm" placeholder="Password" />
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <asp:Button ID="btnLogin" ClientIDMode="Static" runat="server" CssClass="form-control btn-login input-sm" Text="Login" OnClick="btnLogin_Click" OnClientClick=" $('#spinner').show();" />
                                                </div>
                                                <div class="col-sm-6">
                                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CssClass="form-control btn-register input-sm" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
                <div style="text-align:center">
                    <asp:Literal ID="litMessage" runat="server"></asp:Literal><asp:HiddenField ID="myHID" runat="server" />
                </div>
        </ContentTemplate>
    </aspx:UpdatePanel>
</asp:Content>
