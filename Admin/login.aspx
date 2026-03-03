<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/Master/base.master" CodeFile="login.aspx.cs" Inherits="Admin_login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<link type="text/css" rel="stylesheet" href="/Admin/css/ui/login.css"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div class="panel">
		<div class="center">
			<div class="center_top">
                <a class="center_top_logo"><%--<h2 style="color:#fff">游戏培训系统</h2>--%><img src="/Admin/img/logo.png" /></a>
                <br />登录后使用，如有问题请连线系统管理员！
            </div>
			<div class="body">
				<div class="body_panel">
				    <div class="body_code"><div class="body_code_icon"></div></div>
				    <div class="body_top">
					    <div class="body_tabs">
						    <div class="body_tabs_list">管理员登录</div>
					    </div>
					    <div class="body_content">
							<div><asp:TextBox ID="txt_uid" runat="server" class="body_input" maxlength="20" autocomplete="off" placeholder="用户名"></asp:TextBox></div>
							<div><asp:TextBox ID="txt_pass" runat="server" class="body_input" maxlength="20" autocomplete="off" placeholder="密&nbsp;&nbsp;&nbsp;码" TextMode="Password"></asp:TextBox></div>
							<div><asp:Button ID="Button1" runat="server" class="body_button" Text="登录" onclick="Button1_Click"/></div>
							<div class="body_auto">
								<input type="checkbox" id="checkboxed" name="checkboxed" style="margin-top:-2px"/><label for="checkboxed">自动登录（7天）</label>
								<%--<div class="body_links"><a>忘记密码</a>&nbsp;| &nbsp;<a>重置密码</a></div>--%>
							</div>
					    </div>
				    </div>
				    <div class="body_more">
					    <p class="body_more_tip">更多功能请点击</p>
					    <div class="body_more_list">
						    <a title="官方网站" class="more_e1"></a>
						    <a title="服务热线" class="more_e2"></a>
						    <a title="帮助中心" class="more_e3"></a>
					    </div>
				    </div>
			    </div>
			</div>
			<div class="footer">
                <p>
                    <a>Copyright © 2023</a>&nbsp;&nbsp;&nbsp;
                    <a>All Rights Reserved</a>&nbsp;&nbsp;&nbsp;
                    <a>harry 版权所有</a>
                </p>
                <p>游戏培训系统 Version 1.0.0</p>
			</div>
		</div>
	</div>
</asp:Content>