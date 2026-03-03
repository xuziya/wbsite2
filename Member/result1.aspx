<%@ Page Language="C#" AutoEventWireup="true" CodeFile="result1.aspx.cs" Inherits="Member_result1" %>
<!DOCTYPE html>
<html style="touch-action:none">
<head id="Head1" runat="server">
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
			<div class="result-box">
				<img class="dtimg" src="img/cg/skjs_shengli-shengli_38.png"/>
				<!-- <img class="dtimg1" src="img/sb/skjs_shibai-shibai_38.png"/> -->
				<div class="result-win animated zoomInDown">
					<h1 class="result-win-tit" data-text="恭喜完成此次试炼">恭喜完成此次试炼</h1>
					<div class="defen clear" style="margin-left:-210px"><p>场景满分</p>&nbsp;<span id="manfen"></span><p>，您得分&nbsp;</p><span id="defen"></span></div>
					<div class="jibai clear"><p>你击败了&nbsp;</p><span id="jibai"></span><p>&nbsp;的玩家</p></div>
					<ul>
						<li id="r1">你的得分率：<span>20%</span></li>
						<li id="r2">客户情绪值：<span>5%</span></li>
						<li id="r3">产品正确率：<span>100%</span></li>
						<li id="r4">触点正确率：<span>100%</span></li>
					</ul>
					<img class="jz" id='zhuangtai' src="img/卓越.png"/>
				</div>
				<div id="div111" class="popbtn" style="top: 1050px;z-index: 99; display:none">
					<div class="confirm"><a href="room2.aspx?rid=<%=rid %>&did=<%=did %>"><img src="img/pop/继续试炼.png"/></a></div>
					<div class="cancel"><a href="room2.aspx?rid=<%=rid %>&did=<%=did %>"><img src="img/pop/关闭.png"/></a></div>
				</div>
				<div id="div222" class="popbtn" style="top: 1050px;z-index: 99; display:none">
					<div class="confirm"><a href="javascript:history.go(-3);"><img src="img/pop/继续试炼.png"/></a></div>
					<div class="cancel"><a href="javascript:history.go(-3);"><img src="img/pop/关闭.png"/></a></div>
				</div>
			</div>					
		</div>
		<script>
		    var rid = "<%=rid %>";
		    if (rid != "")
		    {
		        $("#div111").show();
		        $("#div222").hide();
		    }
		    else
		    {
		        $("#div222").show();
		        $("#div111").hide();
            }

		    function random(lower, upper) { return Math.floor(Math.random() * (upper - lower + 1)) + lower; }
		    function yiwei(val1) { return Math.floor(val1 * 10) / 10; }

		    var cqp = "<%=cqp %>", all = "<%=all %>", now = "<%=now %>", qingxu = "<%=qingxu %>", p1 = "<%=p1 %>", p2 = "<%=p2 %>";
		    var _percent = Math.round(now / all * 100);
		    var _min = _percent - random(1, 10); if (_min < 0) { _min = 0; }
		    var _max = _percent - -random(1, 10); if (_max > 100) { _max = 100; }
		    $("#manfen").html(cqp);
		    $("#defen").html(yiwei(cqp * _percent / 100));
		    $("#jibai").html(yiwei(random(_min, _max)) + " %");
		    $("#r1").html("你的得分率：" + yiwei(_percent) + "%");
		    $("#r2").html("客户情绪值：" + yiwei(qingxu) + "%");
		    $("#r3").html("产品正确率：" + yiwei((p1 * 100)) + "%");
		    $("#r4").html("触点正确率：" + yiwei((p2 * 100)) + "%");
		    if (_percent > 80) { $("#zhuangtai").attr("src", "/Upload/game/result/卓越.png"); }
		    else if (_percent >= 60 && _percent <= 80) { $("#zhuangtai").attr("src", "/Upload/game/result/优秀.png"); }
		    else { $("#zhuangtai").attr("src", "/Upload/game/result/继续努力.png"); }

		    //序列帧动画
		    var num = 0, enteranimet = setInterval(function ()
		    {
		        num == 38 ? num = 0 : num++
		        $(".result-box .dtimg").attr('src', 'img/cg/skjs_shengli-shengli_' + num + '.png')
		    }, 60);
		</script>
    </form>
    <audio autoplay="autoplay" loop="loop" preload="auto"><source src="img/music/1.mp3"></audio>
</body>
</html>