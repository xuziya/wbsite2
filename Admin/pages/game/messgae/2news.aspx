<%@ Page Language="C#" MasterPageFile="~/Admin/master/table.master" AutoEventWireup="true" CodeFile="2news.aspx.cs" Inherits="Admin_pages_game_messgae_2news" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div style="height:40px"></div>
    <script type="text/javascript">
        (function ()
        {
            var t1 = new Table();
            t1.title = "<%=GetPath() %>";
            t1.array.batchs = ["禁用", "启用"];
            t1.array.menus = "<%=GetOperHTML() %>";
            t1.addSearch("text", "标题", "t1_title", "like");
            t1.addSearch("select", "使用状态", "t1_isUsed", "=");
            t1.addSearch("time", "留言时间", "t1_createDate");
            t1.pager.tname = "[message_news] as t1";
            t1.addColumn("60", "t1.id", "编号", "center", "0");
            t1.addColumn("150", "t1.title", "标题");
            t1.addColumn("300", "t1.intro", "简介");
            t1.addColumn("100", "m1.name=m1name", "添加人", "center");
            t1.addColumn("130", "t1.createDate", "添加时间", "center", "0");
            t1.addColumn("100", "t1.isUsed", "启用/禁用", "center");
            t1.pager.value2 = " t1.type='通知' ";
            t1.template_tr = function (newRow, cells)
            {
                var id = cells[1], sole = cells[cells.length - 1];
                for (var columns = t1.array.columns, i = 0; i < columns.length; i++)
                {
                    var newCell = $("<td></td>"), value = cells[i + 1];
                    if (i == 1) { newCell = t1.getEditHtml(newCell, id, sole, value, "/Admin/pages/game/messgae/2news_ad.aspx?oper=up&id=" + id, "回复留言"); }
                    else if (i == 5) { newCell = t1.getUsedHtml(newCell, id, sole, value); }
                    else { newCell.html(value != "" ? value : "&nbsp;"); }
                    newRow.append(newCell.css("text-align", columns[i].align));
                }
                return newRow;
            };
            t1.init();
        })();
    </script>
</asp:Content>