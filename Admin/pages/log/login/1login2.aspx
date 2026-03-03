<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/table.master" CodeFile="1login2.aspx.cs" Inherits="Admin_pages_sys_log_1login2" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div style="height:40px"></div>
    <script type="text/javascript">
        (function ()
        {
            var t1 = new Table();
            t1.title = "<%=GetPath() %>";
            t1.addSearch("text", "学员名称", "c1_name", "like", "100px");
            t1.addSearch("text", "学员账号", "c1_uid", "like", "100px");
            t1.addSearch("text", "登录ip", "t1_loginIp", "like", "100px");
            t1.addSearch("time", "登录时间", "t1_createDate");
            t1.pager.tname = "member_log_login as t1 left join student_info as c1 on t1.createSole=c1.sole";
            t1.addColumn("60", "t1.id", "编号", "center", "0");
            //t1.addColumn("100", "t1.type", "学员类型", "center");
            t1.addColumn("100", "c1.name=c1_name", "学员名称", "center");
            t1.addColumn("100", "c1.uid", "学员账号", "center");
            //t1.addColumn("200", "o1.name=o1name", "所属机构", "center");
            t1.addColumn("100", "t1.indexs", "登陆次数", "right", "0");
            t1.addColumn("120", "t1.loginIp", "登陆ip", "center");
            t1.addColumn("100", "t1.result", "登录结果", "center");
            t1.addColumn("130", "t1.createDate", "登录时间", "center", "0");
            t1.addColumn("400", "t1.note", "备注");
            t1.pager.value2 = " t1.type='学员' ";
            t1.init();
        })();
    </script>
</asp:Content>