using System;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

/// <summary>修改密码</summary>
public partial class Admin_sys_self_password : AdminBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        uid.InnerHtml = GetUid();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (pass.Text == "") { this.Alert("请输入旧密码"); return; }
        if (pass.Text.Trim() != GetPass()) { this.Alert("旧密码错误"); return; }
        if (CitySole.Text == "") { this.Alert("请输入新密码"); return; }
        if (CityName.Text == "") { this.Alert("请重复新密码"); return; }
        if (CitySole.Text != CityName.Text) { this.Alert("两次输入的密码不一致"); return; }

        //发送sql
        bool result = skin.ExecuteSql("update admin_per_manager set pass='" + CitySole.Text.Trim() + "' where sole='" + GetSole() + "'") > 0;
        if (result)
        {
            this.Script("alert('操作成功，请重新登陆');top.location.assign('/Admin/logout.aspx')");
        }
        else
        {
            this.Alert("操作失败");
        }
    }
}