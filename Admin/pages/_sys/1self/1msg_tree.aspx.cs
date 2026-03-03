using System;

/// <summary>个人信息-权限</summary>
public partial class Admin_sys_self_msg1_tree : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string sole1 = Request["s"] ?? AdminBasePage.GetSole();
            ViewState["menuSoles"] = Tools.TreeNode.ReckonNode("select menuCode as code from view_admin_manager_role_menu as mrm where manSole='" + sole1 + "' order by code");
            //添加权限树
            Tools.TreeNode.AddNode(TreeView1.Nodes, "admin_per_menu", "-1", " where sole in (" + ViewState["menuSoles"] + ")", "used", 5, false);
        }
    }

    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "admin_per_menu", e.Node.Value, " where sole in (" + ViewState["menuSoles"] + ")", "used", 5, false);
    }
}