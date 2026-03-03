using System;
using System.Collections;
using System.Data;
using System.Web;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Admin_pages_game_messgae_2news_ad : AdminBasePage
{
    private string oper = string.Empty;
    public string content = string.Empty;
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        oper = (ViewState["oper"] ?? (ViewState["oper"] = Request["oper"] ?? "add")).ToString();
        if (!IsPostBack)
        {
            string id = Request["id"] ?? "0", sole = Request["sole"] ?? "";
            if (oper == "up" && (id != "0" || sole != ""))
            {
                DataTable dt = skin.GetDT("select * from message_news where id=" + id);
                if (dt.Rows.Count > 0)
                {
                    ViewState.Add("id", dt.Rows[0]["id"].ToString());

                    title.Text = dt.Rows[0]["title"].ToString();
                    intro.Text = dt.Rows[0]["intro"].ToString();
                    content = HttpContext.Current.Server.HtmlDecode(dt.Rows[0]["content"].ToString());
                    isUsed.Checked = dt.Rows[0]["isUsed"].ToString() == "1";
                    note.Text = dt.Rows[0]["note"].ToString();
                }
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (title.Text == "") { this.Alert("请输入标题"); title.Focus(); return; }
        if (intro.Text == "") { this.Alert("请输入简介"); intro.Focus(); return; }
        content = HttpContext.Current.Server.HtmlEncode(HttpContext.Current.Request.Form["editor1"]);
        if (content == "") { this.Alert("请输入详细内容"); return; }

        ArrayList sql = new ArrayList();
        if (oper == "add")
        {
            sql.Add(@"insert into [message_news] values('','通知','" + title.Text + "','','" + intro.Text + "','" + content + "',''," + (isUsed.Checked ? 1 : 0) + ",'" + GetSole() + "','" + GetDateTime() + "','" + note.Text + "');");
            sql.Add(harry.Tools.Common.SetSole("message_news"));
        }
        else if (oper == "up")
        {
            sql.Add(@"update [message_news] set [title]='" + title.Text + "',[intro]='" + intro.Text + "',[content]='" + content + "',isUsed=" + (isUsed.Checked ? 1 : 0) + ",[note]='" + note.Text + "' where [id]=" + ViewState["id"] + ";");
        }
        bool result = skin.Transaction(sql);
        if (result)
        {
            content = HttpContext.Current.Server.HtmlDecode(HttpContext.Current.Request.Form["editor1"]);
        }
        this.AlertSubmit(result);
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        string[] alert = { "操作失败", "操作成功" };
        this.AlertSubmit(skin.ExecuteSql("delete from [message_news] where id=" + (Request["id"])) > 0, alert, true, "location.href", "");
    }
}