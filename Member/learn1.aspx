<%@ Page Language="C#" AutoEventWireup="true" CodeFile="learn1.aspx.cs" Inherits="Member_learn1" %>

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
				<div class="head-left"><div class="head-tit"><h2>学习资料</h2></div></div>
				<%--<div class="head-right">
					<div class="score"><p>10000</p></div>
					<div class="gold"><p>10000</p></div>
					<div class="diamond"><p>10000</p></div>
				</div>--%>
			</div>
			<div >
				<div class="ck animated" style="background: url(img/弹窗背景.png) no-repeat">
					<img class="pop-tit" src="img/学习资料.png"/><br />
					<div class="pop-content logs message pinggu" style="height:540px">
                        <ul>
                            <%--<li><p>系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息</p><span>2023-11-11</span></li>--%>
					        <%=GetLearns() %>
						</ul>
					</div>
				</div>
			</div>
			<div class="study-contbg">
				<div class="study-cont">
					<h3 id="title" style="font-size:40px">学习资料一</h3>
					<p class="time"><small id="time" style="margin-left:-40px">发布时间：2023-9-6</small></p>
                    <%--<p id="content"></p>--%>
					<p><iframe id="iframe" name="iframe" src="learn2.aspx" frameborder="0" class="admin-iframe" style="width:100%;height:100%"></iframe></p>
				</div>
				<div class="study-close"><img src="img/pop/关闭.png"/></div>
			</div>
			<!-- 底部 -->
			<div class="footer animated slideInUp"><a class="back" href="index.aspx"><div class="iconfont icon-return"></div></a></div>
		</div>
		<script>
		    $(".message ul li").click(function ()
		    {
		        $("#title").html($(this).attr("title"));
		        $("#time").html("发布时间：" + $(this).attr("time"));
		        $("#content").html($(this).attr("content"));

		        $("#iframe").attr("src", "learn2.aspx?id=" + $(this).attr("id"));
		        $(".study-contbg").slideDown()
		    });
		    $('.study-close').click(function () { $(".study-contbg").slideUp() })
		</script>
        <audio autoplay="autoplay" loop="loop" preload="auto"><source src="img/music/1.mp3"></audio>
    </form>
</body>
</html>
