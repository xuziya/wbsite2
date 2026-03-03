using System;
using System.Web;
using harry.DAL.Sql.Sql2008;

public partial class Member_message2 : MemberBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            string html = HttpContext.Current.Server.HtmlDecode(skin.ExecuteScalar("select content from message_news where id=" + (Request["id"] ?? "101")).ToString());
            Response.Write(html);
            Response.End();
        }
    }
}