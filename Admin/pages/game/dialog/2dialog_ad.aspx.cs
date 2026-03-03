using System;
using System.Collections;
using System.Data;
using System.Web.UI.WebControls;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Admin_pages_game_dialog_2dialog_ad : AdminBasePage
{
    private string oper = string.Empty;
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        oper = (ViewState["oper"] ?? (ViewState["oper"] = Request["oper"] ?? "add")).ToString();
        if (!IsPostBack)
        {
            //触点
            Tools.TreeNode.AddNode(TreeView1.Nodes, "[place_info]", "-1");
            //显示信息
            string id = Request["id"] ?? "0", sole = Request["sole"] ?? "";
            if (oper == "up" && (id != "0" || sole != ""))
            {
                DataTable dt = skin.GetDT("select * from dialog2_info where id=" + id);
                if (dt.Rows.Count > 0)
                {
                    ViewState.Add("id", dt.Rows[0]["id"].ToString());

                    placeSole.Value = dt.Rows[0]["type3"].ToString();
                    if (placeSole.Value != "") { placeName.Text = skin.ExecuteScalar("select name from [place_info] where sole='" + placeSole.Value + "'").ToString(); }
                    type1.SelectedValue = dt.Rows[0]["type1"].ToString();
                    type2.SelectedValue = dt.Rows[0]["type2"].ToString();

                    content1.Text = dt.Rows[0]["content1"].ToString();
                    reply1.Text = dt.Rows[0]["reply1"].ToString();
                    point1.Text = dt.Rows[0]["point1"].ToString();

                    content2.Text = dt.Rows[0]["content2"].ToString();
                    reply2.Text = dt.Rows[0]["reply2"].ToString();
                    point2.Text = dt.Rows[0]["point2"].ToString();

                    content3.Text = dt.Rows[0]["content3"].ToString();
                    reply3.Text = dt.Rows[0]["reply3"].ToString();
                    point3.Text = dt.Rows[0]["point3"].ToString();

                    isUsed.Checked = dt.Rows[0]["isUsed"].ToString() == "1";
                    note.Text = dt.Rows[0]["note"].ToString();
                }
            }
        }
    }

    /// <summary>提交信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (placeSole.Value == "") { this.Alert("请选择触点"); placeName.Focus(); return; }
        if (content1.Text == "") { this.Alert("请输入内容1"); content1.Focus(); return; }

        ArrayList sql = new ArrayList();
        //发送sql
        string type = skin.ExecuteScalar("select type from place_info where sole='" + placeSole.Value + "'").ToString();
        if (oper == "add")
        {
            sql.Add(@"insert into dialog2_info values('','" + placeSole.Value + "','" + type1.SelectedValue + "','" + type2.SelectedValue + "','" + content1.Text + "','" + reply1.Text + "','" + point1.Text + "','" + content2.Text + "','" + reply2.Text + "','" + point2.Text + "','" + content3.Text + "','" + reply3.Text + "','" + point3.Text + "','','','','','','',1," + (isUsed.Checked ? 1 : 0) + ",'" + GetSole() + "','" + GetDateTime() + "','" + note.Text + "');");
            sql.Add(harry.Tools.Common.SetSole("dialog2_info"));
        }
        else if (oper == "up")
        {
            sql.Add(@"update [dialog2_info] set [placeSole]='" + placeSole.Value + "',[type1]='" + type1.SelectedValue + "',[type2]='" + type2.SelectedValue + "',[content1]='" + content1.Text + "',[reply1]='" + reply1.Text + "',[point1]='" + point1.Text + "',[content2]='" + content2.Text + "',[reply2]='" + reply2.Text + "',[point2]='" + point2.Text + "',[content3]='" + content3.Text + "',[reply3]='" + reply3.Text + "',[point3]='" + point3.Text + "',isUsed=" + (isUsed.Checked ? 1 : 0) + ",[note]='" + note.Text + "' where [id]=" + ViewState["id"] + ";");
        }

        bool result = skin.Transaction(sql);
        this.AlertSubmit(result);
    }

    //树形结构
    protected void TreeView1_PopulateNodes(object sender, NineRays.WebControls.FlyTreeNodeEventArgs e)
    {
        Tools.TreeNode.AddNode(e.Node.ChildNodes, "[place_info]", e.Node.Value);
    }
}