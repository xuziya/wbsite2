<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="Member_login"%>

<!DOCTYPE html>
<html style="touch-action:none;">
<head runat="server">
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0" />
	<title>学员登录</title>
	<link rel="stylesheet" href="css/animate.min.css"/>
	<link rel="stylesheet" href="css/base.css"/>		
	<link rel="stylesheet" href="css/style.css"/>
	
</head>
<body class="animated fadeIn" style="" oncontextmenu="return false" onselectstart="return false" ondragstart="return false;" ondragend="return false;" onbeforecopy="return false" oncopy="document.selection.empty()" onselect="document.selection.empty()">
    <form id="form1" runat="server">
        <div class="bg">
			<div class="center">
				<div class="center_top"><a class="center_top_logo"><img src="img/中国移动培训系统.png" /></a><br />移动培训系统，请登录后使用，如有问题请连线系统管理员！</div>
				<div class="body">
					<div class="body_panel">
						<div class="body_top">
							<div class="body_tabs">
								<div class="body_tabs_list">密码登录</div>
							</div>
							<div class="body_content">
							    <div><asp:TextBox ID="txt_uid" runat="server" Text="xy1" class="body_input" maxlength="20" autocomplete="off" placeholder="用户名"></asp:TextBox></div>
							    <div><asp:TextBox ID="txt_pass" runat="server" Text="xy1" class="body_input" maxlength="20" autocomplete="off" placeholder="密&nbsp;&nbsp;&nbsp;码" TextMode="Password"></asp:TextBox></div>
							    <div><asp:Button ID="Button1" runat="server" class="body_button" Text="登录" onclick="Button1_Click"/></div>
							</div>
						</div>						   
					</div>
				</div>
				<div class="login-footer">
			        <p>
			            <a>Copyright © 2023 - 2024</a>&nbsp;&nbsp;&nbsp;
			            <a>All Rights Reserved</a>&nbsp;&nbsp;&nbsp;
			            <a>harry 版权所有</a>
			        </p>
			        <p>培训系统 Version 1.0.0</p>
				</div>
			</div>
		</div>
		<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
    </form>
</body>
</html>