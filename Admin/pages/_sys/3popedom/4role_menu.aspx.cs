using System;
using System.Collections;
using System.Data;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Admin_sys_popedom_role_menu : AdminBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            //获取菜单
            if ((Request["at"] ?? "") == "getMenus")
            {
                DataTable dt = skin.GetDT("select convert(bigint,menuSole) as sole from admin_per_role_menus as rm,admin_per_menu as m where rm.menuSole=m.sole and rm.roleSole='" + Request["sole"] + "' order by sole");//and m.isMenu=1 
                Response.ContentType = "text/plain";
                Response.Write(dt.DataToJson());
                Response.End();
                return;
            }
            //树形结构
            Tools.TreeNode.AddNode(TreeView1.Nodes, "admin_per_role", "-1", " where isUsed=1 ", "child", 2, true);
            Tools.TreeNode.AddNode(TreeView2.Nodes, "admin_per_menu", "-1", " where isUsed=1 ", "child", 5, true);
        }
    }

    /// <summary>添加信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (tree1_soles.Value == "") { this.Alert("请选择角色"); return; }
        if (tree2_soles.Value == "") { this.Alert("请选择菜单"); return; }

        ArrayList sql = new ArrayList();
        string[] soles1 = tree1_soles.Value.Split(',');
        string[] soles2 = tree2_soles.Value.Split(',');
        string manager = GetSole();
        for (int i = 0; i < soles1.Length; i++)
        {
            sql.Add("delete from admin_per_role_menus where roleSole='" + soles1[i] + "'");
            for (int j = 0; j < soles2.Length; j++)
            {
                sql.Add("insert into [admin_per_role_menus]([sole],[roleSole],[menuSole],[createSole],[createDate],[note]) values('','" + soles1[i] + "','" + soles2[j] + "','" + manager + "','','')");
            }
        }
        //string s = harry.Tools.Test.Sql.ToSql(sql, true);
        this.Alert(skin.Transaction(sql));
    }

    /// <summary>树形结构</summary>
    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "admin_per_role", e.Node.Value, " where isUsed=1 ", "child", 2, true);
    }

    /// <summary>树形结构</summary>
    protected void TreeView2_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "admin_per_menu", e.Node.Value, " where isUsed=1 ", "child", 5, true);
    }
}