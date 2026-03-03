using System;
using System.Web;
using harry.DAL.Sql.Sql2008;

public partial class Member_learn2 : MemberBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            //string html = HttpContext.Current.Server.HtmlDecode(skin.ExecuteScalar("select content from [learn_info] where id=" + (Request["id"] ?? "101")).ToString());
            string html = HttpContext.Current.Server.HtmlDecode(skin.ExecuteScalar("select intro from [produce_info] where id=" + (Request["id"] ?? "101")).ToString());
            Response.Write(html);
            Response.End();
        }
    }
}