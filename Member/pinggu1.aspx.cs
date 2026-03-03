using System;
using System.Data;
using System.Text;
using System.Web;
using harry.DAL.Sql.Sql2008;


public partial class Member_pinggu1 : MemberBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
    }

    /// <summary>获取学习资料</summary>
    public static string GetLearns()
    {
        string sql = @"select t1.id as '信息编号',si1.id as '场景编号',si1.name as '场景名称',si1.point as '场景评价', ti1.name as '游戏者',t1.type1 as '类型',t1.result as '结果',t1.value1 as '剩余血量',t1.value2 as '情绪值',t1.value3 as '总分',t1.value4 as '得分',t1.value7 as '用时（秒）',CAST((CAST(t1.value8 as float) * 100) as varchar) + '%' as '产品正选率',CAST((CAST(t1.value9 as float) * 100) as varchar) + '%' as '触点正选率',t1.createDate as '游戏时间'  
from game_reg as t1 left join student_info as ti1 on t1.studentSole=ti1.sole left join scene_info as si1 on t1.sceneSole=si1.sole where t1.createSole='" + GetSole() + "' order by t1.id desc";

        DataTable dt = skin.GetDT(sql);

        StringBuilder html = new StringBuilder();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            html.Append("<li id=" + dt.Rows[i]["信息编号"] + " result=" + dt.Rows[i]["结果"] + " title=" + dt.Rows[i]["场景名称"] + " time=" + dt.Rows[i]["游戏时间"] + "><p>" + (i + 1) + "、" + dt.Rows[i]["场景名称"] + "  （" + dt.Rows[i]["结果"] + "）</p><span>" + DateTime.Parse(dt.Rows[i]["游戏时间"].ToString()).ToString("yyyy-MM-dd") + "</span></li>");
        }
        return html.ToString();
    }
}