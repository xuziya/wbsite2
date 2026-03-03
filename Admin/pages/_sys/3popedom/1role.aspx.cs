using System;

public partial class Admin_sys_popedom_role : AdminBasePage
{
    public const string tableName = "admin_per_role";
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
        Tools.TreeNode.AddNode(e.Node.ChildNodes, tableName, e.Node.Value, "used|child", 2);
    }
}