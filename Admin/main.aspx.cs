using System;
using System.Data;
using System.Text;
using harry.DAL.Sql.Sql2008;

public partial class Admin_main : AdminBasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /// <summary>获取学习资料</summary>
    /// <returns></returns>
    public string GetLearn()
    {
        StringBuilder html = new StringBuilder();
        DataTable dt = skin.GetDT("select top 5 t1.*,c1.name as m1name from [learn_info] as t1 left join [admin_per_manager] as c1 on t1.createSole=c1.sole order by id desc");
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                //string url = "/Admin/pages/game/messgae/1leave_up.aspx?oper=up&id=" + dt.Rows[i]["id"].ToString();
                html.Append("<li class='active'>");
                html.Append("  <p title='查看信息'><a href='javascript:parent.openWindows(window,\"/Admin/pages/game/learn/1learn_view.aspx?id=" + dt.Rows[i]["id"] + "\")'>" + (i + 1) + "、" + dt.Rows[i]["name"] + "</a></p>");
                html.Append("	<small class='list-small'>" + dt.Rows[i]["m1name"] + "  -  " + dt.Rows[i]["createDate"] + "</small><a class='more'><i class='fa fa-ellipsis-v'></i></a>");
                html.Append("  <div class='clearfix'></div>");
                html.Append("</li>");
            }
        }
        return html.ToString();
    }

    /// <summary>获取通知信息</summary>
    /// <returns></returns>
    public string GetNews()
    {
        StringBuilder html = new StringBuilder();
        DataTable dt = skin.GetDT("select top 5 t1.*,c1.name as m1name from [message_news] as t1 left join [admin_per_manager] as c1 on t1.createSole=c1.sole order by id desc");
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                //string url = "/Admin/pages/game/messgae/1leave_up.aspx?oper=up&id=" + dt.Rows[i]["id"].ToString();
                html.Append("<li class='active'>");
                html.Append("  <p title='查看信息'><a href='javascript:parent.openWindows(window,\"/Admin/pages/game/messgae/2news_view.aspx?id=" + dt.Rows[i]["id"] + "\")'>" + (i + 1) + "、" + dt.Rows[i]["title"] + "</a></p>");
                html.Append("	<small class='list-small'>" + dt.Rows[i]["m1name"] + "  -  " + dt.Rows[i]["createDate"] + "</small><a class='more'><i class='fa fa-ellipsis-v'></i></a>");
                html.Append("  <div class='clearfix'></div>");
                html.Append("</li>");
            }
        }
        return html.ToString();
    }
}