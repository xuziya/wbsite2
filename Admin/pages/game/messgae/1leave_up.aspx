<%@ Page Language="C#" MasterPageFile="~/Admin/master/form.master" AutoEventWireup="true" CodeFile="1leave_up.aspx.cs" Inherits="Admin_pages_game_messgae_1leave_up" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr><th width="170">标题</th><td id="title" runat="server"></td></tr>
            <tr><th>留言时间</th><td id="createDate" runat="server"></td></tr>
            <tr><th>留言人</th><td id="name" runat="server"></td></tr>
            <tr><th>相关资料</th><td><asp:Label ID="path1" runat="server" ToolTip="点击下载文件"></asp:Label><br /></td></tr>
            <tr><th>留言内容</th><td id="content" runat="server"></td></tr>
            <tr><td colspan="2" style="background:green;color:#fff;text-align:center">回复</td></tr>
            <tr>
                <th width="170">回复内容</th>
                <td><asp:TextBox ID="replay" runat="server" class="form-input" Width="300px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th width="170">回复时间</th>
                <td id="date2" runat="server"></td>
            </tr>
            <tr>
                <th width="170">回复人</th>
                <td id="sole2" runat="server"></td>
            </tr>
            <tr>
                <td style="padding:20px 200px" colspan="2">
                    <asp:Button id="Button1" runat="server" class="btn btn-primary" Text="确&nbsp;&nbsp;认" OnClick="Button1_Click"/>
                    <button type="button" class="btn btn-primary" onclick="location.href=location.href">重&nbsp;&nbsp;置</button>
                    <button type="button" class="btn btn-primary" onclick="parent.layer.close(parent.layer.getFrameIndex(window.name));">关&nbsp;&nbsp;闭</button>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>