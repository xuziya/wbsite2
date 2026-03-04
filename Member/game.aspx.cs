using System;
using System.Data;
using System.Text;
using harry.DAL.Sql.Sql2008;
using Tools;

public partial class Member_game : MemberBasePage
{
    public string rid = "";     //房间编号
    public string did = "";     //房间明细编号
    public string sid = "";     //场景编号
    public string mid = "";     //客户画像编号
    public string pids = "";    //产品编号 - 选择
    public string pid = "";     //触点编号 - 选择

    public string itemCount = "3";  //道具数量：简单=3，中级=4，困难=5
    public string time1 = "180";    //道具数量：简单=180，中级=300，困难=420
    public string levPoint = "10";  //场景分

    public string produces = "";    //绑定产品
    public string places = "";      //绑定触点

    public string percent_produce1 = "0";//产品正确数
    public string percent_produce2 = "0";//产品总数
    public string percent_place = "";    //触点正确率

    public string reg_sole = "";

    public StringBuilder date = new StringBuilder();    //数据集合

    private DeepSeekAPI deepSeekAPI;    //DeepSeek API客户端

    private string contents = "";
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        //初始化DeepSeek API客户端
        string baseUrl = System.Configuration.ConfigurationManager.AppSettings["DeepSeekBaseUrl"];
        string apiKey = System.Configuration.ConfigurationManager.AppSettings["DeepSeekApiKey"];
        deepSeekAPI = new DeepSeekAPI(baseUrl, apiKey);
        //game.aspx?sid=104&mid=105&pids=148,148,135,140,148,135&pid=5

        //房间编号
        rid = Request["rid"] ?? "";
        //房间明细编号
        did = Request["did"] ?? "";
        if (did != "") { skin.ExecuteSql("update room_detail set state='已开始',point=0 where sole='" + did + "' and roomSole='" + rid + "'"); }

        //场景编号
        sid = Request["sid"] ?? "104";
        //客户画像编号
        mid = Request["mid"] ?? "";
        //产品编号 - 选择
        pids = Request["pids"] ?? "";
        //触点编号 - 选择
        pid = Request["pid"] ?? "";


        //获取绑定信息
        GetBinding();
        //显示客户画像
        getMember();
        //产品信息
        getProduce();
        //获取触点
        getPlace();
        getResources();//获取资源库

        //场景类型
        string type = skin.ExecuteScalar("select type from scene_info where id=" + sid).ToString();

        //按照触点对应问候对话
        DataTable dt1 = skin.GetDT("select top 1 * from dialog1_info where type1='" + type + "' and type3='第一句' and placeSole='" + pid + "' order by newid()");
        DataTable dt2 = skin.GetDT("select top 1 * from dialog1_info where type1='" + type + "' and type3='其他' and  placeSole='" + pid + "' order by newid()");

        //按照人物画像获取关怀对话
        DataTable dt3 = skin.GetDT("select top 2 * from dialog2_info where memberSole='" + mid + "' and type3='" + pid + "'");// and type3='" + pid + "'
        //int count3 = dt3.Rows.Count;

        //按照产品获取销售对话
        //DataTable dt4 = skin.GetDT("select * from dialog3_info where produceSole in ('" + pids.Replace(",", "','") + "')");
        DataTable dt4 = skin.GetDT("select * from dialog3_info as di1 left join produce_info as pi1 on di1.produceSole=pi1.sole where di1.produceSole in('" + pids.Replace(",", "','") + "') order by CAST(pi1.index1 as int)");
        //int count4 = dt4.Rows.Count;

