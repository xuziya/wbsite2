using System;
using System.Data;
using System.Web;
using harry.DAL.Sql.Sql2008;

public partial class Admin_pages_game_messgae_2news_view : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request["id"] ?? "0", sole = Request["sole"] ?? "";
            if ((id != "0" || sole != ""))
            {
                DataTable dt = skin.GetDT("select * from message_news where id=" + id);
                if (dt.Rows.Count > 0)
                {
                    ViewState.Add("id", dt.Rows[0]["id"].ToString());

                    title.InnerHtml = dt.Rows[0]["title"].ToString();
                    createSole.InnerHtml = dt.Rows[0]["createSole"].ToString();
                    if (createSole.InnerHtml != "") { createSole.InnerHtml = skin.ExecuteScalar("select name from admin_per_manager where sole='" + createSole.InnerHtml + "'").ToString(); }
                    createDate.InnerHtml = dt.Rows[0]["createDate"].ToString();
                    intro.InnerHtml = dt.Rows[0]["intro"].ToString();
                    content.InnerHtml = HttpContext.Current.Server.HtmlDecode(dt.Rows[0]["content"].ToString());
                }
            }
        }
    }
}