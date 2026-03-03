<%@ Page Language="C#" MasterPageFile="~/Admin/master/form.master" AutoEventWireup="true" CodeFile="1learn_view.aspx.cs" Inherits="Admin_pages_game_learn_1learn_view" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div class="breadcrumb-box"><ol class="breadcrumb"><span>位置：</span><li class="active">首页 - 查看资料</li><div class="clear"></div></ol></div>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr>
                <th width="170">标题<span class="form-red">*</span></th>
                <td id="title" runat="server"></td>
            </tr>
            <tr>
                <th>添加人<span class="form-red">*</span></th>
                <td id="createSole" runat="server"></td>
            </tr>
            <tr>
                <th>添加时间<span class="form-red">*</span></th>
                <td id="createDate" runat="server"></td>
            </tr>
            <tr>
                <th>简介<span class="form-red">*</span></th>
                <td id="intro" runat="server"></td>
            </tr>
            <tr>
                <th>详细内容<span class="form-red">*</span></th>
                <td id="content" runat="server"></td>
            </tr>
            <tr>
                <td style="padding:20px 200px" colspan="2">
                    <button type="button" class="btn btn-primary" onclick="location.href=location.href">重&nbsp;&nbsp;置</button>
                    <button type="button" class="btn btn-primary" onclick="parent.layer.close(parent.layer.getFrameIndex(window.name));">关&nbsp;&nbsp;闭</button>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>