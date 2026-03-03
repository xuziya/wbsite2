<%@ Page Language="C#" AutoEventWireup="true" CodeFile="room2.aspx.cs" Inherits="Member_room2" %>
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
			<!-- 计时 -->
			<div class="time-box" style="left: 1200px;background: none;z-index: 999;"><span>倒计时：</span><span class="sj"><%=time %></span><span>s</span></div>
			<div class="bgblack">
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
					        <div style="margin-left: -20px;">
						        <h3 class="room-cont-name">你的名字 </h3>
						        <p class="room-cont-zt">状态：<span class="green">已完成</span>&nbsp;&nbsp;得分：<span class="fen">100</span></p>
					        </div>
				        </div>
				        <div class="room-cont people2">
					        <img  src="img/房间/nan2.png"/>
					        <div>
						        <h3 class="room-cont-name">你的名字 </h3>
						        <p class="room-cont-zt">状态：<span>未开始</span>&nbsp;&nbsp;得分：<span class="fen">0</span></p>
					        </div>
				        </div>
				        <div class="room-cont people3">
					        <img  src="img/房间/nv1.png"/>
					        <div>
						        <h3 class="room-cont-name">你的名字 </h3>
						        <p class="room-cont-zt">状态：<span class="red">未完成</span>&nbsp;&nbsp;得分：<span class="fen">0</span></p>
					        </div>
				        </div>
				        <div class="room-cont people4">
					        <img  src="img/房间/nv2.png"/>
					        <div>
						        <h3 class="room-cont-name">你的名字 </h3>
						        <p class="room-cont-zt">状态：<span class="green">已完成</span>&nbsp;&nbsp;得分：<span class="fen">100</span></p>
					        </div>
				        </div>
				        <div class="room-cont people5">
					        <img  src="img/房间/nv3.png"/>
					        <div>
						        <h3 class="room-cont-name">你的名字 </h3>
						        <p class="room-cont-zt">状态：<span class="green">已完成</span>&nbsp;&nbsp;得分：<span class="fen">100</span></p>
					        </div>
				        </div>
				        <div class="room-cont people6">
					        <img  src="img/房间/nan3.png"/>
					        <div>
						        <h3 class="room-cont-name">你的名字 </h3>
						        <p class="room-cont-zt">状态：<span class="green">已完成</span>&nbsp;&nbsp;得分：<span class="fen">100</span></p>
					        </div>
				        </div>--%>
                    </div>
			    </div>
			
			    <img class="room-center" src="img/房间/答题房间标题.png"/>
			    <%--<div class="sure"><img src="img/房间/确认1.png"/></div>--%>
			    <div class="off"><a onclick="likai()"><img src="img/房间/取消1.png"/></a></div>
			</div>
		</div>
		<script src="js/jquery-1.11.3.min.js"></script>
		<script src="js/swiper.min.js"></script>
        <script type="text/javascript" src="/Admin/js/harry/harry.ajax.js"></script>
        <script>
            //离开房间
            function likai()
            {
                if (confirm("确认离开房间？"))
                {
                    var ajax = new Ajax("/Member/index.aspx");
                    ajax.onCom = function (r) { history.go(-1); }
                    ajax.start("at=room_leave&did=<%=did %>");
                }
            }
            function getData()
            {
                //获取房间信息
                getRoomInfo();
                //获取明细
                getDetail();
            }
            var sid = "<%=sid %>";
            function getRoomInfo()
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
                            sid = s1.id;//设置场景id
                            $('.toggle-box').slideUp();
                        }
                    }
                }
                ajax.start("at=scene_change&rid=<%=rid %>");
            }
            //获取明细
            function getDetail()
            {
                var ajax = new Ajax("/Member/index.aspx");
                ajax.onCom = function (r)
                {
                    if (r != "")
                    {
                        var json = $.parseJSON(r), list_html = $("#list_html");
                        list_html.html("");
                        if (json.length > 0)
                        {
                            if (json[0].state == "已关闭") { alert("房间已关闭"); location.href = "index.aspx"; }
                            else if (json[0].state == "已开始") { alert("游戏已开始！"); location.href = "select.aspx?sid=" + sid + "&rid=<%=rid %>&did=<%=did %>"; }
                            for (var i = 0; i < json.length; i++)
                            {
                                var p = json[i], html1 = [];
                                html1.push("<div class='room-cont people" + (i + 1) + "'>");
                                html1.push("	<img  src='/Upload/student/" + p.savePath1 + "/房间.png'/>"); //
                                html1.push("	<div" + (i == 0 ? " style='margin-left: -20px;'" : "") + ">");
                                html1.push("		<h3 class='room-cont-name'>" + p.name + " </h3>");
                                html1.push("		<p class='room-cont-zt'>状态：<span class='green'>" + p.state + "</span>&nbsp;&nbsp;得分：<span class='fen'>" + p.point + "</span></p>");
                                html1.push("	</div>");
                                html1.push("</div>");
                                list_html.append($(html1.join("")));
                            }
                        }
                    }
                    else { alert("房间已关闭"); location.href = "index.aspx"; }
                }
                ajax.start("at=room_detail&rid=<%=rid %>");
            }

            getData();
            setInterval("getData()", 3000);
        </script>
    </form>
        <audio autoplay="autoplay" loop="loop" preload="auto"><source src="img/music/2.mp3"></audio>
</body>
</html>
