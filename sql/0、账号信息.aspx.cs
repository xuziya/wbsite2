using System;
using System.Data;
using System.Text;
using harry.DAL.Sql.Sql2008;
using harry.Tools.Files;

public partial class sql_0_账号信息 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    /// <summary>产品信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        DataTable dt = Excel.Import(Server.MapPath("~/sql/0、账号3.xlsx"),1);

        StringBuilder sql = new StringBuilder();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            //产品分类编号
            string organ = skin.ExecuteScalar("select sole from [admin_organ] where name='" + dt.Rows[i]["所属机构"].ToString() + "'").ToString();
            sql.Append("insert into student_info values('','" + organ + "','','" + dt.Rows[i]["姓名"] + "','" + dt.Rows[i]["员工编号"] + "','" + dt.Rows[i]["性别"] + "','','" + dt.Rows[i]["部门"] + "','','" + dt.Rows[i]["用户名"] + "','" + dt.Rows[i]["密码"] + "','" + dt.Rows[i]["性别"] + "1','" + dt.Rows[i]["性别"] + "1',1,1,0,'','','','');" + "<br />");
        }

        Response.Write(sql.ToString());
        Response.End();
    }
}