using System;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_pages_llm_1llm_ad : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(id))
            {
                // 编辑模式
                lblTitle.Text = "编辑大模型配置";
                lblFrameTitle.Text = "编辑大模型配置";
                hdnId.Value = id;
                LoadLLMConfig(int.Parse(id));
            }
        }
    }

    private void LoadLLMConfig(int id)
    {
        // 这里可以从数据库或配置文件中读取配置
        // 暂时使用硬编码的示例数据
        if (id == 1)
        {
            txtName.Text = "DeepSeek";
            txtApiUrl.Text = ConfigurationManager.AppSettings["DeepSeekBaseUrl"];
            txtApiKey.Text = ConfigurationManager.AppSettings["DeepSeekApiKey"];
            txtPrompt.Text = "你是一个运营商客服对话训练系统的客户角色扮演者，根据用户的对话内容，生成真实、自然的客户回复。";
            chkStatus.Checked = true;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        // 这里可以实现保存大模型配置的逻辑
        // 暂时只做简单的验证
        if (string.IsNullOrEmpty(txtName.Text))
        {
            Response.Write("<script>alert('请输入模型名称');</script>");
            return;
        }
        
        if (string.IsNullOrEmpty(txtApiUrl.Text))
        {
            Response.Write("<script>alert('请输入API地址');</script>");
            return;
        }
        
        if (string.IsNullOrEmpty(txtApiKey.Text))
        {
            Response.Write("<script>alert('请输入API Key');</script>");
            return;
        }
        
        // 保存成功后跳转到列表页面
        Response.Redirect("1llm.aspx");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        // 取消操作，返回列表页面
        Response.Redirect("1llm.aspx");
    }
}