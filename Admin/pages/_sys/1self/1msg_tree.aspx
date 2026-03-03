<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/form.master" CodeFile="1msg_tree.aspx.cs" Inherits="Admin_sys_self_msg1_tree" %>
<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div class="row row-col-space15">
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
            <div class="tree_panel" style="height:600px">
                <div class="tree_view" style="width:99%">
                    <NineRays:FlyTreeView ID="TreeView1" runat="server" Width="100%" Height="100%" ImageSet="Office2003" WideCell="True" OnInitializedJavascript="onInit1" onpopulatenodes="TreeView1_PopulateNodes">
                        <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
                        <SelectedStyle RowBackColor="#e3ecf3" />
                        <HoverStyle RowBackColor="#0075d0" ForeColor="#ffffff" />
                        <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
                        <NodeTypes><NineRays:FlyNodeType AutoApplyAtLevels="0"><DefaultStyle Font-Bold="true" Font-Size="13px" /></NineRays:FlyNodeType></NodeTypes>
                    </NineRays:FlyTreeView>
                    <script type="text/javascript">
                        var tree1 = new TreeControl();
                        function onInit1(to) { tree1.treeview = to; }
                    </script>
                </div>
            </div>
        </div>
    </div>
    <%--设置父窗体iframe高度--%>
    <script type="text/javascript">$(window.parent.document.getElementById("iframepage")).css("height", $(document.body).width());</script>
</asp:Content>