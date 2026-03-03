<%@ Page Language="C#" MasterPageFile="~/Admin/master/form.master" AutoEventWireup="true" CodeFile="1learn_ad.aspx.cs" Inherits="Admin_pages_game_learn_1learn_ad" %>
<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>

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
                <th width="170">资料名称<span class="form-red">*</span></th>
                <td><asp:TextBox ID="name" runat="server" class="form-input" Width="500px" MaxLength="100" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr style="display:none">
                <th>资料类型<span class="form-red">*</span></th>
                <td>
                    <asp:TextBox ID="typeName" runat="server" class="form-input" style="width:500px" autocomplete="off" MaxLength="40"></asp:TextBox>
                    <asp:HiddenField ID="typeSole" runat="server" />
                </td>
            </tr>
            <tr>
                <th>简介<span class="form-red">*</span></th>
                <td><asp:TextBox ID="intro" runat="server" class="form-input" Width="500px" MaxLength="200" autocomplete="off"></asp:TextBox></td>
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
	<div id="treePanel1" style="display:none">
        <NineRays:FlyTreeView ID="TreeView1" runat="server" Width="398px" Height="450px" ImageSet="Office2003" BackColor="White" BorderWidth="1px" BorderColor="silver" SlideEffect="True" DrawLines="true" Padding="1px"
            EnableFullRowEvents="true" ContentClickExpands="false" PathSeparator="\" OnInitializedJavascript="onInit1" OnSelectedNodeChangedJavascript="onChanged1" OnPopulateNodes="TreeView1_PopulateNodes">
            <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
            <SelectedStyle RowBackColor="#dddddd"/>
            <HoverStyle RowBackColor="#dddddd"  Font-Underline="True" />
            <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
        </NineRays:FlyTreeView>
        <script type="text/javascript">
            var tree1 = new TreeDropDown("treePanel1", "<%=typeName.ClientID %>", "<%=typeSole.ClientID %>");
            function onInit1(to) { tree1.treeview = to; }
            function onChanged1(cid, on, n) { tree1.onSelectedNodeChangedHandler(cid, on, n); }
        </script>
    </div>
    <script type="text/javascript">
        var ue = UE.getEditor('editor1');
        ue.ready(function () { ue.setContent('<%=content %>'); });
    </script>
</asp:Content>