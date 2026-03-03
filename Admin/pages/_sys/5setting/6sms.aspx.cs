using System;
using System.Data;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

/// <summary>邮件设置</summary>
public partial class Admin_setting_sms : AdminBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            //显示信息
            DataTable dt = skin.GetDT("select top 1 * from [admin_setting] where type='系统设置' and name='短信设置'");
            if (dt.Rows.Count > 0)
            {
                v1.Text = dt.Rows[0]["v1"].ToString();
                v2.Text = dt.Rows[0]["v2"].ToString();
                v3.Text = dt.Rows[0]["v3"].ToString();
                v4.Text = dt.Rows[0]["v4"].ToString();
                v5.Text = dt.Rows[0]["v5"].ToString();
                v6.Text = dt.Rows[0]["v6"].ToString();
            }
        }
    }

    /// <summary>提交信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (v1.Text == "") { this.Alert("请输入网址"); return; }
        if (v2.Text == "") { this.Alert("请输入API"); return; }
        if (v3.Text == "") { this.Alert("请输入账号"); return; }
        if (v4.Text == "") { this.Alert("请输入密码"); return; }
        if (v5.Text == "") { this.Alert("请输入服务到期模板"); return; } if (v5.Text.Length >= 200) { this.Alert("服务到期模板内容最大长度 [ 200字 ]"); }
        if (v6.Text == "") { this.Alert("请输入档案到期模板"); return; } if (v6.Text.Length >= 200) { this.Alert("档案到期模板内容最大长度 [ 200字 ]"); }
        this.Alert(skin.ExecuteSql("update [admin_setting] set v1='" + v1.Text + "',v2='" + v2.Text + "',v3='" + v3.Text + "',v4='" + v4.Text + "',v5='" + v5.Text + "',v6='" + v6.Text + "' where type='系统设置' and name='短信设置'") > 0);
    }
}