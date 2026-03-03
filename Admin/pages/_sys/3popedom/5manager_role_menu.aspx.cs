using System;
using harry.Tools;

public partial class Admin_sys_popedom_manager_role_menu : AdminBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            string at = Request["at"] ?? "";
            if (at != "")
            {
                //获取角色
                string sql = string.Empty;
                if (at == "getRoles")
                {
                    sql = "select convert(bigint,roleSole) as sole from admin_per_manager_role as mr left join admin_per_role as r on mr.roleSole=r.sole where managerSole='" + Request["sole"] + "' order by sole";
                }
                //获取菜单
                else if (at == "getMenus1")
                {
                    sql = "select convert(bigint,menuSole) as sole from admin_per_role_menus as rm,admin_per_menu as m where rm.menuSole=m.sole and rm.roleSole='" + Request["sole"] + "' order by sole";//and m.isMenu=1 
                }
                //获取菜单
                else if (at == "getMenus2")
                {
                    sql = "select convert(bigint,menuSole) as sole from view_admin_manager_role_menu as mrm where manSole='" + Request["sole"] + "' order by sole";
                }
                Response.ContentType = "text/plain";
                Response.Write(harry.DAL.Sql.Sql2008.skin.GetDT(sql).DataToJson());
                Response.End();
                return;
            }
            //树形结构
            Tools.TreeNode.AddManagerByType(TreeView1.Nodes, " and isUsed=1 ");
            Tools.TreeNode.AddNode(TreeView2.Nodes, "admin_per_role", "-1", " where isUsed=1 ", "child", 5, true);
            Tools.TreeNode.AddNode(TreeView3.Nodes, "admin_per_menu", "-1", " where isUsed=1 ", "child", 5, true);
        }
    }

    /// <summary>树形结构</summary>
    protected void TreeView2_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "admin_per_role", e.Node.Value, " where isUsed=1 ", "child", 5, true);
    }

    /// <summary>树形结构</summary>
    protected void TreeView3_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "admin_per_menu", e.Node.Value, " where isUsed=1 ", "child", 5, true);
    }
}