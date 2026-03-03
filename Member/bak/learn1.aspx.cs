using System;
using System.Data;
using System.Text;
using harry.DAL.Sql.Sql2008;


public partial class Member_learn : MemberBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
    }

    /// <summary>获取学习资料</summary>
    public static string GetLearns()
    {
        StringBuilder html = new StringBuilder();
        DataTable dt = skin.GetDT("select * from [learn_info] where isUsed=1");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            html.Append(@"<div class='study-sub'>
	<div><img src='img/pop/zlbg.png'/></div>
	<div>
		<a>
			<h3>" + dt.Rows[i]["name"] + @"</h3>
			<p class='ms'>" + dt.Rows[i]["intro"] + @"</p>
			<p class='time'>发布时间：" + dt.Rows[i]["createDate"] + @"</p>
		</a>
	</div>
</div>");
        }
        return html.ToString();
    }
}