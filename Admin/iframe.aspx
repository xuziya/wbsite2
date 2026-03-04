<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/Master/base.master" CodeFile="iframe.aspx.cs" Inherits="Admin_iframe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<link type="text/css" rel="stylesheet" href="/Admin/css/ui/index.css"/>
	<link type="text/css" rel="stylesheet" href="/Admin/css/ui/fonts/font-awesome.min.css"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div class="header-box">
		<div class="header-left left">
           <%-- 游戏培训系统--%>
			<img src="img/logo.png"/>
			<%--<div class="has-feedback">
				<span class="form-control-feedback"></span>
				<input type="text" placeholder="搜索" >
			</div>--%>
			<%--<div class="clearfix"></div>--%>
		</div>
		<div class="header-right">
			<ul>
				<li><i class="fa fa-globe"></i><a href="javascript:void(0);"> 官方网站</a></li>
				<li><i class="fa fa-question-circle"></i><a href="javascript:void(0);"> 帮助中心</a></li>
				<li><i class="fa fa-phone"></i><a href="javascript:void(0);"> 服务热线</a></li>
				<li><i class="fa fa-sign-out"></i><a href="javascript:if(confirm('确认退出?')){top.location.assign('/Admin/login.aspx')}"> 退出系统</a></li>
				<div class="clear"></div>
			</ul>
			<div class="time"><%=GetName() %>，今天是：<%=DateTime.Now.ToString("yyyy 年 MM 月 dd 日") %> &nbsp;&nbsp;<script type="text/javascript">document.write("星期" + ["日", "一", "二", "三", "四", "五", "六"][new Date().getDay()]);</script></div>
		</div>
		<div class="clearfix"></div>
	</div>
	<div class="navbar"><ul><%=GetTopMenu() %></ul><div class="arrow-box"><div class="arrow"><i class="fa fa-angle-right"></i></div></div></div>
	<div class="navbar-two">
		<div style="height:80px"></div>
		<div id="leftMenus_html" runat="server" class="sidebar-menu"></div>
    </div>
    <div class="container-box"><div class="admin-body"><iframe id="iframe" name="iframe" src="main.aspx" frameborder="0" class="admin-iframe"></iframe></div></div>
    <%--<div class="container-box"><div class="admin-body"><iframe id="iframe" name="iframe" src="/Admin/pages/client/1organ.aspx" frameborder="0" class="admin-iframe" ></iframe></div></div>--%>
    <script type="text/javascript" src="/Admin/js/custom.js"></script>
    <script type="text/javascript">
        /*顶部菜单*/
        function topMenuClick(top)
        {
            var index = $(top).index();
            $("#<%=leftMenus_html.ClientID %>").children("ul").each(function (i)
            {
                if (i == index) { $(this).show(); }
                else { $(this).hide(); }
            });
        }
    </script>
</asp:Content>