        for (int i = 0; i < dt1.Rows.Count; i++)
        {
            string id = dt1.Rows[i]["id"].ToString();
            contents = "'" + dt1.Rows[i]["content1"].ToString() + "'";

            id = GetRandom1("dialog1_info", id, dt1.Rows[i], 2);
            id = GetRandom1("dialog1_info", id, dt1.Rows[i], 3);
            id = GetRandom1("dialog1_info", id, dt1.Rows[i], 4);
            id = GetRandom1("dialog1_info", id, dt1.Rows[i], 5);

            contents = "";
            if (places.IndexOf(pid) > -1)//正确触点
            {
                percent_place = "1";
                date.Append("datas.push(['正确', '" + dt1.Rows[i]["content1"] + "', '" + dt1.Rows[i]["reply1"] + "', '" + dt1.Rows[i]["point1"] + "', '" +
                    dt1.Rows[i]["content2"] + "', '" + dt1.Rows[i]["reply2"] + "', '" + dt1.Rows[i]["point2"] + "', '" + dt1.Rows[i]["content3"] + "', '" + dt1.Rows[i]["reply3"] + "', '" + dt1.Rows[i]["point3"] + "', '" +
                    dt1.Rows[i]["content4"] + "', '" + dt1.Rows[i]["reply4"] + "', '" + dt1.Rows[i]["point4"] + "', '" + dt1.Rows[i]["content5"] + "', '" + dt1.Rows[i]["reply5"] + "', '" + dt1.Rows[i]["point5"] + "']);");
            }
            else//错误触点
            {
                percent_place = "0";
                date.Append("datas.push(['错误', '" + dt1.Rows[i]["content1"] + "', '" + dt1.Rows[i]["reply1"] + "', '" + dt1.Rows[i]["point1"] + "', '" +
                    dt1.Rows[i]["content2"] + "', '" + dt1.Rows[i]["reply2"] + "', '" + dt1.Rows[i]["point2"] + "', '" + dt1.Rows[i]["content3"] + "', '" + dt1.Rows[i]["reply3"] + "', '" + dt1.Rows[i]["point3"] + "', '" +
                    dt1.Rows[i]["content4"] + "', '" + dt1.Rows[i]["reply4"] + "', '" + dt1.Rows[i]["point4"] + "', '" + dt1.Rows[i]["content5"] + "', '" + dt1.Rows[i]["reply5"] + "', '" + dt1.Rows[i]["point5"] + "']);");
            }
        }
        for (int i = 0; i < dt2.Rows.Count; i++)
        {
            string id = dt2.Rows[i]["id"].ToString();
            contents = "'" + dt2.Rows[i]["content1"].ToString() + "'";

            id = GetRandom1("dialog1_info", id, dt2.Rows[i], 2);
            id = GetRandom1("dialog1_info", id, dt2.Rows[i], 3);
            id = GetRandom1("dialog1_info", id, dt2.Rows[i], 4);
            id = GetRandom1("dialog1_info", id, dt2.Rows[i], 5);

            contents = "";
            if (places.IndexOf(pid) > -1)//正确触点
            {
                date.Append("datas.push(['正确', '" + dt2.Rows[i]["content1"] + "', '" + dt2.Rows[i]["reply1"] + "', '" + dt2.Rows[i]["point1"] + "', '" +
                    dt2.Rows[i]["content2"] + "', '" + dt2.Rows[i]["reply2"] + "', '" + dt2.Rows[i]["point2"] + "', '" + dt2.Rows[i]["content3"] + "', '" + dt2.Rows[i]["reply3"] + "', '" + dt2.Rows[i]["point3"] + "', '" +
                    dt2.Rows[i]["content4"] + "', '" + dt2.Rows[i]["reply4"] + "', '" + dt2.Rows[i]["point4"] + "', '" + dt2.Rows[i]["content5"] + "', '" + dt2.Rows[i]["reply5"] + "', '" + dt2.Rows[i]["point5"] + "']);");
            }
            else//错误触点
            {
                date.Append("datas.push(['错误', '" + dt2.Rows[i]["content1"] + "', '" + dt2.Rows[i]["reply1"] + "', '" + dt2.Rows[i]["point1"] + "', '" +
                    dt2.Rows[i]["content2"] + "', '" + dt2.Rows[i]["reply2"] + "', '" + dt2.Rows[i]["point2"] + "', '" + dt2.Rows[i]["content3"] + "', '" + dt2.Rows[i]["reply3"] + "', '" + dt2.Rows[i]["point3"] + "', '" +
                    dt2.Rows[i]["content4"] + "', '" + dt2.Rows[i]["reply4"] + "', '" + dt2.Rows[i]["point4"] + "', '" + dt2.Rows[i]["content5"] + "', '" + dt2.Rows[i]["reply5"] + "', '" + dt2.Rows[i]["point5"] + "']);");
            }
        }
        //错误触点
        if (dt3.Rows.Count == 0)
        {
            dt3 = skin.GetDT("select top 2 * from dialog2_info where memberSole='" + mid + "'");// and type3='" + pid + "'
            for (int i = 0; i < dt3.Rows.Count; i++)
            {
                string id = dt3.Rows[i]["id"].ToString();
                contents = "'" + dt3.Rows[i]["content1"].ToString() + "'";

                id = GetRandom1("dialog2_info", id, dt3.Rows[i], 2);
                id = GetRandom1("dialog2_info", id, dt3.Rows[i], 3);
                id = GetRandom1("dialog2_info", id, dt3.Rows[i], 4);
                id = GetRandom1("dialog2_info", id, dt3.Rows[i], 5);

                contents = "";
                date.Append("datas.push(['错误', '" + dt3.Rows[i]["content1"] + "', '" + dt3.Rows[i]["reply1"] + "', '0', '" +
                    dt3.Rows[i]["content2"] + "', '" + dt3.Rows[i]["reply2"] + "', '0', '" + dt3.Rows[i]["content3"] + "', '" + dt3.Rows[i]["reply3"] + "', '0', '" +
                    dt3.Rows[i]["content4"] + "', '" + dt3.Rows[i]["reply4"] + "', '0', '" + dt3.Rows[i]["content5"] + "', '" + dt3.Rows[i]["reply5"] + "', '0']);");
            }
        }
        //正确触点
        else
        {
            for (int i = 0; i < dt3.Rows.Count; i++)
            {
                string id = dt3.Rows[i]["id"].ToString();
                contents = "'" + dt3.Rows[i]["content1"].ToString() + "'";

                id = GetRandom1("dialog2_info", id, dt3.Rows[i], 2);
                id = GetRandom1("dialog2_info", id, dt3.Rows[i], 3);
                id = GetRandom1("dialog2_info", id, dt3.Rows[i], 4);
                id = GetRandom1("dialog2_info", id, dt3.Rows[i], 5);

                contents = "";
                date.Append("datas.push(['正确', '" + dt3.Rows[i]["content1"] + "', '" + dt3.Rows[i]["reply1"] + "', '" + dt3.Rows[i]["point1"] + "', '" +
                    dt3.Rows[i]["content2"] + "', '" + dt3.Rows[i]["reply2"] + "', '" + dt3.Rows[i]["point2"] + "', '" + dt3.Rows[i]["content3"] + "', '" + dt3.Rows[i]["reply3"] + "', '" + dt3.Rows[i]["point3"] + "', '" +
                    dt3.Rows[i]["content4"] + "', '" + dt3.Rows[i]["reply4"] + "', '" + dt3.Rows[i]["point4"] + "', '" + dt3.Rows[i]["content5"] + "', '" + dt3.Rows[i]["reply5"] + "', '" + dt3.Rows[i]["point5"] + "']);");
            }
        }
        //'144','133','101' -正确
        //171,177,150       -选择
        int zhengque = 0;
        for (int i = 0; i < dt4.Rows.Count; i++)
        {
            string id = dt4.Rows[i]["id"].ToString();
            contents = "'" + dt4.Rows[i]["content1"].ToString() + "'";

            id = GetRandom1("dialog3_info", id, dt4.Rows[i], 2);
            id = GetRandom1("dialog3_info", id, dt4.Rows[i], 3);
            id = GetRandom1("dialog3_info", id, dt4.Rows[i], 4);
            id = GetRandom1("dialog3_info", id, dt4.Rows[i], 5);

            contents = "";
            string ps = dt4.Rows[i]["produceSole"].ToString();
            if (produces.IndexOf("'" + ps + "'") > -1)//绑定产品
            {
                zhengque++;
                date.Append("datas.push(['正确', '" + dt4.Rows[i]["content1"] + "', '" + dt4.Rows[i]["reply1"] + "', '" + dt4.Rows[i]["point1"] + "', '" +
                    dt4.Rows[i]["content2"] + "', '" + dt4.Rows[i]["reply2"] + "', '" + dt4.Rows[i]["point2"] + "', '" + dt4.Rows[i]["content3"] + "', '" + dt4.Rows[i]["reply3"] + "', '" + dt4.Rows[i]["point3"] + "', '" +
                    dt4.Rows[i]["content4"] + "', '" + dt4.Rows[i]["reply4"] + "', '" + dt4.Rows[i]["point4"] + "', '" + dt4.Rows[i]["content5"] + "', '" + dt4.Rows[i]["reply5"] + "', '" + dt4.Rows[i]["point5"] + "']);");
            }
            else//错误产品
            {
                date.Append("datas.push(['错误', '" + dt4.Rows[i]["content1"] + "', '我不需要！', '0', '" +
                    dt4.Rows[i]["content2"] + "', '我不需要！', '0', '" + dt4.Rows[i]["content3"] + "', '我不需要！', '0', '" +
                    dt4.Rows[i]["content4"] + "', '我不需要！', '0', '" + dt4.Rows[i]["content5"] + "', '我不需要！', '0']);");
            }
        }
        percent_produce1 = zhengque.ToString();
        percent_produce2 = dt4.Rows.Count.ToString();
        
