<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/master/table.master" AutoEventWireup="true" CodeFile="1log.aspx.cs" Inherits="Admin_pages_game_log_1log" %>
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
            t1.addSearch("text", "学员名称", "t1_name", "like");
            t1.addSearch("dropdown", "所属场景", "t1_sceneSole", "=");
            t1.addSearch("time", "完成时间", "t1_createDate");

            t1.pager.tname = "game_reg as t1 left join student_info as ti1 on t1.studentSole=ti1.sole left join scene_info as si1 on t1.sceneSole=si1.sole";
            t1.addColumn("60", "t1.id", "编号", "center", "0");
            t1.addColumn("250", "si1.name as si1name", "场景名称", "center");
            t1.addColumn("250", "ti1.name as ti1name", "游戏者", "center");

            t1.addColumn("150", "t1.type1", "类型", "center");
            t1.addColumn("150", "t1.result", "结果", "center");
            t1.addColumn("150", "t1.value1", "剩余血量", "center");
            t1.addColumn("150", "t1.value2", "情绪值", "center");
            t1.addColumn("150", "t1.value3", "总分", "center");
            t1.addColumn("150", "t1.value4", "得分", "center");
            t1.addColumn("150", "t1.value5", "场景分", "center");
            t1.addColumn("150", "t1.value7", "用时（秒）", "center");
            t1.addColumn("150", "t1.value8", "产品正选率", "center");
            t1.addColumn("150", "t1.value9", "触点正选率", "center");

            t1.addColumn("130", "t1.createDate", "完成时间", "center", "0");
            t1.template_tr = function (newRow, cells)
            {
                var id = cells[1], sole = cells[cells.length - 1];
                for (var columns = t1.array.columns, i = 0; i < columns.length; i++)
                {
                    var newCell = $("<td></td>"), value = cells[i + 1] + "";
                    if (i == 4) { newCell = $("<td style='color:" + (value == "成功" ? "green" : "red") + "'>" + value + "</td>"); }
                    else if (i == 5) { newCell.html(value + "%"); }
                    else if (i == 6) { newCell.html(value + "%"); }
                    else if (i == 11) { newCell.html(value * 100 + "%"); }
                    else if (i == 12) { newCell.html(value * 100 + "%"); }
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