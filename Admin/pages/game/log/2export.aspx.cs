using System;
using System.Collections.Generic;
using Tools;

public partial class Admin_pages_game_log_2export : AdminBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
    }

    /// <summary>导出</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        string _start = start.Text, _end = end.Text, fname = DateTime.Now.ToString("yyyy年MM月dd日HHmmss 游戏记录");
        System.Data.DataTable dt = harry.DAL.Sql.Sql2008.skin.GetDT(@"select t1.id as '信息编号',si1.id as '场景编号',si1.name as '场景名称',si1.point as '场景评价', ti1.name as '游戏者',t1.type1 as '类型',mi1.name as '房主',t1.result as '结果',t1.value1 as '剩余血量',t1.value2 as '情绪值',t1.value3 as '总分',t1.value4 as '得分',t1.value7 as '用时（秒）',CAST((CAST(t1.value8 as float) * 100) as varchar) + '%' as '产品正选率',CAST((CAST(t1.value9 as float) * 100) as varchar) + '%' as '触点正选率',t1.createDate as '游戏时间'  
from game_reg as t1
 left join student_info as ti1 on t1.studentSole=ti1.sole
 left join scene_info as si1 on t1.sceneSole=si1.sole
 left join room_info as ri1 on t1.roomSole1=ri1.sole
 left join admin_per_manager as mi1 on t1.roomSole2=mi1.sole " + (_start != "" ? " and t1.createDate>='" + _start + "'" : "") + (_end != "" ? " and t1.createDate<='" + _end + "'" : ""));
        harry.Tools.Files.Excel.Export(this, dt);
    }
}