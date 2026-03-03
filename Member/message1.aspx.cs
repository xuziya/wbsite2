using System;
using System.Data;
using System.Text;
using System.Web;
using harry.DAL.Sql.Sql2008;


public partial class Member_message1 : MemberBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
    }

    /// <summary>获取学习资料</summary>
    public static string GetLearns()
    {
        StringBuilder html = new StringBuilder();
        DataTable dt = skin.GetDT("select * from [message_news] where isUsed=1");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            html.Append("<li id=" + dt.Rows[i]["id"] + " title=" + dt.Rows[i]["title"] + " time=" + dt.Rows[i]["createDate"] + "><p>" + (i + 1) + "、" + dt.Rows[i]["title"] + "</p><span>" + DateTime.Parse(dt.Rows[i]["createDate"].ToString()).ToString("yyyy-MM-dd") + "</span></li>");
        }
        return html.ToString();
    }
}