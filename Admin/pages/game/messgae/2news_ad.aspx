<%@ Page Language="C#" MasterPageFile="~/Admin/master/form.master" AutoEventWireup="true" CodeFile="2news_ad.aspx.cs" Inherits="Admin_pages_game_messgae_2news_ad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" charset="utf-8" src="/Tools/ueditor-dev-1.5.0/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/Tools/ueditor-dev-1.5.0/_examples/editor_api.js"> </script>
    <script type="text/javascript" charset="utf-8" src="/Tools/ueditor-dev-1.5.0/lang/zh-cn/zh-cn.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr>
                <th width="170">标题<span class="form-red">*</span></th>
                <td><asp:TextBox ID="title" runat="server" class="form-input" Width="300px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>简介<span class="form-red">*</span></th>
                <td><asp:TextBox ID="intro" runat="server" class="form-input" Width="300px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>详细内容<span class="form-red">*</span></th>
                <td><script id="editor1" name="editor1" type="text/plain" style="width:1024px;height:500px;"></script></td>
            </tr>
            <tr>
                <th></th>
                <td><label><input type="checkbox" id="isUsed" class="form-checkbox" runat="server" lay-skin="primary"/> 正常使用</label></td>
            </tr>
            <tr>
                <th>备注</th>
                <td><asp:TextBox ID="note" runat="server" class="form-input" MaxLength="200" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="padding:20px 200px" colspan="2">
                    <asp:Button id="Button1" runat="server" class="btn btn-primary" Text="确&nbsp;&nbsp;认" OnClick="Button1_Click"/>
                    <button type="button" class="btn btn-primary" onclick="location.href=location.href">重&nbsp;&nbsp;置</button>
                    <asp:Button id="Button3" runat="server" class="btn btn-primary" Text="删&nbsp;&nbsp;除" OnClick="Button2_Click" OnClientClick="return confirm('确认删除？')"/>
                    <button type="button" class="btn btn-primary" onclick="parent.layer.close(parent.layer.getFrameIndex(window.name));">关&nbsp;&nbsp;闭</button>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        var ue = UE.getEditor('editor1');
        ue.ready(function () { ue.setContent('<%=content %>'); });
    </script>
</asp:Content>