using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class Admin_pages_llm_1llm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static string GetLLMConfigs()
    {
        // 从配置文件中获取大模型配置
        var configs = new List<LLMConfig>();
        
        // 这里可以从数据库或配置文件中读取配置
        // 暂时使用硬编码的示例数据
        configs.Add(new LLMConfig
        {
            id = 1,
            name = "DeepSeek",
            apiUrl = ConfigurationManager.AppSettings["DeepSeekBaseUrl"],
            status = true
        });
        
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        return serializer.Serialize(configs);
    }

    [WebMethod]
    public static bool DeleteLLM(int id)
    {
        // 这里可以实现删除大模型配置的逻辑
        // 暂时返回true表示删除成功
        return true;
    }
}

public class LLMConfig
{
    public int id { get; set; }
    public string name { get; set; }
    public string apiUrl { get; set; }
    public bool status { get; set; }
}