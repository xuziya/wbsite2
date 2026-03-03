using System;
using System.Collections;
using System.Data;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Admin_pages_game_scene_4resources_ad : AdminBasePage
{
    private string oper = string.Empty;
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        oper = (ViewState["oper"] ?? (ViewState["oper"] = Request["oper"] ?? "add")).ToString();
        if (!IsPostBack)
        {
            //数值
            for (int i = -100; i < 101; i++)
            {
                num1.Items.Add(i.ToString());
                num2.Items.Add(i.ToString());
            }
            num1.SelectedValue = num2.SelectedValue = "0";

            //显示信息
            string id = Request["id"] ?? "0", sole = Request["sole"] ?? "";
            if (oper == "up" && (id != "0" || sole != ""))
            {
                DataTable dt = skin.GetDT("select * from resources_info where id=" + id);
                if (dt.Rows.Count > 0)
                {
                    ViewState.Add("id", dt.Rows[0]["id"].ToString());

                    name.Text = dt.Rows[0]["name"].ToString();
                    type.SelectedValue = dt.Rows[0]["type"].ToString();
                    num1.SelectedValue = dt.Rows[0]["num1"].ToString();
                    num2.SelectedValue = dt.Rows[0]["num2"].ToString();

                    isUsed.Checked = dt.Rows[0]["isUsed"].ToString() == "1";
                    note.Text = dt.Rows[0]["note"].ToString();
                }
            }
        }
    }

    /// <summary>提交信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (name.Text == "") { this.Alert("请输入资源名称"); name.Focus(); return; }

        ArrayList sql = new ArrayList();
        //发送sql
        if (oper == "add")
        {
            sql.Add(@"insert into resources_info values('','" + type.SelectedValue + "','" + name.Text + "'," + num1.SelectedValue + "," + num2.SelectedValue + "," + (isUsed.Checked ? 1 : 0) + ",'" + GetSole() + "','" + GetDateTime() + "','" + note.Text + "');");
            sql.Add(harry.Tools.Common.SetSole("resources_info"));
        }
        else if (oper == "up")
        {
            sql.Add(@"update [resources_info] set [type]='" + type.SelectedValue + "',[name]='" + name.Text + "',[num1]='" + num1.SelectedValue + "',[num2]='" + num2.SelectedValue + "',isUsed=" + (isUsed.Checked ? 1 : 0) + ",[note]='" + note.Text + "' where [id]=" + ViewState["id"] + ";");
        }

        bool result = skin.Transaction(sql);
        this.AlertSubmit(result);
    }
}