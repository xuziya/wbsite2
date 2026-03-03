using System;
using System.Collections;
using System.Data;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Admin_pages_game_scene_4produce_ad : AdminBasePage
{
    private string oper = string.Empty;
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        oper = (ViewState["oper"] ?? (ViewState["oper"] = Request["oper"] ?? "add")).ToString();
        if (!IsPostBack)
        {
            //分类
            Tools.TreeNode.AddNode(TreeView1.Nodes, "[produce_type]", "-1", "used|child", 2);

            //显示信息
            string id = Request["id"] ?? "0", sole = Request["sole"] ?? "";
            if (oper == "up" && (id != "0" || sole != ""))
            {
                DataTable dt = skin.GetDT("select * from produce_info where id=" + id);
                if (dt.Rows.Count > 0)
                {
                    ViewState.Add("id", dt.Rows[0]["id"].ToString());

                    name.Text = dt.Rows[0]["name"].ToString();
                    typeSole.Value = dt.Rows[0]["typeSole"].ToString();
                    if (typeSole.Value != "") { typeName.Text = skin.ExecuteScalar("select name from [produce_type] where sole='" + typeSole.Value + "'").ToString(); }
                    lev.Text = dt.Rows[0]["lev"].ToString();
                    index.Text = dt.Rows[0]["index1"].ToString();
                    intro.Text = dt.Rows[0]["intro"].ToString();
                    isUsed.Checked = dt.Rows[0]["isUsed"].ToString() == "1";
                    note.Text = dt.Rows[0]["note"].ToString();
                }
            }
        }
    }

    /// <summary>提交信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (name.Text == "") { this.Alert("请输入产品名称"); name.Focus(); return; }

        ArrayList sql = new ArrayList();
        //发送sql
        if (oper == "add")
        {
            sql.Add(@"insert into produce_info values('','" + typeSole.Value + "','','" + name.Text + "','" + lev.Text + "','" + index.Text + "','" + intro.Text + "','','',1," + (isUsed.Checked ? 1 : 0) + ",'" + GetSole() + "','" + GetDateTime() + "','" + note.Text + "');");
            sql.Add(harry.Tools.Common.SetSole("produce_info"));
        }
        else if (oper == "up")
        {
            sql.Add(@"update [produce_info] set [typeSole]='" + typeSole.Value + "',[name]='" + name.Text + "',[lev]='" + lev.Text + "',[index1]=" + index.Text + ",[intro]='" + intro.Text + "',isUsed=" + (isUsed.Checked ? 1 : 0) + ",[note]='" + note.Text + "' where [id]=" + ViewState["id"] + ";");
        }

        bool result = skin.Transaction(sql);
        this.AlertSubmit(result);
    }

    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "[produce_type]", e.Node.Value, " where isUsed=1 ");
    }
}