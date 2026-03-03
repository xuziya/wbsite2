<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pinggu1.aspx.cs" Inherits="Member_pinggu1" %>

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
				<div class="head-left"><div class="head-tit"><h2>评估</h2></div></div>
				<%--<div class="head-right">
					<div class="score"><p>10000</p></div>
					<div class="gold"><p>10000</p></div>
					<div class="diamond"><p>10000</p></div>
				</div>--%>
			</div>
			<div >
				<div class="ck animated" style="background: url(img/弹窗背景.png) no-repeat">
					<img class="pop-tit" src="img/教学评估.png"/>
                    <br />
					<div class="pop-content logs pinggu message">
                        <ul>
                            <%--<li><p>系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息系统消息</p><span>2023-11-11</span></li>--%>
					        <%=GetLearns() %>
						</ul>
					</div>
				</div>
			</div>
			<div class="study-contbg">
                <iframe id="iframe" name="iframe" src="" frameborder="0" class="admin-iframe" style="width:100%;height:100%"></iframe>
			</div>
			<!-- 底部 -->
			<div class="footer animated slideInUp"><a class="back" href="index.aspx"><div class="iconfont icon-return"></div></a></div>
		</div>
		<script>
		    $(".message ul li").click(function ()
		    {
		        var result = $(this).attr("result");
		        $("#iframe").attr("src", "pinggu2" + (result == "成功" ? "1" : "2") + ".aspx?regID=" + $(this).attr("id"));
		        $(".study-contbg").slideDown();
		    });
		    function close123() { $(".study-contbg").slideUp(); }
		</script>
        <audio autoplay="autoplay" loop="loop" preload="auto"><source src="img/music/1.mp3"></audio>
    </form>
</body>
</html>
