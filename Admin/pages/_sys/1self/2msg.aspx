<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/form.master" CodeFile="2msg.aspx.cs" Inherits="Admin_sys_self_msg2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<link type="text/css" rel="stylesheet" href="/Admin/css/ui/index.css"/>	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div class="user">
        <%--<div class="user-img"><img src="/Upload/init/logo2.png" width="100" height="100"></div>--%>
	    <h5 class="text-center">欢迎使用游戏培训系统</h5>
	    <ul>
		    <li class="left"><a class="btn btn-primary btn-lg" href="javascript:top.openWindows(window, '/Admin/pages/_sys/1self/1msg.aspx?isWin=true&s=101', '查看管理员账号信息');" title="点击查看管理员账号信息">查看</a></li>
		    <li  class="left"><a class="btn btn-default btn-lg" href="javascript:top.openWindows(window, '/Admin/pages/_sys/1self/2password.aspx', '修改密码');" title="点击修改密码">修改</a></li>
		    <div class="clear"></div>
	    </ul>
	    <dl class="dl-horizontal">
		    <%--<dt>登陆次数:</dt><dd>3</dd>--%>
		    <dt>姓名:</dt><dd><%=manager.Name %></dd>
		    <dt>账号:</dt><dd><%=manager.Uid %></dd>
		    <dt>类型:</dt><dd><%=manager.Type %></dd>
		    <dt>添加人:</dt><dd><%=manager.CreateSole%></dd>
		    <dt>密码长度:</dt><dd><%=manager.Pass.Length %></dd>
		    <dt>所属机构:</dt><dd><%=manager.OrganSole%></dd>
		    <dt>添加时间:</dt><dd><%=manager.CreateDate %></dd>
	    </dl>
     </div>
</asp:Content>