using System;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.Script.Serialization;

public partial class Admin_pages_llm_2llm_log : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static string GetLLMLogs()
    {
        // 从数据库或其他存储中获取对话记录
        var logs = new List<LLMLog>();
        
        // 暂时使用硬编码的示例数据
        logs.Add(new LLMLog
        {
            id = 1,
            studentName = "张三",
            dialogTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
            dialogContent = "学员：您好，我想咨询一下最近的流量套餐。\n客户：您好，请问您目前使用的是什么套餐？",
            score = 4.5
        });
        
        logs.Add(new LLMLog
        {
            id = 2,
            studentName = "李四",
            dialogTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
            dialogContent = "学员：您好，我想办理宽带业务。\n客户：好的，请问您需要多少兆的宽带？",
            score = 5.0
        });
        
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        return serializer.Serialize(logs);
    }

    [WebMethod]
    public static string SearchLLMLogs(string searchText)
    {
        // 从数据库或其他存储中搜索对话记录
        var logs = new List<LLMLog>();
        
        // 暂时使用硬编码的示例数据
        if (searchText.Contains("张三") || searchText.Contains("流量"))
        {
            logs.Add(new LLMLog
            {
                id = 1,
                studentName = "张三",
                dialogTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                dialogContent = "学员：您好，我想咨询一下最近的流量套餐。\n客户：您好，请问您目前使用的是什么套餐？",
                score = 4.5
            });
        }
        
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        return serializer.Serialize(logs);
    }

    [WebMethod]
    public static bool DeleteLLMLog(int id)
    {
        // 这里可以实现删除对话记录的逻辑
        // 暂时返回true表示删除成功
        return true;
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