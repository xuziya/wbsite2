<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/table.master" CodeFile="1login1.aspx.cs" Inherits="Admin_pages_sys_log_1login1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div style="height:40px"></div>
    <script type="text/javascript">
        (function ()
        {
            var t1 = new Table();
            t1.title = "<%=GetPath() %>";
            t1.addSearch("text", "管理员姓名", "m1_name", "like", "100px");
            t1.addSearch("text", "管理员账号", "m1_uid", "like", "100px");
            t1.addSearch("text", "登录ip", "t1_loginIp", "like", "100px");
            t1.addSearch("time", "登录时间", "t1_createDate");
            t1.pager.tname = "admin_log_login as t1 left join admin_per_manager as m1 on t1.createSole=m1.sole left join [admin_organ] as o1 on m1.organSole=o1.sole";
            t1.addColumn("60", "t1.id", "编号", "center", "0");
            t1.addColumn("100", "t1.type", "管理员类型", "center");
            t1.addColumn("100", "m1.name=m1_name", "管理员姓名", "center");
            t1.addColumn("100", "m1.uid", "管理员账号", "center");
            t1.addColumn("200", "o1.name=o1name", "所属机构", "center");
            t1.addColumn("100", "t1.indexs", "登陆次数", "right", "0");
            t1.addColumn("120", "t1.loginIp", "登陆ip", "center");
            t1.addColumn("100", "t1.result", "登录结果", "center");
            t1.addColumn("130", "t1.createDate", "登录时间", "center", "0");
            t1.addColumn("400", "t1.note", "备注");
            t1.pager.value2 = " t1.type='管理员' ";
            t1.init();
        })();
    </script>
</asp:Content>