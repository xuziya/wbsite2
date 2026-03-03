<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/master/table.master" AutoEventWireup="true" CodeFile="4resources.aspx.cs" Inherits="Admin_pages_game_scene_4resources" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div style="height:40px"></div>
    <script type="text/javascript">
        (function ()
        {
            var t1 = new Table();
            t1.title = "<%=GetPath() %>";
            t1.array.batchs = ["禁用", "启用"];
            t1.array.menus = "<%=GetOperHTML() %>";
            t1.addSearch("text", "道具名称", "t1_name", "like");
            t1.addSearch("select", "使用状态", "t1_isUsed", "=");
            t1.addSearch("time", "添加时间", "t1_createDate");
            t1.pager.tname = "resources_info as t1 left join [admin_per_manager] as m1 on t1.createSole=m1.id";
            t1.addColumn("60", "t1.id", "编号", "center", "0");
            t1.addColumn("250", "t1.name=t1_name", "道具名称", "center");
            t1.addColumn("150", "t1.num1", "血量增加", "center");
            t1.addColumn("150", "t1.num2", "好感度增加", "center");
            t1.addColumn("100", "m1.name=m1_name", "添加人", "center");
            t1.addColumn("130", "t1.createDate", "添加时间", "center", "0");
            t1.addColumn("100", "t1.isUsed", "启用/禁用", "center");
            t1.addColumn("200", "t1.note", "备注");
            t1.template_tr = function (newRow, cells)
            {
                var id = cells[1], sole = cells[cells.length - 1];
                for (var columns = t1.array.columns, i = 0; i < columns.length; i++)
                {
                    var newCell = $("<td></td>"), value = cells[i + 1] + "";
                    if (i == 1) { newCell = t1.getEditHtml(newCell, id, sole, value, "/Admin/pages/game/scene/4resources_ad.aspx?oper=up&id=" + id, "修改学员信息"); }
                    if (i == 2) { newCell.html(value + " %"); }
                    if (i == 3) { newCell.html(value + " %"); }
                    else if (i == 6) { newCell = t1.getUsedHtml(newCell, id, sole, value); }
                    else { newCell.html(value != "" ? value : "&nbsp;"); }
                    newRow.append(newCell.css("text-align", columns[i].align));
                }
                return newRow;
            };
            t1.init();
        })();
    </script>
</asp:Content>