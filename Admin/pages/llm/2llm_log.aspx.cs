using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Services;
using System.Web.Script.Serialization;
using harry.DAL.Sql.Sql2008;

public partial class Admin_pages_llm_2llm_log : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static string GetLLMLogs()
    {
        // 从数据库中获取对话记录
        var logs = new List<LLMLog>();
        
        // 创建数据库连接
        harry.DAL.Sql.Sql2008.DbHelper skin = new harry.DAL.Sql.Sql2008.DbHelper();
        
        try
        {
            // 从数据库中读取对话记录
            DataTable dt = skin.GetDT("select * from llm_log order by dialogTime desc");
            
            foreach (DataRow row in dt.Rows)
            {
                logs.Add(new LLMLog
                {
                    id = Convert.ToInt32(row["id"]),
                    studentName = row["studentName"].ToString(),
                    dialogTime = row["dialogTime"].ToString(),
                    dialogContent = row["dialogContent"].ToString(),
                    score = Convert.ToDouble(row["score"])
                });
            }
        }
        catch (Exception ex)
        {
            // 记录错误日志
            System.Diagnostics.Debug.WriteLine("GetLLMLogs error: " + ex.Message);
        }
        
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        return serializer.Serialize(logs);
    }

    [WebMethod]
    public static string SearchLLMLogs(string searchText)
    {
        // 从数据库中搜索对话记录
        var logs = new List<LLMLog>();
        
        // 创建数据库连接
        harry.DAL.Sql.Sql2008.DbHelper skin = new harry.DAL.Sql.Sql2008.DbHelper();
        
        try
        {
            // 从数据库中搜索对话记录
            string sql = string.Format("select * from llm_log where studentName like '%{0}%' or dialogContent like '%{0}%' order by dialogTime desc", searchText);
            DataTable dt = skin.GetDT(sql);
            
            foreach (DataRow row in dt.Rows)
            {
                logs.Add(new LLMLog
                {
                    id = Convert.ToInt32(row["id"]),
                    studentName = row["studentName"].ToString(),
                    dialogTime = row["dialogTime"].ToString(),
                    dialogContent = row["dialogContent"].ToString(),
                    score = Convert.ToDouble(row["score"])
                });
            }
        }
        catch (Exception ex)
        {
            // 记录错误日志
            System.Diagnostics.Debug.WriteLine("SearchLLMLogs error: " + ex.Message);
        }
        
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        return serializer.Serialize(logs);
    }

    [WebMethod]
    public static bool DeleteLLMLog(int id)
    {
        // 从数据库中删除对话记录
        try
        {
            // 创建数据库连接
            harry.DAL.Sql.Sql2008.DbHelper skin = new harry.DAL.Sql.Sql2008.DbHelper();
            
            // 删除对话记录
            string sql = string.Format("delete from llm_log where id = {0}", id);
            skin.ExecuteSql(sql);
            
            return true;
        }
        catch (Exception ex)
        {
            // 记录错误日志
            System.Diagnostics.Debug.WriteLine("DeleteLLMLog error: " + ex.Message);
            return false;
        }
    }
}

public class LLMLog
{
    public int id { get; set; }
    public string studentName { get; set; }
    public string dialogTime { get; set; }
    public string dialogContent { get; set; }
    public double score { get; set; }
}