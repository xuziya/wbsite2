using System;
using System.Data;
using harry.DAL.Sql.Sql2008;

public partial class Member_pinggu22 : System.Web.UI.Page
{
    public string cqp = "";
    public string all = "";
    public string now = "";
    public string qingxu = "";
    public string p1 = "";
    public string p2 = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        string regID = Request["regID"] ?? "";
        if (regID != "")
        {
            DataTable dt = skin.GetDT("select t1.*,si1.point from game_reg as t1 left join scene_info as si1 on t1.sceneSole=si1.sole where t1.id=" + regID);
            if (dt.Rows.Count > 0)
            {
                cqp = dt.Rows[0]["point"].ToString();
                all = dt.Rows[0]["value3"].ToString();
                now = dt.Rows[0]["value4"].ToString();
                qingxu = dt.Rows[0]["value2"].ToString();
                p1 = dt.Rows[0]["value8"].ToString();
                p2 = dt.Rows[0]["value9"].ToString();
            }
        }

        //cqp = Request["cqp"] ?? "0";
        //all = Request["all"] ?? "0";
        //now = Request["now"] ?? "0";
        //qingxu = Request["qingxu"] ?? "0";
        //p1 = Request["p1"] ?? "0";
        //p2 = Request["p2"] ?? "0";
    }
}