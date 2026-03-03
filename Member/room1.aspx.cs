using System;
using System.Data;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Member_room1 : MemberBasePage
{
    public string rid = "";     //房间编号
    public string sid = "";     //场景编号
    public string time = "180"; //时长
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);

        if (!IsPostBack)
        {
            rid = Request["rid"] ?? "";
            string sole = GetSole(), createSole = skin.ExecuteScalar("select createSole from room_info where id=" + rid).ToString();
            //非创建者
            if (sole != createSole)
            {
                this.Script("location.href='room2.aspx?rid=" + rid + "';");
            }

            getMsg(rid);
        }
    }

    /// <summary>获取场景信息</summary>
    public void getMsg(string rid)
    {
        DataTable dt = skin.GetDT("select * from scene_info where sole=(select sceneSole from room_info where id=" + rid + ")");
        if (dt.Rows.Count > 0)
        {
            string lev = dt.Rows[0]["lev"].ToString();
            string index1 = dt.Rows[0]["index1"].ToString();
            if (lev == "简单")
            {
                scene_index.InnerHtml = "0" + index1;
                time = "180";
            }
            else if (lev == "中级")
            {
                scene_index.InnerHtml = "0" + (int.Parse(index1) - 5);
                time = "300";
            }
            else
            {
                scene_index.InnerHtml = "0" + (int.Parse(index1) - 10);
                time = "420";
            }

            sid = dt.Rows[0]["id"].ToString();
            scene_image.Src = dt.Rows[0]["image4"].ToString();
            scene_name.InnerHtml = "&nbsp;&nbsp;" + dt.Rows[0]["name"].ToString();
            scene_intro.InnerHtml = dt.Rows[0]["intro"].ToString();
        }
    }

    /// <summary>获取场景信息</summary>
    public string getScenes()
    {
        string[] types = { "个人", "家庭", "集团" };
        string[] models = { "简单", "中级", "困难" };

        System.Text.StringBuilder html = new System.Text.StringBuilder();
        for (int i = 0; i < types.Length; i++)
        {

            for (int j = 0; j < types.Length; j++)
            {
                DataTable dt = skin.GetDT("select * from scene_info where type='" + types[i] + "' and lev='" + models[j] + "' and isUsed=1");
                html.Append("<div id='" + types[i] + "_" + models[j] + "' style='display:" + (i + j == 0 ? "block" : "none") + "' class='toggle-imgbox clear'>");
                for (int k = 0; k < dt.Rows.Count; k++)
                {
                    string name = dt.Rows[k]["name"].ToString();
                    if (name.Length > 4) { name = name.Substring(0, 4) + "<br />" + name.Substring(4); }
                    html.Append("<div class='gkbtn' id='" + dt.Rows[k]["sole"] + "'><img class='gkrw' src='" + dt.Rows[k]["image4"] + "'/><h1>0" + (k + 1) + "</h1><div class='numbers'><h2 class='ks'>&nbsp;&nbsp;" + name + "</div><img class='bj' " + (sid == dt.Rows[k]["id"].ToString() ? " style='display:block' " : "") + " src='img/pop/绿色.png'/></div>");
                    
                }
                html.Append("</div>");
            }
        }
        return html.ToString();
    }

}