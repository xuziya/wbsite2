<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/master/form.master" AutoEventWireup="true" CodeFile="4produceType.aspx.cs" Inherits="Admin_pages_game_scene_4produceType" %>
<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%=GetPath() %>
    <div style="height:40px"></div>
    <div class="container-fluid">
        <div class="row row-col-space15">
             <div class="col-lg-3 col-md-4 col-sm-5 col-xs-5">
                <div class="tree_panel">
                    <div class="tree_leftmenu"><table class="tree_leftmenu_controls"><tr><td><img alt="" src="/Admin/img/tree/moves_right.gif" onclick="tree1.open(true)" title="强制展开所有节点" /></td></tr></table></div>
                    <div class="tree_view">
                        <NineRays:FlyTreeView ID="TreeView1" runat="server" Width="100%" Height="100%" ImageSet="Office2003" WideCell="True" onInitializedJavascript="onInit" OnNodeEventJavascript="onNodeEvent" ContextMenuID="ContextMenuFolder" OnContextMenuJavascript="onContextMenu" onpopulatenodes="TreeView1_PopulateNodes">
                            <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
                            <SelectedStyle RowBackColor="#e3ecf3" />
                            <HoverStyle RowBackColor="#0075d0" ForeColor="#ffffff" />
                            <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
                            <NodeTypes><NineRays:FlyNodeType AutoApplyAtLevels="0"><DefaultStyle Font-Bold="true" Font-Size="13px" /></NineRays:FlyNodeType></NodeTypes>
                        </NineRays:FlyTreeView>
                        <NineRays:FlyContextMenu ID="ContextMenuFolder" runat="server"><Items><NineRays:FlyMenuItem Text="添加新节点" Javascript="tree1.menuChecked(item,argument,'add')" /></Items></NineRays:FlyContextMenu>
                        <script type="text/javascript">
                            var tree1 = new TreeControl("<%=tableName %>");
                            tree1.maxLev.add = 2;
                            function onInit(to) { tree1.treeview = to; }
                            function onNodeEvent(cid, n, et) { tree1.onNodeEventHandler(cid, n, et); }
                            function onContextMenu(s, n, e) { tree1.onContextMenuHandler(s, n, e, CFlyContextMenu.getInstanceById("<%=ContextMenuFolder.ClientID%>")); }
                            tree1.node_click_ajax = function (targetNode, onCom) { if (targetNode.lev >= 0) { document.getElementById("iframepage").src = "4produceType_up.aspx?sole=" + targetNode.value + "&" + new Date().getTime(); } }
                        </script>
                    </div>
                </div>
            </div>
             <div class="col-lg-9 col-md-8 col-sm-7 col-xs-7"><iframe id="iframepage" width="100%" frameborder="0" scrolling="no" src="4produceType_up.aspx" onload="this.style.height=this.contentWindow.document.body.scrollHeight+'px'"></iframe></div>
        </div>
    </div>
    <script type="text/javascript">$("#<%=ContextMenuFolder.ClientID %>").css("margin-top", "-45px").css("margin-left", "-10px");</script>
</asp:Content>