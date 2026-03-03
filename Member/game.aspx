<%@ Page Language="C#" AutoEventWireup="true" CodeFile="game.aspx.cs" Inherits="Member_game" %>

<!DOCTYPE html>
<html style="touch-action:none">
<head id="Head1" runat="server">
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0"/>
	<title></title>
	<link rel="stylesheet" href="css/normalize.css"/>
	<link rel="stylesheet" href="css/animate.min.css"/>
	<link rel="stylesheet" href="css/font/iconfont.css"/>
	<link rel="stylesheet" href="css/base.css"/>
	<link rel="stylesheet" href="css/style.css"/>
	<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>		
</head>
<body class="animated fadeIn" style="" oncontextmenu="return false" onselectstart="return false" ondragstart="return false" ondragend="return false" onbeforecopy="return false" oncopy="document.selection.empty()" onselect="document.selection.empty()">
     <form id="form1" runat="server">
        <div class="bg1" id="page_bg" runat="server">
            <!-- 上边栏 -->
			<div class="head animated slideInDown clear">
				<div class="head-left"><div class="head-tit"><h2>实战演练</h2></div></div>
				<div class="head-right">
					<div class="score"><p id="point3_p" value='0'>0</p></div>
					<%--<div class="gold"><p>10000</p></div>--%>
					<%--<div class="diamond"><p>10000</p></div>--%>
                    <span class="guize"><img src="img/规则.png"/></span>
				</div>
                <!-- 计时 -->
                <div class="time-box"><span>游戏时间：</span><span class="sj" id="time1" value="0"><%=time1 %></span><span> s</span></div>
			</div>
            <!-- 开场视频 -->
            <div class="video-box" style="background:#000">
                <video id="video1" muted="muted"><source src="/Upload/mp4/游戏页.mp4" type="video/mp4"/></video>
                <audio id="video2"><source src="/Upload/mp4/游戏页.mp4"></audio>
            </div>
            <!-- 规则弹框 -->
			<div class="guize-layer">
				<div class="tit1">规则说明</div>
				<div class="panel"><p>游戏模拟实际营销，通过对话的方式呈现一个完整的营销过程<br />
