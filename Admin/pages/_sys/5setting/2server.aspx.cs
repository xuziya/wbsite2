using System;
using System.Data;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

/// <summary>服务器信息</summary>
public partial class Admin_sys_setting_server : AdminBasePage
{
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        if (!IsPostBack)
        {
            //显示信息
            DataTable dt = skin.GetDT("select top 1 * from [admin_setting] where type='系统设置' and name='服务器设置'");
            if (dt.Rows.Count > 0)
            {
                v1.Text = dt.Rows[0]["v1"].ToString();
                v2.Text = dt.Rows[0]["v2"].ToString();
            }
        }
        //string at = area_type.SelectedValue;
        //TreeView1.Nodes.Clear();
        //Tools.TreeNode.AddArea(TreeView1.Nodes, "", " where pparent='100' and lev<=" + area_type.SelectedValue + " and isUsed=1 ", "", 1, false);
    }

    /// <summary>提交信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (v1.Text == "") { this.Alert("请输入服务器ip地址"); return; }
        if (v2.Text == "") { this.Alert("请输入服务器端口号"); return; }

        bool result = skin.ExecuteSql("update [admin_setting] set v1='" + v1.Text + "',v2='" + v2.Text + "' where type='系统设置' and name='服务器设置'") > 0;
        if (result)
        {
            Page.Cache.Remove("serverIp");
            Page.Cache.Insert("serverIp", v1.Text);
            Page.Cache.Remove("serverPort");
            Page.Cache.Insert("serverPort", v2.Text);
        }
        this.Alert(result);
    }

    //protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    //{
    //    Tools.TreeNode.AddArea(e.Node.ChildNodes, e.Node.Value, " where lev<=" + area_type.SelectedValue + " and isUsed=1", "", 1, true);
    //}

    //protected void area_type_SelectedIndexChanged(object sender, EventArgs e)
    //{

    //}
}