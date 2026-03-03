using System;
using System.Collections;
using System.Data;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Admin_pages_game_messgae_1leave_up : AdminBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            string id = Request["id"] ?? "0", sole = Request["sole"] ?? "";
            if (id != "0" || sole != "")
            {
                DataTable dt = skin.GetDT("select * from message_leave where id=" + id);
                if (dt.Rows.Count > 0)
                {
                    ViewState.Add("id", dt.Rows[0]["id"].ToString());
                    ViewState.Add("saveURL1", dt.Rows[0]["saveURL"].ToString());

                    title.InnerHtml = dt.Rows[0]["title"].ToString();
                    createDate.InnerHtml = dt.Rows[0]["createDate"].ToString();
                    name.InnerHtml = dt.Rows[0]["createSole"].ToString();
                    if (name.InnerHtml != "") { name.InnerHtml = skin.ExecuteScalar("select name from student_info where sole='" + name.InnerHtml + "'").ToString(); }
                    string _saveURL1 = dt.Rows[0]["saveURL"].ToString();
                    if (_saveURL1 != "")
                    {
                        path1.Text = "<a href='" + _saveURL1 + "' target='_blank'>文件地址：" + _saveURL1 + "(点击下载)</a>";
                    }
                    content.InnerHtml = dt.Rows[0]["content"].ToString();

                    replay.Text = dt.Rows[0]["replay"].ToString();
                    date2.InnerHtml = dt.Rows[0]["date2"].ToString();
                    sole2.InnerHtml = dt.Rows[0]["sole2"].ToString();
                    if (sole2.InnerHtml != "") { sole2.InnerHtml = skin.ExecuteScalar("select name from admin_per_manager where sole='" + sole2.InnerHtml + "'").ToString(); }
                }
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (replay.Text == "") { this.Alert("请输入回复内容"); replay.Focus(); return; }
        this.AlertSubmit(skin.ExecuteSql(@"update [message_leave] set [replay]='" + replay.Text + "',[sole2]='" + GetSole() + "',[date2]='" + GetDateTime() + "' where [id]=" + ViewState["id"] + ";") > 0);
    }
}