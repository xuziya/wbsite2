using System;
using System.Data;
using System.Text;
using harry.DAL.Sql.Sql2008;
using harry.Tools.Files;

public partial class sql_3集客信息 : System.Web.UI.Page
{
    private string excel_path = "~/sql/3、集客.xlsx";
    protected void Page_Load(object sender, EventArgs e)
    {
        excel_path = Server.MapPath(excel_path);
    }

    /// <summary>产品信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        object name = "产品库";
        DataTable dt = Excel.Import(excel_path, name);

        string type = "";
        StringBuilder sql = new StringBuilder("----  集客  ---- <br />");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            //产品分类编号
            string code = skin.ExecuteScalar("select sole from [produce_type] where name='" + dt.Rows[i]["产品类型"].ToString() + "' and type='集团'").ToString();

            if (type != dt.Rows[i]["产品类型"].ToString())
            {
                type = dt.Rows[i]["产品类型"].ToString();
                sql.Append("--" + type + " " + code + "<br />");
            }
            sql.Append("insert into produce_info values('','" + code + "','集团','" + dt.Rows[i]["产品名称"].ToString() + "','" + dt.Rows[i]["产品档位"].ToString() + "','" + dt.Rows[i]["排序"].ToString() + "','" + dt.Rows[i]["产品介绍"].ToString() + "','','',1,1,'','','');" + "<br />");
        }

        Response.Write(sql.ToString());
        Response.End();
    }

    /// <summary>场景信息</summary>
    protected void Button2_Click(object sender, EventArgs e)
    {
        object name = "场景名称库";
        DataTable dt = Excel.Import(excel_path, name);

        StringBuilder sql = new StringBuilder("----  集客  ---- <br />");
        for (int i = 0; i < 15; i++)
        {
            string lev = "", produce1 = "", produce2 = "", produce3 = "", produce4 = "", code1 = "", code2 = "", code3 = "", code4 = "";
            //难度
            lev = dt.Rows[i]["难度"].ToString(); if (lev == "10") { lev = "简单"; } else if (lev == "15") { lev = "中级"; } else { lev = "困难"; }
            //产品信息编号
            produce1 = dt.Rows[i]["推荐产品1"].ToString(); if (produce1 != "") { code1 = skin.ExecuteScalar("select sole from produce_info where name='" + produce1 + "'").ToString(); }
            produce2 = dt.Rows[i]["推荐产品2"].ToString(); if (produce2 != "") { code2 = skin.ExecuteScalar("select sole from produce_info where name='" + produce2 + "'").ToString(); }
            produce3 = dt.Rows[i]["推荐产品3"].ToString(); if (produce3 != "") { code3 = skin.ExecuteScalar("select sole from produce_info where name='" + produce3 + "'").ToString(); }
            produce4 = dt.Rows[i]["推荐产品4"].ToString(); if (produce4 != "") { code4 = skin.ExecuteScalar("select sole from produce_info where name='" + produce4 + "'").ToString(); }

            sql.Append("insert into scene_info values('','集团','" + dt.Rows[i]["场景名称"].ToString() + "','" + lev + "'," + dt.Rows[i]["难度"].ToString() + "," + (i + 1) + ",'" + dt.Rows[i]["场景介绍"].ToString() + "','/Upload/scene/集团/" + (i + 1) + ".jpg','/Upload/scene/集团/" + (i + 1) + "-.jpg','/Upload/scene/集团/" + (i + 1) + "--.png','/Upload/scene/集团/" + (i + 1) + "---.png','/Upload/scene/集团/" + (i + 1) + "----.png','','','','','" + code1 + "','" + code2 + "','" + code3 + "','" + code4 + "','',0,1,0,'','');" + "<br />");
        }

        Response.Write(sql.ToString());
        Response.End();
    }

    /// <summary>客户画像信息</summary>
    protected void Button3_Click(object sender, EventArgs e)
    {
        object name = "客户画像库";
        DataTable dt = Excel.Import(excel_path, name);

        int index = 130;
        StringBuilder sql = new StringBuilder("----  集客  ---- <br />");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (i % 6 == 0) { index++; }
            sql.Append("insert into member_info values('','" + index + "','','集团','" + dt.Rows[i]["客户名称"].ToString() + "','" + dt.Rows[i]["人设"].ToString() + "','" + dt.Rows[i]["性别"].ToString() + "','" + dt.Rows[i]["年龄"].ToString() + "','" + dt.Rows[i]["合约"].ToString() + "','" + dt.Rows[i]["价值"].ToString() + "','" + dt.Rows[i]["流量"].ToString() + "','" + dt.Rows[i]["资费"].ToString() + "','" + dt.Rows[i]["融合"].ToString() + "','" + dt.Rows[i]["家庭"].ToString() + "','" + dt.Rows[i]["权益"].ToString() + "','" + dt.Rows[i]["集团属性（ABCD）"].ToString() + "','" + dt.Rows[i]["集团星级"].ToString() + "','" + dt.Rows[i]["集团等级"].ToString() + "','" + dt.Rows[i]["集团份额"].ToString() + "','" + dt.Rows[i]["集团成员数"].ToString() + "','" + dt.Rows[i]["保拓优先级"].ToString() + "','','','','','','','',1,1,0,'','','','');" + "<br />");
        }

        Response.Write(sql.ToString());
        Response.End();
    }

    /// <summary>问候对话池</summary>
    protected void Button4_Click(object sender, EventArgs e)
    {
        object name = "问候对话池";
        DataTable dt = Excel.Import(excel_path, name);

        string place = "";
        StringBuilder sql = new StringBuilder("----  集客  ---- <br />");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            //难度
            place = dt.Rows[i]["触点名称"].ToString();
            if (place == "外呼触点" || place == "外呼") { place = "10"; }
            else if (place == "进厅触点" || place == "进厅") { place = "11"; }
            else if (place == "入户触点" || place == "入户") { place = "12"; }
            else if (place == "微信触点" || place == "微信") { place = "13"; }
            else if (place == "短信触点" || place == "短信") { place = "14"; }
            else { place = "15"; }

            sql.Append("insert into dialog1_info values('','" + place + "','集团','选择','" + dt.Rows[i]["类型"].ToString() + "','" + dt.Rows[i]["内容1"].ToString() + "','" + dt.Rows[i]["回复1"].ToString() + "','" + dt.Rows[i]["得分1"].ToString() + "','" + dt.Rows[i]["内容2"].ToString() + "','" + dt.Rows[i]["回复2"].ToString() + "','" + dt.Rows[i]["得分2"].ToString() + "','随机','随机','0','随机','随机','0','随机','随机','205',1,1,'','','');" + "<br />");
        }

        Response.Write(sql.ToString());
        Response.End();
    }

    ///// <summary>关怀对话池</summary>
    //protected void Button5_Click(object sender, EventArgs e)
    //{
    //    DataTable dt = Excel.Import(Server.MapPath("~/sql/3集客信息/5、关怀.xls"));
    //    StringBuilder sql = new StringBuilder("----  集客  ---- <br />");

    //    int index = 280;
    //    for (int i = 0; i < dt.Rows.Count; i++)
    //    {
    //        if (i % 2 == 0) { index++; }

    //        sql.Append("insert into dialog2_info values('','" + index + "','集团','选择','','" + dt.Rows[i]["内容1"].ToString() + "','" + dt.Rows[i]["回复1"].ToString() + "','" + dt.Rows[i]["得分1"].ToString() + "','随机','随机','0','随机','随机','0','随机','随机','0','随机','随机','0',1,1,'','','');" + "<br />");
    //    }

    //    Response.Write(sql.ToString());
    //    Response.End();
    //}

    /// <summary>关怀对话池 - 新</summary>
    protected void Button7_Click(object sender, EventArgs e)
    {
        object name = "关怀对话池";
        DataTable dt = Excel.Import(excel_path, name);

        int index = 281;
        string place1 = "", place2 = "", place3 = "";
        StringBuilder sql = new StringBuilder("----  集客  ---- <br />");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            sql.Append("--" + index + "<br />");

            place1 = dt.Rows[i]["触点1名称"].ToString();
            if (place1 != "")
            {
                place1 = getPlace(dt.Rows[i]["触点1名称"].ToString());
                sql.Append("insert into dialog2_info values('','" + index + "','集团','选择','" + place1 + "','" + dt.Rows[i]["触点1销售"].ToString() + "','" + dt.Rows[i]["触点1客户"].ToString() + "','" + dt.Rows[i]["触点1得分"].ToString() + "','随机','随机','0','随机','随机','0','随机','随机','0','随机','随机','0',1,1,'','','');" + "<br />");
                sql.Append("insert into dialog2_info values('','" + index + "','集团','选择','" + place1 + "','" + dt.Rows[i + 1]["触点1销售"].ToString() + "','" + dt.Rows[i + 1]["触点1客户"].ToString() + "','" + dt.Rows[i + 1]["触点1得分"].ToString() + "','随机','随机','0','随机','随机','0','随机','随机','0','随机','随机','0',1,1,'','','');" + "<br />");
            }
            //place2 = dt.Rows[i]["触点2名称"].ToString();
            //if (place2 != "")
            //{
            //    place2 = getPlace(dt.Rows[i]["触点2名称"].ToString());
            //    sql.Append("insert into dialog2_info values('','" + index + "','集团','选择','" + place2 + "','" + dt.Rows[i]["触点2销售"].ToString() + "','" + dt.Rows[i]["触点2客户"].ToString() + "','" + dt.Rows[i]["触点2得分"].ToString() + "','随机','随机','0','随机','随机','0','随机','随机','0','随机','随机','0',1,1,'','','');" + "<br />");
            //    sql.Append("insert into dialog2_info values('','" + index + "','集团','选择','" + place2 + "','" + dt.Rows[i + 1]["触点2销售"].ToString() + "','" + dt.Rows[i + 1]["触点2客户"].ToString() + "','" + dt.Rows[i + 1]["触点2得分"].ToString() + "','随机','随机','0','随机','随机','0','随机','随机','0','随机','随机','0',1,1,'','','');" + "<br />");
            //}
            //place3 = dt.Rows[i]["触点3名称"].ToString();
            //if (place3 != "")
            //{
            //    place3 = getPlace(dt.Rows[i]["触点3名称"].ToString());
            //    sql.Append("insert into dialog2_info values('','" + index + "','集团','选择','" + place3 + "','" + dt.Rows[i]["触点3销售"].ToString() + "','" + dt.Rows[i]["触点3客户"].ToString() + "','" + dt.Rows[i]["触点3得分"].ToString() + "','随机','随机','0','随机','随机','0','随机','随机','0','随机','随机','0',1,1,'','','');" + "<br />");
            //    sql.Append("insert into dialog2_info values('','" + index + "','集团','选择','" + place3 + "','" + dt.Rows[i + 1]["触点3销售"].ToString() + "','" + dt.Rows[i + 1]["触点3客户"].ToString() + "','" + dt.Rows[i + 1]["触点3得分"].ToString() + "','随机','随机','0','随机','随机','0','随机','随机','0','随机','随机','0',1,1,'','','');" + "<br />");
            //}
            index++;
            i++;
        }

        Response.Write(sql.ToString());
        Response.End();
    }

    /// <summary>销售对话池</summary>
    protected void Button6_Click(object sender, EventArgs e)
    {
        object name = "销售对话池";
        DataTable dt = Excel.Import(excel_path, name);

        string name1 = "";
        StringBuilder sql = new StringBuilder("----  集客  ---- <br />");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            //产品编号
            string code = skin.ExecuteScalar("select sole from [produce_info] where name='" + dt.Rows[i]["产品名称"].ToString() + "'").ToString();

            if (name1 != dt.Rows[i]["产品名称"].ToString())
            {
                name1 = dt.Rows[i]["产品名称"].ToString();
                sql.Append("--" + name1 + " " + code + "<br />");
            }

            sql.Append("insert into dialog3_info values('','" + code + "','集团','选择','1','" + dt.Rows[i]["内容11"].ToString() + "','" + dt.Rows[i]["回复11"].ToString() + "','" + dt.Rows[i]["得分11"].ToString() + "','" + dt.Rows[i]["内容12"].ToString() + "','" + dt.Rows[i]["回复12"].ToString() + "','" + dt.Rows[i]["得分12"].ToString() + "','随机','随机','0','随机','随机','0','随机','随机','0',1,1,'','','');" + "<br />");
            sql.Append("insert into dialog3_info values('','" + code + "','集团','选择','2','" + dt.Rows[i]["内容21"].ToString() + "','" + dt.Rows[i]["回复21"].ToString() + "','" + dt.Rows[i]["得分21"].ToString() + "','" + dt.Rows[i]["内容22"].ToString() + "','" + dt.Rows[i]["回复22"].ToString() + "','" + dt.Rows[i]["得分22"].ToString() + "','随机','随机','0','随机','随机','0','随机','随机','0',1,1,'','','');" + "<br />");
            sql.Append("insert into dialog3_info values('','" + code + "','集团','选择','3','" + dt.Rows[i]["内容31"].ToString() + "','" + dt.Rows[i]["回复31"].ToString() + "','" + dt.Rows[i]["得分31"].ToString() + "','" + dt.Rows[i]["内容32"].ToString() + "','" + dt.Rows[i]["回复32"].ToString() + "','" + dt.Rows[i]["得分32"].ToString() + "','随机','随机','0','随机','随机','0','随机','随机','0',1,1,'','','');" + "<br />");
        }

        Response.Write(sql.ToString());
        Response.End();
    }

    public string getPlace(string place)
    {
        if (place == "外呼触点" || place == "外呼") { place = "10"; }
        else if (place == "进厅触点" || place == "进厅") { place = "11"; }
        else if (place == "入户触点" || place == "入户") { place = "12"; }
        else if (place == "微信触点" || place == "微信") { place = "13"; }
        else if (place == "短信触点" || place == "短信") { place = "14"; }
        else { place = "15"; }
        return place;
    }
}