using System;

public partial class Admin_pages_statistics_equipment_22pie1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public string GetPieJs()
    {
        string typeSole = Request["t"] ?? "";
        System.Data.DataTable dt = harry.DAL.Sql.Sql2008.skin.GetDT(@"select ct1.sole,ct1.name as ct1_name,t1.count1 from (select typeSole,COUNT(id) as count1 from student_info group by typeSole) as t1 left join [company_type] as ct1 on t1.typeSole=ct1.sole");
        System.Text.StringBuilder result = new System.Text.StringBuilder();
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                result.Append("{ value: " + dt.Rows[i]["count1"] + ", name: '" + dt.Rows[i]["ct1_name"] + "' },");
            }
        }
        return result.ToString();
    }
}