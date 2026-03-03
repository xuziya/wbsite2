<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/table.master" ValidateRequest="false" CodeFile="2manager.aspx.cs" Inherits="Admin_sys_manager_manager" %>
<%@ Register Assembly="NineRays.WebControls.FlyTreeView" Namespace="NineRays.WebControls" TagPrefix="NineRays" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div style="height:40px"></div>
    <script type="text/javascript">
        (function ()
        {
            var t1 = new Table();
            /*多字段排序*/
            t1.state.order = false;
            /*标题*/
            t1.title = "<%=GetPath() %>";
            /*批量*/
            t1.array.batchs = ["禁用", "启用"];
            /*菜单*/
            t1.array.menus = "<%=GetOperHTML() %>";
            /*查询*/
            t1.addSearch("text", "管理员姓名", "t1_name", "like");
            t1.addSearch("dropdown", "所属机构", "t1_organSole", "=", "150px");
            t1.addSearch("time", "添加时间", "t1_createDate");
            /*数据*/
            t1.pager.tname = "[admin_per_manager] as t1 left join [admin_organ] as o1 on t1.organSole=o1.sole";
            /*列*/
            t1.addColumn("60", "t1.id", "编号", "center", "0");
            t1.addColumn("150", "t1.name=t1_name", "管理员姓名", "center");
            t1.addColumn("300", "o1.name=o1name", "所属机构", "center");
            t1.addColumn("100", "t1.type", "管理员类型", "center");
            t1.addColumn("150", "t1.uid", "管理员账号", "center", "0");
            t1.addColumn("80", "t1.isUsed", "状态", "center");
            t1.addColumn("100", "m1.name=m1_name", "添加人", "center");
            t1.addColumn("130", "t1.createDate", "添加时间", "center", "0");
            /*行*/
            t1.template_tr = function (newRow, cells)
            {
                var id = cells[1], sole = cells[cells.length - 1];
                for (var columns = t1.array.columns, i = 0; i < columns.length; i++)
                {
                    var newCell = $("<td></td>"), value = cells[i + 1] + "";
                    if (i == 1) { newCell = $("<td style='cursor:pointer'><a style='color:green'> [ " + value + " ] </a></td>").click(function () { top.openWindows(window, "_sys/2manager/2manager_ad.aspx?oper=up&id=" + id, "修改管理员账号信息"); }); }
                    else if (i == 4) { newCell = t1.getEditHtml(newCell, id, sole, value, "_sys/1self/1msg.aspx?isWin=true&id=" + id, "查看管理员账号信息", 1620, 770); }
                    else if (i == 5) { newCell = t1.getUsedHtml(newCell, id, sole, value); }
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
            EnableFullRowEvents="true" ContentClickExpands="false" PathSeparator="\" OnInitializedJavascript="onInit1" OnSelectedNodeChangedJavascript="onChanged1" OnPopulateNodes="TreeView1_PopulateNodes">
            <DefaultStyle Font-Names="Tahoma" Font-Size="14px" ForeColor="Black" RowHeight="23px" Padding="0px;5px;0px;0px" />
            <SelectedStyle RowBackColor="#dddddd"/>
            <HoverStyle RowBackColor="#dddddd"  Font-Underline="True" />
            <SelectedHoverStyle BorderStyle="NotSet"></SelectedHoverStyle>
        </NineRays:FlyTreeView>
        <script type="text/javascript">
            var tree1 = new TreeDropDown("treePanel1", "t1_organSole1", "t1_organSole");
            function onInit1(to) { tree1.treeview = to; }
            function onChanged1(cid, on, n) { tree1.onSelectedNodeChangedHandler(cid, on, n); }
        </script>
    </div>
</asp:Content>