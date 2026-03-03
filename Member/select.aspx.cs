using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using harry.DAL.Sql.Sql2008;

public partial class Member_select : System.Web.UI.Page
{
    public string lev = "2";

    public string rid = "";
    public string did = "";
    public string sid = "";
    public string mid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        //房间编号
        rid = Request["rid"] ?? "";
        //房间明细编号
        did = Request["did"] ?? "";
        if (rid != "" && did != "")
        {
            skin.ExecuteSql("update room_detail set state='已开始',point=0 where sole='" + did + "' and roomSole='" + rid + "'");
        }

        //场景编号
        sid = Request["sid"] ?? "104";
        //场景半身像
        //image_html.Src = skin.ExecuteScalar("select image2 from scene_info where id=" + sid).ToString();
        //随机抽取一个客户画像
        getMember(sid);
        //产品信息
        getProduce(sid);


        string l = skin.ExecuteScalar("select lev from scene_info where id=" + sid).ToString();
        if (l == "简单") { lev = "2"; }
        else if (l == "中级") { lev = "3"; }
        else { lev = "4"; }
    }

    /// <summary>随机抽取一个客户画像</summary>
    public void getMember(string sid)
    {
        DataTable dt = skin.GetDT("select top 1 p1.name as p1name,mi1.* from member_info as mi1 left join place_info as p1 on mi1.placeSole=p1.sole where sceneSole='" + sid + "' order by NEWID()");
        if (dt.Rows.Count > 0)
        {
            //客户ID
            mid = dt.Rows[0]["id"].ToString();
            //客户图片
            image_html.Src = "/Upload/member1/" + dt.Rows[0]["sex"] + "" + dt.Rows[0]["age"] + "-.png";

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
    public void getProduce(string sid)
    {
        StringBuilder html = new StringBuilder();

        DataTable scene = skin.GetDT("select * from scene_info where id='" + sid + "'");
        if (scene.Rows.Count > 0)
        {
            string lev = scene.Rows[0]["lev"].ToString();
            if (lev == "简单") { produce_tip_html.InnerHtml = "请在下列产品中选择 1-2 个你认为客户需要的产品"; }
            else if (lev == "中级") { produce_tip_html.InnerHtml = "请在下列产品中选择 1-3 个你认为客户需要的产品"; }
            else { produce_tip_html.InnerHtml = "请在下列产品中选择 1-4 个你认为客户需要的产品"; }

            //场景信息
            scene_image.Src = scene.Rows[0]["image4"].ToString();
            scene_name.InnerHtml = "&nbsp;&nbsp;" + scene.Rows[0]["name"].ToString();
            string index1 = scene.Rows[0]["index1"].ToString();
            if (lev == "简单") { scene_index.InnerHtml = "0" + index1; }
            else if (lev == "中级") { scene_index.InnerHtml = "0" + (int.Parse(index1) - 5); }
            else { scene_index.InnerHtml = "0" + (int.Parse(index1) - 10); }

            //简介
            intro_html.InnerHtml = scene.Rows[0]["intro"].ToString();

            string produceSole1 = scene.Rows[0]["produceSole1"].ToString();
            string produceSole2 = scene.Rows[0]["produceSole2"].ToString();
            string produceSole3 = scene.Rows[0]["produceSole3"].ToString();
            string produceSole4 = scene.Rows[0]["produceSole4"].ToString();
            string produceSole5 = scene.Rows[0]["produceSole5"].ToString();
            string pid = "";
            if (produceSole1 != "") { pid += "'" + produceSole1 + "'"; }
            if (produceSole2 != "") { pid += ",'" + produceSole2 + "'"; }
            if (produceSole3 != "") { pid += ",'" + produceSole3 + "'"; }
            if (produceSole4 != "") { pid += ",'" + produceSole4 + "'"; }
            if (produceSole5 != "") { pid += ",'" + produceSole5 + "'"; }
            if (pid.Substring(0, 1) == ",") { pid = pid.Substring(1); }

            List<DataRow> rows = new List<DataRow>();

            //string typeSole = "";
            //获取对应的产品信息
            DataTable produce1 = skin.GetDT("select pi1.*,pt1.string1 from produce_info as pi1 left join [produce_type] as pt1 on pi1.typeSole=pt1.sole where pi1.sole in(" + pid + ")");
            for (int i = 0; i < produce1.Rows.Count; i++)
            {
                rows.Add(produce1.Rows[i]);

                //typeSole = produce1.Rows[i]["typeSole"].ToString();
//                html.Append(@"<div class='cont3-card'>
//	<div class='cont3-card-name'><img src='" + produce1.Rows[i]["string1"] + @"'/></div>
//	<div class='cont3-card-text'>
//		<h3>" + produce1.Rows[i]["name"] + @"</h3>
//		<ul class='cont3-card-ul'><li class='look'><a value='" + produce1.Rows[i]["intro"] + @"'>详情</a></li><li class='choice'><a>选择</a></li></ul>
//	</div>
//	<div id='" + produce1.Rows[i]["id"] + @"' class='cont3-card-xz'><img src='img/pop/绿色.png'/></div>
//</div>");
            }

            int pro_num1 = produce1.Rows.Count;//绑定
            //int pro_num2 = (8 - produce1.Rows.Count) % 2;if (pro_num2 == 0) { pro_num2 = (8 - produce1.Rows.Count) / 2; } else { pro_num2 = (8 - produce1.Rows.Count - 1) / 2; }
            //int pro_num3 = 8 - pro_num1 - pro_num2;

//            //获取同类随机产品信息
//            DataTable produce2 = skin.GetDT("select top " + pro_num2 + " pi1.*,pt1.string1 from produce_info as pi1 left join [produce_type] as pt1 on pi1.typeSole=pt1.sole where pi1.typeSole='" + typeSole + "' and pi1.sole not in(" + pid + ") order by NEWID()");
//            for (int i = 0; i < produce2.Rows.Count; i++)
//            {
//                html.Append(@"<div class='cont3-card'>
//	<div class='cont3-card-name'><img src='" + produce2.Rows[i]["string1"] + @"'/></div>
//	<div class='cont3-card-text'>
//		<h3>" + produce2.Rows[i]["name"] + @"</h3>
//		<ul class='cont3-card-ul'><li class='look'><a value='" + produce2.Rows[i]["intro"] + @"'>详情</a></li><li class='choice'><a>选择</a></li></ul>
//	</div>
//	<div id='" + produce2.Rows[i]["id"] + @"' class='cont3-card-xz'><img src='img/pop/绿色.png'/></div>
//</div>");
//            }

            //获取其他类随机产品信息
            DataTable produce3 = skin.GetDT("select top " + (8 - pro_num1) + " pi1.*,pt1.string1 from produce_info as pi1 left join [produce_type] as pt1 on pi1.typeSole=pt1.sole where pi1.sole not in(" + pid + ") order by NEWID()");
            for (int i = 0; i < produce3.Rows.Count; i++)
            {
                rows.Add(produce3.Rows[i]);

//                html.Append(@"<div class='cont3-card'>
//	<div class='cont3-card-name'><img src='" + produce3.Rows[i]["string1"] + @"'/></div>
//	<div class='cont3-card-text'>
//		<h3>" + produce3.Rows[i]["name"] + @"</h3>
//		<ul class='cont3-card-ul'><li class='look'><a value='" + produce3.Rows[i]["intro"] + @"'>详情</a></li><li class='choice'><a>选择</a></li></ul>
//	</div>
//	<div id='" + produce3.Rows[i]["id"] + @"' class='cont3-card-xz'><img src='img/pop/绿色.png'/></div>
//</div>");
            }

            //Sort2(rows);
            for (int i = 0; i < rows.Count; i++)
            {
                DataRow row = rows[i];
                html.Append(@"<div class='cont3-card'>
                	<div class='cont3-card-name'><img src='" + row["string1"] + @"'/></div>
                	<div class='cont3-card-text'>
                		<h3>" + row["name"] + @"</h3>
                		<ul class='cont3-card-ul'><li class='look'><a value='" + row["intro"] + @"'>详情</a></li><li class='choice'><a>选择</a></li></ul>
                	</div>
                	<div id='" + row["id"] + @"' class='cont3-card-xz'><img src='img/pop/绿色.png'/></div>
                </div>");
            }
        }
        produce_html.InnerHtml = html.ToString();
    }

    /// <summary>随机打乱数组/summary>
    public static void Sort2(List<DataRow> arr)
    {
        for (int i = 0; i < arr.Count; i++)
        {
            var index = new Random().Next(i, arr.Count);
            var tmp = arr[i];
            var ran = arr[index];
            arr[i] = ran;
            arr[index] = tmp;
        }
    }
}