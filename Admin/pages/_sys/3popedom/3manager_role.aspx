<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/form.master" CodeFile="3manager_role.aspx.cs" Inherits="Admin_sys_popedom_manager_role" %>
<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
    <div class="container-fluid">
        <div>
            <div class="tree_panel" style="width:400px;height:590px;float:left">
                <div class="tree_leftmenu" style="height:590px"><table class="tree_leftmenu_controls"><tr><td><img alt="" src="/Admin/img/tree/moves_right.gif" onclick="tree1.open(true)" title="强制展开所有节点" /></td></tr></table></div>
                <div class="tree_view">
                    <NineRays:FlyTreeView ID="TreeView1" runat="server" Width="100%" Height="100%" ImageSet="Office2003" WideCell="True" OnInitializedJavascript="onInit1" OnNodeEventJavascript="onNodeEvent1" onpopulatenodes="TreeView1_PopulateNodes">
                        <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
                        <SelectedStyle RowBackColor="#e3ecf3" />
                        <HoverStyle RowBackColor="#0075d0" ForeColor="#ffffff" />
                        <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
                        <NodeTypes><NineRays:FlyNodeType AutoApplyAtLevels="0"><DefaultStyle Font-Bold="true" Font-Size="13px" /></NineRays:FlyNodeType></NodeTypes>
                    </NineRays:FlyTreeView>
                    <script type="text/javascript">
                        var tree1 = new TreeControl();
                        function onInit1(to) { tree1.treeview = to; }
                        function onNodeEvent1(cid, n, et) { tree1.onNodeEventHandler(cid, n, et); }
                        tree1.node_click_ajax = function (targetNode, onCom)
                        {
                            if (targetNode.obj.getToolTip() == "账号" && !targetNode.obj.getPopulateNodesOnDemand() && targetNode.obj.getChildNodes().length == 0)
                            {
                                var a = new Ajax();
                                a.onCom = function (r) { tree2.nodeSelected(r); }
                                a.start("at=getMenus&sole=" + targetNode.value);
                            }
                        };
                    </script>
                </div>
            </div>
            <div class="tree_panel" style="width:400px;height:590px;float:left">
                <div class="tree_leftmenu" style="height:590px"><table class="tree_leftmenu_controls"><tr><td><img alt="" src="/Admin/img/tree/moves_right.gif" onclick="tree2.open(true)" title="强制展开所有节点" /></td></tr></table></div>
                <div class="tree_view">
                    <NineRays:FlyTreeView ID="TreeView2" runat="server" Width="100%" Height="100%" ImageSet="Office2003" WideCell="True" OnInitializedJavascript="onInit2" OnNodeEventJavascript="onNodeEvent2" onpopulatenodes="TreeView2_PopulateNodes">
                        <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
                        <SelectedStyle RowBackColor="#e3ecf3" />
                        <HoverStyle RowBackColor="#0075d0" ForeColor="#ffffff" />
                        <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
                        <NodeTypes><NineRays:FlyNodeType AutoApplyAtLevels="0"><DefaultStyle Font-Bold="true" Font-Size="13px" /></NineRays:FlyNodeType></NodeTypes>
                    </NineRays:FlyTreeView>
                    <script type="text/javascript">
                        var tree2 = new TreeControl();
                        function onInit2(to) { tree2.treeview = to; }
                        function onNodeEvent2(cid, n, et) { tree2.onNodeEventHandler(cid, n, et); }
                    </script>
                </div>
            </div>
            <div style="clear:both"></div>
        </div>
        <div class="btn-box" style=" position:relative;margin-top:20px;left:446px">
            <asp:Button id="Button1" runat="server" class="btn btn-primary" Text="确&nbsp;&nbsp;认" OnClick="Button1_Click" OnClientClick="return checkSubmit();" />
            <button class="btn btn-primary" onclick="location.href=location.href">刷&nbsp;&nbsp;新</button>
            <asp:HiddenField ID="tree1_soles" runat="server" />
            <asp:HiddenField ID="tree2_soles" runat="server" />
        </div>
    </div>
    <script type="text/javascript">
        function checkSubmit()
        {
            var sole1 = [], sole2 = [];
            tree1.find(null, function (node) { if (node.getChildNodes().length == 0 && node.getChecked() && node.getToolTip() == "账号") { sole1.push(node.getValue()) }; });
            if (sole1.length == 0) { sole1.push(tree1.getSelected().getValue()); }
            document.getElementById("<%=tree1_soles.ClientID %>").value = sole1.join(",");
            tree2.find(null, function (node) { if (node.getChildNodes().length == 0 && node.getChecked()) { sole2.push(node.getValue()) }; });
            document.getElementById("<%=tree2_soles.ClientID %>").value = sole2.join(",");
        }
        body.onselectstart = function () { return false; }
    </script>
</asp:Content>