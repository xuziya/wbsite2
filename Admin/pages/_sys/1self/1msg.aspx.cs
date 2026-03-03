using System;
using harry.DAL.Sql.Sql2008;
using Models.Admin.System;

/// <summary>个人信息</summary>
public partial class Admin_sys_self_msg1 : AdminBasePage
{
    public ManagerInfo manager;
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        //获取个人信息
        manager = new Skin<ManagerInfo>().Model(Request["id"] ?? GetSole());
        manager.OrganSole = skin.ExecuteScalar("select name from [admin_organ] where sole='" + manager.OrganSole + "'").ToString();
        manager.CreateSole = skin.ExecuteScalar("select name from [admin_per_manager] where sole='" + manager.CreateSole + "'").ToString();
    }

    /// <summary>当前页面是否以窗体显示</summary>
    public string IsWindow()
    {
        return (Request["isWin"] ?? "false") == "true" ? "" : "display:none";
    }
}