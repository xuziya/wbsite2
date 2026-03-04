using System;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.Script.Serialization;

public partial class Admin_pages_llm_3llm_prompt : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static string GetPrompts()
    {
        // 从数据库或其他存储中获取Prompt列表
        var prompts = new List<Prompt>();
        
        // 暂时使用硬编码的示例数据
        prompts.Add(new Prompt
        {
            id = 1,
            name = "客户角色",
            type = "客户模拟",
            content = "你是一个运营商的客户，正在与客服代表对话。请根据上下文和客户信息，生成自然、真实的客户回应。回应应该符合客户的角色和情境，不要过于正式，要像真实的人在说话。"
        });
        
        prompts.Add(new Prompt
        {
            id = 2,
            name = "对话评估",
            type = "评分标准",
            content = "你是一个运营商培训的裁判，负责评估学员与客户的对话。请根据对话历史和评分标准，对学员的表现进行评分和评价。评价应该客观、详细，指出优点和改进空间。"
        });
        
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        return serializer.Serialize(prompts);
    }

    [WebMethod]
    public static bool DeletePrompt(int id)
    {
        // 这里可以实现删除Prompt的逻辑
        // 暂时返回true表示删除成功
        return true;
    }
}

public class Prompt
{
    public int id { get; set; }
    public string name { get; set; }
    public string type { get; set; }
    public string content { get; set; }
}