1、对话共分为问候、关怀、产品推荐三大环节。<br />
2、每句话术共5个选项，其中1个5分选项、1个4分选项、3个0分选项。<br />
3、游戏最终得分为每句话术累计得分。<br />
4、游戏左上方为游戏血量，每进行1轮对话扣5%血量，选择0分对话，额外扣除10%血量，血量为0后，可通过学习游戏资料复活，复活后拥有10%血量，再次血量为0后，游戏失败。<br />
5、游戏右上方为客户情绪值，话术选择正确与否会影响用户情绪值。<br />
6、游戏中可点击左侧“资源”按钮使用免费资源，资源使用后掉血5%，增长情绪值10%。</p></div>
				<div class="close"><img src="img/pop/关闭1.png"/></div>
			</div>
			<!-- 血条 -->
			<div class="HP clear">
				<div class="hp-left"><div value="100" class="hp-leftbg"></div></div>
				<div class="hp-right"><div value="50" class="hp-rightbg"></div></div>
				<img class="vs" src="img/vs.png"/>
			</div>
			<!-- 人物对话 -->
			<div class="talk-box" style="cursor:pointer">
			    <div class="djbox"><img class="dj" src="img/dj/13.png"/><p>点击进行</p></div>
				<img id="image_left" class="work-people big" src="/Upload/student/<%=GetSavePath() %>/正常.png"/>
				<img id="image_right" class="kh-people small" runat="server" src="img/people/客户/kh1-dh.png"/>
				<div class="talk-name work-talk-name">我</div>
				<div class="talk-name kh-talk-name">客户</div>	
				<div class="talk">
					<ul>
						<li class="clear"><p id="wo_html" class="work">游戏开始啦，点击这里继续~</p></li>
						<li class="clear" style="display:none"><p id="kehu_html" class="kh" style="text-align:left">好的</p></li>
					</ul>
				</div>
			</div>
            <!-- 弹幕 -->
			<%--<div class="danmu"><img id="danmu_image" src="img/GIF/Nose-Steam.gif"/><p id="danmu_content">恭喜，客户心情+10%</p></div>--%>
			<!-- 对话选择 -->
			<div class="talk-select">		
				<div class="talk-select-cont">
					<ul id="select_html">
						<%--<li class="clear">
							<div class="select-k"><i class="iconfont icon-duigou"></i></div>
							<p>A、我查询到您近期套内流量基本不够用，您办理新政策后，在没有宽带覆盖的地方也可以放心使用流量了，60GB基本可以满足您的日常使用需求，而且您每个月也仅需多花费几块钱</p>
						</li>--%>
					</ul>
				</div>
				<div class="talk-select-btn"><div class="confirm" id="confirm_btn"><img src="img/pop/确认1.png"/></div></div>
			</div>
			<!-- 左右按钮 -->
			<div class="btn-box">
				<a class="btn-left1"><img src="img/介绍.png"/></a>
				<a class="btn-left2"><img src="img/资源.png"/></a>
				<a class="btn-left3 chat"><img src="img/聊天记录.png"/></a>
				<a class="btn-right1"><img src="img/客户.png"/></a>
				<a class="btn-right2"><img src="img/产品.png"/></a>
				<a class="btn-right3"><img src="img/触点.png"/></a>
			</div>
			<!-- ！介绍 -->
			<div class="intro-popbox" style="display: none">
				<div class="ck">
					<div class="pop animated" style="display: block">
						<img class="pop-tit" src="img/pop/场景介绍.png"/>
						<div class="pop-content cont1">
							<%--<div ><img src="img/背景/缩略图/1.jpg"/></div>--%>
                            <div >
                                <%--<img src="img/背景/缩略图/1.jpg"/>--%>
				                <div class="gkbtn" style="position:relative;top:0px;left:60px">
					                <a>
						                <img class="gkrw" id="scene_image" runat="server" src="img/gkrw/gkr1.png"/>
                                        <h1 id="scene_index" runat="server">01</h1>
						                <div class="numbers"><h2 class="ks" id="scene_name" runat="server">&nbsp;&nbsp;情景二二<br>二二二二</h2></div>						                       
					                </a>
				                </div>
                            </div>
							<div id="scene_html" runat="server">
								<p>你将要模拟接待一位客户，场景中左侧为此场景说明，产品优惠仓库，右侧为客户基本信息，已办理业务。通过选择合适的对话，以及适当的产品来打动你的客户。</p>
								<p><strong>如果客户的满意度为100，即为通过测试。如果你的血量为0，客户的仍未满意，即为测试失败。</strong></p>
							</div>
						</div>
						<div class="popbtn"><div class="close"><img src="img/pop/关闭.png"/></div></div>
					</div>
				</div>
			</div>
			<!-- 资源弹框 -->
			<div class="ck-box">
				<div class="ck">
					<ul class="ck-btn clear"><li class="active">优惠卡</li></ul>
					<div id="resources_html" runat="server" class="ck-cont">
						<%--<div class="ck-cont-card active">
							<h1>8</h1>
							<p>8折卡</p>
							<img class="dg" src="img/pop/对勾.png"/>
						</div>--%>
					</div>
					<div class="ck-bottom">
						<div id="ziyuan" class="confirm"><img src="img/pop/确认.png"/></div>
						<div class="cancel"><img src="img/pop/取消.png"/></div>
					</div>
				</div>
			</div>			
			<!-- 聊天记录 -->
			<div class="chat-box">
				<div class="chat-panel">
					<div class="chat-close"></div>
					<div class="chat-cont">
						<ul id="jilu_html">
							<%--<li class="chat-cont-r clear">
								<div class="face-right"><img src="img/people/客服女1/头像.jpg" /></div>
								<div class="face-right-cont"><div class="name">我的名字</div><p class="cont-pop cont-pop2">你好，我是xxxxx，来商量商量商量</p></div>
							</li>--%>
						</ul>
					</div>
				</div>
			</div>						
			<!-- ！客户画像 -->
			<div class="kehu-popbox" style="display: none">
				<div class="ck">
					<div class="pop animated" style="display: block">
						<img class="pop-tit" src="img/pop/客户画像.png"/>
						<div class="pop-content cont2">
							<div><img id="member_image1" runat="server" src="img/people/客户/kh1-hx.jpg"/></div>
							<div class="table-box">
								<table class="table table-borderd">
                                    <tbody id="member_html" runat="server">
									    <%--<tr>
										    <td><span class="iconfont icon-name"></span>&nbsp;姓名:张三</td>
										    <td><span class="iconfont icon-nianling"></span>&nbsp;年龄:25岁</td>
									    </tr>--%>
                                    </tbody>
								</table>
							</div>
						</div>
						<div class="popbtn"><div class="close"><img src="img/pop/关闭.png"/></div></div>
					</div>
				</div>
			</div>
			<!-- ！产品选择 -->
			<div class="product-popbox" style="display: none">
				<div class="ck">
					<div class="pop"style="display: block">
						<img class="pop-tit" src="img/pop/产品.png"/>
                        <div class="normal-layer" style="display:none">
							<div class="layer-cont"><p class="p2"></p></div>
							<div class="close1"><img src="img/pop/关闭1.png"/></div>
						</div>
						<div class="pop-content cont3" id="produce_html" runat="server">
							<%--<div class="cont3-card">
								<div class="cont3-card-name">
									<img src="img/pop/logobg.png"/>
									<h3>套餐一</h3>
								</div>
								<div class="cont3-card-text">
									<p>500分通话</p>
									<p>40GB流量</p>
									<p>电视盒子免费送</p>
									<p>千兆流量</p>
									<p>千兆流量</p>
								</div>
								<img style="position: absolute;right: 0;top: 78px" src="img/pop/已选.png"/>
							</div>--%>
						</div>
						<div class="popbtn"><div class="close"><img src="img/pop/关闭.png"/></div></div>
					</div>
				</div>
			</div>
			<!-- ！触点 -->
			<div class="cd-popbox" style="display: none">
				<div class="ck">
					<div class="pop"style="display: block">
						<img class="pop-tit" src="img/pop/触点.png"/>
						<div class="pop-content cont4">
							<div class="cont4-card">
								<img id="place_image" runat="server" src="img/背景/缩略图/1.jpg"/>
								<h5 id="place_name" runat="server">触点一</h5>								
							</div>
						</div>
						<div class="popbtn"><div class="close"><img src="img/pop/关闭.png"/></div></div>
					</div>
				</div>
			</div>
			<!-- 退出提示框 -->
			<div class="back-box">
				<div class="back-boximg">
					<div class="confirm"></div>
					<div class="cancel"></div>
				</div>				
			</div>
			<!-- 失败复活选择 -->
			<div class="fuhuo-popbox" style="display:none">
				<div class="normal-layer fuhuo">
					<div class="layer-cont"><p class="p2" style="text-align: center;font-size: 36px;">很遗憾您失败了，是否去学习复活一次？</p></div>
					<div class="popbtn" style="top: 250px;">
						<div class="confirm"><img src="img/pop/学习.png"/></div>
						<div class="cancel"><img src="img/pop/结算.png"/></div>							
					</div>
				</div>
				<div class="ck study-box" style="display: none;">
					<div class="pop"style="display: block;">
						<img class="pop-tit" src="img/学习资料.png"/>
						<div class="pop-content message"><ul><%=GetLearns() %></ul></div>	
						<div class="popbtn" id="fuhuo_popbtn" style="display: none;">
							<%--<div class="confirm"><img src="img/pop/确认.png"/></div>--%>
							<div onclick="$('.fuhuo-popbox').hide();$('.study-contbg').hide();" class="cancel"><img src="img/pop/取消.png"/></div>		
						</div>
					</div>
				</div>
			</div>
            <!-- 学习资料内容 -->
			<div class="study-contbg">
				<div class="study-cont">
                    <div style="position:absolute;top:5px;right:10px;font-size:18px;color:red">学习 <span id="study_time1">？</span> 秒后关闭</div>
					<h3 id="title">学习资料一</h3>
					<p id="time" class="time"><small>发布时间：2023-9-6</small></p>
                    <p><iframe id="iframe" name="iframe" src="learn2.aspx" frameborder="0" class="admin-iframe" style="width:100%;height:100%"></iframe></p>
				</div>
				<%--<div class="study-close"><img src="img/pop/关闭.png"/></div>--%>
			</div>
		    <div class="footer1 animated slideInUp"><a class="back"><div class="iconfont icon-return"></div></a></div>
        </div>
        <script type="text/javascript">
            //开场效果
            $(window).ready(function ()
            {
                document.getElementById("video1").play();
                document.getElementById("video2").play();
                document.getElementById("video3").pause();
                var interval1 = setInterval(function ()
                {
                    if (document.getElementById("video1").paused)
                    {
                        document.getElementById("video3").play();
                        $(".video-box").remove();
                        clearInterval(interval1);
                    }
                }, 300);
            });
            //规则
            $('.guize').click(function () { sound111(); $('.guize-layer').slideDown() })
            $('.guize-layer .close').click(function () { sound111(); $('.guize-layer').slideUp() })
            //产品
            //$(".cont3-card-ul .look a").click(function () { $(".layer-cont .p2").html($(this).attr("value")); $(".normal-layer").fadeIn(); });
            $('.normal-layer .close1').click(function () { sound111(); $(".normal-layer").fadeOut(); });

            //弹幕
            //$(".danmu").css({ 'animation': '', '-webkit-animation': '' })
            //$(".danmu").css({ 'animation': 'move0 12s linear ', '-webkit-animation': 'move0 12s linear ' })
            // 序列帧动画
            var enteranimet, num = 1;
            enteranimet = setInterval(function () { num == 22 ? num = 1 : num++; $(".djbox img").attr('src', 'img/dj/' + num + '.png') }, 80);

            // 对话选择
            //$(".talk-select-cont li").click(function ()
            //{
            //	$(this).addClass('active').siblings().removeClass('active');
            //	$(this).find('.select-k i').css("display", "block");
            //	$(this).siblings().find('.select-k i').css("display", "none");
            //})
            //$('.talk-select-btn .close').click(function () { $('.talk-select').fadeOut() })
            // 介绍
            $(".btn-left1").click(function () { sound111(); $(".intro-popbox").fadeIn() })
            $(".intro-popbox").find('.close').click(function () { sound111(); $(".intro-popbox").fadeOut() })
            // 资源
            $(".ck-btn li").click(function ()
            {
                sound111();
                $(this).addClass('active').siblings().removeClass('active');
                $('.ck-cont').hide().eq($(this).index()).fadeIn()
            })
            $(".ck-cont-card").click(function ()
            {
                sound111();
                $(this).addClass('active').siblings().removeClass('active');
                $(".ck-cont-card").find('.dg').hide();
                $(this).find('.dg').show()
            })
            //$(".ck-cont-card.active").find('.dg').show()
            //资源取消
            $(".ck-bottom .cancel").click(function () { sound111(); $(".ck-box").fadeOut() })
            $('.ck-cont').hide().eq(0).fadeIn()
            $(".btn-left2").click(function () { sound111(); $(".ck-box").fadeIn(); })
            // 聊天记录
            $(".chat").click(function () { sound111(); $(".chat-box").fadeIn() })
            $('.chat-close').click(function () { sound111(); $(".chat-box").fadeOut() })
            // 客户画像
            $(".btn-right1").click(function () { sound111(); $(".kehu-popbox").fadeIn() })
            $(".kehu-popbox").find('.close').click(function () { sound111(); $(".kehu-popbox").fadeOut() })
            // 产品选择
            $(".btn-right2").click(function () { sound111(); $(".product-popbox").fadeIn() })
            $(".product-popbox").find('.close').click(function () { sound111(); $(".product-popbox").fadeOut() })
            // 触点
            $(".btn-right3").click(function () { sound111(); $(".cd-popbox").fadeIn() })
            $(".cd-popbox").find('.close').click(function () { sound111(); $(".cd-popbox").fadeOut() })
            // 返回
            $(".back").click(function () { sound111(); $(".back-box").fadeIn(); })
            $(".back-boximg .confirm").click(function () { sound111(); window.location.href = "list.aspx" })
            $(".back-boximg .cancel").click(function () { sound111(); $(".back-box").fadeOut(); })
            //$(".talk").click(function () { $(".talk-select").fadeIn() })
            //复活弹窗切换
            $('.fuhuo .confirm').click(function () { $(".fuhuo").css("display", "none"); $(".study-box").css("display", "block") });
            $('.fuhuo .cancel').click(function () { $(".fuhuo-popbox").css("display", "none"); game1.result_go("失败"); });
            $(".study-sub").click(function () { $(".study-contbg").slideDown() });
            $('.study-close').click(function () { $(".study-contbg").slideUp() });
            //学习资料
            $(".message ul li").click(function ()
            {
                $("#title").html($(this).attr("title"));
                $("#time").html("发布时间：" + $(this).attr("time"));
                $("#content").html($(this).attr("content"));

                $("#iframe").attr("src", "learn2.aspx?id=" + $(this).attr("id"));
                $(".study-contbg").slideDown();

                setStudyTime(10);
            });
            //$('.study-close').click(function () { $(".study-contbg").slideUp(); })
            var study_time1, study_count = 1, study_interval;
            function setStudyTime(time)
            {
                $("#study_time1").html(study_time1 = time);
                study_interval = setInterval(function ()
                {
                    study_time1--;
                    if (study_time1 <= 0)
                    {
                        clearInterval(study_interval);
                        study_interval = null;

                        //game1.is_time1 = true;
                        game1.setPoint1(10);
                        $("#fuhuo_popbtn").show();
                        $(".study-contbg").slideUp();
                        //达到最大次数
                        study_count--;
                        if (study_count <= 0)
                        {
                            $(".fuhuo-popbox").hide();
                        }
                    }
                    else
                    {
                        $("#study_time1").html(study_time1);
                    }
                }, 1000);
            }
		</script>
        <script type="text/javascript" src="/Admin/js/harry/harry.ajax.js"></script>
        <script type="text/javascript">
		    function shuffle(arr){var length=arr.length,rIndex,temp;while(length){rIndex=Math.floor(Math.random()*(length--));temp=arr[rIndex];arr[rIndex]=arr[length];arr[length]=temp;}return arr;}
            function random(lower, upper) { return Math.floor(Math.random() * (upper - lower + 1)) + lower; }
		    function yiwei(val1) { return Math.floor(val1 * 10) / 10; }
            function dialog(id, type,result, c1, r1, t1, c2, r2, t2, c3, r3, t3, c4, r4, t4, c5, r5, t5)
            {
                this.id = id;           //编号
                this.type = type;       //类型：对话、选择
                this.result = result;   //类型：对话、选择
                this.c1 = c1 || "";     //内容1
                this.r1 = r1 || "";     //回复1
                this.p1 = p1 || "";     //分数1
                this.c2 = c2 || "";     //内容2
                this.r2 = r2 || "";     //回复2
                this.p2 = p2 || "";     //分数2
                this.c3 = c3 || "";     //内容3
                this.r3 = r3 || "";     //回复3
                this.p3 = p3 || "";     //分数3
                this.c4 = c4 || "";     //内容4
                this.r4 = r4 || "";     //回复4
                this.p4 = p4 || "";     //分数4
                this.c5 = c5 || "";     //内容5
                this.r5 = r5 || "";     //回复5
                this.p5 = p5 || "";     //分数5
            }
            function Game(d)
            {
                var self = this;

                this.dialogs = d;   //对话集合
                this.now = 0;       //对话标记
                this.rounds = 0;    //对话轮数
                this.itemCount1 = "<%=itemCount %>";    //道具总数
                this.itemCount2 = 0;                    //道具已使用数

                this.point1 = $(".hp-leftbg");  //血量
                this.point2 = $(".hp-rightbg"); //情绪值
                this.point3 = $("#point3_p");   //得分
                this.left = $("#wo_html");      //对话框-左
                this.right = $("#kehu_html");   //对话框-右
                this.select = $("#select_html");//选择
                this.time1 = $("#time1");       //计时器

                this.states = ["愤怒_客户很生气喽","生气_客户有点不爽啦","一般_客户心情不好也不坏噢","开心_客户心情不错","喜欢_客户很开心哦","喜欢_客户很开心哦"];
                this.headImage = "/Upload/student/<%=GetSavePath() %>/头像.jpg";

                this.is_select = false; //是否在选择
                this.is_talk = false;   //是否在打字
                //this.is_end = false;  //是否结束
                this.is_time1 = true;   //是否继续计时
                this.is_study = false;  //是否已学习
                this.is_fly = false;    //是否已经弹幕

                var _time1 = 0,_time2 = "<%=time1 %>";
                var _p_point = 0;       //产品部分得分
                //计时器
                this.setTime1 = function()
                {
                    _time1 -= 0; _time2 -= 0;
                    setInterval(function()
                    {
                        //if(self.is_time1) { _time2--; }
                        _time2--;
                        if(_time2<=0){self.result_go("失败");}
                        else
                        {
                            _time1++;
                            self.time1.html(_time2);
                        }
                    },1000);
                };
                //弹幕
                this.fly = function(tag,content)
                {
                    if(self.is_fly){return;}
                    if(tag == "成功" || tag == "失败" || tag == "天使"){self.is_fly = true;}
                    $(".bg1").append($("<div class='danmu' style='left:2100px;top:"+random(200,800)+"px'><img id='danmu_image' src='/Upload/game/bq/" + (tag || "一般") + ".gif'/><p id='danmu_content'>"+(content||"")+"</p></div>").animate({left: "-500px" }, (random(10,20)) * 1000, function () {  $(this).remove();}));
                };
                //设置血量
                this.setPoint1 = function (p)
                {
                    var value = self.point1.attr("value") - -p;
                    self.point1.attr("value", value).animate({ width: value + "%" }, 1000, function () { });

                    if (value > 100) { value = 100; }
                    else if (value <= 30 && value > 20) { self.fly("血量","你的血量还有 "+value+"%，不多了哦~"); }
                    else if (value <= 20 && value > 10) { self.fly("血量","你的血量还有 "+value+"%，不多了哦~"); }
                    else if (value <= 10 && value > 0) { self.fly("血量","你的血量还有 "+value+"%，不多了哦~"); }
                    if (value <= 0)
                    {
                        if(self.is_study){self.result_go("失败");}
                        else
                        {
                            self.is_study = true;
                            self.is_time1 = false;
                            $(".fuhuo-popbox").show();
                        }
                        return;
                    }
                };
                //设置情绪值
                this.setPoint2 = function (p)
                {
                    var value = self.point2.attr("value") - -p;if (value > 100) { value = 100; }if (value < 0) { value = 0; }
                    self.point2.attr("value", value).animate({ width: value + "%" }, 1000, function () { });
                    //弹幕
                    var _range = Math.floor(value/20) - 0,_image = $("#<%=image_right.ClientID %>"),_src = _image.attr("src").replace("--1","--").replace("--2","--");
                    if(_range == 2){ _image.attr("src",_src.replace("--1","--").replace("--2","--")); }
                    else
                    {
                        var _state = self.states[_range].split("_");
                        self.fly(_state[0],_state[1]);
                        //切换表情
                        if(_range > 2){_image.attr("src",_src.replace("--","--1").replace("--2","--1"));}
                        else{_image.attr("src",_src.replace("--","--2").replace("--1","--2"));}
                    }
                };
                //设置得分
                this.setPoint3 = function(p)
                {
                    var value = self.point3.attr("value") - -p;//当前分
                    self.point3.attr("value",value).html(value);
                    //产品部分得分
                    if(self.rounds>4){_p_point+=value-0;}

                    //组队实时信息
                    var cqf = "<%=levPoint %>";//场景评价
                    var point_all = self.dialogs.length*5;//总分
                    var pingjia = yiwei(value/point_all*cqf);
                    //实时记录得分
                    var rid = "<%=rid %>", did = "<%=did %>";
                    if(rid != "" && did != "" && (p - 0) > 0)
                    {
                        var ajax = new Ajax("/Member/index.aspx");
                        ajax.onCom = function (r) { }
                        ajax.start("at=room_addPoint&rid="+rid+"&did="+did+"&point=" + pingjia);
                    }
                };
                //设置对话内容
                this.interval1 = null; this.content1 = ""; this.content2 = "";
                this.setDialog = function(log1, log2)
                {
                    var left = $("#image_left"), right = $("#<%=image_right.ClientID %>");
                    //设置左图片
                    left.removeClass("small").addClass("big");right.removeClass("big").addClass("small");
                    //设置内容
                    self.content1 = "我：" + log1;
                    self.content2 = "客户：" + log2;
                    //清空内容
                    self.left.html("");
                    self.right.html("");
                    self.right.parent().hide();
                    self.interval1 = setInterval(function()
                    {
                        document.getElementById("audio22").play();
                        if(self.content1.length > 0)
                        {
                            var c1 = self.left.html();
                            c1 += self.content1.substring(0,1);
                            self.content1 = self.content1.substring(1);
                            self.left.html(c1);
                        }
                        else
                        {
                            //设置右图片
                            left.removeClass("big").addClass("small");right.removeClass("small").addClass("big");
                            self.right.parent().show();
                            if(self.content2.length > 0)
                            {
                                var c2 = self.right.html();
                                c2 += self.content2.substring(0,1);
                                self.content2 = self.content2.substring(1);
                                self.right.html(c2);
                            }
                            else
                            {
                                self.is_talk = false;
                                self.interval1 = null;
                                clearInterval(self.interval1);
                                document.getElementById("audio22").pause();
                                //if(self.now == self.dialogs.length && !self.is_end)
                                //{
                                //    self.is_end = true;
                                //    self.result_go("成功");
                                //}
                            }
                        }
                    },60);
                };
                //跳转结果页
                this.result_go = function(type)
                {
                    self.fly("天使","游戏结束了哦，3 秒后进入结算页面啦~");
                    $(".ck-box").show().children().hide();
                    
                    var reg_sole = "<%=reg_sole %>";
                    if(reg_sole!="")
                    {
                        var ajax = new Ajax("/Member/index.aspx");
                        var p1 = "<%=percent_produce1 %>", p2 = "<%=percent_produce2 %>"; if(p1 - 0 == 0){type = "失败";}if(_p_point == 0){type ="失败";}
                        var point_all = self.dialogs.length*5, point_now = self.point3.attr("value"), qingxu = self.point2.attr("value");
                        ajax.onCom = function (r)
                        {
                            setTimeout(function()
                            {
                                location.href = "result"+(type == "成功"? "1" : "2")+".aspx?rid=<%=rid %>&did=<%=did %>&cqp=<%=levPoint %>&all="+point_all+"&now="+point_now+"&qingxu="+qingxu+"&p1="+(p2 == 0 ? 0 : p1 / p2)+"&p2=" + "<%=percent_place %>";//总分、当前得分、情绪值、产品正确率、触点正确率
                            },3000);
                        }
                        ajax.start("at=reg_add&rs="+reg_sole+"&r="+type+"&v1="+self.point1.attr("value")+"&v2="+qingxu+"&v3="+point_all+"&v4="+point_now+"&v7="+_time1+"&v8="+(p2 == 0 ? 0 : p1 / p2)+"&v9=<%=percent_place %>");
                    }
                    //setTimeout(function()
                    //{
                    //    //alert("产品正确数："+p1+"，产品总数" + p2);
                    //    var p1 = "<%=percent_produce1 %>", p2 = "<%=percent_produce2 %>"; if(p1 - 0 == 0){type = "失败";}
                    //    var point_all = self.dialogs.length*5, point_now = self.point3.attr("value"), qingxu = self.point2.attr("value");
                    //    location.href = "result"+(type == "成功"? "1" : "2")+".aspx?rid=<%=rid %>&did=<%=did %>&cqp=<%=levPoint %>&all="+point_all+"&now="+point_now+"&qingxu="+qingxu+"&p1="+(p2 == 0 ? 0 : p1 / p2)+"&p2=" + "<%=percent_place %>";//总分、当前得分、情绪值、产品正确率、触点正确率
                    //},3000);
                };
                //下一个内容
                this.next = function ()
                {
                    self.is_select = true;
                    if(self.now > self.dialogs.length){ self.result_go("成功"); }
                    else
                    {
                        self.setPoint1(-5);

                        var data = self.dialogs[self.now]; self.now++;
                        //清空之前的选择项
                        self.select.html("");
                        var html = [];
                        if (data[1] != "") { html.push("<li result='"+data[0]+"' class='clear' replay='" + data[2] + "' point ='" + data[3] + "' title ='" + data[3] + "'><div class='select-k'><i class='iconfont icon-duigou'></i></div><p>" + data[1] + "</p></li>");}
                        if (data[4] != "") { html.push("<li result='"+data[0]+"' class='clear' replay='" + data[5] + "' point ='" + data[6] + "' title ='" + data[6] + "'><div class='select-k'><i class='iconfont icon-duigou'></i></div><p>" + data[4] + "</p></li>");}
                        if (data[7] != "") { html.push("<li result='"+data[0]+"' class='clear' replay='" + data[8] + "' point ='" + data[9] + "' title ='" + data[9] + "'><div class='select-k'><i class='iconfont icon-duigou'></i></div><p>" + data[7] + "</p></li>");}
                        if (data[10] != "") { html.push("<li result='"+data[0]+"' class='clear' replay='" + data[11] + "' point ='" + data[12] + "' title ='" + data[12] + "'><div class='select-k'><i class='iconfont icon-duigou'></i></div><p>" + data[10] + "</p></li>");}
                        if (data[13] != "") { html.push("<li result='"+data[0]+"' class='clear' replay='" + data[14] + "' point ='" + data[15] + "' title ='" + data[15] + "'><div class='select-k'><i class='iconfont icon-duigou'></i></div><p>" + data[13] + "</p></li>");}
                        html = shuffle(html);
                        for(var i=0;i<html.length;i++){self.select.append($(html[i]));}

			            $(".talk-select-cont li").click(function()
                        {
            	            $(this).addClass('active').siblings().removeClass('active');
            	            $(this).find('.select-k i').css("display", "block");
            	            $(this).siblings().find('.select-k i').css("display", "none");
			            })
                        $(".talk-select").fadeIn();
                    }
                };
                //初始化
                (this.init = function ()
                {
                    self.setPoint1(0); self.setPoint2(0); self.setPoint3(0);
                    self.setTime1();
                    $("#confirm_btn").click(function()
                    {
                        self.is_select = false;
                        //关闭选择框
                        $('.talk-select').fadeOut();

                        var check1 = $("#select_html").find(".select-k i:visible").parent().parent();
                        //设置情绪值、得分
                        var result = check1.attr("result"), point = check1.attr("point") - 0;
                        //alert(result);
                        if(result == "正确")
                        {
                            if(point == 5) { self.setPoint2(5); self.setPoint3(5); }
                            else if(point == 4) { self.setPoint2(0); self.setPoint3(4); }
                            else { self.setPoint1(-10);self.setPoint2(-5); } 
                        }

                        var log1 = check1.find("p").eq(0).html().replace("1、","").replace("2、","").replace("3、","").replace("4、","").replace("5、","");
                        var log2 = check1.attr("replay");
                        //设置对话
                        self.is_talk = true;
                        self.setDialog(log1, log2);
                        //设置聊天记录
                        $("#jilu_html").append($("<li class='chat-cont-r clear'><div class='face-right'><img src='"+self.headImage+"' /></div><div class='face-right-cont'><div class='name'>我</div><p class='cont-pop cont-pop2'>"+log1+"</p></div></li>"));
                        $("#jilu_html").append($("<li class='chat-cont-l clear'><div class='face-left'><img src='"+($("#<%=member_image1.ClientID %>").attr("src").replace("-.png",".jpg"))+"' /></div><div class='face-left-cont'><div class='name'>客户</div><p class='cont-pop cont-pop1'>"+log2+"</p></div></li>"));

                        //轮数+1
                        self.rounds++;
                        //if(self.now == self.dialogs.length){self.result_go("成功");}
                    });
                    $('.talk-box').click(function () //talk
                    {
                        if(self.now > self.dialogs.length){ self.result_go("成功"); }
                        if(self.is_select == false && self.is_talk == false)
                        {
                            self.next();
                            sound111();
                            $(".djbox").remove();
                        }
                    });
                    //资源回血
                    $(".ck-bottom .confirm").click(function()
                    {
                        if(self.itemCount2>self.itemCount1){self.fly("哭泣","已使用"+self.itemCount2+"次，超过使用数量了噢~");$("#ziyuan").hide();return;}
                        var _checked = $(".ck-cont").find("div.active");
                        if(_checked.length > 0)
                        {
                            self.itemCount2++;
                            var _c = $(_checked[0]);
                            var point1 = _c.attr("point1") - 0;if(point1){self.setPoint1(point1);}
                            var point2 = _c.attr("point2") - 0;if(point2){self.setPoint2(point2);}
                            $(".ck-box").fadeOut();
                        }
                    });
                })();
            }
            var datas = [], dialogs = [];
            <%=date.ToString() %>
            var game1 = new Game(datas);
		    function sound111() { document.getElementById("audio11").play(); }
        </script>
        <audio id="video3" autoplay="autoplay" loop="loop" preload="auto"><source src="img/music/2.mp3"></audio>
        <audio id="audio11"><source src="/Upload/sound/点击1.mp3"></audio>
        <audio id="audio22"><source src="/Upload/sound/打字1.wav"></audio>
    </form>
</body>
</html>