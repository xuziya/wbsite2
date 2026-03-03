using System;
using System.Collections;
using System.Data;
using System.Web.UI.WebControls;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Admin_pages_game_scene_2member3_ad : AdminBasePage
{
    private string oper = string.Empty;
    protected override void Page_Load(object sender, EventArgs e)
    {
        base.Page_Load(sender, e);
        oper = (ViewState["oper"] ?? (ViewState["oper"] = Request["oper"] ?? "add")).ToString();
        if (!IsPostBack)
        {
            //场景
            Tools.TreeNode.AddSceneByLev(TreeView1.Nodes, " where type='集团'");
            //触点
            DataTable places = skin.GetDT("select sole,name from [place_info] where lev=1");
            for (int i = 0; i < places.Rows.Count; i++)
            {
                place.Items.Add(new ListItem(places.Rows[i]["name"].ToString(), places.Rows[i]["sole"].ToString()));
            }

            //显示信息
            string id = Request["id"] ?? "0", sole = Request["sole"] ?? "";
            if (oper == "up" && (id != "0" || sole != ""))
            {
                DataTable dt = skin.GetDT("select * from member_info where id=" + id);
                if (dt.Rows.Count > 0)
                {
                    ViewState.Add("id", dt.Rows[0]["id"].ToString());

                    name.Text = dt.Rows[0]["name"].ToString();
                    character1.Text = dt.Rows[0]["character1"].ToString();
                    sceneSole.Value = dt.Rows[0]["sceneSole"].ToString();
                    if (sceneSole.Value != "") { sceneName.Text = skin.ExecuteScalar("select name from [scene_info] where sole='" + sceneSole.Value + "'").ToString(); }
                    place.SelectedValue = dt.Rows[0]["placeSole"].ToString();

                    sex.SelectedValue = dt.Rows[0]["sex"].ToString();
                    age.SelectedValue = dt.Rows[0]["age"].ToString();

                    shuxing1.Text = dt.Rows[0]["shuxing1"].ToString();
                    shuxing2.Text = dt.Rows[0]["shuxing2"].ToString();
                    shuxing3.Text = dt.Rows[0]["shuxing3"].ToString();
                    shuxing4.Text = dt.Rows[0]["shuxing4"].ToString();
                    shuxing5.Text = dt.Rows[0]["shuxing5"].ToString();
                    shuxing6.Text = dt.Rows[0]["shuxing6"].ToString();
                    shuxing7.Text = dt.Rows[0]["shuxing7"].ToString();
                    shuxing8.Text = dt.Rows[0]["shuxing8"].ToString();
                    shuxing9.Text = dt.Rows[0]["shuxing9"].ToString();
                    shuxing10.Text = dt.Rows[0]["shuxing10"].ToString();
                    shuxing11.Text = dt.Rows[0]["shuxing11"].ToString();
                    shuxing12.Text = dt.Rows[0]["shuxing12"].ToString();
                    shuxing13.Text = dt.Rows[0]["shuxing13"].ToString();
                    shuxing14.Text = dt.Rows[0]["shuxing14"].ToString();

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
        if (sceneSole.Value == "") { this.Alert("请选择所属场景"); sceneName.Focus(); return; }

        ArrayList sql = new ArrayList();
        //发送sql
        string type = skin.ExecuteScalar("select type from scene_info where sole='" + sceneSole.Value + "'").ToString();
        if (oper == "add")
        {
            sql.Add(@"insert into member_info values('','" + sceneSole.Value + "','" + place.SelectedValue + "','" + type + "','" + name.Text + "','" + character1.Text + "','" + sex.SelectedValue + "','" + age.SelectedValue + "','" + shuxing1.Text + "','" + shuxing2.Text + "','" + shuxing3.Text + "','" + shuxing4.Text + "','" + shuxing5.Text + "','" + shuxing6.Text + "','" + shuxing7.Text + "','" + shuxing8.Text + "','" + shuxing9.Text + "','" + shuxing10.Text + "','" + shuxing11.Text + "','" + shuxing12.Text + "','" + shuxing13.Text + "','" + shuxing14.Text + "','','','','','','',1," + (isUsed.Checked ? 1 : 0) + ",0,'','" + GetSole() + "','" + GetDateTime() + "','" + note.Text + "');");
            sql.Add(harry.Tools.Common.SetSole("member_info"));
        }
        else if (oper == "up")
        {
            sql.Add(@"update [member_info] set [sceneSole]='" + sceneSole.Value + "',[placeSole]='" + place.SelectedValue + "',[type]='" + type + "',[name]='" + name.Text + "',[character1]='" + character1.Text + "',[sex]='" + sex.SelectedValue + "',[age]='" + age.SelectedValue + "',[shuxing1]='" + shuxing1.Text + "',[shuxing2]='" + shuxing2.Text + "',[shuxing3]='" + shuxing3.Text + "',[shuxing4]='" + shuxing4.Text + "',[shuxing5]='" + shuxing5.Text + "',[shuxing6]='" + shuxing6.Text + "',[shuxing7]='" + shuxing7.Text + "',[shuxing8]='" + shuxing8.Text + "',[shuxing9]='" + shuxing9.Text + "',[shuxing10]='" + shuxing10.Text + "',[shuxing11]='" + shuxing11.Text + "',[shuxing12]='" + shuxing12.Text + "',[shuxing13]='" + shuxing13.Text + "',[shuxing14]='" + shuxing14.Text + "',isUsed=" + (isUsed.Checked ? 1 : 0) + ",[note]='" + note.Text + "' where [id]=" + ViewState["id"] + ";");
        }

        bool result = skin.Transaction(sql);
        this.AlertSubmit(result);
    }
}