<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/master/table.master" AutoEventWireup="true" CodeFile="4resources_ad.aspx.cs" Inherits="Admin_pages_game_scene_4resources_ad" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr>
                <th width="170">资源名称<span class="form-red">*</span></th>
                <td><asp:TextBox ID="name" runat="server" class="form-input" style="width:300px" MaxLength="40" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr style="display:none">
                <th>类型</th>
                <td>
                    <asp:DropDownList ID="type" runat="server" class="form-select" style="width:300px">
                        <asp:ListItem Value="血量回复">血量回复</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th>血量增加</th>
                <td><asp:DropDownList ID="num1" runat="server" class="form-select" style="width:300px"></asp:DropDownList></td>
            </tr>
            <tr>
                <th>好感度增加</th>
                <td><asp:DropDownList ID="num2" runat="server" class="form-select" style="width:300px"></asp:DropDownList></td>
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
                    <button type="button" class="btn btn-primary" onclick="parent.layer.close(parent.layer.getFrameIndex(window.name));">关&nbsp;&nbsp;闭</button>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>