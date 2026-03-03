using System;

public partial class Admin_pages_game_scene_3place : AdminBasePage
{
    public const string tableName = "[place_info]";
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            //树形结构
            Tools.TreeNode.AddNode(TreeView1.Nodes, tableName, "-1", "used|child", 2);
        }
    }

    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        //树形结构
        Tools.TreeNode.AddNode(e.Node.ChildNodes, tableName, e.Node.Value, "", "used|child", 2, false, " popedom ");
    }
}