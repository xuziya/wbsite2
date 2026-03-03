using System;

public partial class Admin_pages_game_scene_1scene : AdminBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            //学员分类
            Tools.TreeNode.AddNode(TreeView1.Nodes, "[admin_organ]", "0", " where isUsed=1 ", 3);
        }
    }

    //树形结构
    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "[admin_organ]", e.Node.Value, " where isUsed=1 ", 3);
    }
}