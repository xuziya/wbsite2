using System;

public partial class Admin_pages_game_scene_4produce : AdminBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            //产品分类
            Tools.TreeNode.AddNode(TreeView1.Nodes, "[produce_type]", "0", " where isUsed=1 ", 3);
        }
    }

    //树形结构
    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "[produce_type]", e.Node.Value, " where isUsed=1 ", 3);
    }
}