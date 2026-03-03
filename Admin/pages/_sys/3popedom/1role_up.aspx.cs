using System;
using System.Data;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

public partial class Admin_sys_popedom_role_up : System.Web.UI.Page
{
    private const string tableName = "admin_per_role";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //显示信息
            string sole1 = Request["sole"] ?? "";
            if (sole1 != "")
            {
                DataTable dt = skin.GetDT("select pr.*,m1.name as m1name from " + tableName + " as pr left join admin_per_manager as m1 on pr.createSole=m1.sole where pr.sole='" + sole1 + "'");
                if (dt.Rows.Count > 0)
                {
                    name.Text = dt.Rows[0]["name"].ToString();
                    indexs.Text = dt.Rows[0]["indexs"].ToString();
                    isMain.Checked = dt.Rows[0]["isMain"].ToString() == "1";
                    isUsed.Checked = dt.Rows[0]["isUsed"].ToString() == "1";
                    note.Text = dt.Rows[0]["note"].ToString();
                    id.InnerText = dt.Rows[0]["id"].ToString();
                    sole.InnerText = dt.Rows[0]["sole"].ToString();
                    code.InnerHtml = dt.Rows[0]["code"].ToString() != "" ? dt.Rows[0]["code"].ToString() : "&nbsp;";
                    path.Text = dt.Rows[0]["path"].ToString() != "" ? dt.Rows[0]["path"].ToString() : "&nbsp;";
                    lev.InnerText = dt.Rows[0]["lev"].ToString();
                    createSole.InnerText = dt.Rows[0]["m1name"].ToString();
                    createDate.InnerHtml = dt.Rows[0]["createDate"].ToString() != "" ? dt.Rows[0]["createDate"].ToString() : "&nbsp;";
                }
            }
            Button1.Visible = Button2.Visible = sole1 != "";
        }
    }

    /// <summary>添加信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        bool result = skin.ExecuteSql("update " + tableName + " set [name]='" + name.Text + "',[indexs]='" + indexs.Text + "',[path]='" + path.Text + "',[isMain]=" + (isMain.Checked ? "1" : "0") + ",[isUsed]=" + (isUsed.Checked ? "1" : "0") + ",[note]='" + note.Text + "' where sole='" + sole.InnerHtml + "'") > 0;
        this.Script(result ? "alert('操作成功');window.parent.location.reload();" : "alert('操作失败');");
    }

    /// <summary>删除信息</summary>
    protected void Button2_Click(object sender, EventArgs e)
    {
        string code = skin.ExecuteScalar("select code from " + tableName + " where sole='" + (Request["sole"] ?? "") + "'").ToString();
        if (code != "")
        {
            int result = skin.ExecuteSql("delete from " + tableName + " where sole='" + (Request["sole"] ?? "") + "' or code like '" + code + "-%'");
            this.Script(result > 0 ? "alert('操作成功');window.parent.location.reload();" : "alert('操作失败');");
        }
    }
}