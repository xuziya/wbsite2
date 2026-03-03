using System;
using System.Data;
using System.Text;
using harry.DAL.Sql.Sql2008;
using harry.Tools;
using harry.Tools.Web;
using Models.Client;

/// <summary>验证基类 - 学员登录</summary>
public class MemberBasePage : BasePage
{
    /// <summary>本模块根目录</summary>
    public const string PartRoot = "/Member";
    /// <summary>本模块登陆页面的路径</summary>
    public const string LoginPath = "/Member/login.aspx";
    /// <summary>本模块中的Cookie、Session前缀</summary>
    public const string SelfPerfix = ProjectPerfix + "member_";

    /// <summary>检测登陆状态</summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        try
        {
            string sole = GetSole();
            if (sole != "101")
            {
                //检测对页面地址的访问权限
                string filepath = System.Web.HttpContext.Current.Request.FilePath;
                if (filepath == PartRoot + "/index.aspx" || filepath == PartRoot + "/welcome.aspx") { }
                else
                {
                    //if (!CheckPage())
                    //{
                    //    Response.Write("<div style='background:#e5eef5;border:#84b0c7 1px solid;margin:10% auto;width:500px'><h1 style='background:#eee;border-bottom:#84b0c7 1px solid;margin:0px;padding:4px;font-size:14px'>提示：超出权限的操作</h1><p style='margin:0px;padding:15px'>您当前的行为已被记录，如有疑问请联系系统管理员</p></div>");
                    //    Response.End();
                    //}
                }
            }
            ReloadMessage();
        }
        catch { Js.ErrorPage(this, "info1"); }
    }

    /// <summary>根据登陆状态加载信息，无状态则跳转至登陆页面</summary>
    /// <returns></returns>
    protected static MemberInfo ReloadMessage()
    {
        int state = LoginState(SelfPerfix);
        MemberInfo model = null;
        switch (state)
        {
            //Session空、Cookie空
            case 0: { Assign("登陆已过期，请从新登陆", LoginPath); break; }
            //Session有、Cookie空
            case 1:
                {
                    model = (MemberInfo)SessionEx.Get(SelfPerfix + "_model");
                    ReloadCookie(model, DateTime.Now.AddDays(7));
                    break;
                }
            //Session空、Cookie有
            case 2:
                {
                    string uid = CookieEx.Get(SelfPerfix + "uid");
                    string pass = CookieEx.Get(SelfPerfix + "pass");
                    model = new Skin<MemberInfo>().Model(uid, pass);//Manager.GetModel(uid, pass);
                    if (!ReloadSession(model)) { Assign("无效的登陆信息:当前登陆学员账号 [ " + uid + " ]", LoginPath); }
                    break;
                }
            //Session有、Cookie有
            case 3:
                {
                    model = (MemberInfo)SessionEx.Get(SelfPerfix + "_model");
                    break;
                }
        }
        return model;
    }

    #region 获取登陆信息

    /// <summary>
    /// 检测当前登陆的登录状态:
    ///  -1  错误
    ///  0 - Session、Cookie都空
    ///  1 - Session有、Cookie空
    ///  2 - Session空、Cookie有
    ///  3 - Session、Cookie都有
    /// </summary>
    /// <returns></returns>
    public static int LoginState() { return LoginState(SelfPerfix); }

    /// <summary>唯一编号</summary>
    public static string GetSole() { ReloadMessage(); return CookieEx.Get(SelfPerfix + "sole"); }

    /// <summary>名称</summary>
    public static string GetName() { ReloadMessage(); return skin.ExecuteScalar("select name from student_info where sole='" + GetSole() + "'").ToString(); }

    /// <summary>类型</summary>
    public static string GetType() { ReloadMessage(); return CookieEx.Get(SelfPerfix + "type"); }

    /// <summary>年龄</summary>
    public static string GetAge() { ReloadMessage(); return CookieEx.Get(SelfPerfix + "age"); }

    /// <summary>性别</summary>
    public static string GetSex() { ReloadMessage(); return CookieEx.Get(SelfPerfix + "sex"); }

    /// <summary>账号</summary>
    public static string GetUid() { ReloadMessage(); return CookieEx.Get(SelfPerfix + "uid"); }

    /// <summary>密码</summary>
    public static string GetPass() { ReloadMessage(); return CookieEx.Get(SelfPerfix + "pass"); }

    /// <summary>存放路径</summary>
    public static string GetSavePath() { ReloadMessage(); return skin.ExecuteScalar("select savePath1 from student_info where sole='" + GetSole() + "'").ToString(); }

    /// <summary>model</summary>
    public static MemberInfo GetManager() { return ReloadMessage(); }

    #endregion

    #region session、cookie操作

    /// <summary>加载Session</summary>
    /// <param name="uid">账号</param>
    /// <param name="pass">密码</param>
    /// <returns></returns>
    public static bool ReloadSession(string uid, string pass)
    {
        return ReloadSession(new Skin<MemberInfo>().Model(uid, pass));
    }

    /// <summary>加载Session</summary>
    /// <param name="model">学员信息</param>
    /// <returns></returns>
    public static bool ReloadSession(MemberInfo model)
    {
        bool r = model != null;
        if (r)
        {
            SessionEx.Add(SelfPerfix + "_model", model);
        }
        return r;
    }

    /// <summary>清除Session</summary>
    public static void RemoveSession()
    {
        harry.Tools.Web.SessionEx.Del(SelfPerfix + "_model");
    }

    /// <summary>加载Cookie</summary>
    /// <param name="model">学员信息</param>
    /// <param name="expires">过期时间</param>
    /// <returns></returns>
    public static bool ReloadCookie(MemberInfo model, DateTime expires)
    {
        bool r = model != null;
        if (r)
        {
            CookieEx.Add(SelfPerfix + "sole", model.Sole, expires);
            CookieEx.Add(SelfPerfix + "name", model.Name, expires);
            CookieEx.Add(SelfPerfix + "type", model.Type, expires);
            CookieEx.Add(SelfPerfix + "age", model.Age, expires);
            CookieEx.Add(SelfPerfix + "sex", model.Sex, expires);
            CookieEx.Add(SelfPerfix + "uid", model.Uid, expires);
            CookieEx.Add(SelfPerfix + "pass", model.Pass, expires);

            CookieEx.Add(SelfPerfix + "path", model.SavePath1, expires);
        }
        return r;
    }

    /// <summary>清除Cookie</summary>
    public static void RemoveCookie()
    {
        harry.Tools.Web.CookieEx.Del(SelfPerfix + "sole");
        harry.Tools.Web.CookieEx.Del(SelfPerfix + "name");
        harry.Tools.Web.CookieEx.Del(SelfPerfix + "type");
        harry.Tools.Web.CookieEx.Del(SelfPerfix + "uid");
        harry.Tools.Web.CookieEx.Del(SelfPerfix + "pass");
        harry.Tools.Web.CookieEx.Del(SelfPerfix + "path");
    }

    #endregion

    #region 验证登陆信息

    /// <summary>验证登陆信息</summary>
    /// <returns></returns>
    public static string UserCheck()
    {
        return UserCheck(GetManager());
    }

    /// <summary>验证登陆信息</summary>
    /// <param name="uid">账号</param>
    /// <param name="pass">密码</param>
    /// <returns></returns>
    public static string UserCheck(string uid, string pass)
    {
        return UserCheck(new Skin<MemberInfo>().Model(uid, pass));
    }

    /// <summary>验证登陆信息</summary>
    /// <param name="model">学员信息</param>
    /// <returns></returns>
    public static string UserCheck(MemberInfo model)
    {
        string result = "";
        //用户是否存在
        if (model == null || model.Id == null || model.Id == 0) { result = "无效的登陆信息"; }
        ////用户登录状态
        //else if (model.IsLogin != 0) { result = "该用户已登录"; }
        ////用户审核状态
        //else if (model.IsAudit != 1) { result = "信息尚未通过审核，请联系系统管理员"; }
        //用户使用状态
        else if (model.IsUsed != 1) { result = "用户已禁用，请联系系统管理员"; }
        ////用户使用期
        //else if (Convert.ToDateTime(model.Date1).CompareTo(Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd"))) < 0) { result = "学员账号已过期，请联系系统管理员"; }
        ////检测登陆ip
        //else if (model.AllowIp != "")
        //{
        //    string ip = harry.Tools.Web.Ip.GetIP();
        //    string[] allowIP = model.AllowIp.assign(".*", "").Split(',');
        //    bool b = false;
        //    for (int i = 0; i < allowIP.Length; i++)
        //    {
        //        if (ip.IndexOf(allowIP[i]) == 0)
        //        {
        //            b = true;
        //            break;
        //        }
        //    }
        //    if (!b) result = "非法ip";
        //}
        return result;
    }
    #endregion

    #region 查看用户访问权限

    /// <summary>查看用户访问权限</summary>
    /// <returns></returns>
    protected static bool CheckPage()
    {
        string pageUrl = System.Web.HttpContext.Current.Request.FilePath;
        string sql = "select count(menusole) from view_admin_manager_role_menu where mansole='" + GetSole() + "' and (menulinkurl='" + pageUrl + "' or menulinkurl like '" + pageUrl + "%')";
        return skin.ExecuteScalar(sql).ToString() != "0";
    }

    /// <summary>查看用户操作权限 </summary>
    /// <param name="menuName">权限名称</param>
    /// <returns></returns>
    protected static bool CheckMenu(string menuName)
    {
        string pageUrl = System.Web.HttpContext.Current.Request.FilePath;
        string sql = "select count(menusole) from view_admin_manager_role_menu where mansole='" + GetSole() + "' and (menuname='" + menuName + "' or menuname like '" + menuName + "') and (menulinkurl='" + pageUrl + "' or menulinkurl like '" + pageUrl + "%')";
        return skin.ExecuteScalar(sql).ToString() != "0";
    }

    #endregion

    /// <summary>获取用户拥有访问权限的功能菜单</summary>
    /// <returns></returns>
    public string GetOperHTML()
    {
        //根据学员会员等级确定访问权限
        string sole = "104", type = GetType();
        switch (type)
        {
            case "白金会员": { sole = "106"; break; }
            case "高级会员": { sole = "105"; break; }
            case "一般会员": { sole = "104"; break; }
            default: { sole = "104"; break; }
        }

        string groups = string.Empty, mans = AdminBasePage.GetSole(), url = System.Web.HttpContext.Current.Request.FilePath;
        DataTable dt = skin.GetDT("select distinct menuSole,menuName,menuLinkUrl,menugroups from view_admin_manager_role_menu where menutype='菜单' and mansole='" + sole + "' and menuParent=(select top 1 sole from [admin_per_menu] where string1='" + url + "')");
        StringBuilder write = new StringBuilder();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (groups != dt.Rows[i]["menugroups"].ToString())
            {
                if (i != 0) { write.Append("<div class='nav-divider'></div>"); }
                groups = dt.Rows[i]["menugroups"].ToString();
            }
            write.Append("<li onclick=\\\"top.openWindows(window, '" + dt.Rows[i]["menuLinkUrl"] + "', '" + dt.Rows[i]["menuName"] + "');\\\"><a><i class='fa fa-caret-right'></i>&nbsp;&nbsp;" + dt.Rows[i]["menuName"] + "</a></li>");
        }
        return write.ToString();
    }

    /// <summary>获取页面面包屑</summary>
    /// <returns></returns>
    public static string GetPath()
    {
        StringBuilder html = new StringBuilder();
        string[] path = skin.ExecuteScalar("select path+'-'+name from [admin_per_menu] where string1='" + System.Web.HttpContext.Current.Request.FilePath + "'").ToString().Replace(" ", "").Replace("权限设置-", "").Split('-');
        if (path.Length > 0)
        {
            html.Append("<div class='breadcrumb-box'><ol class='breadcrumb'><span>位置：</span>");
            html.Append("<li class='active'><a href='/Member/main.aspx'>首页</a></li>");
            for (int i = 0; i < path.Length; i++)
            {
                html.Append("<li " + (i == path.Length - 1 ? " class='active'" : "") + "><a>" + path[i] + "</a></li>");
            }
            html.Append("<div class='clear'></div></ol></div>");
        }
        return html.ToString().Replace("(学员)", "");
    }
}