<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/form.master" CodeFile="serverMsg.aspx.cs" Inherits="Admin_sys_other_serverMsg" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr><td style="background:#2982ce;color:#fff;text-align:center" colspan="2">硬件信息</td></tr>
            <tr><td style="width:170px">CPU数量</td><td><%=harry.Tools.Web.ServerMessage.CpuCount%></td></tr>
            <tr><td>CPU类型</td><td><%=harry.Tools.Web.ServerMessage.CpuIdentifier%></td></tr>
            <tr><td style="background:#2982ce;color:#fff;text-align:center" colspan="2">系统信息</td></tr>
            <tr><td>操作系统版本</td><td><%=harry.Tools.Web.ServerMessage.SystemVersion%></td></tr>
            <tr><td>计算机名称</td><td><%=harry.Tools.Web.ServerMessage.MachineName%></td></tr>
            <tr><td>区域语言</td><td><%=harry.Tools.Web.ServerMessage.AcceptLanguage%></td></tr>
            <tr><td style="background:#2982ce;color:#fff;text-align:center" colspan="2">服务器信息</td></tr>
            <tr><td>服务器IP地址</td><td><%=harry.Tools.Web.ServerMessage.ServerIp%></td></tr>
            <tr><td>服务器域名</td><td><%=harry.Tools.Web.ServerMessage.DomainName%></td></tr>
            <tr><td>HTTP访问端口</td><td><%=harry.Tools.Web.ServerMessage.ServerPort%></td></tr>
            <tr><td>.NET解释引擎版本</td><td><%=harry.Tools.Web.ServerMessage.DotNetVersion%></td></tr>
            <%--<tr><td>IIS版本</td><td><%=harry.Tools.ServerMessage.IISVersion %></td></tr>--%>
            <tr><td style="background:#2982ce;color:#fff;text-align:center" colspan="2">项目信息</td></tr>
            <tr><td>项目根目录</td><td><%=harry.Tools.Web.ServerMessage.PathTranslated%></td></tr>
            <tr><td>虚拟目录Session总数</td><td><%=harry.Tools.Web.ServerMessage.SessionCount%></td></tr>
            <tr><td>虚拟目录Application总数</td><td><%=harry.Tools.Web.ServerMessage.ApplicationCount %></td></tr>
            <tr><td style="padding:20px 200px" colspan="2"><button class="btn btn-primary" onclick="location.href=location.href">刷&nbsp;&nbsp;新</button></td></tr>
        </table>
    </div>
</asp:Content>