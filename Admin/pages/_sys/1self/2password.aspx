<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/form.master" CodeFile="2password.aspx.cs" Inherits="Admin_sys_self_password" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr><th width="170">管理员账号</th><td id="uid" runat="server"></td></tr>
            <tr>
                <th>旧密码<span class="form-red">*</span><br /><span class="form-tip">当前密码</span></th>
                <td><asp:TextBox ID="pass" runat="server" TextMode="Password" class="form-input" style="width:300px" MaxLength="20" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>新密码<span class="form-red">*</span><br /><span class="form-tip">修改后密码</span></th>
                <td><asp:TextBox ID="CitySole" runat="server" TextMode="Password" class="form-input" style="width:300px" MaxLength="20" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>重复密码<span class="form-red">*</span><br /><span class="form-tip">重复修改后密码</span></th>
                <td><asp:TextBox ID="CityName" runat="server" TextMode="Password" class="form-input" style="width:300px" MaxLength="20" autocomplete="off"></asp:TextBox></td>
            </tr>
            <%--<tr>
                <th>验证码<span class="form-red">*</span><br /><span class="form-tip">验证码</span></th>
                <td>
                    <input type="password" name="Note" class="form-input" style="width:80px;float:left" maxlength="12" autocomplete="off"/>&nbsp;
                    <img src="/validate.aspx?k=setPass" alt="" valign="middle" style="cursor:pointer;border:1px solid #000;width:90px;height:29px" onclick="this.src='/validate.aspx?k=setPass&'+new Date().getTime()" />
                </td>
            </tr>--%>
            <tr>
                <td style="padding:20px 200px" colspan="2">
                    <asp:Button id="Button1" runat="server" class="btn btn-primary" Text="确&nbsp;&nbsp;认" OnClientClick="return check1();" OnClick="Button1_Click" />
                    <button type="button" class="btn btn-primary" onclick="location.href=location.href">刷&nbsp;&nbsp;新</button>
                </td>
            </tr>
        </table>
    </div>
    <%--<asp:HiddenField ID="HiddenField1" runat="server"/>--%>
    <script type="text/javascript">
        function check1()
        {
            if ($("#<%=pass.ClientID %>").val() == "") { top.messageBox("请输入旧密码"); return false; }
            if ($("#<%=CitySole.ClientID %>").val() == "") { top.messageBox("请输入新密码"); return false; }
            if ($("#<%=CityName.ClientID %>").val() == "") { top.messageBox("请重复新密码"); return false; }
            if ($("#<%=CitySole.ClientID %>").val() != $("#<%=CityName.ClientID %>").val()) { top.messageBox("两次输入的密码不一致"); return false; }
            return true;
        }
    </script>
</asp:Content>