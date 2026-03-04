using System;
using System.Web.UI;

public partial class Admin_pages_llm_3llm_prompt_ad : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(id))
            {
                // 编辑模式
                lblTitle.Text = "编辑Prompt";
                lblFrameTitle.Text = "编辑Prompt";
                hdnId.Value = id;
                LoadPrompt(int.Parse(id));
            }
        }
    }

    private void LoadPrompt(int id)
    {
        // 从数据库或其他存储中获取Prompt信息
        // 暂时使用硬编码的示例数据
        if (id == 1)
        {
            txtName.Text = "客户角色";
            ddlType.SelectedValue = "客户模拟";
            txtContent.Text = "你是一个运营商的客户，正在与客服代表对话。请根据上下文和客户信息，生成自然、真实的客户回应。回应应该符合客户的角色和情境，不要过于正式，要像真实的人在说话。";
        }
        else if (id == 2)
        {
            txtName.Text = "对话评估";
            ddlType.SelectedValue = "评分标准";
            txtContent.Text = "你是一个运营商培训的裁判，负责评估学员与客户的对话。请根据对话历史和评分标准，对学员的表现进行评分和评价。评价应该客观、详细，指出优点和改进空间。";
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        // 这里可以实现保存Prompt的逻辑
        // 暂时只做简单的验证
        if (string.IsNullOrEmpty(txtName.Text))
        {
            Response.Write("<script>alert('请输入名称');</script>");
            return;
        }
        
        if (string.IsNullOrEmpty(txtContent.Text))
        {
            Response.Write("<script>alert('请输入内容');</script>");
            return;
        }
        
        // 保存成功后跳转到列表页面
        Response.Redirect("3llm_prompt.aspx");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        // 取消操作，返回列表页面
        Response.Redirect("3llm_prompt.aspx");
    }
}