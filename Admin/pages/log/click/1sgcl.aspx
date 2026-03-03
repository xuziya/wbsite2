<%@ Page Language="C#" MasterPageFile="~/Admin/master/table.master" AutoEventWireup="true" CodeFile="1sgcl.aspx.cs" Inherits="Admin_pages__sys_log_click_1sgcl" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div style="height:40px"></div>
    <script type="text/javascript">
        (function ()
        {
            var t1 = new Table();
            t1.title = "<%=GetPath() %>";
            t1.addSearch("time", "点击时间", "t1_createDate");
            t1.pager.tname = "log_sgcldj as t1 left join admin_per_manager as m1 on t1.createSole=m1.sole";
            t1.addColumn("60", "t1.id", "编号", "center", "0");
            t1.addColumn("100", "t1.lev", "菜单等级", "center");
            t1.addColumn("200", "t1.path", "全路径", "left", "0");
            t1.addColumn("120", "t1.lev1", "1级菜单", "center");
            t1.addColumn("120", "t1.lev2", "2级菜单", "center");
            t1.addColumn("120", "t1.lev3", "3级菜单", "center");
            t1.addColumn("120", "t1.lev4", "4级菜单", "center");
            t1.addColumn("130", "t1.createDate", "点击时间", "center", "0");
            t1.init();
        })();
    </script>
</asp:Content>