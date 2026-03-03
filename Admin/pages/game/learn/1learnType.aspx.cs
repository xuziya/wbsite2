using System;

public partial class Admin_pages_game_learn_1learnType : AdminBasePage
{
    public const string tableName = "[learn_type]";
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            Tools.TreeNode.AddNode(TreeView1.Nodes, tableName, "-1", "used|child", 2);
        }
    }

    /// <summary>树形结构</summary>
    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, tableName, e.Node.Value, "", "used|child", 2, false, " popedom ");
    }
}