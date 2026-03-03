<%@ Page Language="C#" AutoEventWireup="true" CodeFile="select.aspx.cs" Inherits="Member_select" %>
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
        <div class="bg1" style="background:url(/Upload/place/bg/进厅触点.jpg) no-repeat;background-size:cover">
            <div class="video-box"><video id="video1" muted="muted"><source src="/Upload/mp4/选择页.mp4"/></video></div>	
			<!-- 选择弹框 -->
			<div class="select-popbox start">
				<div class="select-pop animated fadeIn">
					<div class="pop-left">
						<div class="pop animated">
							<img class="pop-tit" src="img/pop/场景介绍.png"/>
							<div class="pop-content cont1">
								<div>
                                    <%--<img src="img/背景/缩略图/1.jpg"/>--%>
				                    <div class="gkbtn" style="position:relative;top:0px;left:60px">
					                    <a>
						                    <img class="gkrw" id="scene_image" runat="server" src="img/gkrw/gkr1.png"/>
                                            <h1 id="scene_index" runat="server">01</h1>
						                    <div class="numbers"><h2 class="ks" id="scene_name" runat="server">&nbsp;&nbsp;情景二二<br>二二二二</h2></div>
					                    </a>
				                    </div>
                                </div>
								<div><p id="intro_html" runat="server"></p></div>
                            </div>
							<div class="popbtn"><div class="confirm btn_next" value="1"><img src="img/pop/下一步.png"/></div></div>
						</div>
						<div class="pop animated">
							<img class="pop-tit" src="img/pop/客户画像.png"/>
							<div class="pop-content cont2">
								<div><img id="image_html" runat="server" src="img/people/客户/kh1-hx.jpg"/></div>
								<div class="table-box">
									<table class="table table-borderd">
                                        <tbody id="member_html" runat="server">
										    <%--<tr>
											    <td><span class="iconfont icon-name"></span>&nbsp;合约:张三</td>
											    <td><span class="iconfont icon-nianling"></span>&nbsp;价值:25岁</td>
										    </tr>
										    <tr>
											    <td><span class="iconfont icon-zhiye1"></span>&nbsp;职业:游戏主播</td>
											    <td><span class="iconfont icon-ziyuan25"></span>&nbsp;爱好:打游戏</td>
										    </tr>
										    <tr>
											    <td><span class="iconfont icon-yewu"></span>&nbsp;已办理业务:108元套餐</td>
											    <td><span class="iconfont icon-yewu"></span>&nbsp;已办理业务:108元套餐</td>
										    </tr>
										    <tr>
											    <td><span class="iconfont icon-daiban1"></span>&nbsp;待办理业务:5G套餐升级</td>
											    <td><span class="iconfont icon-daiban1"></span>&nbsp;待办理业务:5G套餐升级</td>
										    </tr>--%>
                                        </tbody>
									</table>
								</div>
							</div>
							<div class="popbtn"><div class="confirm btn_next" value="2"><img src="img/pop/下一步.png"/></div></div>
						</div>
						<div class="pop animated">
							<img class="pop-tit" src="img/pop/产品.png"/>
                            <p id="produce_tip_html" runat="server" style="font-size:20px;position: absolute;left: 950px;top: 30px;color: #ffdc5e;width: 250px;">请在下列产品中选择你认为客户需要的产品</p>						
                            <div class="normal-layer" style="display:none;">
								<div class="layer-cont">
									<p class="p2">请至少选择一个产品!</p>
								</div>
								<div class="close1">
									<img src="img/pop/关闭1.png"/>
								</div>
							</div>
                            <div class="pop-content cont3" id="produce_html" runat="server">
                                <%--<div class="cont3-card">
									<div class="cont3-card-name"><img src="img/pop/logobg.png"/><h3>套餐一</h3></div>
									<div class="cont3-card-text">
										<h3>500分通话</h3>
										<ul class="cont3-card-ul"><li class="look"><a>详情</a></li><li class="choice"><a>选择</a></li></ul>
									</div>
									<div class="cont3-card-xz"><img src="img/pop/绿色.png"/></div>
								</div>--%>
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
									<img class="cont3-card-xz" src="img/pop/已选.png"/>
								</div>--%>
							</div>
							<div class="popbtn"><div class="confirm btn_next" value="3"><img src="img/pop/下一步.png"/></div></div>
						</div>
						<div class="pop animated">
							<img class="pop-tit" src="img/pop/触点.png"/>
							<div class="pop-content cont4">
								<div id="10" class="cont4-card active"><img src="/Upload/place/外呼触点.jpg"/><h5>外呼触点</h5><div class="cont4-card-xz"><img src="img/pop/绿色.png"/></div></div>
								<div id="11" class="cont4-card"><img src="/Upload/place/进厅触点.jpg"/><h5>进厅触点</h5><div class="cont4-card-xz"><img src="img/pop/绿色.png"/></div></div>
								<div id="12" class="cont4-card"><img src="/Upload/place/入户触点.jpg"/><h5>入户触点</h5><div class="cont4-card-xz"><img src="img/pop/绿色.png"/></div></div>
								<div id="13" class="cont4-card"><img src="/Upload/place/微信触点.jpg"/><h5>微信触点</h5><div class="cont4-card-xz"><img src="img/pop/绿色.png"/></div></div>
								<div id="14" class="cont4-card"><img src="/Upload/place/短信触点.jpg"/><h5>短信触点</h5><div class="cont4-card-xz"><img src="img/pop/绿色.png"/></div></div>
								<div id="15" class="cont4-card"><img src="/Upload/place/集团触点.jpg"/><h5>集团触点</h5><div class="cont4-card-xz"><img src="img/pop/绿色.png"/></div></div>
							</div>
							<div class="popbtn">
								<div class="confirm" id="btn_true"><img src="img/pop/确认.png"/></div>
								<div class="cancel"><img src="img/pop/取消.png"/></div>
							
							</div>
						</div>
					</div>
					<ul class="pop-right">
						<li class="active"><a>场景介绍</a></li>
						<li><a>客户画像</a></li>
						<li><a>产品选择</a></li>
						<li><a>触点选择</a></li>
					</ul>
				</div>
			</div>			
		</div>
		<script>
		    function shuffle(arr){var length = arr.length,randomIndex,temp;while (length){randomIndex = Math.floor(Math.random() * (length--));temp = arr[randomIndex];arr[randomIndex] = arr[length];arr[length] = temp}return arr;}
		    function tr_random()
		    {
		        var _div = $("#<%=produce_html.ClientID %>"), childs = _div.children();
		        //alert(childs.length);
		        var c11 = shuffle(childs);
		        _div.html("");
		        for (var i = 0; i < c11.length; i++)
		        {
		            _div.append($(c11[i]));
                }
		    }
		    tr_random();
            
            (function ()
		    {
		        $(window).ready(function ()
		        {
		            //隐藏开场效果
		            document.getElementById("video1").play();
		            var interval1 = setInterval(function ()
		            {
		                if (document.getElementById("video1").paused)
		                {
                            $(".video-box").remove();
		                    clearInterval(interval1);
		                }
		            }, 300);

		        });
		    })();
            //查看
		    $(".cont3-card-ul .look a").click(function ()
		    {
                sound111();
		        $(".layer-cont .p2").html($(this).attr("value"));
		        $(".normal-layer").fadeIn();
		    })
            //选中
	        var produce_ids = [];
	        $(".cont3-card-ul .choice a").click(function ()
	        {
	            sound111();
	            var lev = "<%=lev %>", now = $("#<%=produce_html.ClientID %>").find(".cont3-card-xz:visible").length;
	            if (now < lev - 0) { $(this).parents('.cont3-card-text').siblings(".cont3-card-xz").fadeIn(); }
	            else { $(this).find(".cont3-card-xz:visible").hide(); }

	            produce_ids = [];
	            var produces = $("#<%=produce_html.ClientID %>").find(".cont3-card-xz:visible");
	            produces.each(function () { produce_ids.push(this.id); });
	        });
            //取消选中
	        $(".cont3-card-xz").click(function () {sound111(); $(this).fadeOut(); });
            //关闭
			$('.normal-layer .close1').click(function () { $(".normal-layer").fadeOut(); });

		    //弹框
		    $('.pop-right li').click(function ()
		    {
                sound111();
		        $(this).addClass('active').siblings().removeClass('active');
		        $(".pop").hide().eq($(this).index()).fadeIn()
		    })
		    $(".pop").fadeOut().eq(0).fadeIn()
		    //产品
            //$(".cont3-card").click(function ()
            //{
            //	if ($(this).find(".cont3-card-xz:visible").length == 0)
            //	{
            //		if ($(this).parent().find(".cont3-card-xz:visible").length < <%=lev %>)
            //		{
            //		    $(this).find(".cont3-card-xz").fadeIn();
            //		}
            //	}
            //	else { $(this).find(".cont3-card-xz:visible").hide(); }

            //	produce_ids = [];
            //	var produces = $("#produce_html").find(".cont3-card-xz:visible");
            //	produces.each(function () { produce_ids.push(this.id); });
            //})
		    $(".cont3-card").find(".cont3-card-xz").hide();
		    //触点
		    $('.cont4-card').click(function ()
		    {
                sound111();
				$(this).find(".cont4-card-xz").fadeIn();
				$(this).siblings().find(".cont4-card-xz").hide();
		        place_id = $(this).attr("id");
		    })
		    $(".cont5 li").click(function ()
		    {
		        $(this).addClass('active').siblings().removeClass('active');
		    })
		    $(".btn-left1,.btn-right1,.btn-right2,.btn-right3").click(function ()
		    {
		        $('.talk-box').fadeOut()
		        $(".select-popbox").fadeIn();
		    })

		    var place_id = "", produce_ids = [];
		    //下一步
		    $(".btn_next").click(function ()
		    {
                sound111();
		        var index = $(this).attr("value");
		        $(".pop-right").children().eq(index).addClass('active').siblings().removeClass('active');
		        $(".pop").hide().eq(index).fadeIn()
		    });
            //确认
		    $("#btn_true").click(function ()
		    {
		        if (produce_ids == "") { alert("请选择产品"); return; }
		        if (place_id == "") { alert("请选择触点"); return; }
		        //alert("game.aspx?rid=<%=rid %>&did=<%=did %>&sid=<%=sid %>&mid=<%=mid %>&pids=" + produce_ids + "&pid=" + place_id);
		        location.href = "game.aspx?rid=<%=rid %>&did=<%=did %>&sid=<%=sid %>&mid=<%=mid %>&pids=" + produce_ids + "&pid=" + place_id;
		    })
		    //退出
		    $(".cancel").click(function () { history.go(-1); })
            //自动打字
		    var intro_content = $("#intro_html").html(); $("#intro_html").html("");
		    var interval1 = setInterval(function ()
		    {
		        if (intro_content.length > 0)
		        {
		            var c1 = $("#intro_html").html();
		            c1 += intro_content.substring(0, 1);
		            intro_content = intro_content.substring(1);
		            $("#intro_html").html(c1);
		        }
		        else { clearInterval(interval1); }
		    }, 100);
		    function sound111() { document.getElementById("audio11").play(); }
		</script>
        <audio autoplay="autoplay" loop="loop" preload="auto"><source src="img/music/1.mp3"></audio>
        <audio id="audio11"><source src="/Upload/sound/点击1.mp3"></audio>
    </form>
</body>
</html>