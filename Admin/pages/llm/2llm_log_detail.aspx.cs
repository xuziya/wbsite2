using System;
using System.Data;
using System.Web.UI;
using harry.DAL.Sql.Sql2008;

public partial class Admin_pages_llm_2llm_log_detail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(id))
            {
                LoadDialogDetail(id);
            }
        }
    }

    private void LoadDialogDetail(string id)
    {
        // 从数据库中获取对话详情
        try
        {
            // 创建数据库连接
            harry.DAL.Sql.Sql2008.DbHelper skin = new harry.DAL.Sql.Sql2008.DbHelper();
            
            // 从数据库中读取对话详情
            string sql = string.Format("select * from llm_log where id = {0}", id);
            DataTable dt = skin.GetDT(sql);
            
            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                studentName.InnerText = row["studentName"].ToString();
                dialogTime.InnerText = row["dialogTime"].ToString();
                dialogContent.InnerText = row["dialogContent"].ToString();
                score.InnerText = row["score"].ToString();
                
                // 显示评估结果
                string evaluationText = row["evaluation"] != DBNull.Value ? row["evaluation"].ToString() : "暂无评估结果";
                evaluation.InnerHtml = evaluationText;
            }
        }
        catch (Exception ex)
        {
            // 记录错误日志
            System.Diagnostics.Debug.WriteLine("LoadDialogDetail error: " + ex.Message);
        }
    }
}