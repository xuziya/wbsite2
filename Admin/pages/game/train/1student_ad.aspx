<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/master/form.master" AutoEventWireup="true" CodeFile="1student_ad.aspx.cs" Inherits="Admin_pages_game_train_1student_ad" %>
<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr>
                <th width="170">学员姓名<span class="form-red">*</span></th>
                <td><asp:TextBox ID="name" runat="server" class="form-input" style="width:300px" MaxLength="30" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>员工编号</th>
                <td><asp:TextBox ID="code" runat="server" class="form-input" style="width:300px" MaxLength="30" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>一级归属（旗区、机关）<span class="form-red">*</span></th>
                <td>
                    <asp:TextBox ID="organName" runat="server" class="form-input" style="width:300px" autocomplete="off" MaxLength="30"></asp:TextBox>
                    <asp:HiddenField ID="organSole" runat="server" />
                </td>
            </tr>
            <tr>
                <th>性别</th>
                <td>
                    <asp:DropDownList ID="sex" runat="server" class="form-select" style="width:300px">
                        <asp:ListItem Value="男">男</asp:ListItem>
                        <asp:ListItem Value="女">女</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr style="display:none">
                <th>年龄</th>
                <td><asp:DropDownList ID="age" runat="server" class="form-select" style="width:300px"></asp:DropDownList></td>
            </tr>
            <tr>
                <th>部门</th>
                <td><asp:TextBox ID="dept" runat="server" class="form-input" style="width:300px" MaxLength="30" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr style="display:none">
                <th>联系电话</th>
                <td><asp:TextBox ID="mobile" runat="server" class="form-input" style="width:300px" MaxLength="30" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>登录用户名<span class="form-red">*</span></th>
                <td><asp:TextBox ID="uid" runat="server" class="form-input" style="width:300px" MaxLength="20" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>登录密码<span class="form-red">*</span></th>
                <td><asp:TextBox ID="pass" runat="server" class="form-input" style="width:300px" MaxLength="12" autocomplete="off"></asp:TextBox></td>
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
	<div id="treePanel1" style="display:none">
        <NineRays:FlyTreeView ID="TreeView1" runat="server" Width="398px" Height="450px" ImageSet="Office2003" BackColor="White" BorderWidth="1px" BorderColor="silver" SlideEffect="True" DrawLines="true" Padding="1px"
            EnableFullRowEvents="true" ContentClickExpands="false" PathSeparator="\" OnInitializedJavascript="onInit1" OnSelectedNodeChangedJavascript="onChanged1" OnPopulateNodes="TreeView1_PopulateNodes">
            <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
            <SelectedStyle RowBackColor="#dddddd"/>
            <HoverStyle RowBackColor="#dddddd"  Font-Underline="True" />
            <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
        </NineRays:FlyTreeView>
        <script type="text/javascript">
            var tree1 = new TreeDropDown("treePanel1", "<%=organName.ClientID %>", "<%=organSole.ClientID %>");
            function onInit1(to) { tree1.treeview = to; }
            function onChanged1(cid, on, n) { tree1.onSelectedNodeChangedHandler(cid, on, n); }
        </script>
    </div>
</asp:Content>