<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/master/form.master" AutoEventWireup="true" CodeFile="2member3_ad.aspx.cs" Inherits="Admin_pages_game_scene_2member3_ad" %>
<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr>
                <th width="170">客户名称<span class="form-red">*</span></th>
                <td><asp:TextBox ID="name" runat="server" class="form-input" style="width:600px" MaxLength="30" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr width="170">
                <th>客户人设</th>
                <td><asp:TextBox ID="character1" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>所属场景<span class="form-red">*</span></th>
                <td>
                    <asp:TextBox ID="sceneName" runat="server" class="form-input" style="width:600px" autocomplete="off" MaxLength="30"></asp:TextBox>
                    <asp:HiddenField ID="sceneSole" runat="server" />
                </td>
            </tr>
            <tr style="display:none">
                <th>触点</th>
                <td><asp:DropDownList ID="place" runat="server" class="form-select" style="width:600px"></asp:DropDownList></td>
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
            <tr>
                <th>年龄</th>
                <td>
                    <asp:DropDownList ID="age" runat="server" class="form-select" style="width:300px">
                        <asp:ListItem Value="16-25">16-25</asp:ListItem>
                        <asp:ListItem Value="25-40">25-40</asp:ListItem>
                        <asp:ListItem Value="40-60">40-60</asp:ListItem>
                        <asp:ListItem Value="60岁以上">60岁以上</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th>合约</th>
                <td><asp:TextBox ID="shuxing1" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>价值</th>
                <td><asp:TextBox ID="shuxing2" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>年龄</th>
                <td><asp:TextBox ID="shuxing3" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>流量</th>
                <td><asp:TextBox ID="shuxing4" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>资费</th>
                <td><asp:TextBox ID="shuxing5" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>融合</th>
                <td><asp:TextBox ID="shuxing6" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>权益</th>
                <td><asp:TextBox ID="shuxing7" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>家庭</th>
                <td><asp:TextBox ID="shuxing8" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>集团属性（ABCD）</th>
                <td><asp:TextBox ID="shuxing9" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>集团星级</th>
                <td><asp:TextBox ID="shuxing10" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>集团等级</th>
                <td><asp:TextBox ID="shuxing11" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>集团份额</th>
                <td><asp:TextBox ID="shuxing12" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>集团成员数</th>
                <td><asp:TextBox ID="shuxing13" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>保拓优先级</th>
                <td><asp:TextBox ID="shuxing14" runat="server" class="form-input" style="width:600px" MaxLength="50" autocomplete="off"></asp:TextBox></td>
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
            EnableFullRowEvents="true" ContentClickExpands="false" PathSeparator="\" OnInitializedJavascript="onInit1" OnSelectedNodeChangedJavascript="onChanged1">
            <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
            <SelectedStyle RowBackColor="#dddddd"/>
            <HoverStyle RowBackColor="#dddddd"  Font-Underline="True" />
            <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
        </NineRays:FlyTreeView>
        <script type="text/javascript">
            var tree1 = new TreeDropDown("treePanel1", "<%=sceneName.ClientID %>", "<%=sceneSole.ClientID %>");
            function onInit1(to) { tree1.treeview = to; }
            function onChanged1(cid, on, n) { tree1.onSelectedNodeChangedHandler(cid, on, n); }
        </script>
    </div>
</asp:Content>