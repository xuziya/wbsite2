using System;
using harry.Tools.Web;

/// <summary>验证基类</summary>
public class BasePage : System.Web.UI.Page
{
    /// <summary>项目根目录</summary>
    protected const string ProjectRoot = "/Admin/";
    /// <summary>项目中的Cookie、Session前缀</summary>
    protected const string ProjectPerfix = "harry_";
    /// <summary>前台状态</summary>
    protected static bool ClientUseState = true;
    /// <summary>后台状态</summary>
    protected static bool ServerUseState = true;

    /// <summary>检测登陆状态</summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected virtual void Page_Load(object sender, EventArgs e)
    {

    }

    /// <summary>
    /// 检测当前登陆的登录状态:
    ///  -1  错误
    ///  0 - Session空、Cookie空
    ///  1 - Session有、Cookie空
    ///  2 - Session空、Cookie有
    ///  3 - Session有、Cookie有
    /// </summary>
    /// <param name="perfix">前缀</param>
    /// <returns>status</returns>
    protected static int LoginState(string perfix)
    {
        int tag = 0;
        try
        {
            if (SessionEx.Exists(perfix + "_model")) { tag++; }
            if (CookieEx.Exists(perfix + "uid") || CookieEx.Exists(perfix + "pass")) { tag += 2; }
        }
        catch { tag = -1; }
        return tag;
    }

    /// <summary>获取Cookie或者Session信息</summary>
    /// <param name="perfix">前缀</param>
    /// <param name="key">key</param>
    /// <returns>value</returns>
    protected static object GetValue(string perfix, string key)
    {
        object value = null;
        try
        {
            int state = LoginState(perfix);
            switch (state)
            {
                case 1: { value = SessionEx.Get(perfix + "_model"); break; }
                case 2: { value = CookieEx.Get(perfix + key); break; }
                case 3: { value = CookieEx.Get(perfix + key); break; }
            }
        }
        catch { throw; }
        return value;
    }

    /// <summary>使用Js跳转至登录页面</summary>
    /// <param name="alert">提示内容</param>
    /// <param name="loginPath">登陆页面路径</param>
    protected static void Assign(string alert, string loginPath)
    {
        System.Web.HttpContext.Current.Response.Write("<script>" + (string.IsNullOrEmpty(alert) ? "" : "alert('" + alert + "');") + "top.location.assign('" + loginPath + "');</script>");
    }

    /// <summary>获取当前系统时间</summary>
    /// <returns></returns>
    public static string GetDateTime()
    {
        return DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
    }

    /// <summary>获取当前系统时间</summary>
    /// <param name="format">时间格式</param>
    /// <returns></returns>
    public static string GetDateTime(string format)
    {
        return DateTime.Now.ToString(format);
    }
}