        reg_sole = skin.ExecuteScalar("insert into game_reg values('','" + (rid == "" ? "个人" : "组队") + "','','','" + rid + "','" + did + "','" + GetSole() + "','" + sid + "','" + mid + "','" + produces.Replace("'", "”") + "','" + places + "','" + pids + "','" + pid +
            "','','','','','','" + levPoint + "','','','','',0,0,'" + GetSole() + "','" + GetDateTime() + "','');update game_reg set sole=id where id=ident_current('game_reg');select sole from game_reg where id=ident_current('game_reg');").ToString();
    }

    /// <summary>获取问候随机内容</summary>
    /// <param name="tableNmae">表名</param>
    /// <param name="id">当前数据id</param>
    /// <param name="row">数据源</param>
    /// <param name="columnIndex">当前排序</param>
    /// <returns></returns>
    public string GetRandom1(string tableNmae, string id, DataRow row, int columnIndex)
    {
        string content = row["content" + columnIndex].ToString();
        if (content == "随机" || content == "")
        {
            DataTable dt = skin.GetDT("select top 1 * from " + tableNmae + " where id not in(" + id + ") and content1!='随机' and content1 not in (" + contents + ") order by newid()");
            id += "," + dt.Rows[0]["id"];
            row["content" + columnIndex] = dt.Rows[0]["content1"].ToString();
            row["reply" + columnIndex] = dt.Rows[0]["reply1"].ToString();
            row["point" + columnIndex] = "0";

            contents += (contents == "" ? "" : ",") + "'" + row["content" + columnIndex] + "'";
        }
        return id;
    }

    /// <summary>获取绑定信息</summary>
    public void GetBinding()
    {
        //场景信息
        DataTable dt = skin.GetDT("select * from scene_info where id=" + sid);
        if (dt.Rows.Count > 0)
        {
            //获取介绍信息
            scene_html.InnerHtml = "<p>" + dt.Rows[0]["intro"] + "</p>";
            //场景图片
            scene_image.Src = dt.Rows[0]["image4"].ToString();
            scene_name.InnerHtml = "&nbsp;&nbsp;" + dt.Rows[0]["name"].ToString();

            string point = dt.Rows[0]["point"].ToString();
            string index1 = dt.Rows[0]["index1"].ToString();
            string lev = dt.Rows[0]["lev"].ToString();
            if (lev == "简单")
            {
                scene_index.InnerHtml = "0" + index1;
                itemCount = "3"; time1 = "180";
                levPoint = "10";

            }
            else if (lev == "中级")
            {
                scene_index.InnerHtml = "0" + (int.Parse(index1) - 5);
                itemCount = "4"; time1 = "300";
                levPoint = "15";
            }
            else
            {
                scene_index.InnerHtml = "0" + (int.Parse(index1) - 10);
                itemCount = "5"; time1 = "420";
                levPoint = "20";
            }

            //绑定产品
            string produceSole1 = dt.Rows[0]["produceSole1"].ToString();
            string produceSole2 = dt.Rows[0]["produceSole2"].ToString();
            string produceSole3 = dt.Rows[0]["produceSole3"].ToString();
            string produceSole4 = dt.Rows[0]["produceSole4"].ToString();
            string produceSole5 = dt.Rows[0]["produceSole5"].ToString();
            ;
            if (produceSole1 != "") { produces += "'" + produceSole1 + "'"; }
            if (produceSole2 != "") { produces += ",'" + produceSole2 + "'"; }
            if (produceSole3 != "") { produces += ",'" + produceSole3 + "'"; }
            if (produceSole4 != "") { produces += ",'" + produceSole4 + "'"; }
            if (produceSole5 != "") { produces += ",'" + produceSole5 + "'"; }
            if (produces.Substring(0, 1) == ",") { produces = produces.Substring(1); }

        }
    }

    /// <summary>显示客户画像</summary>
    public void getMember()
    {
        DataTable dt = skin.GetDT("select p1.name as p1name,mi1.* from member_info as mi1 left join place_info as p1 on mi1.placeSole=p1.sole where mi1.sole='" + mid + "'");
        if (dt.Rows.Count > 0)
        {
            //places = dt.Rows[0]["placeSole"].ToString();
            places = skin.ExecuteScalar("select stuff((select ','+type3 from dialog2_info where memberSole='" + mid + "' for xml path('')),1,1,'')").ToString();
            ////客户ID
            //mid = dt.Rows[0]["id"].ToString();
            //客户图片
            member_image1.Src = "/Upload/member1/" + dt.Rows[0]["sex"] + "" + dt.Rows[0]["age"] + "-.png";
            image_right.Src = "/Upload/member1/" + dt.Rows[0]["sex"] + "" + dt.Rows[0]["age"] + "--.png";

            string type = dt.Rows[0]["type"].ToString();
            string html = @"<tr>
	<td colspan='2'><span class='iconfont icon-name'></span>&nbsp;人设 : " + dt.Rows[0]["character1"].ToString() + @"</td>
</tr>
<tr>
	<td><span class='iconfont icon-ziyuan25'></span>&nbsp;性别 : " + dt.Rows[0]["sex"] + @"</td>
	<td><span class='iconfont icon-nianling'></span>&nbsp;年龄 : " + dt.Rows[0]["age"] + @"</td>
</tr>
<tr>
	<td><span class='iconfont icon-daiban1'></span>&nbsp;合约 : " + dt.Rows[0]["shuxing1"] + @"</td>
	<td><span class='iconfont icon-daiban1'></span>&nbsp;价值 : " + dt.Rows[0]["shuxing2"] + @"</td>
</tr>
<tr>
	<td><span class='iconfont icon-yewu'></span>&nbsp;流量 : " + dt.Rows[0]["shuxing3"] + @"</td>
	<td><span class='iconfont icon-yewu'></span>&nbsp;资费 : " + dt.Rows[0]["shuxing4"] + @"</td>
</tr>
<tr>
	<td><span class='iconfont icon-daiban1'></span>&nbsp;融合 : " + dt.Rows[0]["shuxing5"] + @"</td>";
            if (type == "个人")
            {
                html += @"<td><span class='iconfont icon-daiban1'></span>&nbsp;视频 : " + dt.Rows[0]["shuxing6"] + @"</td></tr>
<tr>
	<td><span class='iconfont icon-yewu'></span>&nbsp;权益 : " + dt.Rows[0]["shuxing7"] + @"</td>
	<td><span class='iconfont icon-yewu'></span>&nbsp;职业 : " + dt.Rows[0]["shuxing8"] + @"</td>
</tr>
<tr><td colspan='2'><span class='iconfont icon-daiban1'></span>&nbsp;地域 : " + dt.Rows[0]["shuxing9"] + @"</td></tr>";
            }
            else if (type == "家庭")
            {
                html += @"<td><span class='iconfont icon-daiban1'></span>&nbsp;视频 : " + dt.Rows[0]["shuxing6"] + @"</td></tr>
<tr>
	<td><span class='iconfont icon-yewu'></span>&nbsp;权益 : " + dt.Rows[0]["shuxing7"] + @"</td>
	<td><span class='iconfont icon-yewu'></span>&nbsp;职业 : " + dt.Rows[0]["shuxing8"] + @"</td>
</tr>
<tr>
	<td><span class='iconfont icon-daiban1'></span>&nbsp;地域 : " + dt.Rows[0]["shuxing9"] + @"</td>
	<td><span class='iconfont icon-daiban1'></span>&nbsp;家庭 : " + dt.Rows[0]["shuxing10"] + @"</td>
</tr>";
            }
            else
            {
                html += @"<td><span class='iconfont icon-daiban1'></span>&nbsp;家庭 : " + dt.Rows[0]["shuxing6"] + @"</td></tr>
<tr>
	<td><span class='iconfont icon-yewu'></span>&nbsp;权益 : " + dt.Rows[0]["shuxing7"] + @"</td>
	<td><span class='iconfont icon-yewu'></span>&nbsp;集团属性（ABCD） : " + dt.Rows[0]["shuxing8"] + @"</td>
</tr>
<tr>
	<td><span class='iconfont icon-daiban1'></span>&nbsp;集团星级 : " + dt.Rows[0]["shuxing9"] + @"</td>
	<td><span class='iconfont icon-daiban1'></span>&nbsp;集团等级 : " + dt.Rows[0]["shuxing10"] + @"</td>
</tr>
<tr>
	<td><span class='iconfont icon-yewu'></span>&nbsp;集团份额 : " + dt.Rows[0]["shuxing11"] + @"</td>
	<td><span class='iconfont icon-yewu'></span>&nbsp;集团成员数 : " + dt.Rows[0]["shuxing12"] + @"</td>
</tr>
<tr><td colspan='2'><span class='iconfont icon-daiban1'></span>&nbsp;保拓优先级 : " + dt.Rows[0]["shuxing13"] + @"</td></tr>";
            }
            member_html.InnerHtml = html;
        }
    }

    /// <summary>产品信息</summary>
    public void getProduce()
    {
        StringBuilder html = new StringBuilder();

        //获取对应的产品信息
        DataTable produce1 = skin.GetDT("select pi1.*,pt1.string1 from produce_info as pi1 left join [produce_type] as pt1 on pi1.typeSole=pt1.sole where pi1.sole in ('" + pids.Replace(",", "','") + "') order by pi1.index1");
        for (int i = 0; i < produce1.Rows.Count; i++)
        {
            html.Append(@"<div class='cont3-card'>
	<div class='cont3-card-name'><img src='" + produce1.Rows[i]["string1"] + @"'/></div>
	<div class='cont3-card-text'>
		<h3>" + produce1.Rows[i]["name"] + @"</h3>
		<ul class='cont3-card-ul'><li class='look'><a value='" + produce1.Rows[i]["intro"] + @"'>详情</a></li></ul>
	</div>
	
</div>");
        }
        produce_html.InnerHtml = html.ToString();
    }

    /// <summary>获取触点</summary>
    public void getPlace()
    {
        string name = skin.ExecuteScalar("select name from [place_info] where sole='" + pid + "'").ToString();
        place_image.Src = "/Upload/place/" + name + ".jpg";
        page_bg.Style.Add("background", "url(/Upload/place/bg/" + name + ".jpg) no-repeat;background-size:cover");
        place_name.InnerHtml = name;
    }

    /// <summary>获取资源库</summary>
    public void getResources()
    {
        DataTable dt = skin.GetDT("select * from resources_info where isUsed=1");
        StringBuilder html = new StringBuilder();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            html.Append(@"<div class='ck-cont-card active' title='" + dt.Rows[i]["name"] + "' point1='" + dt.Rows[i]["num1"] + "' point2='" + dt.Rows[i]["num2"] + "'><p>" + dt.Rows[i]["name"] + "</p><img class='dg' src='img/pop/对勾.png' style='display:none'/></div>");
        }
        resources_html.InnerHtml = html.ToString();
    }

    /// <summary>获取学习资料</summary>
    public static string GetLearns()
    {
        StringBuilder html = new StringBuilder();
        //DataTable dt = skin.GetDT("select * from [learn_info] where isUsed=1");
        DataTable dt = skin.GetDT("select * from [produce_info] where isUsed=1");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            html.Append("<li id=" + dt.Rows[i]["id"] + " title=" + dt.Rows[i]["name"] + " time=" + dt.Rows[i]["createDate"] + "><p>" + (i + 1) + "、" + dt.Rows[i]["name"] + "</p><span>" + DateTime.Parse(dt.Rows[i]["createDate"].ToString()).ToString("yyyy-MM-dd") + "</span></li>");
        }
        return html.ToString();
    }

    /// <summary>获取客户回应</summary>
    /// <param name="chatHistory">对话历史</param>
    /// <param name="customerInfo">客户信息</param>
    /// <returns>客户回应</returns>
    [System.Web.Services.WebMethod]
    public static string GetCustomerResponse(object chatHistory, object customerInfo)
    {
        Member_game page = new Member_game();
        return page.GetCustomerResponseInternal(chatHistory, customerInfo);
    }

    /// <summary>获取随机客户角色信息</summary>
    /// <returns>随机客户角色信息</returns>
    private string GetRandomCustomerInfo()
    {
        // 从数据库中获取所有客户信息
        DataTable dt = skin.GetDT("select top 5 * from member_info order by newid()");
        if (dt.Rows.Count > 0)
        {
            // 随机选择一个客户信息
            int randomIndex = new Random().Next(0, dt.Rows.Count);
            DataRow row = dt.Rows[randomIndex];
            
            // 构建客户信息对象
            var customerInfo = new {
                name = row["character1"].ToString(),
                age = row["age"].ToString(),
                sex = row["sex"].ToString(),
                type = row["type"].ToString(),
                shuxing1 = row["shuxing1"].ToString(),
                shuxing2 = row["shuxing2"].ToString(),
                shuxing3 = row["shuxing3"].ToString(),
                shuxing4 = row["shuxing4"].ToString(),
                shuxing5 = row["shuxing5"].ToString()
            };
            
            return Newtonsoft.Json.JsonConvert.SerializeObject(customerInfo);
        }
        return "{}";
    }

    /// <summary>内部获取客户回应方法</summary>
    /// <param name="chatHistory">对话历史</param>
    /// <param name="customerInfo">客户信息</param>
    /// <returns>客户回应</returns>
    private string GetCustomerResponseInternal(object chatHistory, object customerInfo)
    {
        // 转换参数格式
        string context = Newtonsoft.Json.JsonConvert.SerializeObject(chatHistory);
        string customerContext = Newtonsoft.Json.JsonConvert.SerializeObject(customerInfo);
        return deepSeekAPI.GetCustomerResponse(context, customerContext);
    }

    /// <summary>评估对话</summary>
    /// <param name="dialogHistory">对话历史</param>
    /// <returns>评估结果</returns>
    [System.Web.Services.WebMethod]
    public static string EvaluateDialog(object dialogHistory)
    {
        Member_game page = new Member_game();
        return page.EvaluateDialogInternal(dialogHistory);
    }

    /// <summary>内部评估对话方法</summary>
    /// <param name="dialogHistory">对话历史</param>
    /// <returns>评估结果</returns>
    private string EvaluateDialogInternal(object dialogHistory)
    {
        string dialogContext = Newtonsoft.Json.JsonConvert.SerializeObject(dialogHistory);
        // 使用默认评分标准
        string scoringCriteria = "根据对话内容，评估学员的话术是否专业、准确、有针对性，是否能够有效引导客户购买合适的套餐。评分范围为1-5分，5分为最佳。请返回评分和详细评价。";
        string evaluation = deepSeekAPI.EvaluateDialog(dialogContext, scoringCriteria);
        
        // 解析评估结果
        return ParseEvaluationResult(evaluation);
    }

    /// <summary>解析评估结果</summary>
    /// <param name="evaluation">评估结果</param>
    /// <returns>解析后的评估结果</returns>
    private string ParseEvaluationResult(string evaluation)
    {
        // 简单的解析逻辑，实际项目中可能需要更复杂的解析
        // 这里假设评估结果包含评分和评价
        return evaluation;
    }
}