using System;
using System.Data;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Member_room2 : MemberBasePage
{
    public string sid = "";//场景编号
    public string rid = "";//房间编号
    public string did = "";//明细编号
    public string time = "180";
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);

        if (!IsPostBack)
        {
            rid = Request["rid"] ?? "";
            string sole = GetSole(), state = skin.ExecuteScalar("select state from room_info where id=" + rid).ToString();
            if (state == "") { this.Script("alert('无效的房间信息');location.href='index.aspx';"); }
            //else if (state == "已开始") { this.Script("alert('房间游戏已开始');location.href='index.aspx';"); }
            //else 
            if (state == "已结束") { this.Script("alert('房间游戏已结束');location.href='index.aspx';"); }
            else if (state == "已关闭") { this.Script("alert('房间已关闭');location.href='index.aspx';"); }
            else
            {
                //是否已加入
                if (skin.ExecuteScalar("select id from room_detail where roomSole='" + rid + "' and createSole='" + sole + "'").ToString() == "")
                {
                    did = skin.ExecuteScalar("insert into room_detail values('','" + rid + "','','" + sole + "','未开始','',0,-1,'" + sole + "','" + GetDateTime() + "','');update room_detail set sole=id where id=ident_current('room_detail');select ident_current('room_detail');").ToString();
                }
                else
                {
                    did = Request["did"] ?? "";
                }
            }
        }

        getMsg(rid);
    }

    /// <summary>获取场景信息</summary>
    public void getMsg(string rid)
    {
        DataTable dt = skin.GetDT("select * from scene_info where sole=(select sceneSole from room_info where id=" + rid + ")");
        if (dt.Rows.Count > 0)
        {
            sid = dt.Rows[0]["id"].ToString();

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

            scene_image.Src = dt.Rows[0]["image4"].ToString();
            scene_name.InnerHtml = "&nbsp;&nbsp;" + dt.Rows[0]["name"].ToString();
            scene_intro.InnerHtml = dt.Rows[0]["intro"].ToString();
        }
    }
}