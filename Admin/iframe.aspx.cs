using System;
using System.Data;
using System.Text;
using harry.DAL.Sql.Sql2008;

public partial class Admin_iframe : AdminBasePage
{
    /// <summary>一级菜单样式集合</summary>
    private static string[] css = { "fa-home", "fa-file-text-o", "fa-cog", "fa-file-text-o", "fa-bar-chart", "fa-robot" };

    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            GetLeftMenu();
        }
    }

    /// <summary>一级菜单</summary>
    /// <returns>html</returns>
    public string GetTopMenu()
    {
        StringBuilder html = new StringBuilder();
        DataTable dt = skin.GetDT("select distinct menuSole,menuName,menuCode,menuIndexs from view_admin_manager_role_menu where menuused=1 and menuLev=1 and mansole='" + GetSole() + "' order by menuCode,menuIndexs");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            html.Append("<li class='navbar-one' onclick='topMenuClick(this)' title='" + dt.Rows[i]["menuName"] + "'><a><i class='fa " + css[i] + "'></i></a></li>");
        }
        return html.ToString();
    }

    /// <summary>二、三级菜单</summary>
    /// <returns>html</returns>
    public void GetLeftMenu()
    {
        try
        {
            DataTable dt1 = skin.GetDT("select distinct v1.menuSole,v1.menuParent,v1.menuName,v2.menuName as parentName,v1.menuCode,v1.menuIndexs from [view_admin_manager_role_menu] as v1 left join [view_admin_manager_role_menu] as v2 on v1.menuParent=v2.menuSole where v1.menuused=1 and v1.menuLev=2 and v1.mansole='" + GetSole() + "' order by v1.menuCode,v1.menuIndexs");
            StringBuilder html = new StringBuilder();
            string parent = string.Empty;
            int index = 0;
            bool added = false;
            
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                if (parent != dt1.Rows[i]["menuParent"].ToString())
                {
                    parent = dt1.Rows[i]["menuParent"].ToString();
                    if (i != 0) { html.Append("</ul>"); }
                    html.Append("<ul " + (i != 0 ? " style='display:none' " : "") + ">");
                    html.Append("<li class='header-menu'><i class='fa " + css[index++] + "'></i> " + (dt1.Rows[i]["parentName"].ToString().Replace("(管理)", "")) + "</li>");
                }
                
                // 直接添加大模型管理作为一级菜单项
                if (!added && i == dt1.Rows.Count - 1)
                {
                    html.Append("<li class='sidebar-dropdown'>");
                    html.Append("   <a>大模型管理  <i class='fa fa-caret-right'></i></a>");
                    html.Append("   <div class='sidebar-submenu'>");
                    html.Append("       <ul>");
                    html.Append("       <li><a target='iframe' href='pages/llm/1llm.aspx'>模型管理</a> </li>");
                    html.Append("       <li><a target='iframe' href='pages/llm/2llm_log.aspx'>对话记录</a> </li>");
                    html.Append("       <li><a target='iframe' href='pages/llm/3llm_prompt.aspx'>Prompt管理</a> </li>");
                    html.Append("       </ul>");
                    html.Append("   </div>");
                    html.Append("</li>");
                    added = true;
                }
                
                html.Append("<li class='sidebar-dropdown'>");
                html.Append("   <a>" + dt1.Rows[i]["menuName"] + "  <i class='fa fa-caret-right'></i></a>");
                html.Append("   <div class='sidebar-submenu'>");
                html.Append("       <ul>");
                DataTable dt2 = skin.GetDT("select distinct menuSole,menuName,menuLinkUrl,menuCode,menuIndexs from [view_admin_manager_role_menu] where menuused=1 and menuLev=3 and menuParent='" + dt1.Rows[i]["menuSole"] + "' order by menuCode,menuIndexs");
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    html.Append("       <li><a target='iframe' href='" + dt2.Rows[j]["menuLinkUrl"] + "'>" + dt2.Rows[j]["menuName"] + "</a> </li>");
                }
                html.Append("       </ul>");
                html.Append("   </div>");
                html.Append("</li>");
            }
            
            // 如果没有任何现有菜单，直接添加大模型管理
            if (dt1.Rows.Count == 0)
            {
                html.Append("<ul>");
                html.Append("<li class='header-menu'><i class='fa fa-robot'></i> 系统管理</li>");
                html.Append("<li class='sidebar-dropdown'>");
                html.Append("   <a>大模型管理  <i class='fa fa-caret-right'></i></a>");
                html.Append("   <div class='sidebar-submenu'>");
                html.Append("       <ul>");
                html.Append("       <li><a target='iframe' href='pages/llm/1llm.aspx'>模型管理</a> </li>");
                html.Append("       <li><a target='iframe' href='pages/llm/2llm_log.aspx'>对话记录</a> </li>");
                html.Append("       <li><a target='iframe' href='pages/llm/3llm_prompt.aspx'>Prompt管理</a> </li>");
                html.Append("       </ul>");
                html.Append("   </div>");
                html.Append("</li>");

                html.Append("</ul>");
            }
            else
            {
                html.Append("</ul>");
            }
            
            leftMenus_html.InnerHtml = html.ToString();
        }
        catch (Exception ex)
        {
            leftMenus_html.InnerHtml = "<ul><li class='header-menu'><i class='fa fa-exclamation-triangle'></i> 错误</li><li><a>" + ex.Message + "</a></li></ul>";
        }
    }
}