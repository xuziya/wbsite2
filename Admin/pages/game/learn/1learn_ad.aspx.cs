using System;
using System.Collections;
using System.Data;
using System.Web;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Admin_pages_game_learn_1learn_ad : AdminBasePage
{
    private string oper = string.Empty;
    public string content = string.Empty;
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        oper = (ViewState["oper"] ?? (ViewState["oper"] = Request["oper"] ?? "add")).ToString();
        if (!IsPostBack)
        {
            Tools.TreeNode.AddNode(TreeView1.Nodes, "[learn_type]", "0", " where isUsed=1 ");

            string id = Request["id"] ?? "0", sole = Request["sole"] ?? "";
            if (oper == "up" && (id != "0" || sole != ""))
            {
                DataTable dt = skin.GetDT("select * from learn_info where id=" + id);
                if (dt.Rows.Count > 0)
                {
                    ViewState.Add("id", dt.Rows[0]["id"].ToString());

                    name.Text = dt.Rows[0]["name"].ToString();
                    typeSole.Value = dt.Rows[0]["typeSole"].ToString();
                    if (typeSole.Value != "") { typeName.Text = skin.ExecuteScalar("select name from [learn_type] where sole='" + typeSole.Value + "'").ToString(); }
                    intro.Text = dt.Rows[0]["intro"].ToString();
                    content = HttpContext.Current.Server.HtmlDecode(dt.Rows[0]["content"].ToString());
                    isUsed.Checked = dt.Rows[0]["isUsed"].ToString() == "1";
                    note.Text = dt.Rows[0]["note"].ToString();
                }
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (name.Text == "") { this.Alert("请输入标题"); name.Focus(); return; }
        //if (typeSole.Value == "") { this.Alert("请选择资料分类"); typeName.Focus(); return; }
        if (intro.Text == "") { this.Alert("请输入简介"); intro.Focus(); return; }
        content = HttpContext.Current.Server.HtmlEncode(HttpContext.Current.Request.Form["editor1"]);
        if (content == "") { this.Alert("请输入详细内容"); return; }

        ArrayList sql = new ArrayList();
        if (oper == "add")
        {
            sql.Add(@"insert into [learn_info] values('','" + typeSole.Value + "','','" + name.Text + "','" + intro.Text + "','" + content + "'," + (isUsed.Checked ? 1 : 0) + ",'" + GetSole() + "','" + GetDateTime() + "','" + note.Text + "');");
            sql.Add(harry.Tools.Common.SetSole("learn_info"));
        }
        else if (oper == "up")
        {
            sql.Add(@"update [learn_info] set [typeSole]='" + typeSole.Value + "',[name]='" + name.Text + "',[intro]='" + intro.Text + "',isUsed=" + (isUsed.Checked ? 1 : 0) + ",[note]='" + note.Text + "' where [id]=" + ViewState["id"] + ";");
        }
        bool result = skin.Transaction(sql);
        if (result) { content = HttpContext.Current.Server.HtmlDecode(HttpContext.Current.Request.Form["editor1"]); }
        this.AlertSubmit(result);
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        string[] alert = { "操作失败", "操作成功" };
        this.AlertSubmit(skin.ExecuteSql("delete from [learn_info] where id=" + (Request["id"])) > 0, alert, true, "location.href", "");
    }

    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "[learn_type]", e.Node.Value, " where isUsed=1 ");
    }
}