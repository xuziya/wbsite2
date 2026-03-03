using System;

public partial class Admin_sys_data_area : AdminBasePage
{
    public const string tableName = "[data_area]";
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            //默认行政区域
            string asole = harry.DAL.Sql.Sql2008.skin.ExecuteScalar("select v1 from [admin_setting] where type='系统设置' and name='应用设置'").ToString();
            if (asole != "")
            {
                //树形结构
                Tools.TreeNode.AddNode(TreeView1.Nodes, tableName, "", " where sole='" + asole + "' ", "used|child", 3, false);
            }
            else
            {
                harry.Tools.Js.Alert(this, "无效的区域信息");
            }
        }
    }

    /// <summary>树形结构</summary>
    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddArea(e.Node.ChildNodes, e.Node.Value, "", "used|child", 3, false);
    }
}