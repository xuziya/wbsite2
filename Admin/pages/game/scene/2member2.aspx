<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/master/table.master" AutoEventWireup="true" CodeFile="2member2.aspx.cs" Inherits="Admin_pages_game_scene_2member2" %>
<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div style="height:40px"></div>
    <script type="text/javascript">
        (function () {
            var t1 = new Table();
            t1.title = "<%=GetPath() %>";
            t1.array.batchs = ["禁用", "启用"];
            t1.array.menus = "<%=GetOperHTML() %>";
            t1.addSearch("text", "学员名称", "t1_name", "like");
            t1.addSearch("dropdown", "所属场景", "t1_sceneSole", "=");
            t1.addSearch("select", "使用状态", "t1_isUsed", "=");
            t1.addSearch("time", "添加时间", "t1_createDate");
            t1.pager.tname = "member_info as t1 left join scene_info as ci1 on t1.sceneSole=ci1.sole left join place_info as pi1 on t1.placeSole=pi1.sole left join [admin_per_manager] as m1 on t1.createSole=m1.id";
            t1.addColumn("60", "t1.id", "编号", "center", "0");
            t1.addColumn("250", "t1.name=t1_name", "客户姓名", "center");
            t1.addColumn("250", "t1.character1=t1_character1", "客户人设", "center");
            t1.addColumn("250", "ci1.name=ci1_name", "所属场景", "center");
            //t1.addColumn("250", "pi1.name=pi1_name", "触点", "center");
            t1.addColumn("200", "t1.sex", "性别", "center");
            t1.addColumn("200", "t1.age", "年龄", "center");

            t1.addColumn("150", "t1.shuxing1", "合约", "center");
            t1.addColumn("150", "t1.shuxing2", "价值", "center");
            t1.addColumn("150", "t1.shuxing3", "流量", "center");
            t1.addColumn("150", "t1.shuxing4", "资费", "center");
            t1.addColumn("150", "t1.shuxing5", "融合", "center");
            t1.addColumn("150", "t1.shuxing6", "视频", "center");
            t1.addColumn("150", "t1.shuxing7", "权益", "center");
            t1.addColumn("150", "t1.shuxing8", "职业", "center");
            t1.addColumn("150", "t1.shuxing9", "地域", "center");
            t1.addColumn("200", "t1.shuxing10", "家庭情况", "center");

            t1.addColumn("100", "m1.name=m1_name", "添加人", "center");
            t1.addColumn("130", "t1.createDate", "添加时间", "center", "0");
            t1.addColumn("100", "t1.isUsed", "启用/禁用", "center");
            t1.addColumn("200", "t1.note", "备注");
            t1.pager.value2 = " t1.type='家庭' ";
            t1.template_tr = function (newRow, cells)
            {
                var id = cells[1], sole = cells[cells.length - 1];
                for (var columns = t1.array.columns, i = 0; i < columns.length; i++)
                {
                    var newCell = $("<td></td>"), value = cells[i + 1] + "";
                    if (i == 1) { newCell = t1.getEditHtml(newCell, id, sole, value, "/Admin/pages/game/scene/2member2_ad.aspx?oper=up&id=" + id, "修改学员信息"); }
                    else if (i == 18) { newCell = t1.getUsedHtml(newCell, id, sole, value); }
                    else { newCell.html(value != "" ? value : "&nbsp;"); }
                    newRow.append(newCell.css("text-align", columns[i].align));
                }
                return newRow;
            };
            t1.init();
        })();
    </script>
	<div id="treePanel1" style="display:none">
        <NineRays:FlyTreeView ID="TreeView1" runat="server" Width="350px" Height="450px" ImageSet="Office2003" BackColor="White" BorderWidth="1px" BorderColor="silver" SlideEffect="True" DrawLines="true" Padding="1px"
            EnableFullRowEvents="true" ContentClickExpands="false" PathSeparator="\" OnInitializedJavascript="onInit1" OnSelectedNodeChangedJavascript="onChanged1">
            <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
            <SelectedStyle RowBackColor="#dddddd"/>
            <HoverStyle RowBackColor="#dddddd"  Font-Underline="True" />
            <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
        </NineRays:FlyTreeView>
        <script type="text/javascript">
            var tree1 = new TreeDropDown("treePanel1", "t1_sceneSole1", "t1_sceneSole");
            function onInit1(to) { tree1.treeview = to; }
            function onChanged1(cid, on, n) { tree1.onSelectedNodeChangedHandler(cid, on, n); }
        </script>
    </div>
</asp:Content>