<%@ Page Language="C#" AutoEventWireup="true"%>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        //harry.DAL.Sql.Sql2008.skin.ExecuteSql("update [admin_per_manager] set [isLogin]=0,[loginLastDate]='' where sole='" + AdminBasePage.GetSole() + "'");
        AdminBasePage.RemoveCookie();
        AdminBasePage.RemoveSession();
        System.Web.HttpContext.Current.Response.Redirect("/Admin/login.aspx");
    }
</script>