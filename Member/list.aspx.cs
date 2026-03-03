using System;
using System.Data;
using System.Text;
using harry.DAL.Sql.Sql2008;

public partial class Member_list : MemberBasePage
{
    public string type = "";
    public string sex = "";
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);

        GetList(Request["type"] ?? "0", Request["lev"] ?? "0");
    }

    /// <summary>获取场景列表</summary>
    public void GetList(string t, string l)
    {
        string[] types = { "个人", "家庭", "集团" };
        string[] levs = { "简单", "中等", "困难" };
        type = types[int.Parse(t)];
        string lev = levs[int.Parse(l)];

        StringBuilder html = new StringBuilder();

        DataTable dt1 = skin.GetDT("select * from [scene_info] where type='" + type + "' and lev='简单' and isUsed=1");
        html.Append("<div class='gkbox animated pulse'>");
        html.Append("<div class='feiji' style='position: absolute;top: -240px;left: 0px;'><img src='img/线/29.png'/></div>");
        for (int i = 0; i < dt1.Rows.Count; i++)
        {
            string name = dt1.Rows[i]["name"].ToString();

            html.Append(@"<div title='" + dt1.Rows[i]["name"] + @"' class='gkbtn gk" + (i + 1) + @" animated'>
	<a id='" + dt1.Rows[i]["id"] + @"' name='" + name + @"' sex='" + dt1.Rows[i]["image9"] + @"' image='" + dt1.Rows[i]["image3"] + @"' words=''>
		<img class='gkrw' src='" + dt1.Rows[i]["image4"] + @"'/>
		<h1>0" + (i + 1) + @"</h1>
		<img class='lock' src='img/gkm/开锁.png'/>
		<!-- <img class='numbers' src='img/gkm/一紫色.png'/> -->
		<div class='numbers'><h2 class='ks' style='width:140px'>&nbsp;&nbsp;" + name + @"</h2></div>
		<p>进行中</p>
		<img class='status' src='img/gkm/完成标记.png'/>
	</a>
</div>");
        }
        html.Append("</div>");

        DataTable dt2 = skin.GetDT("select * from [scene_info] where type='" + type + "' and lev='中级' and isUsed=1");
        html.Append("<div class='gkbox animated pulse' style='display:none'>");
        html.Append("<div class='feiji' style='position: absolute;top: -240px;left: 0px;'><img src='img/线/29.png'/></div>");
        for (int i = 0; i < dt2.Rows.Count; i++)
        {
            string name = dt2.Rows[i]["name"].ToString();

            html.Append(@"<div title='" + dt2.Rows[i]["name"] + @"' class='gkbtn gk" + (i + 1) + @" animated'>
	<a id='" + dt2.Rows[i]["id"] + @"' name='" + name + @"' sex='" + dt2.Rows[i]["image9"] + @"' image='" + dt2.Rows[i]["image3"] + @"' words=''>
		<img class='gkrw' src='" + dt2.Rows[i]["image4"] + @"'/>
		<h1>0" + (i + 1) + @"</h1>
		<img class='lock' src='img/gkm/开锁.png'/>
		<!-- <img class='numbers' src='img/gkm/一紫色.png'/> -->
		<div class='numbers'><h2 class='ks' style='width:140px'>&nbsp;&nbsp;" + name + @"</h2></div>
		<p>进行中</p>
		<img class='status' src='img/gkm/完成标记.png'/>
	</a>
</div>");
        }
        html.Append("</div>");

        DataTable dt3 = skin.GetDT("select * from [scene_info] where type='" + type + "' and lev='困难' and isUsed=1");
        html.Append("<div class='gkbox animated pulse' style='display:none'>");
        html.Append("<div class='feiji' style='position: absolute;top: -240px;left: 0px;'><img src='img/线/29.png'/></div>");
        for (int i = 0; i < dt3.Rows.Count; i++)
        {
            string name = dt3.Rows[i]["name"].ToString();

            html.Append(@"<div title='" + dt3.Rows[i]["name"] + @"' class='gkbtn gk" + (i + 1) + @" animated'>
	<a id='" + dt3.Rows[i]["id"] + @"' name='" + name + @"' sex='" + dt3.Rows[i]["image9"] + @"' image='" + dt3.Rows[i]["image3"] + @"' words=''>
		<img class='gkrw' src='" + dt3.Rows[i]["image4"] + @"'/>
		<h1>0" + (i + 1) + @"</h1>
		<img class='lock' src='img/gkm/开锁.png'/>
		<!-- <img class='numbers' src='img/gkm/一紫色.png'/> -->
		<div class='numbers'><h2 class='ks' style='width:140px'>&nbsp;&nbsp;" + name + @"</h2></div>
		<p>进行中</p>
		<img class='status' src='img/gkm/完成标记.png'/>
	</a>
</div>");
        }
        html.Append("</div>");

        scene_html.InnerHtml = html.ToString();
    }
}