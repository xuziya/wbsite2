<%@ Page Language="C#" AutoEventWireup="true" CodeFile="setting.aspx.cs" Inherits="Member_setting" %>

<!DOCTYPE html>
<html style="touch-action:none;">
<head runat="server">
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0" />
	<title></title>
    <link rel="stylesheet" href="css/normalize.css">
	<link rel="stylesheet" href="css/base.css">
	<link rel="stylesheet" href="css/animate.min.css">
	<link rel="stylesheet" href="css/font/iconfont.css">
	<link rel="stylesheet" href="css/style.css">
	<script src="js/jquery-1.11.3.min.js"></script>
</head>
<body class="animated fadeIn" style="" oncontextmenu="return false" onselectstart="return false" ondragstart="return false;" ondragend="return false;" onbeforecopy="return false" oncopy="document.selection.empty()" onselect="document.selection.empty()">
    <form id="form1" runat="server">
        <div class="bg1">
			<div class="head animated slideInDown clear">
				<div class="head-left"><div class="head-tit"><h2>个人设置</h2></div></div>
				<div class="head-right">
					<%--<div class="score"><p>10000</p></div>--%>
					<%--<div class="gold"><p>10000</p></div>--%>
					<%--<div class="diamond"><p>10000</p></div>--%>
				</div>
			</div>			
			<img class="work-img animated slideInLeft" style="left:200px"  src="/Upload/student/<%=GetSavePath() %>/半身像.png"/>
			<ul class="set-btn">
				<li class="active"><a>角色设置</a></li>
				<li><a>基本信息</a></li>
				<%--<li><a>技能等级</a></li>--%>
			</ul>
			<div class="set-bigbox">
				<div class="set-box">
					<h3>角色设置</h3>
					<div class="set-cont1">
						<div><img id="img_1" value="1" src="/Upload/student/男1/头像.jpg"/></div>
						<div><img id="img_2" value="2" src="/Upload/student/男2/头像.jpg"/></div>
					</div>
					<div class="set-bottom">
						<div><asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="img/修改.png" onclick="ImageButton1_Click" /></div>
						<div><img src="img/取消.png"/></div>
					</div>
				</div>
				<div class="set-box">
					<h3>基本信息</h3>
					<div class="set-cont">
						<table class="table table-borderd">
							<tr><td width="50%"><span class="iconfont"></span>&nbsp;姓名:</td><td id="name" runat="server"></td></tr>
							<tr><td><span class="iconfont"></span>&nbsp;员工编号:</td><td id="code" runat="server"></td></tr>
							<tr><td><span class="iconfont"></span>&nbsp;性别:</td><td id="sex" runat="server"></td></tr>
							<tr><td><span class="iconfont"></span>&nbsp;所属机构:</td><td id="organSole" runat="server"></td></tr>
							<tr><td><span class="iconfont"></span>&nbsp;部门:</td><td id="dept" runat="server"></td></tr>
							<tr><td><span class="iconfont"></span>&nbsp;账号:</td><td id="uid" runat="server"></td></tr>
							<tr><td><span class="iconfont"></span>&nbsp;密码:</td><td id="pass" runat="server"></td></tr>
						</table>
					</div>
					<%--<div class="set-bottom" style="text-align:right">
						<div><img src="img/修改.png"/></div>
						<div onclick="history.go(-1)"><img src="img/取消.png"/></div>
					</div>--%>
				</div>
				<%--<div class="set-box">
					<h3>技能等级</h3>
					<div class="set-cont">
						<table class="table table-borderd">
							<tr>
								<td width="50%"><span class="iconfont icon-jinengfen"></span>&nbsp;技能一:<input class="setinput" type="text" value="套餐优惠卡"></td>							
							</tr>
						</table>
					</div>
					<div class="set-bottom">
						<div><img src="img/修改.png"/></div>
						<div><img src="img/取消.png"/></div>
					</div>
				</div>--%>
			</div>
			<!-- 底部 -->
			<div class="footer animated slideInUp"><a class="back" href="index.aspx"><div class="iconfont icon-return"></div></a></div>
		</div>
        <script type="text/javascript">
            var sex = $("#<%=sex.ClientID %>").html();
            (function ()
            {
                if (!sex || sex == "") { sex = "男"; }
                $("#img_1").attr("src", "/Upload/student/" + sex + "1/头像.jpg");
                $("#img_2").attr("src", "/Upload/student/" + sex + "2/头像.jpg");
            })();
            //tab切换
            $('.set-btn li').click(function ()
            {
                $(this).addClass('active').siblings().removeClass('active');
                $(".set-box").hide().eq($(this).index()).fadeIn();
            })
            $(".set-box").fadeOut().eq(0).fadeIn();
            $(".set-box .set-cont1 div").click(function ()
            {
                var val = $(this).find('img').attr("value");
                $(this).addClass('active').siblings().removeClass('active');
                $('.work-img').attr("src", "/Upload/student/" + sex + "" + val + "/半身像.png");

                $("#<%=HiddenField1.ClientID %>").val(sex + val);
            })
		</script>
        <asp:HiddenField ID="HiddenField1" runat="server" />
        <audio autoplay="autoplay" loop="loop" preload="auto"><source src="img/music/2.mp3"></audio>
    </form>
</body>
</html>
