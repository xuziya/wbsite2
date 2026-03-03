<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/master/form.master" AutoEventWireup="true" CodeFile="2export.aspx.cs" Inherits="Admin_pages_game_log_2export" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr>
                <th width="170">开始时间</th>
                <td><asp:TextBox ID="start" runat="server" class="form-input" Width="300px" MaxLength="20" autocomplete="off" onclick="WdatePicker()"></asp:TextBox></td>
            </tr>
            <tr>
                <th>结束时间<span class="form-red">*</span></th>
                <td><asp:TextBox ID="end" runat="server" class="form-input" Width="300px" MaxLength="20" autocomplete="off" onclick="WdatePicker()"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="padding:20px 200px" colspan="2">
                    <asp:Button id="Button1" runat="server" class="btn btn-primary" Text="确&nbsp;&nbsp;认" OnClick="Button1_Click" />
                    <button type="button" class="btn btn-primary" onclick="location.href=location.href">重&nbsp;&nbsp;置</button>
                    <button type="button" class="btn btn-primary" onclick="parent.layer.close(parent.layer.getFrameIndex(window.name));">关&nbsp;&nbsp;闭</button>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>