using System;

public partial class Admin_pages_game_dialog_3dialog : AdminBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            //触点
            Tools.TreeNode.AddNode(TreeView1.Nodes, "[place_info]", "-1");
        }
    }
    //树形结构
    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "[place_info]", e.Node.Value);
    }
}