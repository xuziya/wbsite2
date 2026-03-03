using System;
using System.Collections;
using System.Data;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Admin_pages_game_train_1student_ad : AdminBasePage
{
    private string oper = string.Empty;
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        oper = (ViewState["oper"] ?? (ViewState["oper"] = Request["oper"] ?? "add")).ToString();
        if (!IsPostBack)
        {
            //机构
            Tools.TreeNode.AddNode(TreeView1.Nodes, "[admin_organ]", "-1", "used|child", 2);
            //年龄 18-81
            for (int i = 18; i < 66; i++) { age.Items.Add(i.ToString()); }

            //显示信息
            string id = Request["id"] ?? "0", sole = Request["sole"] ?? "";
            if (oper == "up" && (id != "0" || sole != ""))
            {
                DataTable dt = skin.GetDT("select * from student_info where id=" + id);
                if (dt.Rows.Count > 0)
                {
                    ViewState.Add("id", dt.Rows[0]["id"].ToString());

                    name.Text = dt.Rows[0]["name"].ToString();
                    organSole.Value = dt.Rows[0]["organSole"].ToString();
                    if (organSole.Value != "") { organName.Text = skin.ExecuteScalar("select name from [admin_organ] where sole='" + organSole.Value + "'").ToString(); }
                    sex.SelectedValue = dt.Rows[0]["sex"].ToString();
                    age.Text = dt.Rows[0]["age"].ToString();
                    dept.Text = dt.Rows[0]["dept"].ToString();
                    code.Text = dt.Rows[0]["code"].ToString();
                    mobile.Text = dt.Rows[0]["mobile"].ToString();

                    uid.Text = dt.Rows[0]["uid"].ToString();
                    pass.Text = dt.Rows[0]["pass"].ToString();

                    isUsed.Checked = dt.Rows[0]["isUsed"].ToString() == "1";
                    note.Text = dt.Rows[0]["note"].ToString();
                }
            }
        }
    }

    /// <summary>提交信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (name.Text == "") { this.Alert("请输入学员姓名"); name.Focus(); return; }
        if (uid.Text == "") { this.Alert("请输入用户名"); uid.Focus(); return; }
        if (pass.Text == "") { this.Alert("请输入密码"); pass.Focus(); return; }

        //数据库重复检测
        string now_id = skin.ExecuteScalar("select id from [student_info] where uid='" + uid.Text + "'").ToString();
        //添加时id必须为空
        if (oper == "add" && now_id != "") { this.Alert("账号 [ " + uid.Text + " ] 已被使用"); return; }

        ArrayList sql = new ArrayList();
        //发送sql
        if (oper == "add")
        {
            sql.Add(@"insert into student_info values('','" + organSole.Value + "','','" + name.Text + "','" + code.Text + "','" + sex.SelectedValue + "','" + age.SelectedValue + "','" + dept.Text + "','" + mobile.Text + "','" + uid.Text + "','" + pass.Text + "','','',1," + (isUsed.Checked ? 1 : 0) + ",0,'','" + GetSole() + "','" + GetDateTime() + "','" + note.Text + "');");
            sql.Add(harry.Tools.Common.SetSole("student_info"));
        }
        else if (oper == "up")
        {
            sql.Add(@"update [student_info] set [organSole]='" + organSole.Value + "',[name]='" + name.Text + "',[sex]='" + sex.SelectedValue + "',[age]='" + age.SelectedValue + "',[dept]='" + dept.Text + "',[code]='" + code.Text + "',[mobile]='" + mobile.Text + "',[pass]='" + pass.Text + "',isUsed=" + (isUsed.Checked ? 1 : 0) + ",[note]='" + note.Text + "' where [id]=" + ViewState["id"] + ";");
        }

        bool result = skin.Transaction(sql);
        this.AlertSubmit(result);
    }

    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "[admin_organ]", e.Node.Value, " where isUsed=1 ");
    }
}