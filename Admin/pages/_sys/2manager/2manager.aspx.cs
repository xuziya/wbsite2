using System;

public partial class Admin_sys_manager_manager : AdminBasePage
{
    private const string tableName = "[admin_organ]";
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            //树形结构
            Tools.TreeNode.AddNode(TreeView1.Nodes, tableName, "-1", " where isUsed=1 ", 3);
        }
    }

    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        //树形结构
        Tools.TreeNode.AddNode(e.Node.ChildNodes, tableName, e.Node.Value, " where isUsed=1 ", 3);
    }
}