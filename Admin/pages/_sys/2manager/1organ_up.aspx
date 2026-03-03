<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/Master/form.master" CodeFile="1organ_up.aspx.cs" Inherits="Admin_sys_manager_organ_up" %>
<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">	
    <table class="table table-bordered table-hover">
        <tr style="display:none">
            <th width="100px">机构类型</th>
            <td colspan="3">
                <asp:DropDownList ID="type" runat="server" class="form-select" Width="206px">
                    <asp:ListItem Value="总行">总行</asp:ListItem>
                    <asp:ListItem Value="分行">分行</asp:ListItem>
                    <asp:ListItem Value="中支">中支</asp:ListItem>
                    <asp:ListItem Value="支行">支行</asp:ListItem>
                    <asp:ListItem Value="总行机构">总行机构</asp:ListItem>
                    <asp:ListItem Value="分行机构">分行机构</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <th>行政区域<span class="form-red">*</span></th>
            <td colspan="3">
                <asp:TextBox ID="areaName" runat="server" class="form-input" MaxLength="40" autocomplete="off"></asp:TextBox>
                <asp:HiddenField ID="areaSole" runat="server" />
            </td>
        </tr>
        <tr>
            <th width="100px">机构名称<span class="form-red">*</span><br /><span class="form-tip">官方通用名称，便于识别</span></th>
            <td colspan="3"><asp:TextBox ID="name" runat="server" class="form-input" Width="300px" MaxLength="20" autocomplete="off"></asp:TextBox></td>
        </tr>
        <tr style="display:none">
            <th>行号</th>
            <td colspan="3"><asp:TextBox ID="popedom" runat="server" class="form-input" MaxLength="8" autocomplete="off" onkeyup="this.value=this.value.replace(/[^-|\d*]/,'')" onafterpaste="harry.onlyInt(this)"></asp:TextBox></td>
        </tr>
        <tr style="display:none">
            <th>详细地址<br /><span class="form-tip">实际物理地址</span></th>
            <td colspan="3"><asp:TextBox ID="string1" runat="server" class="form-input" MaxLength="40" autocomplete="off"></asp:TextBox></td>
        </tr>
        <tr>
            <th>排序</th>
            <td colspan="3"><asp:TextBox ID="indexs" runat="server" class="form-input" Width="300px" MaxLength="2" autocomplete="off" onkeyup="this.value=this.value.replace(/[^-|\d*]/,'')" onafterpaste="harry.onlyInt(this)"></asp:TextBox></td>
        </tr>
        <tr style="display:none"><th colspan="3">全 路 径</th><td><asp:TextBox ID="path" runat="server" class="form-input" MaxLength="100" autocomplete="off"></asp:TextBox></td></tr>
        <tr><th>备注</th><td colspan="3"><asp:TextBox ID="note" runat="server" class="form-input" MaxLength="100" autocomplete="off" style="width:100%"></asp:TextBox></td></tr>
        <tr><td>&nbsp;</td><td colspan="3"><label><input type="checkbox" id="isUsed" runat="server" class="form-checkbox"/> 正常使用</label></td></tr>
        <tr>
            <td width="100px">自动编码</td><td runat="server" id="id">&nbsp;</td>
            <td width="100px">唯一编码</td><td runat="server" id="sole">&nbsp;</td>
        </tr>
        <tr>
            <td>层级编码</td><td runat="server" id="code">&nbsp;</td>
            <td>菜单等级</td><td runat="server" id="lev">&nbsp;</td>
        </tr>
        <tr>
            <td>创 建 人</td><td runat="server" id="createSole">&nbsp;</td>
            <td>创建时间</td><td runat="server" id="createDate">&nbsp;</td>
        </tr>
        <tr>
            <td style="padding:20px 200px" colspan="4">
                <asp:Button id="Button1" runat="server" class="btn btn-primary" Text="确&nbsp;&nbsp;认" OnClick="Button1_Click" />
                <button class="btn btn-primary" onclick="location.href=location.href">刷&nbsp;&nbsp;新</button>
                <asp:Button id="Button2" runat="server" class="btn btn-primary" Text="删除节点" onclick="Button2_Click" OnClientClick="return confirm('确认删除当前选择节点？')" />
            </td>
        </tr>
    </table>
	<div id="treePanel1" style="display:none">
        <NineRays:FlyTreeView ID="TreeView1" runat="server" Width="398px" Height="450px" ImageSet="Office2003" BackColor="White" BorderWidth="1px" BorderColor="silver" SlideEffect="True" DrawLines="true" Padding="1px"
            EnableFullRowEvents="true" ContentClickExpands="false" PathSeparator="\" OnInitializedJavascript="onInit1" OnSelectedNodeChangedJavascript="onChanged1" OnPopulateNodes="TreeView1_PopulateNodes">
            <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
            <SelectedStyle RowBackColor="#dddddd"/>
            <HoverStyle RowBackColor="#dddddd"  Font-Underline="True" />
            <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
        </NineRays:FlyTreeView>
        <script type="text/javascript">
            var tree1 = new TreeDropDown("treePanel1", "<%=areaName.ClientID %>", "<%=areaSole.ClientID %>");
            function onInit1(to) { tree1.treeview = to; }
            function onChanged1(cid, on, n) { tree1.onSelectedNodeChangedHandler(cid, on, n); }
        </script>
    </div>
</asp:Content>