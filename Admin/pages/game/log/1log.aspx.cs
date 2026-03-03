using System;

public partial class Admin_pages_game_log_1log : AdminBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            //场景类型
            Tools.TreeNode.AddSceneByLev(TreeView1.Nodes, "");
        }
    }
}