<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="Member_index" %>

<!DOCTYPE html>
<html style="touch-action:none;">
<head runat="server">
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0" />
	<title>首页</title>
    <link rel="stylesheet" href="css/normalize.css">
	<link rel="stylesheet" href="css/animate.min.css">
	<link rel="stylesheet" href="css/swiper.min.css">
	<link rel="stylesheet" href="css/base.css">	
    <link rel="stylesheet" href="css/font/iconfont.css">	
	<link rel="stylesheet" href="css/style.css">
	<style>
		.swiper-slide { display: -webkit-box;display: -ms-flexbox;display: -webkit-flex;display:flex;-webkit-box-pack: center;-ms-flex-pack: center;-webkit-justify-content: center;justify-content: center;-webkit-box-align: center;-ms-flex-align: center;-webkit-align-items: center; align-items: center;transition: 300ms;transform: scale(0.8);z-index: 88;}
		.swiper-slide-active,.swiper-slide-duplicate-active{transform: scale(1);z-index: 999;}
		.swiper-slide-active img,.swiper-slide-duplicate-active img{border: 1px solid #446ec9;}
		.swiper-slide img{padding: 10px;box-shadow: 0 0px 20px 0 rgba(0,0,0,0.5);box-sizing: border-box;background: #fff;}
	</style>
</head>
<body class="animated fadeIn" style="" oncontextmenu="return false" onselectstart="return false" ondragstart="return false;" ondragend="return false;" onbeforecopy="return false" oncopy="document.selection.empty()" onselect="document.selection.empty()">
    <form id="form1" runat="server">
        <div class="bg">
			<div class="head animated slideInDown clear">
				<div class="head-left">
					<div class="head-img"><img src="/Upload/student/<%=GetSavePath() %>/头像.jpg"/></div>
					<div class="head-tit"><h3><%=GetName() %></h3><p>段位：白银</p></div>
				</div>
				<div class="head-right">
					<%--<div class="score"><p>10000</p></div>--%>
					<%--<div class="gold"><p>10000</p></div>--%>
					<%--<div class="diamond"><p>10000</p></div>--%>
                    <span class="guize"><img src="img/规则.png"/></span >	
				</div>
			</div>
            <!-- 规则弹框 -->
			<div class="guize-layer">
				<div class="tit1">规则说明</div>
				<div class="panel"><p>1、CHBN融合场景实战演练共分为个客、家庭、集客三大场景，各场景下分别包含简单模式、中级模式、困难模式，每个模式共5个细分场景。实战演练共分为青铜、白银、铂金、钻石、皇冠5个段位，玩家可通过进行场景游戏积累得分晋级。</p></div>
				<div class="close"><img src="img/pop/关闭1.png"/></div>
			</div>
			<div class="middle">
				<img class="map animated bounceInRight" src="img/场景1.png"/>
                <div class="btnint animated bounceInRight"><img class="image_types0" style="display:none" src="img/个人.png"/></div>
				<div class="btnint animated bounceInRight" style="left:1143px;"><img class="image_types0" style="display:none" src="img/家庭.png"/></div>		
				<div class="btnint animated bounceInRight" style="left:1462px;"><img class="image_types0" style="display:none" src="img/集团.png"/></div>
				<img class="work-img animated slideInLeft"  src="/Upload/student/<%=GetSavePath() %>/半身像.png"/>
				<ul class="menu-box animated slideInLeft">
					<li><a href="setting.aspx"><img src="img/设置.png"/></a></li>
					<li class="rizhi"><a href="javascript:sound1();"><img src="img/日志.png"/></a></li>
					<li><a href="learn1.aspx"><img src="img/资料.png"/></a></li>
					<li><a href="pinggu1.aspx"><img src="img/评估.png"/></a></li>
					<li class="xiaoxi"><a href="message1.aspx"><img src="img/消息.png"/></a></li>
				</ul>
				<div class="map-btn">
					<div class="map-btn1"><a href="list.aspx?type=0"></a></div>
					<div class="map-btn2"><a href="list.aspx?type=1"></a></div>
					<div class="map-btn3"><a href="list.aspx?type=2"></a></div>
				</div>
				<%--<div class="creat-room"><img src="img/创建房间.png"/></di v>--%>
				<div class="join-room"><img src="img/加入房间.png"/></div>
			</div>
			<!-- 创建房间 -->
			<%--<div class="creat-box" style="display: none;">
				<div class="creat">
					<img src="img/房间/创建房间标题.png"/>
					<div class="creat-content">
						<div class="form">
							<div class="form-div"><label>房间名称:</label><input type="text" id="room_name1" maxlength="20" autocomplete="off" placeholder="你的房间名称"/></div>
							<div class="form-div"><label>房间密码:</label><input type="text" id="room_pass1" maxlength="20" autocomplete="off" placeholder="你的房间密码"/></div>
							<div class="form-div"><label>人数设置:</label><input type="text" id="room_num" value="6" autocomplete="off" placeholder="人数设置"/></div>
							<div class="fdiv">
								<label>说明:</label>
								<input type="text" id="room_name1" placeholder="说明"/>
							</div>							
				        </div>
						<div class="swiper-container" id="cj1">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
                                    <div class="gkbtn" style="position:relative;top:0px;left:60px">
					                    <a>
						                    <img class="gkrw" src="img/gkrw/gkr1.png"/>
                                            <h1>01</h1>
						                    <div class="numbers"><h2 class="ks">&nbsp;&nbsp;情景二二<br>二二二二</h2></div>
					                    </a>
				                    </div>
                                </div>
								<div class="swiper-slide"><img src="img/背景/缩略图/1.jpg"/></div>
								<div class="swiper-slide"><img src="img/背景/缩略图/1.jpg"/></div>
								<div class="swiper-slide"><img src="img/背景/缩略图/1.jpg"/></div>							
							</div>
						</div>
					</div>
					<div class="creatbtn">
						<div class="confirm" onclick="room_create()"><img src="img/pop/确认.png"/></div>
						<div class="cancel"><img src="img/pop/取消.png"/></div>
					</div>
				</div>
			</div>
            <script type="text/javascript" src="/Admin/js/harry/harry.ajax.js"></script>
            <script type="text/javascript">
                function room_create()
                {
                    if ($("#room_name1").val() == "") { alert("请输入房间名称"); $("#room_name1").focus(); return; }
                    if ($("#room_pass1").val() == "") { alert("请输入房间密码"); $("#room_pass1").focus(); return; }
                    if ($("#room_num").val() == "") { alert("请输入房间人数"); $("#room_num").focus(); return; }
                    var ajax = new Ajax();
                    ajax.onCom = function (r)
                    {
                        if (r == "false") { alert("操作失败"); }
                        else { location.href = "room1.aspx?rid=" + r; }
                    }
                    ajax.start("at=room_create&name=" + $("#room_name1").val() + "&pass=" + $("#room_pass1").val() + "&num=" + $("#room_num").val());
                }
            </script>--%>
			<!-- 进入房间 -->
			<div class="join-box" style="display: none;">
				<div class="join">
					<img src="img/房间/加入房间标题.png"/>
					<div class="form-div"><label>房间名称:</label><input type="text" id="room_name2" maxlength="8" autocomplete="off" placeholder="房间名称"/></div>
					<div class="form-div"><label>房间密码:</label><input type="text" id="room_pass2" maxlength="8" autocomplete="off" placeholder="房间密码"/></div>
					<div class="joinbtn">
						<div class="confirm" onclick="room_join()"><img src="img/pop/确认.png"/></div>
						<div class="cancel"><img src="img/pop/取消.png"/></div>
					</div>
				</div>
			</div>
            <script type="text/javascript" src="/Admin/js/harry/harry.ajax.js"></script>
            <script>
                function room_join()
                {
                    sound1();
                    if ($("#room_name2").val() == "") { alert("请输入房间名称"); $("#room_name2").focus(); return; }
                    if ($("#room_pass2").val() == "") { alert("请输入房间密码"); $("#room_pass2").focus(); return; }
                    var ajax = new Ajax();
                    ajax.onCom = function (r)
                    {
                        if (r == "false") { alert("操作失败"); }
                        else if (r == "") { alert("无效的房间信息"); }
                        else
                        {
                            var rs = r.split("_");
                            if (rs[0] == "已开始") { alert("房间已开始"); }
                            else if (rs[0] == "已关闭") { alert("房间已关闭"); }
                            else { location.href = "room2.aspx?rid=" + rs[1]; }
                        }
                    }
                    ajax.start("at=room_join&name=" + $("#room_name2").val() + "&pass=" + $("#room_pass2").val());
                }
            </script>
            <!-- 日志 -->
			<div class="logs-box animated " style="display: none;">
				<div class="ck ">
					<img class="pop-tit" src="img/日志标题.png"/>
					<div class="pop-content logs">
						<ul><%=GetLoginLog() %></ul>
					</div>
					<div class="popbtn">
						<!-- <div class="confirm"><img src="img/pop/确认.png"/></div>
						<div class="cancel"><img src="img/pop/取消.png"/></div> -->
						<div class="logs-close"><img src="img/pop/关闭.png"/></div>
					</div>
				</div>
			</div>
             <!-- 消息 -->
			<div class="message-box animated " style="display: none;">
				<div class="ck">
					<img class="pop-tit" src="img/消息标题.png"/>
					<div class="pop-content message">
						<ul>
							<%--<li>系统消息</li>--%>
                            <%=GetMessage() %>
						</ul>
					</div>
					<div class="popbtn"><div class="message-close"><img src="img/pop/关闭.png"/></div></div>
				</div>
			</div>
			<!-- 退出提示框 -->
			<div class="back-box">
				<div class="back-boximg">
					<div class="confirm"></div>
					<div class="cancel"></div>
				</div>				
			</div>
			<div class="footer animated slideInUp"><a class="exit"><img src="img/退出.png"/></a></div>
		</div>
		<script src="js/jquery-1.11.3.min.js"></script>
		<script src="js/swiper.min.js"></script>
		<script>
            //图片轮换
            var now = 0;
            (function (){setInterval(function (){$(".image_types0").hide().eq(now).show();now++; if (now >= 3) { now = 0; }}, 5000);})();
            $('.guize').click(function(){$('.guize-layer').slideDown()})
			$('.guize-layer .close').click(function(){$('.guize-layer').slideUp()})
			//$(".xiaoxi a").click(function(){$('.message-box').removeClass('zoomOutLeft').addClass('zoomInLeft').css("display",'block')})
			//$('.message-close').click(function(){$('.message-box').removeClass('zoomInLeft').addClass('zoomOutLeft')})
			$(".rizhi a").click(function(){$('.logs-box').removeClass('zoomOutLeft').addClass('zoomInLeft').css("display",'block')})
			$('.logs-close').click(function(){sound1();$('.logs-box').removeClass('zoomInLeft').addClass('zoomOutLeft')})
			
			$(".creat-room").click(function(){
				$(".creat-box").slideDown(function(){
					var mySwiper = new Swiper('#cj1',{
						slidesPerView:2,
						spaceBetween: 0,
						centeredSlides: true,
						 direction: 'vertical',
						 loop: true,
						 speed:300,
					})
				})
			})
            //创建确认
			//$(".creatbtn .confirm").click(function(){window.location.href="房间.html"})
            //创建取消
			//$(".creatbtn .cancel").click(function(){$(".creat-box").slideUp();})
			//加入房间
			$(".join-room").click(function(){sound1();$(".join-box").slideDown();})
            //加入确认
			//$(".joinbtn .confirm").click(function(){window.location.href="房间.html"})
            //加入取消
			$(".joinbtn .cancel").click(function(){sound1();$(".join-box").slideUp();})
			
			$(".exit").click(function(){$(".back-box").fadeIn();})
			$(".back-box .confirm").click(function(){window.location.href="login.aspx"})
			$(".back-box .cancel").click(function(){$(".back-box").fadeOut();})
            function sound1(){document.getElementById("audio11").play();}
            
            function roomMsg_clear()
            {
                var ajax = new Ajax("/Member/index.aspx");
                ajax.onCom = function (r) {};
                ajax.start("at=room_clear");
            };
            //roomMsg_clear();
            //window.setInterval("roomMsg_clear()",5000);
		</script>
        <audio autoplay="autoplay" loop="loop" preload="auto"><source src="img/music/1.mp3"></audio>
        <audio id="audio11"><source src="/Upload/sound/点击1.mp3"></audio>
    </form>
</body>
</html>