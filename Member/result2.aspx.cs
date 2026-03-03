using System;
using harry.DAL.Sql.Sql2008;

public partial class Member_result2 : System.Web.UI.Page
{
    public string cqp = "";
    public string all = "";
    public string now = "";
    public string qingxu = "";
    public string p1 = "";
    public string p2 = "";

    public string rid = "";
    public string did = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        cqp = Request["cqp"] ?? "0";
        all = Request["all"] ?? "0";
        now = Request["now"] ?? "0";
        qingxu = Request["qingxu"] ?? "0";
        p1 = Request["p1"] ?? "0";
        p2 = Request["p2"] ?? "0";

        rid = Request["rid"] ?? "101";
        did = Request["did"] ?? "101";
        if (rid != "" && did != "")
        {
            skin.ExecuteSql("update room_detail set state='已结束',result='失败' where sole='" + did + "' and roomSole='" + rid + "'");
        }
    }
}