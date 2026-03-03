<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/form.master" CodeFile="5manager_role_menu.aspx.cs" Inherits="Admin_sys_popedom_manager_role_menu" %>
<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
    <div class="container-fluid">
        <div>
            <div class="tree_panel" style="width:400px;height:590px;float:left">
                <div class="tree_leftmenu" style="height:590px"><table class="tree_leftmenu_controls"><tr><td><img alt="" src="/Admin/img/tree/moves_right.gif" onclick="tree1.open(true)" title="强制展开所有节点" /></td></tr></table></div>
                <div class="tree_view">
                    <NineRays:FlyTreeView ID="TreeView1" runat="server" Width="100%" Height="100%" ImageSet="Office2003" WideCell="True" OnInitializedJavascript="onInit1" OnNodeEventJavascript="onNodeEvent1">
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
                            //当前节点无法打开、没有子节点
                            if (!targetNode.obj.getPopulateNodesOnDemand() && targetNode.obj.getChildNodes().length == 0)
                            {
                                var a1 = new Ajax();
                                a1.onCom = function (r) { tree2.nodeSelected(r); }
                                a1.start("at=getRoles&sole=" + targetNode.value);
                                var a2 = new Ajax();
                                a2.onCom = function (r) { tree3.nodeSelected(r); }
                                a2.start("at=getMenus2&sole=" + targetNode.value);
                            }
                        };
                    </script>
                </div>
            </div>
            <div class="tree_panel" id="tree_panel2" style="width:400px;height:590px;float:left">
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
                        tree2.node_click_ajax = function (targetNode, onCom)
                        {
                            if (!targetNode.obj.getPopulateNodesOnDemand() && targetNode.obj.getChildNodes().length == 0)
                            {
                                var a = new Ajax();
                                a.onCom = function (r) { tree3.nodeSelected(r); }
                                a.start("at=getMenus1&sole=" + targetNode.value);
                            }
                        };
                    </script>
                </div>
            </div>
            <div class="tree_panel" id="tree_panel3" style="width:400px;height:590px;float:left">
                <div class="tree_leftmenu" style="height:590px"><table class="tree_leftmenu_controls"><tr><td><img alt="" src="/Admin/img/tree/moves_right.gif" onclick="tree3.open(true)" title="强制展开所有节点" /></td></tr></table></div>
                <div class="tree_view">
                    <NineRays:FlyTreeView ID="TreeView3" runat="server" Width="100%" Height="100%" ImageSet="Office2003" WideCell="True" OnInitializedJavascript="onInit3" OnNodeEventJavascript="onNodeEvent3" onpopulatenodes="TreeView3_PopulateNodes">
                        <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
                        <SelectedStyle RowBackColor="#e3ecf3" />
                        <HoverStyle RowBackColor="#0075d0" ForeColor="#ffffff" />
                        <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
                        <NodeTypes><NineRays:FlyNodeType AutoApplyAtLevels="0"><DefaultStyle Font-Bold="true" Font-Size="13px" /></NineRays:FlyNodeType></NodeTypes>
                    </NineRays:FlyTreeView>
                    <script type="text/javascript">
                        var tree3 = new TreeControl();
                        function onInit3(to) { tree3.treeview = to; }
                        function onNodeEvent3(cid, n, et) { tree3.onNodeEventHandler(cid, n, et); }
                    </script>
                </div>
            </div>
            <div style="clear:both"></div>
        </div>
        <div class="btn-box" style=" position:relative;margin-top:20px;left:700px">
            <button class="btn btn-primary" onclick="location.href=location.href">刷&nbsp;&nbsp;新</button>
            <asp:HiddenField ID="tree1_soles" runat="server" />
            <asp:HiddenField ID="tree2_soles" runat="server" />
            <asp:HiddenField ID="tree3_soles" runat="server" />
        </div>
     </div>
</asp:Content>