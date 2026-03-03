using System;
using System.Data;
using harry.DAL.Sql.Sql2008;
using harry.Tools;

/// <summary>行政区域</summary>
public partial class Admin_sys_data_area_ad : System.Web.UI.Page
{
    private const string tableName = "[data_area]";
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
                    type.SelectedValue = dt.Rows[0]["type"].ToString();
                    name.Text = dt.Rows[0]["name"].ToString();
                    indexs.Text = dt.Rows[0]["indexs"].ToString();
                    note.Text = dt.Rows[0]["note"].ToString();
                    isUsed.Checked = dt.Rows[0]["isUsed"].ToString() == "1";
                    id.InnerText = dt.Rows[0]["id"].ToString();
                    sole.InnerText = dt.Rows[0]["sole"].ToString();
                    code.InnerHtml = dt.Rows[0]["code"].ToString() != "" ? dt.Rows[0]["code"].ToString() : "&nbsp;";
                    path.Text = dt.Rows[0]["path"].ToString() != "" ? dt.Rows[0]["path"].ToString() : "&nbsp;";
                    lev.InnerText = dt.Rows[0]["lev"].ToString();
                    createSole.InnerText = dt.Rows[0]["m1name"].ToString();
                    createDate.InnerHtml = dt.Rows[0]["createDate"].ToString() != "" ? dt.Rows[0]["createDate"].ToString() : "&nbsp;";
                }
            }
            Button1.Visible = sole1 != "";
            Button2.Visible = skin.ExecuteScalar("select count(id) from " + tableName + " where parentSole='" + sole1 + "'").ToString() == "0";
        }
    }

    /// <summary>添加信息</summary>
    protected void Button1_Click(object sender, EventArgs e)
    {
        string _name = name.Text;
        if (_name == "") { this.Alert("请输入区域名称"); name.Focus(); return; }
        bool result = skin.ExecuteSql("update " + tableName + " set [type]='" + type.SelectedValue + "',[name]='" + _name + "',[spell1]='" + harry.Tools.Text.Spall.ToSpall(_name) +
            "',[spell2]='" + harry.Tools.Text.Spall.ToChars(_name) + "',[isUsed]=" + (isUsed.Checked ? "1" : "0") + ",[indexs]='" + indexs.Text + "',[path]='" + path.Text + "',[note]='" + note.Text + "' where sole='" + sole.InnerHtml + "'") > 0;
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