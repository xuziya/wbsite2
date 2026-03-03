<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/form.master" CodeFile="2server.aspx.cs" Inherits="Admin_sys_setting_server" %>
<%--<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>--%>

<asp:Content ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
	<div class="container-fluid">
        <table class="table table-bordered table-hover">
            <tr>
                <th width="170">服务器ip地址<span class="form-red">*</span><br /><span class="form-tip">系统所在服务器的ip地址</span></th>
                <td colspan="2"><asp:TextBox ID="v1" runat="server" class="form-input" Width="300px" MaxLength="20" autocomplete="off"></asp:TextBox></td>
            </tr>
            <tr>
                <th>服务器端口号<span class="form-red">*</span><br /><span class="form-tip">系统所在服务器的端口号</span></th>
                <td colspan="2"><asp:TextBox ID="v2" runat="server" class="form-input" Width="300px" MaxLength="6" autocomplete="off"></asp:TextBox></td>
            </tr>
            <%--<tr>
                <th width="170">行政区域<br/><b class="form-tip">当前系统使用的顶级行政区域</b></th>
                <td width="120">
                    <asp:DropDownList ID="area_type" runat="server" class="form-select" Width="120px" AutoPostBack="True" onselectedindexchanged="area_type_SelectedIndexChanged">
                        <asp:ListItem Value="0">国家</asp:ListItem>
                        <asp:ListItem Value="1">省份</asp:ListItem>
                        <asp:ListItem Value="2">城市</asp:ListItem>
                        <asp:ListItem Value="3">区县</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="v3_1" runat="server" class="form-input" Width="400px" MaxLength="40" autocomplete="off"></asp:TextBox>
                    <asp:HiddenField ID="v3_2" runat="server"/>
                </td>
            </tr>--%>
            <tr>
                <td style="padding:20px 200px" colspan="3">
                    <asp:Button id="Button1" runat="server" class="btn btn-primary" Text="确&nbsp;&nbsp;认" OnClick="Button1_Click"/>
                    <button class="btn btn-primary" onclick="location.href=location.href">刷&nbsp;&nbsp;新</button>
                </td>
            </tr>
        </table>
    </div>
	<%--<div id="treePanel1" style="display:none">
        <NineRays:FlyTreeView ID="TreeView1" runat="server" Width="397px" Height="450px" ImageSet="Office2003" BackColor="White" BorderWidth="1px" BorderColor="silver" SlideEffect="True" DrawLines="true" Padding="1px"
            EnableFullRowEvents="true" ContentClickExpands="false" PathSeparator="\" OnInitializedJavascript="onInit1" OnSelectedNodeChangedJavascript="onChanged1" OnPopulateNodes="TreeView1_PopulateNodes">
            <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
            <SelectedStyle RowBackColor="#dddddd"/>
            <HoverStyle RowBackColor="#dddddd"  Font-Underline="True"/>
            <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
        </NineRays:FlyTreeView>
        <script type="text/javascript">
            var tree1 = new TreeDropDown("treePanel1", "<%=v3_1.ClientID %>", "<%=v3_2.ClientID %>");
            function onInit1(to) { tree1.treeview = to; }
            function onChanged1(cid, on, n) { tree1.onSelectedNodeChangedHandler(cid, on, n); }
        </script>
    </div>--%>
</asp:Content>