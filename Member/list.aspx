<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="Member_list" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
        <div class="bg">
			<div class="head animated slideInDown clear">
				<div class="head-left"><div class="head-tit"><h2><%=type %>场景</h2></div></div>
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
				<div class="panel" id="tips_html">
					<p>1、当前为10分场景，游戏开始后，需根据客户画像进行最优的触点、产品推荐选择，随后进入游戏对话环节；<br />2、对话环节中，每轮对话会降低血量，当血量为0时或或环节进行完后游戏结束。<br />3、当前简单模式场景累计得分达35分可解锁中级模式。</p>
                    <p style="display:none">1、当前为15分场景，游戏开始后，需根据客户画像进行最优的触点、产品推荐选择，随后进入游戏对话环节；<br />2、对话环节中，每轮对话会降低血量，当血量为0时或环节进行完后游戏结束。<br />3、当前简单模式场景累计得分达52分可解锁中级模式。</p>
                    <p style="display:none">1、当前为20分场景，游戏开始后，需根据客户画像进行最优的触点、产品推荐选择，随后进入游戏对话环节；<br />2、对话环节中，每轮对话会降低血量，当血量为0时游戏结束或环节进行完后游戏结束。</p>
				</div>
				<div class="close"><img src="img/pop/关闭1.png"/></div>
			</div>
		    <!-- 侧面弹窗 -->
			<div class="jrcj-box" style="display: none;">
				<div class="jrcj-left animated bounceInLeft" style="display: none;">
					<img class="person" src="img/people/客户/kh1-dh.png"/>
					<div class="qipao"><p>准备好了吗？我可不是好对付的哦。那就开始吧</p></div>
					<h2 class="names11"><%=type %>客户场景</h2>
					<div class="jrcj-btn">
						<div class="confirm confirm111"><img src="img/pop/确认.png"/></div>
						<div class="cancel"><img src="img/pop/取消.png"/></div>
					</div>
					<div class="jrcj-btn"><div class="create" style="position:absolute;top:110px;left:130px"><img src="img/创建房间.png"/></div></div>
				</div>
				<div class="jrcj-right animated" style="display: none;">
					<img class="person" src="img/people/客户/kh1-dh.png"/>
					<div class="qipao"><p>准备好了吗？我可不是好对付的哦。那就开始吧</p></div>
					<h2 class="names11"><%=type %>客户场景</h2>
					<div class="jrcj-btn">
						<div class="confirm confirm111"><img src="img/pop/确认.png"/></div>
						<div class="cancel"><img src="img/pop/取消.png"/></div>
					</div>
					<div class="jrcj-btn"><div class="create" style="position:absolute;top:110px;left:130px"><img src="img/创建房间.png"/></div></div>
				</div>
			</div>
			<!-- 关卡 -->
            <div id="scene_html" runat="server">
			    <%--<div class="gkbox animated pulse">
				    <div class="gkbtn gk1 animated">
					    <a href="对话.html">
						    <img class="gkrw" src="img/gkrw/gkr1.png"/>
						    <h1>01</h1>
						    <img class="lock" src="img/gkm/开锁.png"/>
						    <!-- <img class="numbers" src="img/gkm/一紫色.png"/> -->
						    <div class="numbers">
							    <h2 class="ks">&nbsp;&nbsp;情景一一一<br>一一一一一</h2>
						    </div>
						    <p>进行中</p>
						    <img class="status" src="img/gkm/完成标记.png"/>
					    </a>
				    </div>
			    </div>--%>
            </div>
			<!-- 底部 -->
			<div class="footer animated slideInUp">
				<ul class="modebox clear">
					<li class="active"><a><p><i class="iconfont icon-duigouxiao"></i>&nbsp;简单模式</p></a></li>
					<li><a><p><i class="iconfont icon-duigouxiao"></i>&nbsp;中级模式</p></a></li>
					<li><a><p><i class="iconfont icon-duigouxiao"></i>&nbsp;困难模式</p></a></li>
				</ul>
				<a class="back" href="index.aspx"><div class="iconfont icon-return"></div></a>
			</div>
		</div>
		<!-- 创建房间 -->
		<div class="creat-box" style="display: none;">
			<div class="creat">
				<img src="img/房间/创建房间标题.png"/>
				<div class="creat-content">
                    <div class="gkbtn" id="create_msg" style="position:relative;top:0px;left:60px">
						<img class="gkrw" src="img/gkrw/gkr1.png"/>
                        <h1>01</h1>
						<div class="numbers"><h2 class="ks">&nbsp;&nbsp;情景二二<br>二二二二</h2></div>
				    </div>
					<div class="form">
						<div class="form-div"><label>房间名称:</label><input type="text" id="room_name1" maxlength="8" autocomplete="off" placeholder="你的房间名称"/></div>
						<div class="form-div"><label>房间密码:</label><input type="text" id="room_pass1" maxlength="8" autocomplete="off" placeholder="你的房间密码"/></div>
						<div class="form-div"><label>人数设置:</label><input type="text" id="room_num" value="6" maxlength="2" autocomplete="off" placeholder="人数设置"/></div>
						<%--<div class="fdiv">
							<label>说明:</label>
							<input type="text" id="room_name1" placeholder="说明"/>
						</div>--%>							
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
                var ajax = new Ajax("index.aspx");
                ajax.onCom = function (r)
                {
                    if (r == "false") { alert("操作失败"); }
                    else { location.href = "room1.aspx?rid=" + r; }
                }
                ajax.start("at=room_create&rid=" + click_a.attr("id") + "&name=" + $("#room_name1").val() + "&pass=" + $("#room_pass1").val() + "&num=" + $("#room_num").val());
            }
        </script>
		<script>
		    $('.guize').click(function () { $('.guize-layer').slideDown(); })
		    $('.guize-layer .close').click(function () { $('.guize-layer').slideUp(); })
		    $(".gkbtn").mouseover(function ()
		    {
		        //$(".gkbtn").removeClass('pulse')
		        $(this).addClass('bounce');
		    })
		    $(".gkbtn").mouseleave(function () { $(".gkbtn").removeClass('bounce');  })
		    $('.modebox li').click(function ()
		    {
		        $(this).addClass('active').siblings().removeClass('active');
		        $("#<%=scene_html.ClientID %>").children().eq($(this).index()).show().siblings().hide();
		        $("#tips_html").children().eq($(this).index()).show().siblings().hide();
		    })

		    var nan1 = ["相信你的选择", "战斗吧，勇士", "游戏世界等你主宰"];
            var nv1 = ["ready？go", "一起去探索吧", "终于等来你喽"];
            function random(lower, upper) { return Math.floor(Math.random() * (upper - lower + 1)) + lower; }
            //自动打字
            function print1(content)
            {
                $(".qipao p").html("");
                var print_str1 = content, print_str2 = "";
                var interval1 = setInterval(function ()
                {
                    if (print_str1.length > 0)
                    {
                        print_str2 += print_str1.substring(0, 1);
                        print_str1 = print_str1.substring(1);
                        $(".qipao p").html(print_str2);
                    }
                    else { clearInterval(interval1); }
                }, 150);
            }
            function sound11(content)
            {
                if(content == ""){return;}
                var audio2 = document.getElementById("audio2");
                audio2.src = "/Upload/sound/"+content+".mp3";
                audio2.play();
            }
            //侧面点击
		    var click_a;
		    $(".gkbtn a").click(function (e)
		    {
		        sound1();
		        click_a = $(this);

		        var _ran = random(0, 2);
		        var content = $(this).attr("sex") == "男" ? nan1[_ran] : nv1[_ran];
		        print1(content);
		        sound11(content);

		        $(".names11").html($(this).attr("name"));
		        $(".person").attr("src", $(this).attr("image"));
		        $(".confirm111").attr("id", $(this).attr("id"));
		        $(".jrcj-box").fadeIn();
		        var left = e.pageX;
		        if (left <= 1000) { $(".jrcj-box").find(".jrcj-right").removeClass("bounceOutRight").css("display", "block").addClass("bounceInRight") }
		        else { $(".jrcj-box").find(".jrcj-left").removeClass("bounceOutLeft").css("display", "block").addClass("bounceInLeft") }
		    });
            //侧面关闭
		    $(".jrcj-btn .cancel").click(function ()
		    {
		        sound1();
		        $(".jrcj-box").find(".jrcj-right").removeClass("bounceInRight").addClass("bounceOutRight").css("display", "none");
		        $(".jrcj-box").find(".jrcj-left").removeClass("bounceInLeft").addClass("bounceOutLeft").css("display", "none");
		        $(".jrcj-box").fadeOut(500);
		    })
		    //跳转
		    $(".confirm111").click(function () { location.href = "select.aspx?sid=" + $(this).attr("id"); });
		    var enteranimet;
		    var num = 1;
		    //成功
		    enteranimet = setInterval(function ()
		    {
		        num == 33 ? num = 1 : num++
		        $(".feiji img").attr('src', 'img/线/' + num + '.png')
		    }, 120);
            //创建房间
		    $(".create").click(function ()
		    {
		        sound1();
		        var create_msg = $("#create_msg");
		        create_msg.find(".gkrw").attr("src", click_a.find(".gkrw").attr("src"));
		        create_msg.find("h1").html(click_a.find("h1").html());
		        create_msg.find(".numbers").html(click_a.find(".numbers").html());
		        $(".creat-box").show();
		    });
		    //创建取消
		    $(".creatbtn .cancel").click(function () { $(".creat-box").slideUp(); })
		    function sound1() { document.getElementById("audio11").play(); }
		</script>
        <audio autoplay="autoplay" loop="loop" preload="auto"><source src="img/music/2.mp3"></audio>
        <audio id="audio2"><source src="img/music/1.mp3"></audio>
        <audio id="audio11"><source src="/Upload/sound/点击1.mp3"></audio>
    </form>
</body>
</html>