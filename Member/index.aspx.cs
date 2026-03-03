using System;
using System.Data;
using System.Text;
using harry.DAL.Sql.Sql2008;
using harry.Tools;
using System.Collections;

public partial class Member_index : MemberBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);

        if (!IsPostBack)
        {
            //处理ajax
            string at = Request["at"] ?? "";
            if (at != "")
            {
                string result = "false";
                try
                {
                    if (at == "room_detail")
                    {
                        string rid = Request["rid"] ?? "";
                        result = skin.GetDT("select rd1.state,rd1.id,rd1.person,si1.name,si1.savePath1,rd1.state,rd1.point from room_detail as rd1 left join room_info as ri1 on rd1.roomSole=ri1.sole  join student_info as si1 on rd1.person=si1.sole where rd1.roomSole='" + rid + "' order by rd1.point desc").DataToJson();
                    }
                    else if (at == "reg_add")
                    {
                        string reg_sole = Request["rs"] ?? "";
                        string r = Request["r"] ?? "";
                        string v1 = Request["v1"] ?? "";
                        string v2 = Request["v2"] ?? "";
                        string v3 = Request["v3"] ?? "";
                        string v4 = Request["v4"] ?? "";
                        string v7 = Request["v7"] ?? "";
                        string v8 = Request["v8"] ?? "";
                        string v9 = Request["v9"] ?? "";
                        result = skin.ExecuteSql("update game_reg set result='" + r + "',value1='" + v1 + "',value2='" + v2 + "',value3='" + v3 + "',value4='" + v4 + "',value7='" + v7 + "',value8='" + v8 + "',value9='" + v9 + "' where sole='" + reg_sole + "'") > 0 ? "true" : "false";
                    }
                    else if (at == "room_clear")
                    {
                        string sid = GetSole();
                        result = skin.ExecuteSql("delete from room_detail where person='" + sid + "' and state='未开始'") > 0 ? "true" : "false";
                    }
                    else if (at == "room_addPoint")
                    {
                        string rid = Request["rid"] ?? "";
                        string did = Request["did"] ?? "";
                        string point = Request["point"] ?? "0";
                        result = skin.ExecuteSql("update room_detail set point=" + point + " where roomSole='" + rid + "' and id=" + did) > 0 ? "true" : "false";
                    }
                    else if (at == "room_join")
                    {
                        string name = Request["name"] ?? "";
                        string pass = Request["pass"] ?? "";
                        result = skin.ExecuteScalar("select top 1 state+'_'+sole from room_info where name='" + name + "' and pass='" + pass + "' and state='未开始' order by id desc").ToString();
                    }
                    else if (at == "scene_change")//房主切换场景
                    {
                        string rid = Request["rid"] ?? "";
                        string sid = Request["sid"] ?? "";
                        if (sid != "")
                        {
                            if (skin.ExecuteSql("update room_info set sceneSole='" + sid + "' where id=" + rid) > 0)
                            {
                                result = skin.GetDT("select index1,image4,name,lev,intro from scene_info where id=" + sid).DataToJson();
                            }
                        }
                        else
                        {
                            result = skin.GetDT("select id,index1,image4,name,lev,intro from scene_info where id=(select sceneSole from room_info where id=" + rid + ")").DataToJson();
                        }
                    }
                    else if (at == "room_leave")
                    {
                        string did = Request["did"] ?? "";
                        result = skin.ExecuteSql("delete from room_detail where sole='" + did + "'") > 0 ? "true" : "false";
                    }
                    else if (at == "room_create")
                    {
                        string rid = Request["rid"] ?? "101";
                        string name = Request["name"] ?? "";
                        string pass = Request["pass"] ?? "";
                        string num = Request["num"] ?? "";
                        result = skin.ExecuteScalar("insert into room_info values('','" + rid + "','" + name + "','" + pass + "','" + num + "','未开始','" + GetSole() + "','" + GetDateTime() + "','');update room_info set sole=id where id=ident_current('room_info');select ident_current('room_info');").ToString();
                    }
                    else if (at == "room_close")
                    {
                        string rid = Request["rid"] ?? "";
                        result = skin.ExecuteSql("update room_info set state='已关闭' where id=" + rid) > 0 ? "true" : "false";// + ";update room_detail set state='已关闭' and roomSole='" + rid + "'"
                    }
                    else if (at == "room_start")
                    {
                        string rid = Request["rid"] ?? "";
                        ArrayList sql = new ArrayList();
                        sql.Add("update room_info set state='已开始' where id=" + rid);
                        sql.Add("update room_detail set state='已开始',point=0 where roomSole='" + rid + "'");
                        result = skin.Transaction(sql).ToString().ToLower();
                    }
                }
                catch { result = "false"; }
                Response.ContentType = "text/plain";
                Response.Write(result);
                Response.End();
                return;
            }
        }
    }

    /// <summary>获取登录日志</summary>
    public static string GetLoginLog()
    {
        StringBuilder html = new StringBuilder();
        DataTable dt = skin.GetDT("select * from [member_log_login] where createSole='" + GetSole() + "'");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            html.Append("<li>" + dt.Rows[i]["createDate"] + " 登录账号学习培训</li>");
        }
        return html.ToString();
    }

    /// <summary>获取系统消息</summary>
    public static string GetMessage()
    {
        StringBuilder html = new StringBuilder();
        DataTable dt = skin.GetDT("select * from [message_news] where isUsed=1");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            html.Append("<li>" + dt.Rows[i]["title"] + "  -  " + dt.Rows[i]["intro"] + "</li>");
        }
        return html.ToString();
    }
}