<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/form.master" CodeFile="2manager_ad.aspx.cs" Inherits="Admin_sys_manager_manager_ad" %>
<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr>
                <th>所属机构<span class="form-red">*</span><br /><span class="form-tip">管理员从属的机构</span></th>
                <td>
                    <asp:TextBox ID="organName" runat="server" class="form-input" style="width:300px" MaxLength="40" autocomplete="off"></asp:TextBox>
                    <asp:HiddenField ID="organSole" runat="server" />
                </td>
            </tr>
            <tr>
                <th>管理员类型<br /><span class="form-tip">相当于身份信息</span></th>
                <td><asp:DropDownList ID="type" runat="server" class="form-select" style="width:300px"></asp:DropDownList></td>
            </tr>
            <tr>
                <th>管理员姓名<span class="form-red">*</span><br /><span class="form-tip">用户的真实姓名</span></th>
                <td><asp:TextBox ID="name" runat="server" class="form-input" style="width:300px" MaxLength="20" autoycomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>管理员账号<span class="form-red">*</span><br /><span class="form-tip">6-12位数字、字母组合</span></th>
                <td><asp:TextBox ID="uid" runat="server" class="form-input" style="width:300px" MaxLength="12" autocomplete="off"></asp:TextBox></td>
            </tr>
            <%--<tr>
                <th>管理员密码<span class="form-red">*</span><br /><span class="form-tip">6-12位数字、字母组合</span></th>
                <td>
                    <asp:TextBox ID="pass" runat="server" class="form-input" style="width:300px" MaxLength="12" autocomplete="off" Text="cib12345"></asp:TextBox>
                    <a id="sp">查看密码</a>
                </td>
            </tr>--%>
            <%--<tr>
                <th>相关编号<span class="form-red">*</span><br /><span class="form-tip">对应其它系统的编号、员工号等</span></th>
                <td><asp:TextBox ID="relatedSole" runat="server" class="form-input" style="width:300px" MaxLength="20" autocomplete="off"></asp:TextBox></td>
            </tr>--%>
            <%--<tr>
                <th>业务条线<span class="form-red">*</span><br /><span class="form-tip">管理员对应的业务条线</span></th>
                <td>
                    <asp:TextBox ID="popedom" runat="server" class="form-input" style="width:300px" MaxLength="40" autocomplete="off"></asp:TextBox>
                    <asp:HiddenField ID="popedom1" runat="server" />
                </td>
            </tr>--%>
            <%--<tr>
                <th>允许登录ip<span class="form-red">*</span><br /><span class="form-tip">多个内容使用“|”分隔<br />可模糊匹配：127.*、127.0.*</span></th>
                <td><asp:TextBox ID="allowIp" runat="server" class="form-input" style="width:300px" MaxLength="20" autocomplete="off"></asp:TextBox></td>
            </tr>--%>
            <tr>
                <th>使用期限<span class="form-red">*</span><br /><span class="form-tip">超过使用期限后自动失效</span></th>
                <td><asp:TextBox ID="allowDate" runat="server" class="form-input" style="width:300px" MaxLength="50" onclick="WdatePicker()"></asp:TextBox></td>
            </tr>
            <tr>
                <th>&nbsp;</th>
                <td>
                    <label><input type="checkbox" id="isUsed" runat="server" class="form-checkbox"/> 正常使用</label>
                    <%--<label><input type="checkbox" id="isLogin" runat="server" class="form-checkbox"/> 登录状态</label>--%>
                </td>
            </tr>
            <tr>
                <th>备注</th>
                <td><asp:TextBox ID="note" runat="server" class="form-input" MaxLength="200" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>&nbsp;</th>
                <td>
                    <asp:Button id="Button1" runat="server" class="btn btn-primary" Text="确&nbsp;&nbsp;认" OnClick="Button1_Click" />
                    <button class="btn btn-primary" onclick="location.href=location.href">刷&nbsp;&nbsp;新</button>
                    <asp:Button id="Button21" runat="server" class="btn btn-primary" Text="删&nbsp;&nbsp;除" OnClick="Button21_Click" OnClientClick="return confirm('确认删除？')" />
                    <asp:Button id="Button22" runat="server" class="btn btn-primary" Text="密码重置" OnClick="Button22_Click" OnClientClick="return confirm('确认重置？')" />
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
            setPass();
        </script>
    </div>
	<%--<div id="treePanel2" style="display:none">
        <NineRays:FlyTreeView ID="TreeView2" runat="server" Width="398px" Height="450px" ImageSet="Office2003" BackColor="White" BorderWidth="1px" BorderColor="silver" SlideEffect="True" DrawLines="true" Padding="1px"
            EnableFullRowEvents="true" ContentClickExpands="false" PathSeparator="\" OnInitializedJavascript="onInit2" OnSelectedNodeChangedJavascript="onChanged2" OnPopulateNodes="TreeView2_PopulateNodes">
            <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
            <SelectedStyle RowBackColor="#dddddd"/>
            <HoverStyle RowBackColor="#dddddd"  Font-Underline="True" />
            <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
        </NineRays:FlyTreeView>
        <script type="text/javascript">
            var tree2 = new TreeDropDown("treePanel2", "<%=popedom.ClientID %>", "<%=popedom1.ClientID %>");
            function onInit2(to) { tree2.treeview = to; }
            function onChanged2(cid, on, n) { tree2.onSelectedNodeChangedHandler(cid, on, n); }
            setPass();
        </script>
    </div>--%>
</asp:Content>