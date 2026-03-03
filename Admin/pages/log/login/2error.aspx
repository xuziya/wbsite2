<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/master/table.master" CodeFile="2error.aspx.cs" Inherits="Admin_pages_sys_log_2error" %>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div style="height:40px"></div>
    <script type="text/javascript">
        (function ()
        {
            var t1 = new Table();
            t1.title = "<%=GetPath() %>";
            t1.addSearch("time", "操作时间", "t1_createDate");
            t1.pager.tname = "log_error";
            t1.addColumn("60", "t1.id", "编号", "center", "0");
            //t1.addColumn("100", "t1.type", "管理员类型", "center");
            //t1.addColumn("100", "t1.name=t1_name", "管理员姓名", "center");
            t1.addColumn("200", "t1.targetSite", "异常方法", "center");
            t1.addColumn("200", "t1.source", "对象名称", "right", "0");
            t1.addColumn("130", "t1.createDate", "操作时间", "center", "0");
            //t1.addColumn("400", "t1.note", "备注");
            t1.addColumn("400", "t1.stackTrace", "堆栈字符串", "center");
            t1.init();
        })();
    </script>
</asp:Content>