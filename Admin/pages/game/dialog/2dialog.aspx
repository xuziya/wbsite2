<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/master/table.master" AutoEventWireup="true" CodeFile="2dialog.aspx.cs" Inherits="Admin_pages_game_dialog_2dialog" %>
<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div style="height:40px"></div>
    <script type="text/javascript">
        (function ()
        {
            var t1 = new Table();
            t1.title = "<%=GetPath() %>";
            t1.array.batchs = ["禁用", "启用"];
            t1.array.menus = "<%=GetOperHTML() %>";
            t1.addSearch("dropdown", "关联触点", "t1_memberSole", "=");
            t1.addSearch("select", "使用状态", "t1_isUsed", "=");
            t1.addSearch("time", "添加时间", "t1_createDate");
            t1.pager.tname = "dialog2_info as t1 left join member_info as pi1 on t1.memberSole=pi1.sole left join [admin_per_manager] as m1 on t1.createSole=m1.id";
            t1.addColumn("60", "t1.id", "编号", "center", "0");
            t1.addColumn("250", "pi1.name=pi1_name", "客户画像", "center");
            t1.addColumn("250", "t1.type1=t1_type1", "类型", "center");
            t1.addColumn("250", "t1.type2=t1_type2", "类型", "center");

            t1.addColumn("300", "t1.content1", "内容1", "left");
            t1.addColumn("300", "t1.reply1", "回复1", "left");
            t1.addColumn("80", "t1.point1", "得分1", "center");

            t1.addColumn("300", "t1.content2", "内容2", "left");
            t1.addColumn("300", "t1.reply2", "回复2", "left");
            t1.addColumn("80", "t1.point2", "得分2", "center");

            t1.addColumn("300", "t1.content3", "内容3", "left");
            t1.addColumn("300", "t1.reply3", "回复3", "left");
            t1.addColumn("80", "t1.point3", "得分3", "center");

            t1.addColumn("100", "m1.name=m1_name", "添加人", "center");
            t1.addColumn("130", "t1.createDate", "添加时间", "center", "0");
            t1.addColumn("100", "t1.isUsed", "启用/禁用", "center");
            t1.addColumn("200", "t1.note", "备注");
            //t1.pager.value2 = " t1.type='个人' ";
            t1.template_tr = function (newRow, cells)
            {
                var id = cells[1], sole = cells[cells.length - 1];
                for (var columns = t1.array.columns, i = 0; i < columns.length; i++)
                {
                    var newCell = $("<td></td>"), value = cells[i + 1] + "";
                    if (i == 4) { newCell = t1.getEditHtml(newCell, id, sole, value, "/Admin/pages/game/dialog/2dialog_ad.aspx?oper=up&id=" + id, "修改学员信息"); }
                    else if (i == 15) { newCell = t1.getUsedHtml(newCell, id, sole, value); }
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
            EnableFullRowEvents="true" ContentClickExpands="false" PathSeparator="\" OnInitializedJavascript="onInit1" OnSelectedNodeChangedJavascript="onChanged1" onpopulatenodes="TreeView1_PopulateNodes">
            <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px"/>
            <SelectedStyle RowBackColor="#dddddd"/>
            <HoverStyle RowBackColor="#dddddd"  Font-Underline="True" />
            <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
        </NineRays:FlyTreeView>
        <script type="text/javascript">
            var tree1 = new TreeDropDown("treePanel1", "t1_memberSole1", "t1_memberSole");
            function onInit1(to) { tree1.treeview = to; }
            function onChanged1(cid, on, n) { tree1.onSelectedNodeChangedHandler(cid, on, n); }
        </script>
    </div>
</asp:Content>