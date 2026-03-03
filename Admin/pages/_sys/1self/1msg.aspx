<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/form.master" CodeFile="1msg.aspx.cs" Inherits="Admin_sys_self_msg1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <div class="row row-col-space15">
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                <table class="table table-bordered table-hover">
                    <tr>
	                    <th width="80">管理员编号</th><td><%=manager.Id %></td>
	                    <%--<td rowspan="3" valign="middle"><asp:Image ID="Image1" Width="100" Height="100" ImageUrl="/Upload/_test/head.jpg" runat="server" /></td>--%>
                    </tr>
                    <tr><th>管理员姓名</th><td width="250"><%=manager.Name %></td></tr>
                    <tr><th>管理员账号</th><td><%=manager.Uid %></td></tr>
                    <tr><th>管理员密码</th><td colspan="2"><%=manager.Pass %></td></tr>
                    <tr><th>管理员类型</th><td colspan="2"><%=manager.Type %></td></tr>
                    <tr><th>所属机构</th><td colspan="2"><%=manager.OrganSole %></td></tr>
                    <%--<tr><th>相关编号</th><td colspan="2"><%=manager.RelatedSole %></td></tr>--%>
                    <%--<tr><th>允许登录ip</th><td colspan="2"><%=manager.AllowIp %></td></tr>--%>
                    <%--<tr><th>到期时间</th><td colspan="2"><%=manager.AllowDate %></td></tr>--%>
                    <tr><th>添加人</th><td colspan="2"><%=manager.CreateSole %></td></tr>
                    <tr><th>添加时间</th><td colspan="2"><%=manager.CreateDate %></td></tr>
                    <tr><th>备注</th><td colspan="2" height="106px"><%=manager.Note %></td></tr>
                    <tr style="<%=IsWindow() %>">
                        <td colspan="3" align="center">
                            <button class="btn btn-primary" onclick="location.href=location.href">刷&nbsp;&nbsp;新</button>
                            <button type="button" class="btn btn-primary" onclick="parent.layer.close(parent.layer.getFrameIndex(window.name));">关&nbsp;&nbsp;闭</button>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8"><iframe id="iframepage" width="100%" frameborder="0" scrolling="no" src="1msg_tree.aspx"></iframe></div>
        </div>
    </div>
    <%--去掉iframe滚动条--%>
    <script type="text/javascript">document.body.style.overflow = "hidden";</script>
</asp:Content>