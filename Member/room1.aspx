<%@ Page Language="C#" AutoEventWireup="true" CodeFile="room1.aspx.cs" Inherits="Member_room1" %>

<!DOCTYPE html>
<html style="touch-action:none;">
<head runat="server">
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0" />
	<title></title>
    <link rel="stylesheet" href="css/normalize.css">
	<link rel="stylesheet" href="css/animate.min.css">
	<link rel="stylesheet" href="css/swiper.min.css">
	<link rel="stylesheet" href="css/base.css">	
	<link rel="stylesheet" href="css/style.css">
</head>
<body class="animated fadeIn" style="" oncontextmenu="return false" onselectstart="return false" ondragstart="return false;" ondragend="return false;" onbeforecopy="return false" oncopy="document.selection.empty()" onselect="document.selection.empty()">
    <form id="form1" runat="server">
        <div class="bg">	
			<div class="bgblack">
                <!-- 计时 -->
				<div class="time-box" style="left: 1200px;background: none;z-index: 999;"><span>倒计时：</span><span class="sj"><%=time %></span><span>s</span></div>
			    <div class="room-left animated slideInLeft">
				    <h3 class="tit">场景介绍</h3>
				    <div class="room-leftcont">
					    <%--<img src="img/背景/缩略图/1.jpg"/>--%>
				        <div class="gkbtn" style="position:relative;top:0px;left:60px">
						    <img class="gkrw" id="scene_image" runat="server" src="img/gkrw/gkr1.png"/>
                            <h1 id="scene_index" runat="server" style="padding:20px">01</h1>
						    <div class="numbers" style="margin-top:30px"><h2 class="ks" id="scene_name" runat="server" style="width:160px">&nbsp;&nbsp;情景二二<br>二二二二</h2></div>
				        </div><br />
					    <p id="scene_intro" runat="server">场景简介</p>
				    </div>
			    </div>
			    <div class="room-right animated slideInRight">
				    <h3 class="tit">房间人员</h3>
                    <div id="list_html">
				        <%--<div class="room-cont people1">
					        <img  src="img/房间/nan1.png"/>
					        <div style="margin-left: -30px;">
						        <h3 class="room-cont-name">你的名字 </h3>
						        <p class="room-cont-zt">状态：<span class="green">已完成</span>&nbsp;&nbsp;得分：<span class="fen">100</span></p>
						        <img class="room-jp" src="img/uiimg_icon_ranking_1.png"/>
					        </div>
				        </div>
				        <div class="room-cont people2">
					        <img  src="img/房间/nan2.png"/>
					        <div>
						        <h3 class="room-cont-name">你的名字 </h3>
						        <p class="room-cont-zt">状态：<span>未开始</span>&nbsp;&nbsp;得分：<span class="fen">0</span></p>
						        <img class="room-jp" src="img/uiimg_icon_ranking_2.png"/>
					        </div>
				        </div>
				        <div class="room-cont people3">
					        <img  src="img/房间/nv1.png"/>
					        <div>
						        <h3 class="room-cont-name">你的名字 </h3>
						        <p class="room-cont-zt">状态：<span class="red">未完成</span>&nbsp;&nbsp;得分：<span class="fen">0</span></p>
						        <img class="room-jp" src="img/uiimg_icon_ranking_3.png"/>
					        </div>
				        </div>
				        <div class="room-cont people4">
					        <img  src="img/房间/nv2.png"/>
					        <div>
						        <h3 class="room-cont-name">你的名字 </h3>
						        <p class="room-cont-zt">状态：<span class="green">已完成</span>&nbsp;&nbsp;得分：<span class="fen">100</span></p>
						        <img class="room-jp" src="img/uiimg_icon_ranking_4.png"/>
					        </div>
				        </div>
				        <div class="room-cont people5">
					        <img  src="img/房间/nv3.png"/>
					        <div>
						        <h3 class="room-cont-name">你的名字 </h3>
						        <p class="room-cont-zt">状态：<span class="green">已完成</span>&nbsp;&nbsp;得分：<span class="fen">100</span></p>
						        <img class="room-jp" src="img/uiimg_icon_ranking_5.png"/>
					        </div>
				        </div>
				        <div class="room-cont people6">
					        <img  src="img/房间/nan3.png"/>
					        <div>
						        <h3 class="room-cont-name">你的名字 </h3>
						        <p class="room-cont-zt">状态：<span class="green">已完成</span>&nbsp;&nbsp;得分：<span class="fen">100</span></p>
						        <img class="room-jp" src="img/uiimg_icon_ranking_6.png"/>
					        </div>
				        </div>--%>
                    </div>
			    </div>
			    <img class="room-center" src="img/房间/答题房间标题.png"/>
			    <div class="sure"><a onclick="kaishi()"><img src="img/房间/开始1.png"/></a></div>
			    <div class="off"><a onclick="tuichu()"><img src="img/房间/取消1.png"/></a></div>
                <div class="toggle"><img src="img/房间/切换场景.png"/></div>
                <!-- 普通弹框 -->
			    <div class="back-box" id="tishi0">
				    <div class="normal-layer">
					    <div class="layer-cont"><p class="p2" id="tishi0_content" style="text-align: center;font-size: 36px">是否要真的退出？</p></div>
					    <div class="popbtn" style="top: 250px;cursor:pointer" onclick="$('#tishi0').hide()"><div class="close"><img src="img/pop/关闭.png"/></div></div>
				    </div>
				</div>
			    <div class="back-box" id="tishi1">
				    <div class="normal-layer">
					    <div class="layer-cont"><p class="p2" style="text-align: center;font-size: 36px;">确认开始游戏？</p></div>
					    <div class="popbtn" style="top: 250px;">
						    <div class="confirm" style="cursor:pointer" id="tishi1_btn"><img src="img/pop/确认.png"/></div>						
						    <div class="close" style="cursor:pointer" onclick="$('#tishi1').hide()"><img src="img/pop/关闭.png"/></div>							
					    </div>
				    </div>
				</div>
			    <div class="back-box" id="tishi2">
				    <div class="normal-layer">
					    <div class="layer-cont"><p class="p2" style="text-align: center;font-size: 36px;">确认关闭房间？</p></div>
					    <div class="popbtn" style="top: 250px;">
						    <div class="confirm" style="cursor:pointer" id="tishi2_btn"><img src="img/pop/确认.png"/></div>						
						    <div class="close" style="cursor:pointer" onclick="$('#tishi2').hide()"><img src="img/pop/关闭.png"/></div>							
					    </div>
				    </div>
				</div>
                <!-- 切换场景 -->
				<div class="toggle-box" style="display:none">
					<div class="toggle-panel">
						<img src="img/房间/切换.png"/>
						<div class="toggle-content">
							<div class="form-div">
								<div class="form-tit">场景选择：</div>
								<div class="label_box">
									<label><input type="radio" value="个人" name="type" checked="checked"><div>个人场景</div></label>
									<label><input type="radio" value="家庭" name="type"><div>家庭场景</div></label>
									<label><input type="radio" value="集团" name="type"><div>集团场景</div></label>
								</div>
							</div>
							<div class="form-div">
								<div class="form-tit">难度选择：</div>
								<div class="label_box">
									<label><input type="radio" value="简单" name="mode" checked="checked"><div>简单模式</div></label>
									<label><input type="radio" value="中级" name="mode"><div>中级模式</div></label>
									<label><input type="radio" value="困难" name="mode"><div>困难模式</div></label>
								</div>
							</div>
                            <div id="scenes_html">
							    <%--<div class="toggle-imgbox clear">
								    <div class="gkbtn"><img class="gkrw" src="/Upload/scene/个人/3---.png"/><h1>01</h1><div class="numbers"><h2 class="ks">&nbsp;&nbsp;情景一二三<br>四五六十字</h2></div><img class="bj" src="img/pop/绿色.png"/></div>
								    <div class="gkbtn"><img class="gkrw" src="/Upload/scene/个人/3---.png"/><h1>01</h1><div class="numbers"><h2 class="ks">&nbsp;&nbsp;情景一二三<br>四五六十字</h2></div><img class="bj" src="img/pop/绿色.png"/></div>
                                </div>--%>
                                <%=getScenes() %>
                            </div>
						</div>
						<div class="togglebtn">
							<div class="confirm" id="btn_cjxz"><img src="img/pop/确认.png"/></div>
							<div class="cancel"><img src="img/pop/取消.png"/></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script src="js/jquery-1.11.3.min.js"></script>
		<script src="js/swiper.min.js"></script>
        <script type="text/javascript" src="/Admin/js/harry/harry.ajax.js"></script>
        <script>
            var check_val = "个人_简单";
            $(".label_box").click(function ()
            {
                var val = $("input[name='type']:checked").val() + "_" + $("input[name='mode']:checked").val();
                if (check_val == val) { return; }
                else
                {
                    check_val = val;
                    $("#scenes_html").children().hide();
                    $("#" + check_val).show();
                }
            });
            var sid = "<%=sid %>";
            $("#btn_cjxz").click(function ()
            {
                var produces = $("#scenes_html").find(".bj:visible");
                if (produces.length > 0)
                {
                    var sid = produces.eq(0).parent().attr("id");
                    if (sid && sid != "")
                    {
                        var ajax = new Ajax("/Member/index.aspx");
                        ajax.onCom = function (r)
                        {
                            if (r != "")
                            {
                                var json = $.parseJSON(r);
                                if (json && json.length > 0)
                                {
                                    var s1 = json[0];
                                    $("#<%=scene_image.ClientID %>").attr("src", s1.image4);
                                    var _idx = s1.index1 - 0; if (_idx > 10) { _idx -= 10; } if (_idx > 5) { _idx -= 5; } _idx = "0" + _idx;
                                    $("#<%=scene_index.ClientID %>").html(_idx);
                                    $("#<%=scene_name.ClientID %>").html(s1.name);
                                    $("#<%=scene_intro.ClientID %>").html(s1.intro);
                                    var lev = s1.lev;
                                    if (lev == "简单") { $(".sj").html(180); }
                                    else if (lev == "中级") { $(".sj").html(300); }
                                    else { $(".sj").html(420); }
                                    $('.toggle-box').slideUp();
                                }
                            }
                        }
                        ajax.start("at=scene_change&rid=<%=rid %>&sid=" + sid);
                    }
                }
            });

            $(".toggle-imgbox .gkbtn").click(function ()
            {
                //$(this).find('.bj').css("display", 'block').parents(".gkbtn").siblings().find('.bj').css("display", 'none');
                $('.bj').css("display", 'none');
                $(this).find('.bj').css("display", 'block');
            })
            $('.toggle').click(function () { $('.toggle-box').slideDown(); })
            $('.togglebtn .cancel').click(function () { $('.toggle-box').slideUp() })

            function alert111(content)
            {
                $("#tishi0_content").html(content);
                $("#tishi0").show();
            }
            var is_start = false;
            //游戏开始
            function kaishi()
            {
                if ($("#list_html").children().length == 0) { alert111("没有任何参与者！"); return; }
                $("#tishi1").show();
                $("#tishi1_btn").click(function ()
                {
                    var ajax = new Ajax("/Member/index.aspx");
                    ajax.onCom = function (r) { $("#tishi1").hide(); alert111("游戏已开始！"); is_start = true; }
                    ajax.start("at=room_start&rid=<%=rid %>");
                });
                //if (confirm("确认开始游戏？"))
                //{
                //    var ajax = new Ajax("/Member/index.aspx");
                //    ajax.onCom = function (r) { alert("游戏已开始！"); is_start = true; }
                //    ajax.start("at=room_start&rid=<%=rid %>");
                //}
            }
            //关闭房间
            function tuichu()
            {
                $("#tishi2").show();
                $("#tishi2_btn").click(function ()
                {
                    var ajax = new Ajax("/Member/index.aspx");
                    ajax.onCom = function (r) { history.go(-1); }
                    ajax.start("at=room_close&rid=<%=rid %>");
                });
                //if (confirm("确认关闭房间？"))
                //{
                //    var ajax = new Ajax("/Member/index.aspx");
                //    ajax.onCom = function (r) { history.go(-1); }
                //    ajax.start("at=room_close&rid=<%=rid %>");
                //}
            }
            var yijieshu = false;
            //获取明细
            function getData()
            {
                var ajax = new Ajax("/Member/index.aspx");
                ajax.onCom = function (r)
                {
                    if (r != "")
                    {
                        var state = 0;
                        var json = $.parseJSON(r), list_html = $("#list_html");
                        list_html.html("");
                        if (json.length > 0)
                        {
                            if (json[0].state == "已关闭") { alert111("房间已关闭"); location.href = "index.aspx"; }
                            for (var i = 0; i < json.length; i++)
                            {
                                var p = json[i], html1 = [];
                                html1.push("<div class='room-cont people" + (i + 1) + "'>"); // "+(i==0 ? " style='margin-left:-30px'":"")+"
                                html1.push("	<img  src='/Upload/student/" + p.savePath1 + "/房间.png'/>");
                                html1.push("	<div" + (i == 0 ? " style='margin-left:-30px;'" : "") + ">");
                                html1.push("		<h3 class='room-cont-name'>" + p.name + " </h3>");
                                state += p.state == "已结束" ? 1 : 0;
                                html1.push("		<p class='room-cont-zt'>状态：<span class='green'>" + p.state + "</span>&nbsp;&nbsp;得分：<span class='fen'>" + p.point + "</span></p>");
                                if (is_start)
                                {
                                    html1.push("	<img class='room-jp' src='img/uiimg_icon_ranking_" + (i + 1) + ".png'/>");
                                }
                                html1.push("	</div>");
                                html1.push("</div>");
                                list_html.append($(html1.join("")));
                            }
                        }
                        //alert(state - 0 == json.length);
                        if (json.length > 0 && !yijieshu && state - 0 == json.length)
                        {
                            yijieshu = true; alert111("全部玩家已结束游戏");

                        }
                    }
                }
                ajax.start("at=room_detail&rid=<%=rid %>");
            }
            getData();
            setInterval("getData()", 3000);
        </script>
        <audio autoplay="autoplay" loop="loop" preload="auto"><source src="img/music/1.mp3"></audio>
    </form>
</body>