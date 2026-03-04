using System;
using System.Web.UI;

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
        // 从数据库或其他存储中获取对话详情
        // 暂时使用硬编码的示例数据
        if (id == "1")
        {
            studentName.InnerText = "张三";
            dialogTime.InnerText = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            dialogContent.InnerText = "学员：您好，我想咨询一下最近的流量套餐。\n客户：您好，请问您目前使用的是什么套餐？\n学员：我目前使用的是10GB流量的套餐，但是不够用。\n客户：我们现在有一个20GB流量的套餐，每月只需多花10元，您觉得怎么样？\n学员：听起来不错，我想办理这个套餐。";
            score.InnerText = "4.5";
            evaluation.InnerHtml = "<p>学员的话术专业、准确，能够有效引导客户购买合适的套餐。</p><p><strong>优点：</strong></p><ul><li>主动问候客户，态度友好</li><li>准确理解客户需求</li><li>提供了合适的套餐推荐</li><li>成功引导客户办理套餐</li></ul><p><strong>改进空间：</strong></p><ul><li>可以更详细地介绍套餐的其他优势</li><li>可以询问客户是否还有其他需求</li></ul>";
        }
        else if (id == "2")
        {
            studentName.InnerText = "李四";
            dialogTime.InnerText = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            dialogContent.InnerText = "学员：您好，我想办理宽带业务。\n客户：好的，请问您需要多少兆的宽带？\n学员：我需要100兆的宽带。\n客户：我们现在有100兆宽带的套餐，每月80元，您觉得怎么样？\n学员：可以，我想办理。";
            score.InnerText = "5.0";
            evaluation.InnerHtml = "<p>学员的话术专业、简洁，能够快速满足客户需求。</p><p><strong>优点：</strong></p><ul><li>主动问候客户，态度友好</li><li>准确理解客户需求</li><li>提供了合适的宽带套餐</li><li>成功引导客户办理业务</li></ul><p><strong>改进空间：</strong></p><ul><li>可以介绍一下宽带的其他服务，如上门安装时间等</li></ul>";
        }
    }
}