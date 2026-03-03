<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/master/form.master" AutoEventWireup="true" CodeFile="1dialog_ad.aspx.cs" Inherits="Admin_pages_game_dialog_1dialog_ad" %>
<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr>
                <th>绑定触点<span class="form-red">*</span></th>
                <td>
                    <asp:TextBox ID="placeName" runat="server" class="form-input" style="width:600px" autocomplete="off" MaxLength="30"></asp:TextBox>
                    <asp:HiddenField ID="placeSole" runat="server" />
                </td>
            </tr>
            <tr>
                <th>类型1</th>
                <td>
                    <asp:DropDownList ID="type1" runat="server" class="form-select" style="width:600px">
                        <asp:ListItem Value="个人">个人</asp:ListItem>
                        <asp:ListItem Value="家庭">家庭</asp:ListItem>
                        <asp:ListItem Value="集团">集团</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr style="display:none">
                <th>类型2</th>
                <td>
                    <asp:DropDownList ID="type2" runat="server" class="form-select" style="width:600px">
                        <asp:ListItem Value="对话">对话</asp:ListItem>
                        <asp:ListItem Value="选择">选择</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th>类型3</th>
                <td>
                    <asp:DropDownList ID="type3" runat="server" class="form-select" style="width:600px">
                        <asp:ListItem Value="第一句">第一句</asp:ListItem>
                        <asp:ListItem Value="其他">其他</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th>内容1</th>
                <td><asp:TextBox ID="content1" runat="server" class="form-input" MaxLength="100" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>回复1</th>
                <td><asp:TextBox ID="reply1" runat="server" class="form-input" MaxLength="100" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>得分1</th>
                <td><asp:TextBox ID="point1" runat="server" class="form-input" style="width:200px" MaxLength="5" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>内容2</th>
                <td><asp:TextBox ID="content2" runat="server" class="form-input" MaxLength="100" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>回复2</th>
                <td><asp:TextBox ID="reply2" runat="server" class="form-input" MaxLength="100" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>得分2</th>
                <td><asp:TextBox ID="point2" runat="server" class="form-input" style="width:200px" MaxLength="5" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>内容3</th>
                <td><asp:TextBox ID="content3" runat="server" class="form-input" MaxLength="100" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>回复3</th>
                <td><asp:TextBox ID="reply3" runat="server" class="form-input" MaxLength="100" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>得分3</th>
                <td><asp:TextBox ID="point3" runat="server" class="form-input" style="width:200px" MaxLength="5" autocomplete="off"></asp:TextBox></td>
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
            EnableFullRowEvents="true" ContentClickExpands="false" PathSeparator="\" OnInitializedJavascript="onInit1" OnSelectedNodeChangedJavascript="onChanged1" onpopulatenodes="TreeView1_PopulateNodes">
            <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
            <SelectedStyle RowBackColor="#dddddd"/>
            <HoverStyle RowBackColor="#dddddd"  Font-Underline="True" />
            <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
        </NineRays:FlyTreeView>
        <script type="text/javascript">
            var tree1 = new TreeDropDown("treePanel1", "<%=placeName.ClientID %>", "<%=placeSole.ClientID %>");
            function onInit1(to) { tree1.treeview = to; }
            function onChanged1(cid, on, n) { tree1.onSelectedNodeChangedHandler(cid, on, n); }
        </script>
    </div>
</asp:Content>