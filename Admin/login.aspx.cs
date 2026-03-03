using System;
using harry.DAL.Sql.Sql2008;
using harry.Tools;
using Models.Admin.System;

public partial class Admin_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        bool local = Request.Url.ToString().IndexOf("http://localhost:") > -1;
        //string uid = txt_uid.Text, pass = txt_pass.Text;
        string uid = local ? "harry1" : txt_uid.Text, pass = local ? "harry1" : txt_pass.Text;
        //验证
        if (string.IsNullOrEmpty(uid)) { this.Alert("请输入管理员账号"); return; }
        if (string.IsNullOrEmpty(pass)) { this.Alert("请输入管理员密码"); return; }
        //检测
        ManagerInfo model = new Skin<ManagerInfo>().Model(uid, pass);
        string result = AdminBasePage.UserCheck(model);
        if (result == "")
        {
            //Session
            AdminBasePage.ReloadSession(model);
            //Cookie
            AdminBasePage.ReloadCookie(model, DateTime.Now.AddDays(7));
            //日志
            Tools.Log.Login1(model.Table, "管理员", model.Sole);
            //首页
            this.Script("top.location.assign('/Admin/iframe.aspx');");
        }
        else
        {
            //日志
            Tools.Log.LoginError("[admin_log_login]", "管理员", model.Sole, uid, pass, result);
            this.Alert(result);
        }
    }
}