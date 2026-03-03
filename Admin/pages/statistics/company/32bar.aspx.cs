using System;

public partial class Admin_pages_statistics_equipment_32bar1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public string GetPieJs()
    {
        string typeSole = Request["t"] ?? "";
        System.Data.DataTable dt = harry.DAL.Sql.Sql2008.skin.GetDT(@"select year(createDate) as 年,month(createDate) as 月,count(id) as 数量 from [student_info] " + (typeSole != "" ? " where typeSole='" + typeSole + "' " : "") + " group by year(createDate),month(createDate)");
        System.Text.StringBuilder result = new System.Text.StringBuilder();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            //result.Append("[new Date(\"" + dt.Rows[i]["年"] + "-" + dt.Rows[i]["月"] + "\"), " + dt.Rows[i]["数量"] + "],");
            result.Append("[\"" + dt.Rows[i]["年"] + "-" + dt.Rows[i]["月"] + "\", " + dt.Rows[i]["数量"] + "],");
        }
        if (result.Length > 0) { result.Remove(result.Length - 1, 1); }
        return "[" + result.ToString() + "]";
    }
}