<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/form.master" CodeFile="6sms.aspx.cs" Inherits="Admin_setting_sms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr>
                <th width="170">网址<span class="form-red">*</span><br /><span class="form-tip">短信平台地址</span></th>
                <td><asp:TextBox ID="v1" runat="server" class="form-input" Width="600px" MaxLength="100" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>API<span class="form-red">*</span><br /><span class="form-tip">完整的API接口内容</span></th>
                <td><asp:TextBox ID="v2" runat="server" class="form-input" Width="600px" MaxLength="120" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>账号<span class="form-red">*</span><br /><span class="form-tip">账号</span></th>
                <td><asp:TextBox ID="v3" runat="server" class="form-input" Width="300px" MaxLength="20" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>密码<span class="form-red">*</span><br /><span class="form-tip">密码</span></th>
                <td><asp:TextBox ID="v4" runat="server" class="form-input" Width="300px" MaxLength="20" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>服务到期模板<span class="form-red">*</span><br /><span class="form-tip">服务到期时发送的内容模板</span></th>
                <td><asp:TextBox ID="v5" runat="server" class="form-input" Width="600px" MaxLength="220" autocomplete="off" Height="150px" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <th>档案到期模板<span class="form-red">*</span><br /><span class="form-tip">档案到期时发送的内容模板</span></th>
                <td><asp:TextBox ID="v6" runat="server" class="form-input" Width="600px" MaxLength="220" autocomplete="off" Height="150px" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="padding:20px 200px" colspan="2">
                    <asp:Button id="Button1" runat="server" class="btn btn-primary" Text="确&nbsp;&nbsp;认" OnClick="Button1_Click"/>
                    <button class="btn btn-primary" onclick="location.href=location.href">刷&nbsp;&nbsp;新</button>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>