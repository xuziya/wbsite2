<%@ Page Language="C#" MasterPageFile="~/Admin/master/table.master" AutoEventWireup="true" CodeFile="1leave.aspx.cs" Inherits="Admin_pages_game_messgae_1leave" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div style="height:40px"></div>
    <script type="text/javascript">
        (function ()
        {
            var t1 = new Table();
            t1.title = "<%=GetPath() %>";
            t1.array.menus = "<%=GetOperHTML() %>";
            t1.addSearch("text", "学员名称", "c1_name", "like");
            t1.addSearch("text", "标题", "t1_title", "like");
            t1.addSearch("time", "留言时间", "t1_createDate");
            t1.pager.tname = "[message_leave] as t1 left join [student_info] as c1 on t1.createSole=c1.sole left join [admin_per_manager] as m1 on t1.sole2=m1.sole";
            t1.addColumn("60", "t1.id", "编号", "center", "0");
            t1.addColumn("150", "c1.name=c1name", "学员名称");
            t1.addColumn("150", "t1.title", "标题");
            t1.addColumn("200", "t1.content", "内容");
            t1.addColumn("200", "t1.replay", "回复内容", "center");
            t1.addColumn("100", "m1.name=m1name", "回复人", "center");
            t1.addColumn("100", "t1.date2", "回复时间", "center");
            t1.addColumn("130", "t1.createDate", "留言时间", "center", "0");
            t1.pager.value2 = " t1.type='留言' ";
            t1.pager.auto = false;
            t1.template_tr = function (newRow, cells)
            {
                var id = cells[1], sole = cells[cells.length - 1];
                for (var columns = t1.array.columns, i = 0; i < columns.length; i++)
                {
                    var newCell = $("<td></td>"), value = cells[i + 1];
                    if (i == 2) { newCell = t1.getEditHtml(newCell, id, sole, value, "/Admin/pages/game/messgae/1leave_up.aspx?oper=up&id=" + id, "回复留言"); }
                    else if (i == 3) { newCell.html(value.length <= 30 ? value : value.substr(0, 30) + "..."); }
                    else { newCell.html(value != "" ? value : "&nbsp;"); }
                    newRow.append(newCell.css("text-align", columns[i].align));
                }
                return newRow;
            };
            t1.init();
        })();
    </script>
</asp:Content>