using System;

public partial class Admin_pages_game_learn_1learn : AdminBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            Tools.TreeNode.AddNode(TreeView1.Nodes, "[learn_type]", "0", " where isUsed=1 ", 3);
        }
    }

    /// <summary>树形结构</summary>
    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "[learn_type]", e.Node.Value, " where isUsed=1 ", 3);
    }
}